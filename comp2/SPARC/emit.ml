open Asm
open Printf

(*
  exception UnknownInstruction
*)
(*
  let opcode_of x =
  match x with
  | "foi" -> 0b010101 | "floor" -> 0b010110(*仮*)
  | "nop" -> 0b000000 | "add" -> 0b000001 | "sub" -> 0b000010
  | "mul" -> 0b000011 | "and" -> 0b000100 | "or" -> 0b000101
  | "nor" -> 0b000110 | "xor" -> 0b000111| "addi" -> 0b001001
  | "subi" -> 0b001010 | "muli" -> 0b001011 | "andi" -> 0b001100
  | "ori" -> 0b001101 | "nori" -> 0b001110 | "xori" -> 0b001111
  | "fadd" -> 0b010000 | "fsub" -> 0b010001| "fmul" -> 0b010010
  | "finv" -> 0b010011 | "fsqrt" -> 0b010100 | "fdiv" -> 0b010011
  | "ldi" -> 0b011001 | "store" -> 0b011011 | "fldi" -> 0b011101
  | "fstore" -> 0b011111 | "beq" -> 0b100000 | "bne" -> 0b100001
  | "bgt" -> 0b100010 | "blt" -> 0b100011 | "fbeq" -> 0b100100
  | "fbne" -> 0b100101 | "fbgt" -> 0b100110 | "fblt" -> 0b100111
  | "jump" -> 0b110000 | "call" -> 0b110100 | "return" -> 0b111000
  | _ -> raise UnknownInstruction
*)

type inst = Ret | Ldi | Fld | Sti | Fst | Call | Jump | Bne | Bgt | Blt | Fbne | Fbgt |
    Nadd | Nfadd | Nnop | Naddi | Nmuli

let ltostr (Id.L x) = x
let soii = function
  | Nnop -> "nop"
  | Naddi -> "addi"
  | Nmuli -> "muli"
  | Ret -> "return"
  | Ldi -> "ldi"
  | Fld -> "fldi"
  | Sti -> "sti"
  | Fst -> "fsti"
  | Call -> "call"
  | Jump -> "jump"
  | Bne -> "bne"
  | Bgt -> "bgt"
  | Blt -> "blt"
  | Fbne -> "fbne"
  | Fbgt -> "fbgt"
  | Nadd -> "add"
  | Nfadd -> "fadd"
let string_of_inst = function
(*  | Pc _ -> "ptc" | Pf _ -> "ptf" | Ri -> "rdi" | Rf -> "rdf"*)
  | Floor _ -> "flr" | Float_of_int _ -> "foi"
  | Nop -> (soii Nnop) | Add _ -> (soii Nadd) | Sub _ -> "sub" | Mul _ -> "mul"
  | And _ -> "and" | Or _ -> "or" | Nor _ -> "nor" | Xor _ -> "xor"
  | Addi _ -> (soii Naddi) | Subi _ -> "subi" | Muli _ -> (soii Nmuli) | Andi _ -> "andi"
  | Ori _ -> "ori" | Nori _ -> "nori" | Xori _ -> "xori" | Fadd _ -> (soii Nfadd)
  | Fsub _ -> "fsub" | Fmul _ -> "fmul" | Finv _ -> "finv" | Fsqrt _ -> "fsqrt"
  | Fdiv _ -> "fdiv" | Load _ -> (soii Ldi) | Store _ ->  (soii Sti) | Fload _ -> (soii Fld)
  | Fstore _ ->  (soii Fst) | IfEq _ -> "IfEq" | IfLE _ -> "IfLE" | IfGE _ -> "IfGE"
  | IfFEq _ -> "IfEFq" | IfFLE _ -> "IfFLE" | CallCls _ -> "CallCls" | CallDir _ -> "CallDir"
  | Save _ -> "Save" | Restore _ -> "Restore"

let stackset = ref S.empty (* すでにSaveされた変数の集合 (caml2html: emit_stackset) *)
let stackmap = ref [] (* Saveされた変数の、スタックにおける位置 (caml2html: emit_stackmap) *)
let save x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    stackmap := !stackmap @ [x]
let savef x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    (let pad =
       if List.length !stackmap mod 2 = 0 then [] else [Id.gentmp Type.Int] in
       stackmap := !stackmap @ pad @ [x; x])
let locate x =
  let rec loc = function
    | [] -> []
    | y :: zs when x = y -> 0 :: List.map succ (loc zs)
    | y :: zs -> List.map succ (loc zs) in
    loc !stackmap
let offset x = List.hd (locate x)
let stacksize () = List.length !stackmap + 1

let pp_id_or_imm = function
  | V(x) -> x
  | C(i) -> string_of_int i

(* 関数呼び出しのために引数を並べ替える(register shuffling) (caml2html: emit_shuffle) *)
let rec shuffle sw xys =
  (* remove identical moves *)
  let _, xys = List.partition (fun (x, y) -> x = y) xys in
    (* find acyclic moves *)
    match List.partition (fun (_, y) -> List.mem_assoc y xys) xys with
      | [], [] -> []
      | (x, y) :: xys, [] -> (* no acyclic moves; resolve a cyclic move *)
	  (y, sw) :: (x, y) :: shuffle sw (List.map
					     (function
						| (y', z) when y = y' -> (sw, z)
						| yz -> yz)
					     xys)
      | xys, acyc -> acyc @ shuffle sw xys

(*nameだとかぶっちゃってエラー起きる*)
type a = { nm : string; ac : int; a1 : string;
	   mutable a2 : string; mutable a3 : string; mutable index : int }

exception UnknownInstruction
  
let print_a a =
  if a.ac = 0 then
    printf "%s\n" a.nm
  else if a.ac = 1 then
    printf "%s %s\n" a.nm a.a1
  else if a.ac = 2 then
    printf "%s %s %s\n" a.nm a.a1 a.a2
  else if a.ac = 3 then
    printf "%s %s %s %s\n" a.nm a.a1 a.a2 a.a3
  else
    printf "%s:\n" a.nm
      
(*相対jumpの距離について*)
(*TODO:a1,a3が数字の時値が範囲内にあるか確かめる*)
let finst0 n =
  { nm = n; ac = 0; a1 = ""; a2 = ""; a3 = ""; index = 0 } 
let finst1 n a =
  { nm = n; ac = 1; a1 = a; a2 = ""; a3 = ""; index = 0 } 
let finst2 n a b =
  { nm = n; ac = 2; a1 = a; a2 = b; a3 = ""; index = 0 } 
let finst3 n a b c =
  { nm = n; ac = 3; a1 = a; a2 = b; a3 = c; index = 0 } 
let flabel n =
  { nm = n; ac = - 1; a1 = ""; a2 = ""; a3 = ""; index = 0 } 


type dest = Tail | NonTail of Id.t (* 末尾かどうかを表すデータ型 (caml2html: emit_dest) *)
let rec g = function (* 命令列のアセンブリ生成 (caml2html: emit_g) *)
  | dest, Ans(exp) -> g' (dest, exp)
  | dest, Let((x, t), exp, e) ->
      (*一度tmpに入れないとやばい*)
      let tmp = (g' (NonTail(x), exp)) in
	tmp @ (g (dest, e))
and g' e =(* 各命令のアセンブリ生成 (caml2html: emit_gprime) *)
  (* 末尾でなかったら計算結果をdestにセット (caml2html: emit_nontail) *)
  let n = string_of_inst (snd e) in
    match e with
      | NonTail(_), Nop -> []
      | NonTail(x), Floor(y) | NonTail(x), Float_of_int(y) ->
	  [finst2 n x y]
(*      | NonTail(_), Pc(y) | NonTail(_), Pf(y) ->
	  [finst1 n y]
      | NonTail(x), Ri | NonTail(x), Rf ->
	  [finst1 n x]*)
      | NonTail(x), Sub(y, z') | NonTail(x), Mul(y, z') | NonTail(x), Or(y, z')
      | NonTail(x), Xor(y, z') | NonTail(x), Nor(y, z') | NonTail(x), And(y, z')
      | NonTail(x), Fadd(y, z') | NonTail(x), Fsub(y, z') | NonTail(x), Fmul(y, z')
      | NonTail(x), Fdiv(y, z') | NonTail(x), Finv(y, z') | NonTail(x), Fsqrt(y, z')
      | NonTail(x), Add(y, z') ->
	  [finst3 n x y z']
      | NonTail(x), Addi(y, z') | NonTail(x), Muli(y, z')
      | NonTail(x), Subi(y, z') | NonTail(x), Ori(y, z') | NonTail(x), Xori(y, z')
      | NonTail(x), Nori(y, z') | NonTail(x), Load(y, z') | NonTail(x), Fload(y, z')
      | NonTail(x), Andi(y, z') ->
	  [finst3 n x y (string_of_int z')]
      | NonTail(_), Store(x, y, z') | NonTail(_), Fstore(x, y, z') ->
	  [finst3 n x y (string_of_int z')]
	    (* 退避の仮想命令の実装 (caml2html: emit_save) *)
      | NonTail(_), Save(x, y) when List.mem x allregs && not (S.mem y !stackset) ->
	  save y;
	  [finst3 (soii Sti) x spreg (string_of_int (offset y))]
      | NonTail(_), Save(x, y) when List.mem x allfregs && not (S.mem y !stackset) ->
	  savef y;
	  [finst3 (soii Fst) x spreg (string_of_int (offset y))]
      | NonTail(_), Save(x, y) -> assert (S.mem y !stackset); []
	  (* 復帰の仮想命令の実装 (caml2html: emit_restore) *)
      | NonTail(x), Restore(y) when List.mem x allregs ->
	  [finst3 (soii Ldi) x spreg (string_of_int (offset y))]
      | NonTail(x), Restore(y) ->
	  assert (List.mem x allfregs);
	  [finst3 (soii Fld) x spreg (string_of_int (offset y))]
	    (* 末尾だったら計算結果を第一レジスタにセットしてret (caml2html: emit_tailret) *)
      | Tail, (Nop | Store _ | Fstore _ | Save _(* | Pc _ | Pf _*) as exp) ->
	  (g' (NonTail(Id.gentmp Type.Unit), exp)) @ [finst0 (soii Ret)]
      | Tail, (Floor _ | Float_of_int _ (*| Rf*) as exp) ->
	  (g' (NonTail(fregs.(0)), exp)) @ [finst0 (soii Ret)]
      | Tail, (Add _ | Sub _ | Mul _ | And _ | Load _ 
	| Or _ | Xor _ | Nor _ | Ori _ | Nori _ | Xori _
	| Andi _ | Addi _ | Subi _ | Muli _ (*| Ri*) as exp) ->
	  (g' (NonTail(regs.(0)), exp)) @ [finst0 (soii Ret)]
      | Tail, (Fadd _ | Fmul _ | Fdiv _ | Finv _ | Fsub _ | Fsqrt _ | Fload _  as exp) ->
	  (g' (NonTail(fregs.(0)), exp)) @ [finst0 (soii Ret)]
      | Tail, (Restore(x) as exp) ->
	  (match locate x with
	     | [i] -> g' (NonTail(regs.(0)), exp)
	     | [i; j] when i + 1 = j -> g' (NonTail(fregs.(0)), exp)
	     | _ -> assert false) @ [finst0 (soii Ret)]
      | Tail, IfEq(x, y', e1, e2) ->
	  g'_tail_if e1 e2 x y' (soii Bne)
      | Tail, IfLE(x, y', e1, e2) ->
	  g'_tail_if e1 e2 x y' (soii Bgt)
      | Tail, IfGE(x, y', e1, e2) ->
	  g'_tail_if e1 e2 x y' (soii Blt)
      | Tail, IfFEq(x, y, e1, e2) ->
	  g'_tail_if e1 e2 x y (soii Fbne)
      | Tail, IfFLE(x, y, e1, e2) ->
	  g'_tail_if e1 e2 x y (soii Fbgt)
      | NonTail(z), IfEq(x, y', e1, e2) ->
	  g'_non_tail_if (NonTail(z)) e1 e2 x y' (soii Bne)
      | NonTail(z), IfLE(x, y', e1, e2) ->
	  g'_non_tail_if (NonTail(z)) e1 e2 x y' (soii Bgt)
      | NonTail(z), IfGE(x, y', e1, e2) ->
	  g'_non_tail_if (NonTail(z)) e1 e2 x y' (soii Blt)
      | NonTail(z), IfFEq(x, y, e1, e2) ->
	  g'_non_tail_if (NonTail(z)) e1 e2 x y (soii Fbne)
      | NonTail(z), IfFLE(x, y, e1, e2) ->
	  g'_non_tail_if (NonTail(z)) e1 e2 x y (soii Fbgt)
	    (* 関数呼び出しの仮想命令の実装 (caml2html: emit_call) *)
      | Tail, CallCls(x, ys, zs) -> raise Exit
      | Tail, CallDir(Id.L(x), ys, zs) -> (* 末尾呼び出し *)
	  (g'_args [] ys zs) @ [finst1 (soii Jump) x]
      | NonTail(a), CallCls(x, ys, zs) -> raise Exit
      | NonTail(a), CallDir(Id.L(x), ys, zs) ->
	  let tmp = (g'_args [] ys zs) in
	  let ss = stacksize () in
	    tmp @
	      [finst3 (soii Naddi) spreg spreg (string_of_int ss);
	       finst1 (soii Call) x;
	       finst3 "subi" spreg spreg (string_of_int ss)]
	    @
	      (if List.mem a allregs && a <> regs.(0) then
		 [finst3 (soii Nadd) a zreg regs.(0)]
	       else if List.mem a allfregs && a <> fregs.(0) then
		 [finst3 (soii Nfadd) a fzreg fregs.(0)] else [])
and g'_tail_if e1 e2 x y bn =
  let b_else = Id.genid "else" in
  let stackset_back = !stackset in
  let tmp = 
    [finst3 bn x y b_else] @
      (g (Tail, e1)) @
      [flabel b_else] in
    stackset := stackset_back;
    tmp @ (g (Tail, e2))
and g'_non_tail_if dest e1 e2 x y bn =
  let b_else = Id.genid ("else") in
  let b_cont = Id.genid ("cont") in
  let stackset_back = !stackset in
  let tmp = 
    [finst3 bn x y b_else] @
      (g (dest, e1)) in
  let stackset1 = !stackset in
  let tmp2 = 
    [finst1 (soii Jump) b_cont;
     flabel b_else] in
    stackset := stackset_back;
    let tmp3 = 
      (g (dest, e2)) @
	[flabel b_cont] in
    let stackset2 = !stackset in
      stackset := S.inter stackset1 stackset2;
      tmp @ tmp2 @ tmp3
and g'_args x_reg_cl ys zs =
  let (i, yrs) =
    List.fold_left
      (fun (i, yrs) y -> (i + 1, (y, regs.(i)) :: yrs))
      (0, x_reg_cl)
      ys in
    (List.map
       (fun (y, r) -> finst3 (soii Nadd) r zreg y)
       (shuffle swreg yrs)) @
      let (d, zfrs) =
	List.fold_left
	  (fun (d, zfrs) z -> (d + 1, (z, fregs.(d)) :: zfrs))
	  (0, [])
	  zs in
	(List.map
	   (fun (z, fr) ->
	      finst3 (soii Nfadd) fr fzreg z)
	   (shuffle fswreg zfrs))

let h { name = Id.L(x); args = _; fargs = _; body = e; ret = _ } =
  let tmp = [flabel x] in
    tmp @ (stackset := S.empty;
	   stackmap := [];
	   g (Tail, e))

let prep_op x =
  if is_reg x then String.sub x 1 (String.length x - 1) else x
    
let string_of_a x =
  if x.ac = - 1 then
    sprintf "%s : " x.nm
  else if x.ac = 0 then
    sprintf "\t%s" x.nm
  else if x.ac = 1 then
    sprintf "\t%s\t%s" x.nm (prep_op x.a1)
  else if x.ac = 2 then
    sprintf "\t%s\t%s %s" x.nm (prep_op x.a1) (prep_op x.a2)
  else 
    sprintf "\t%s\t%s %s %s" x.nm (prep_op x.a1) (prep_op x.a2) (prep_op x.a3)

let string_of_alist (x, _) =
  sprintf "%s\n"
    (String.concat "\n"
       (List.map (fun y -> string_of_a y) x))

let get_label_index y name =
  (List.find (fun x -> x.nm = name && x.ac = - 1) y).index

exception ImValueOverflow
exception Exit5
exception Exit6

(*
  let string_of_bi_a x l =
(*  print_endline (string_of_int (get_label_index l "L_fib_11"));
  print_endline x.nm;*)
  let p = 
  if x.ac = - 1 then ""
  else if x.ac = 0 then
  let y = opcode_of x.nm in
  sprintf "%02X000000\n" (y lsl 2)
  else if x.ac = 1 then
  try
  let y = opcode_of x.nm in
  let z = get_label_index l x.a1 in
  sprintf "%02X%06X\n" ((y lsl 2) lor (z lsr 24)) (z land 0xffffff)
  with Not_found ->
  match x.a1 with
  | _ -> raise Exit6
  else if x.ac = 2 then
  let y = opcode_of x.nm in
  let z = int_of_reg x.a1 in
  let w = int_of_reg x.a2 in
  sprintf "%04X0000\n" ((y lsl 10) lor (z lsl 5) lor w)
  else if x.ac = 3 then
  let y = opcode_of x.nm in
  let z = int_of_reg x.a1 in
  let w = int_of_reg x.a2 in
  let u =
  if is_reg x.a3 then (int_of_reg x.a3) lsl 11
  else if x.a3.[0] = '-' ||
  x.a3.[0] = '0' || x.a3.[0] = '1' ||
  x.a3.[0] = '2' || x.a3.[0] = '3' ||
  x.a3.[0] = '4' || x.a3.[0] = '5' ||
  x.a3.[0] = '6' || x.a3.[0] = '7' ||
  x.a3.[0] = '8' || x.a3.[0] = '9' then
  int_of_string x.a3
  else (get_label_index l x.a3) - x.index in
(*値が幅に収まっているか確かめる*)
  if u < (- 32768) || u > 32767 then raise ImValueOverflow
  else
  sprintf "%04X%04X\n" ((y lsl 10) lor (z lsl 5) lor w) (u land 0xffff)
  else raise Exit5 in
(*    print_endline p;*)
  p
*)
(*
  let string_of_binary (x, _) =
  let i = ref 0 in
  List.iter (fun y ->
  if y.ac = - 1 || (y.nm = (soii Call) &&
  (
  try
  ignore (get_label_index x y.a1); false
  with Not_found -> true
  ))
  then
  y.index <- !i
  else 
  let p = !i in incr i; y.index <- p) x;
  String.concat ""
  ((List.map (fun y -> string_of_bi_a y x) x) @
  ["00000000\n"; "00000000\n"; "00000000\n"; "00000000\n"; "FFFFFFFF\n"])
*)

let string_of_flist (_, x) =
  (*  print_endline (string_of_int (List.length x));*)
  sprintf "%s\n"
    (String.concat "\n"
       (List.map (fun y -> Int32.format "%08X" (Int32.bits_of_float y)) x))


let prep s =
  let r = ref "" in
    for i = 0 to String.length s - 1 do
      if s.[i] = '%' then () else r := !r ^ (String.make 1 s.[i])
    done; !r
      

      
      
let f oc foc istest memext memin memout memsp memhp floffset (Prog(fl, fundefs, e)) =
  (*型つけ*)
  if istest then ignore (memext + memin + memout + memsp + memhp + floffset);
  let lmain = Id.genid "main" in
  let fid255 = Id.genid "fid255" in
  let fid10_0 = Id.genid "fid10_0" in
  let fl = fl @ [(Id.L fid255, 255.0);
		 (Id.L fid10_0, 1000000000.0)] in
  let fli = Array.of_list fl in
    printf "fp table size is %d\n" (Array.length fli);
    let ear = Array.make 1006 0 in
      
    let ear = 
      Array.mapi
	(fun i _ ->
	   if i <= 56 then (0, 0)
	   else if i = 57 then (1, 0)
	   else if i = 58 then (2, 0)
	   else if i <= 108 then (0, i + 50 + memext)
	   else if i <= 158 then (0, -1)
	   else if i = 159 then (0, i + 1 + memext)
	   else if i = 160 then (0, 109 + memext)
	   else if i <= 340 then (0, (i - 161) * 3 + 341 + memext)
	   else if i <= 880 then (0, 0)
	   else if i = 881 then (0, 883 + memext)
	   else if i = 882 then (0, 886 + memext)
	   else if i <= 945 then (0, 0)
	   else if i <= 1005 then (0, (i - 946) * 11 + 1006 + memext)
	   else raise Exit) ear in
      
    let ear =
      List.flatten
	(Array.to_list
	   (Array.mapi
	      (fun i (x, y) ->
		 let i = i + memext in
		   if x = 0 then
		     if y = 0 then [finst3 (soii Sti) zreg zreg (string_of_int i)]
		     else 
		       [finst3 (soii Naddi) regs.(0) zreg (string_of_int y);
			finst3 (soii Sti) regs.(0) zreg (string_of_int i)]
		   else if x = 1 then [finst3 (soii Fld) fregs.(0) fid255 "0";
				       finst3 (soii Fst) fregs.(0) zreg (string_of_int i)]
		   else if x = 2 then [finst3 (soii Fld) fregs.(0) fid10_0 "0";
				       finst3 (soii Fst) fregs.(0) zreg (string_of_int i)]
		   else raise Exit) ear)) in
      
    let ret =
      List.flatten
	[
	  [
	    finst0 (soii Nnop);
	    finst0 (soii Nnop);
	    (*スタックポインタ初期化*)
	    finst3 (soii Naddi) spreg zreg (string_of_int memsp);
	    (*ヒープポインタ初期化*)
	    (*memhpは大きいのでとりあえずTODO:*)
	    finst3 (soii Naddi) hpreg zreg (string_of_int (memhp / 10));
	    finst3 (soii Nmuli) hpreg hpreg (string_of_int 10);
	    (*出力データポインタ初期化*)
	    finst3 (soii Naddi) regs.(0) zreg (string_of_int (memout + 1));
	    finst3 (soii Sti) regs.(0) zreg (string_of_int memout);
	  ];
	  (*外部変数領域初期化*)
	  ear;
	  [finst1 (soii Jump) lmain];
	  (List.flatten (List.map (fun fundef -> h fundef) fundefs));
	  [flabel lmain];
	  (stackset := S.empty;
	   stackmap := [];
	   g (NonTail(regs.(0)), e))
	] in
    let ret =
      List.map (fun x ->
		  if x.nm = (soii Fld) && not (is_reg x.a2) then
		    try
		      for i = 0 to Array.length fli - 1 do
			if (match fli.(i) with (Id.L y, _) -> y) = x.a2 then
			  (x.a2 <- zreg; x.a3 <- string_of_int (i + floffset); raise Exit)
		      done; x
		    with Exit -> x
		  else x) ret in
    let ret = (ret, snd (List.split fl)) in
      output_string oc (string_of_alist ret);
      output_string foc (string_of_flist ret)
