type token =
  | BOOL of (bool)
  | INT of (int)
  | FLOAT of (float)
  | NOT
  | MINUS
  | PLUS
  | MINUS_DOT
  | PLUS_DOT
  | AST_DOT
  | SLASH_DOT
  | EQUAL
  | LESS_GREATER
  | LESS_EQUAL
  | GREATER_EQUAL
  | LESS
  | GREATER
  | IF
  | THEN
  | ELSE
  | IDENT of (Id.t)
  | LET
  | IN
  | REC
  | COMMA
  | ARRAY_CREATE
  | DOT
  | LESS_MINUS
  | SEMICOLON
  | LPAREN
  | RPAREN
  | EOF

open Parsing;;
# 2 "parser.mly"
  (* parserが利用する変数、関数、型などの定義 *)
  open Syntax
  open Lexing
    
  let addtyp x = (x, Type.gentyp ())

# 43 "parser.ml"
let yytransl_const = [|
  260 (* NOT *);
  261 (* MINUS *);
  262 (* PLUS *);
  263 (* MINUS_DOT *);
  264 (* PLUS_DOT *);
  265 (* AST_DOT *);
  266 (* SLASH_DOT *);
  267 (* EQUAL *);
  268 (* LESS_GREATER *);
  269 (* LESS_EQUAL *);
  270 (* GREATER_EQUAL *);
  271 (* LESS *);
  272 (* GREATER *);
  273 (* IF *);
  274 (* THEN *);
  275 (* ELSE *);
  277 (* LET *);
  278 (* IN *);
  279 (* REC *);
  280 (* COMMA *);
  281 (* ARRAY_CREATE *);
  282 (* DOT *);
  283 (* LESS_MINUS *);
  284 (* SEMICOLON *);
  285 (* LPAREN *);
  286 (* RPAREN *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* BOOL *);
  258 (* INT *);
  259 (* FLOAT *);
  276 (* IDENT *);
    0|]

let yylhs = "\255\255\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\003\000\007\000\007\000\004\000\004\000\005\000\005\000\
\006\000\006\000\000\000"

let yylen = "\002\000\
\003\000\002\000\001\000\001\000\001\000\001\000\005\000\001\000\
\002\000\002\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\006\000\002\000\003\000\003\000\003\000\003\000\
\006\000\005\000\002\000\001\000\008\000\007\000\003\000\003\000\
\001\000\004\000\002\000\001\000\002\000\001\000\003\000\003\000\
\003\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\033\000\003\000\004\000\005\000\000\000\000\000\
\000\000\000\000\006\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\001\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\035\000\000\000\000\000\042\000\041\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\007\000\
\000\000\000\000\000\000\000\000"

let yydgoto = "\002\000\
\015\000\016\000\049\000\043\000\017\000\051\000\075\000"

let yysindex = "\255\255\
\248\002\000\000\000\000\000\000\000\000\000\000\248\002\248\002\
\248\002\248\002\000\000\242\254\063\255\052\255\133\003\235\254\
\239\254\063\255\063\255\063\255\017\003\253\254\246\254\255\254\
\001\255\000\000\203\255\248\002\248\002\248\002\248\002\248\002\
\248\002\248\002\248\002\248\002\248\002\248\002\248\002\248\002\
\248\002\247\254\063\255\250\254\248\002\248\002\248\002\000\255\
\002\255\004\255\248\254\252\254\247\254\000\000\094\255\094\255\
\094\255\094\255\063\255\063\255\203\003\203\003\203\003\203\003\
\203\003\203\003\187\003\133\003\247\254\248\002\187\003\046\003\
\075\003\000\255\015\255\248\002\009\255\026\255\036\255\248\002\
\187\002\248\002\248\002\000\000\248\002\133\003\000\000\000\000\
\248\002\217\002\021\255\162\003\133\003\133\003\104\003\000\000\
\248\002\248\002\162\003\133\003"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\058\000\031\000\
\151\000\177\000\203\000\229\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\061\000\255\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\091\000\000\000\078\001\108\001\
\138\001\168\001\026\001\052\001\194\001\220\001\246\001\016\002\
\043\002\069\002\087\002\030\002\121\000\000\000\101\002\000\000\
\000\000\049\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\133\002\000\000\000\000\
\000\000\000\000\001\000\117\002\147\002\040\255\000\000\000\000\
\000\000\000\000\131\002\161\002"

let yygindex = "\000\000\
\004\000\097\000\000\000\000\000\000\000\000\000\245\255"

let yytablesize = 1256
let yytable = "\001\000\
\007\000\004\000\005\000\006\000\044\000\022\000\045\000\047\000\
\023\000\048\000\018\000\019\000\020\000\021\000\024\000\078\000\
\052\000\027\000\050\000\074\000\011\000\079\000\070\000\076\000\
\080\000\085\000\052\000\077\000\087\000\014\000\008\000\055\000\
\056\000\057\000\058\000\059\000\060\000\061\000\062\000\063\000\
\064\000\065\000\066\000\067\000\068\000\088\000\089\000\097\000\
\071\000\072\000\073\000\003\000\004\000\005\000\006\000\007\000\
\008\000\043\000\009\000\036\000\038\000\034\000\084\000\004\000\
\005\000\006\000\000\000\000\000\010\000\000\000\000\000\011\000\
\012\000\081\000\000\000\000\000\013\000\000\000\000\000\086\000\
\014\000\026\000\011\000\090\000\000\000\092\000\093\000\000\000\
\094\000\000\000\032\000\014\000\095\000\000\000\004\000\005\000\
\006\000\000\000\000\000\000\000\099\000\100\000\032\000\033\000\
\000\000\000\000\000\000\000\000\000\000\025\000\000\000\042\000\
\000\000\011\000\042\000\042\000\042\000\042\000\000\000\000\000\
\037\000\053\000\014\000\042\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\069\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\028\000\042\000\
\042\000\042\000\042\000\042\000\042\000\042\000\042\000\042\000\
\042\000\042\000\042\000\042\000\042\000\000\000\000\000\042\000\
\042\000\042\000\000\000\000\000\000\000\000\000\000\000\000\000\
\009\000\042\000\000\000\000\000\000\000\000\000\042\000\000\000\
\000\000\000\000\042\000\000\000\042\000\042\000\042\000\042\000\
\000\000\000\000\000\000\042\000\042\000\000\000\000\000\000\000\
\000\000\000\000\010\000\004\000\005\000\006\000\000\000\028\000\
\029\000\030\000\031\000\032\000\033\000\034\000\035\000\036\000\
\037\000\038\000\039\000\000\000\000\000\000\000\011\000\000\000\
\000\000\000\000\040\000\000\000\020\000\000\000\041\000\014\000\
\054\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\027\000\000\000\
\000\000\007\000\007\000\007\000\000\000\007\000\007\000\007\000\
\007\000\007\000\007\000\007\000\007\000\007\000\007\000\007\000\
\007\000\000\000\007\000\007\000\007\000\000\000\007\000\000\000\
\007\000\023\000\007\000\000\000\007\000\007\000\007\000\008\000\
\008\000\008\000\000\000\008\000\008\000\008\000\008\000\008\000\
\008\000\008\000\008\000\008\000\008\000\008\000\008\000\000\000\
\008\000\008\000\008\000\024\000\008\000\000\000\008\000\000\000\
\000\000\000\000\008\000\008\000\008\000\038\000\038\000\038\000\
\000\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
\038\000\038\000\038\000\038\000\038\000\012\000\038\000\038\000\
\038\000\000\000\038\000\000\000\038\000\000\000\000\000\000\000\
\038\000\038\000\038\000\032\000\032\000\032\000\000\000\032\000\
\032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
\032\000\032\000\032\000\011\000\032\000\032\000\032\000\000\000\
\032\000\000\000\032\000\000\000\000\000\000\000\032\000\032\000\
\032\000\037\000\037\000\037\000\000\000\037\000\037\000\037\000\
\037\000\037\000\037\000\037\000\037\000\037\000\037\000\037\000\
\037\000\022\000\037\000\037\000\037\000\000\000\037\000\000\000\
\037\000\000\000\000\000\000\000\037\000\037\000\037\000\028\000\
\028\000\028\000\000\000\028\000\028\000\028\000\028\000\028\000\
\028\000\028\000\028\000\028\000\028\000\028\000\028\000\021\000\
\028\000\028\000\028\000\000\000\028\000\000\000\000\000\000\000\
\000\000\000\000\028\000\028\000\028\000\009\000\009\000\009\000\
\009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
\009\000\013\000\009\000\009\000\000\000\000\000\009\000\000\000\
\009\000\000\000\000\000\000\000\009\000\000\000\009\000\010\000\
\010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
\010\000\010\000\010\000\014\000\010\000\010\000\000\000\000\000\
\010\000\000\000\010\000\000\000\000\000\000\000\010\000\000\000\
\010\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
\020\000\020\000\020\000\020\000\020\000\017\000\020\000\020\000\
\000\000\000\000\020\000\000\000\020\000\000\000\000\000\000\000\
\020\000\000\000\020\000\027\000\027\000\027\000\027\000\027\000\
\027\000\027\000\027\000\027\000\027\000\027\000\027\000\018\000\
\027\000\027\000\000\000\000\000\027\000\000\000\027\000\000\000\
\000\000\000\000\027\000\000\000\027\000\031\000\023\000\023\000\
\023\000\023\000\023\000\023\000\023\000\023\000\023\000\023\000\
\023\000\023\000\015\000\023\000\023\000\000\000\000\000\023\000\
\000\000\023\000\000\000\000\000\000\000\023\000\000\000\023\000\
\024\000\024\000\024\000\024\000\024\000\024\000\024\000\024\000\
\024\000\024\000\024\000\024\000\016\000\024\000\024\000\000\000\
\000\000\024\000\000\000\024\000\000\000\000\000\000\000\024\000\
\000\000\024\000\012\000\012\000\012\000\012\000\040\000\000\000\
\012\000\012\000\012\000\012\000\012\000\012\000\000\000\012\000\
\012\000\000\000\000\000\012\000\039\000\012\000\000\000\000\000\
\000\000\012\000\000\000\012\000\000\000\000\000\000\000\000\000\
\011\000\011\000\011\000\011\000\019\000\000\000\011\000\011\000\
\011\000\011\000\011\000\011\000\000\000\011\000\011\000\000\000\
\000\000\011\000\030\000\011\000\026\000\000\000\000\000\011\000\
\000\000\011\000\000\000\000\000\000\000\000\000\022\000\022\000\
\022\000\022\000\025\000\000\000\022\000\022\000\022\000\022\000\
\022\000\022\000\000\000\022\000\022\000\000\000\000\000\022\000\
\029\000\022\000\000\000\000\000\000\000\022\000\000\000\022\000\
\000\000\000\000\000\000\000\000\021\000\021\000\021\000\021\000\
\000\000\000\000\021\000\021\000\021\000\021\000\021\000\021\000\
\000\000\021\000\021\000\000\000\000\000\021\000\000\000\021\000\
\000\000\000\000\000\000\021\000\000\000\021\000\000\000\000\000\
\000\000\000\000\000\000\000\000\013\000\013\000\013\000\013\000\
\013\000\013\000\000\000\013\000\013\000\000\000\000\000\013\000\
\000\000\013\000\000\000\000\000\000\000\013\000\000\000\013\000\
\000\000\000\000\000\000\000\000\000\000\000\000\014\000\014\000\
\014\000\014\000\014\000\014\000\000\000\014\000\014\000\000\000\
\000\000\014\000\000\000\014\000\000\000\000\000\000\000\014\000\
\000\000\014\000\000\000\000\000\000\000\000\000\000\000\000\000\
\017\000\017\000\017\000\017\000\017\000\017\000\000\000\017\000\
\017\000\000\000\000\000\017\000\000\000\017\000\000\000\000\000\
\000\000\017\000\000\000\017\000\000\000\000\000\000\000\000\000\
\000\000\000\000\018\000\018\000\018\000\018\000\018\000\018\000\
\000\000\018\000\018\000\000\000\000\000\018\000\000\000\018\000\
\000\000\000\000\000\000\018\000\000\000\018\000\000\000\031\000\
\031\000\000\000\000\000\031\000\000\000\015\000\015\000\015\000\
\015\000\015\000\015\000\031\000\015\000\015\000\000\000\000\000\
\015\000\000\000\015\000\000\000\000\000\000\000\015\000\000\000\
\015\000\000\000\000\000\000\000\000\000\000\000\000\000\016\000\
\016\000\016\000\016\000\016\000\016\000\000\000\016\000\016\000\
\000\000\000\000\016\000\000\000\016\000\000\000\000\000\000\000\
\016\000\000\000\016\000\000\000\000\000\000\000\000\000\000\000\
\040\000\040\000\000\000\000\000\040\000\000\000\040\000\000\000\
\000\000\000\000\040\000\000\000\040\000\000\000\039\000\039\000\
\000\000\000\000\039\000\000\000\039\000\000\000\000\000\000\000\
\039\000\000\000\039\000\000\000\000\000\000\000\019\000\019\000\
\000\000\000\000\019\000\000\000\000\000\000\000\000\000\000\000\
\019\000\000\000\019\000\000\000\030\000\030\000\026\000\026\000\
\030\000\000\000\026\000\000\000\000\000\000\000\030\000\000\000\
\030\000\000\000\026\000\000\000\025\000\025\000\000\000\000\000\
\025\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\025\000\000\000\029\000\029\000\000\000\000\000\029\000\000\000\
\000\000\000\000\000\000\004\000\005\000\006\000\029\000\028\000\
\029\000\030\000\031\000\032\000\033\000\034\000\035\000\036\000\
\037\000\038\000\039\000\000\000\000\000\000\000\011\000\000\000\
\000\000\000\000\040\000\000\000\000\000\000\000\041\000\014\000\
\091\000\004\000\005\000\006\000\000\000\028\000\029\000\030\000\
\031\000\032\000\033\000\034\000\035\000\036\000\037\000\038\000\
\039\000\000\000\000\000\000\000\011\000\000\000\000\000\000\000\
\040\000\000\000\000\000\000\000\041\000\014\000\096\000\003\000\
\004\000\005\000\006\000\007\000\008\000\000\000\009\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\010\000\000\000\000\000\011\000\012\000\000\000\000\000\000\000\
\013\000\004\000\005\000\006\000\014\000\028\000\029\000\030\000\
\031\000\032\000\033\000\034\000\035\000\036\000\037\000\038\000\
\039\000\000\000\046\000\000\000\011\000\000\000\000\000\000\000\
\040\000\000\000\000\000\000\000\041\000\014\000\004\000\005\000\
\006\000\000\000\028\000\029\000\030\000\031\000\032\000\033\000\
\034\000\035\000\036\000\037\000\038\000\039\000\000\000\000\000\
\082\000\011\000\000\000\000\000\000\000\040\000\000\000\000\000\
\000\000\041\000\014\000\004\000\005\000\006\000\000\000\028\000\
\029\000\030\000\031\000\032\000\033\000\034\000\035\000\036\000\
\037\000\038\000\039\000\000\000\000\000\000\000\011\000\000\000\
\083\000\000\000\040\000\000\000\000\000\000\000\041\000\014\000\
\004\000\005\000\006\000\000\000\028\000\029\000\030\000\031\000\
\032\000\033\000\034\000\035\000\036\000\037\000\038\000\039\000\
\000\000\000\000\000\000\011\000\000\000\098\000\000\000\040\000\
\000\000\000\000\000\000\041\000\014\000\004\000\005\000\006\000\
\000\000\028\000\029\000\030\000\031\000\032\000\033\000\034\000\
\035\000\036\000\037\000\038\000\039\000\000\000\000\000\000\000\
\011\000\000\000\000\000\000\000\040\000\000\000\000\000\000\000\
\041\000\014\000\004\000\005\000\006\000\000\000\028\000\029\000\
\030\000\031\000\032\000\033\000\034\000\035\000\036\000\037\000\
\038\000\039\000\000\000\000\000\000\000\011\000\000\000\000\000\
\000\000\040\000\000\000\004\000\005\000\006\000\014\000\028\000\
\029\000\030\000\031\000\032\000\033\000\034\000\035\000\036\000\
\037\000\038\000\039\000\004\000\005\000\006\000\011\000\028\000\
\029\000\030\000\031\000\032\000\033\000\000\000\000\000\014\000\
\000\000\000\000\000\000\000\000\000\000\000\000\011\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\014\000"

let yycheck = "\001\000\
\000\000\001\001\002\001\003\001\026\001\020\001\024\001\011\001\
\023\001\020\001\007\000\008\000\009\000\010\000\029\001\024\001\
\026\001\014\000\020\001\020\001\020\001\030\001\029\001\022\001\
\029\001\011\001\026\001\024\001\020\001\029\001\000\000\028\000\
\029\000\030\000\031\000\032\000\033\000\034\000\035\000\036\000\
\037\000\038\000\039\000\040\000\041\000\020\001\011\001\027\001\
\045\000\046\000\047\000\000\001\001\001\002\001\003\001\004\001\
\005\001\000\000\007\001\011\001\000\000\022\001\074\000\001\001\
\002\001\003\001\255\255\255\255\017\001\255\255\255\255\020\001\
\021\001\070\000\255\255\255\255\025\001\255\255\255\255\076\000\
\029\001\030\001\020\001\080\000\255\255\082\000\083\000\255\255\
\085\000\255\255\000\000\029\001\089\000\255\255\001\001\002\001\
\003\001\255\255\255\255\255\255\097\000\098\000\009\001\010\001\
\255\255\255\255\255\255\255\255\255\255\013\000\255\255\015\000\
\255\255\020\001\018\000\019\000\020\000\021\000\255\255\255\255\
\000\000\025\000\029\001\027\000\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\043\000\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\000\000\055\000\
\056\000\057\000\058\000\059\000\060\000\061\000\062\000\063\000\
\064\000\065\000\066\000\067\000\068\000\255\255\255\255\071\000\
\072\000\073\000\255\255\255\255\255\255\255\255\255\255\255\255\
\000\000\081\000\255\255\255\255\255\255\255\255\086\000\255\255\
\255\255\255\255\090\000\255\255\092\000\093\000\094\000\095\000\
\255\255\255\255\255\255\099\000\100\000\255\255\255\255\255\255\
\255\255\255\255\000\000\001\001\002\001\003\001\255\255\005\001\
\006\001\007\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\255\255\255\255\255\255\020\001\255\255\
\255\255\255\255\024\001\255\255\000\000\255\255\028\001\029\001\
\030\001\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\000\000\255\255\
\255\255\001\001\002\001\003\001\255\255\005\001\006\001\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\255\255\018\001\019\001\020\001\255\255\022\001\255\255\
\024\001\000\000\026\001\255\255\028\001\029\001\030\001\001\001\
\002\001\003\001\255\255\005\001\006\001\007\001\008\001\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\255\255\
\018\001\019\001\020\001\000\000\022\001\255\255\024\001\255\255\
\255\255\255\255\028\001\029\001\030\001\001\001\002\001\003\001\
\255\255\005\001\006\001\007\001\008\001\009\001\010\001\011\001\
\012\001\013\001\014\001\015\001\016\001\000\000\018\001\019\001\
\020\001\255\255\022\001\255\255\024\001\255\255\255\255\255\255\
\028\001\029\001\030\001\001\001\002\001\003\001\255\255\005\001\
\006\001\007\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\000\000\018\001\019\001\020\001\255\255\
\022\001\255\255\024\001\255\255\255\255\255\255\028\001\029\001\
\030\001\001\001\002\001\003\001\255\255\005\001\006\001\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\000\000\018\001\019\001\020\001\255\255\022\001\255\255\
\024\001\255\255\255\255\255\255\028\001\029\001\030\001\001\001\
\002\001\003\001\255\255\005\001\006\001\007\001\008\001\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\000\000\
\018\001\019\001\020\001\255\255\022\001\255\255\255\255\255\255\
\255\255\255\255\028\001\029\001\030\001\005\001\006\001\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\000\000\018\001\019\001\255\255\255\255\022\001\255\255\
\024\001\255\255\255\255\255\255\028\001\255\255\030\001\005\001\
\006\001\007\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\000\000\018\001\019\001\255\255\255\255\
\022\001\255\255\024\001\255\255\255\255\255\255\028\001\255\255\
\030\001\005\001\006\001\007\001\008\001\009\001\010\001\011\001\
\012\001\013\001\014\001\015\001\016\001\000\000\018\001\019\001\
\255\255\255\255\022\001\255\255\024\001\255\255\255\255\255\255\
\028\001\255\255\030\001\005\001\006\001\007\001\008\001\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\000\000\
\018\001\019\001\255\255\255\255\022\001\255\255\024\001\255\255\
\255\255\255\255\028\001\255\255\030\001\000\000\005\001\006\001\
\007\001\008\001\009\001\010\001\011\001\012\001\013\001\014\001\
\015\001\016\001\000\000\018\001\019\001\255\255\255\255\022\001\
\255\255\024\001\255\255\255\255\255\255\028\001\255\255\030\001\
\005\001\006\001\007\001\008\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\016\001\000\000\018\001\019\001\255\255\
\255\255\022\001\255\255\024\001\255\255\255\255\255\255\028\001\
\255\255\030\001\005\001\006\001\007\001\008\001\000\000\255\255\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\018\001\
\019\001\255\255\255\255\022\001\000\000\024\001\255\255\255\255\
\255\255\028\001\255\255\030\001\255\255\255\255\255\255\255\255\
\005\001\006\001\007\001\008\001\000\000\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\255\255\018\001\019\001\255\255\
\255\255\022\001\000\000\024\001\000\000\255\255\255\255\028\001\
\255\255\030\001\255\255\255\255\255\255\255\255\005\001\006\001\
\007\001\008\001\000\000\255\255\011\001\012\001\013\001\014\001\
\015\001\016\001\255\255\018\001\019\001\255\255\255\255\022\001\
\000\000\024\001\255\255\255\255\255\255\028\001\255\255\030\001\
\255\255\255\255\255\255\255\255\005\001\006\001\007\001\008\001\
\255\255\255\255\011\001\012\001\013\001\014\001\015\001\016\001\
\255\255\018\001\019\001\255\255\255\255\022\001\255\255\024\001\
\255\255\255\255\255\255\028\001\255\255\030\001\255\255\255\255\
\255\255\255\255\255\255\255\255\011\001\012\001\013\001\014\001\
\015\001\016\001\255\255\018\001\019\001\255\255\255\255\022\001\
\255\255\024\001\255\255\255\255\255\255\028\001\255\255\030\001\
\255\255\255\255\255\255\255\255\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\255\255\018\001\019\001\255\255\
\255\255\022\001\255\255\024\001\255\255\255\255\255\255\028\001\
\255\255\030\001\255\255\255\255\255\255\255\255\255\255\255\255\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\018\001\
\019\001\255\255\255\255\022\001\255\255\024\001\255\255\255\255\
\255\255\028\001\255\255\030\001\255\255\255\255\255\255\255\255\
\255\255\255\255\011\001\012\001\013\001\014\001\015\001\016\001\
\255\255\018\001\019\001\255\255\255\255\022\001\255\255\024\001\
\255\255\255\255\255\255\028\001\255\255\030\001\255\255\018\001\
\019\001\255\255\255\255\022\001\255\255\011\001\012\001\013\001\
\014\001\015\001\016\001\030\001\018\001\019\001\255\255\255\255\
\022\001\255\255\024\001\255\255\255\255\255\255\028\001\255\255\
\030\001\255\255\255\255\255\255\255\255\255\255\255\255\011\001\
\012\001\013\001\014\001\015\001\016\001\255\255\018\001\019\001\
\255\255\255\255\022\001\255\255\024\001\255\255\255\255\255\255\
\028\001\255\255\030\001\255\255\255\255\255\255\255\255\255\255\
\018\001\019\001\255\255\255\255\022\001\255\255\024\001\255\255\
\255\255\255\255\028\001\255\255\030\001\255\255\018\001\019\001\
\255\255\255\255\022\001\255\255\024\001\255\255\255\255\255\255\
\028\001\255\255\030\001\255\255\255\255\255\255\018\001\019\001\
\255\255\255\255\022\001\255\255\255\255\255\255\255\255\255\255\
\028\001\255\255\030\001\255\255\018\001\019\001\018\001\019\001\
\022\001\255\255\022\001\255\255\255\255\255\255\028\001\255\255\
\030\001\255\255\030\001\255\255\018\001\019\001\255\255\255\255\
\022\001\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\030\001\255\255\018\001\019\001\255\255\255\255\022\001\255\255\
\255\255\255\255\255\255\001\001\002\001\003\001\030\001\005\001\
\006\001\007\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\255\255\255\255\255\255\020\001\255\255\
\255\255\255\255\024\001\255\255\255\255\255\255\028\001\029\001\
\030\001\001\001\002\001\003\001\255\255\005\001\006\001\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\255\255\255\255\255\255\020\001\255\255\255\255\255\255\
\024\001\255\255\255\255\255\255\028\001\029\001\030\001\000\001\
\001\001\002\001\003\001\004\001\005\001\255\255\007\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\017\001\255\255\255\255\020\001\021\001\255\255\255\255\255\255\
\025\001\001\001\002\001\003\001\029\001\005\001\006\001\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\255\255\018\001\255\255\020\001\255\255\255\255\255\255\
\024\001\255\255\255\255\255\255\028\001\029\001\001\001\002\001\
\003\001\255\255\005\001\006\001\007\001\008\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\255\255\255\255\
\019\001\020\001\255\255\255\255\255\255\024\001\255\255\255\255\
\255\255\028\001\029\001\001\001\002\001\003\001\255\255\005\001\
\006\001\007\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\255\255\255\255\255\255\020\001\255\255\
\022\001\255\255\024\001\255\255\255\255\255\255\028\001\029\001\
\001\001\002\001\003\001\255\255\005\001\006\001\007\001\008\001\
\009\001\010\001\011\001\012\001\013\001\014\001\015\001\016\001\
\255\255\255\255\255\255\020\001\255\255\022\001\255\255\024\001\
\255\255\255\255\255\255\028\001\029\001\001\001\002\001\003\001\
\255\255\005\001\006\001\007\001\008\001\009\001\010\001\011\001\
\012\001\013\001\014\001\015\001\016\001\255\255\255\255\255\255\
\020\001\255\255\255\255\255\255\024\001\255\255\255\255\255\255\
\028\001\029\001\001\001\002\001\003\001\255\255\005\001\006\001\
\007\001\008\001\009\001\010\001\011\001\012\001\013\001\014\001\
\015\001\016\001\255\255\255\255\255\255\020\001\255\255\255\255\
\255\255\024\001\255\255\001\001\002\001\003\001\029\001\005\001\
\006\001\007\001\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\001\001\002\001\003\001\020\001\005\001\
\006\001\007\001\008\001\009\001\010\001\255\255\255\255\029\001\
\255\255\255\255\255\255\255\255\255\255\255\255\020\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\029\001"

let yynames_const = "\
  NOT\000\
  MINUS\000\
  PLUS\000\
  MINUS_DOT\000\
  PLUS_DOT\000\
  AST_DOT\000\
  SLASH_DOT\000\
  EQUAL\000\
  LESS_GREATER\000\
  LESS_EQUAL\000\
  GREATER_EQUAL\000\
  LESS\000\
  GREATER\000\
  IF\000\
  THEN\000\
  ELSE\000\
  LET\000\
  IN\000\
  REC\000\
  COMMA\000\
  ARRAY_CREATE\000\
  DOT\000\
  LESS_MINUS\000\
  SEMICOLON\000\
  LPAREN\000\
  RPAREN\000\
  EOF\000\
  "

let yynames_block = "\
  BOOL\000\
  INT\000\
  FLOAT\000\
  IDENT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Syntax.t) in
    Obj.repr(
# 64 "parser.mly"
      ( _2 )
# 511 "parser.ml"
               : 'simple_exp))
; (fun __caml_parser_env ->
    Obj.repr(
# 66 "parser.mly"
   ( Unit )
# 517 "parser.ml"
               : 'simple_exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 68 "parser.mly"
       ( Bool(_1) )
# 524 "parser.ml"
               : 'simple_exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 70 "parser.mly"
    ( Int(_1) )
# 531 "parser.ml"
               : 'simple_exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 72 "parser.mly"
        ( Float(_1) )
# 538 "parser.ml"
               : 'simple_exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Id.t) in
    Obj.repr(
# 74 "parser.mly"
      ( Var(_1) )
# 545 "parser.ml"
               : 'simple_exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'simple_exp) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : Syntax.t) in
    Obj.repr(
# 76 "parser.mly"
         (
				let p = Parsing.rhs_start_pos 2 in
				  Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, Get(_1, _4)) )
# 555 "parser.ml"
               : 'simple_exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'simple_exp) in
    Obj.repr(
# 82 "parser.mly"
      ( _1 )
# 562 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 85 "parser.mly"
(
  let p = Parsing.rhs_start_pos 1 in
    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, Not(_2)) )
# 571 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 90 "parser.mly"
(
  let p = Parsing.rhs_start_pos 1 in
    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, match _2 with
	   | Float(f) -> Float(-.f) (* -1.23などは型エラーではないので別扱い *)
	   | e -> Neg(e)) )
# 582 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 96 "parser.mly"
    (
      let p = Parsing.rhs_start_pos 2 in
	Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, Add(_1, _3)) )
# 592 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 100 "parser.mly"
 (
	  let p = Parsing.rhs_start_pos 2 in
	    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, Sub(_1, _3)) )
# 602 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 104 "parser.mly"
     (
	      let p = Parsing.rhs_start_pos 2 in
		Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, Eq(_1, _3)) )
# 612 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 108 "parser.mly"
  (
		  let p = Parsing.rhs_start_pos 2 in
		    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, Not(Eq(_1, _3))) )
# 622 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 112 "parser.mly"
      (
		      let p = Parsing.rhs_start_pos 2 in
			Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, Not(LE(_3, _1))) )
# 632 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 116 "parser.mly"
   (
			  let p = Parsing.rhs_start_pos 2 in
			    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, Not(LE(_1, _3))) )
# 642 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 120 "parser.mly"
       (
			      let p = Parsing.rhs_start_pos 2 in
				Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, LE(_1, _3)) )
# 652 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 124 "parser.mly"
    (
				  let p = Parsing.rhs_start_pos 2 in
				    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, LE(_3, _1)) )
# 662 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : Syntax.t) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 129 "parser.mly"
(
  let p = Parsing.rhs_start_pos 1 in
    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, If(_2, _4, _6)) )
# 673 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 134 "parser.mly"
(
  let p = Parsing.rhs_start_pos 1 in
    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, FNeg(_2)) )
# 682 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 138 "parser.mly"
    (
      let p = Parsing.rhs_start_pos 2 in
	Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, FAdd(_1, _3)) )
# 692 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 142 "parser.mly"
 (
	  let p = Parsing.rhs_start_pos 2 in
	    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, FSub(_1, _3)) )
# 702 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 146 "parser.mly"
     (
	      let p = Parsing.rhs_start_pos 2 in
		Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, FMul(_1, _3)) )
# 712 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 150 "parser.mly"
  (
		  let p = Parsing.rhs_start_pos 2 in
		    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, FDiv(_1, _3)) )
# 722 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : Id.t) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 155 "parser.mly"
( Let(addtyp _2, _4, _6) )
# 731 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'fundef) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 158 "parser.mly"
(
  let p = Parsing.rhs_start_pos 3 in
    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol }, LetRec(_3, _5)) )
# 741 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Syntax.t) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'actual_args) in
    Obj.repr(
# 163 "parser.mly"
(
  let p = Parsing.rhs_start_pos 1 in
    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, App(_1, _2)) )
# 751 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'elems) in
    Obj.repr(
# 167 "parser.mly"
    ( Tuple(_1) )
# 758 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : 'pat) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 169 "parser.mly"
 (
	  let p = Parsing.rhs_start_pos 1 in
	    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, LetTuple(_3, _6, _8)) )
# 769 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 6 : 'simple_exp) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : Syntax.t) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 173 "parser.mly"
     (
	      let p = Parsing.rhs_start_pos 6 in
		Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, Put(_1, _4, _7)) )
# 780 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 177 "parser.mly"
  ( Let((Id.gentmp Type.Unit, Type.Unit), _1, _3) )
# 788 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'simple_exp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'simple_exp) in
    Obj.repr(
# 180 "parser.mly"
(
  let p = Parsing.rhs_start_pos 1 in
    Info({ln = p.pos_lnum; cn=p.pos_cnum - p.pos_bol}, Array(_2, _3)) )
# 798 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    Obj.repr(
# 184 "parser.mly"
    (
  let p = Parsing.rhs_start_pos 1 in
      failwith
	(Printf.sprintf "parse error near lines %d, characters %d"
	   p.pos_lnum 
	   (p.pos_cnum - p.pos_bol) )
    )
# 810 "parser.ml"
               : Syntax.t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : Id.t) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'formal_args) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 194 "parser.mly"
 ( { name = addtyp _1; args = _2; body = _4 } )
# 819 "parser.ml"
               : 'fundef))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Id.t) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'formal_args) in
    Obj.repr(
# 198 "parser.mly"
     ( addtyp _1 :: _2 )
# 827 "parser.ml"
               : 'formal_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Id.t) in
    Obj.repr(
# 200 "parser.mly"
  ( [addtyp _1] )
# 834 "parser.ml"
               : 'formal_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'actual_args) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'simple_exp) in
    Obj.repr(
# 205 "parser.mly"
( _1 @ [_2] )
# 842 "parser.ml"
               : 'actual_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'simple_exp) in
    Obj.repr(
# 208 "parser.mly"
( [_1] )
# 849 "parser.ml"
               : 'actual_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'elems) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 212 "parser.mly"
    ( _1 @ [_3] )
# 857 "parser.ml"
               : 'elems))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Syntax.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Syntax.t) in
    Obj.repr(
# 214 "parser.mly"
 ( [_1; _3] )
# 865 "parser.ml"
               : 'elems))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'pat) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Id.t) in
    Obj.repr(
# 218 "parser.mly"
     ( _1 @ [addtyp _3] )
# 873 "parser.ml"
               : 'pat))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Id.t) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Id.t) in
    Obj.repr(
# 220 "parser.mly"
  ( [addtyp _1; addtyp _3] )
# 881 "parser.ml"
               : 'pat))
(* Entry exp *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let exp (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Syntax.t)
