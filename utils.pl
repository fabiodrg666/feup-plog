:- use_module(library(lists)).


%%%%% matrix utilities

%%% para ter um elemento de uma certa posição numa list
get_elem(Board,Index,Elem):-
  nth0(Index,Board,Elem).
%%% n esta a ser usada atm, semelhante à anterior
cicle_throw_pos([H|T],Number,CurrentEl):-
    Number \= 0 ->
    Number1 is Number - 1,
    cicle_throw_pos(T,Number1,CurrentEl);
    CurrentEl = H.
%%%% primeiro arg coordenadas segundo board e terceiro peça, com as coord obtemos peça e com a peça obtemos as coordenadas
take_piece(X1-Y1,Board,Piece):-
  get_elem(Board,Y1,Element),
  get_elem(Element,X1,Piece).

%% devolve uma peça dando outra
createPiece(X-Y,NewPiece):-
    NewPiece = X-Y.

%% substitui um itme numa lista
replace_item([_|T],0,Element,[Element|T]).
replace_item([H|T],Index,Element,[H|R]):-
  Index > -1,
  NewIndex is Index-1,
  replace_item(T,NewIndex,Element,R).

%%% substitui uma lista numa matrix e retorna o novo board com a nova peça (Element) na posição x-y
replace_in_matrix(X1-Y1,Board,Element,NewBoard):-
  get_elem(Board,Y1,ElemList),
  replace_item(ElemList,X1,Element,NewList),
  replace_item(Board,Y1,NewList,NewBoard).

%%%move um determinado Number peça da pos x1-y1 para x2-y2  e retorna no final board
move_piece(X1-Y1,X2-Y2,Number,Board,FinalBoard):-
  take_piece(X1-Y1,Board,PiecePlayer-PieceNumber),
  NewPieceNumber is PieceNumber-Number,
  replace_in_matrix(X1-Y1,Board,PiecePlayer-Number,NewBoard),
  replace_in_matrix(X2-Y2,NewBoard,PiecePlayer-Number,FinalBoard).

%%% retorna width e height de uma matrix
get_list_size(List,Width,Height):-
  proper_length(List,Height),
  last(List,Last),
  proper_length(Last,Width).


%%% retorna a width de uma matrix
get_width(List,Width):-
  get_list_size(List,Width,_).

%%% retorna a height de uma matrix
get_height(List,Height):-
  get_list_size(List,_,Height).

%%%valid_moves(Board,Player,ListOfMoves):-

%%%% verify is a certain piece as another as adjacent

verify_left(X-Y,Board,Piece):-
  X1 is X-1,
  take_piece(X1-Y,Board,Piece).

verify_right(X-Y,Board,Piece):-
  X1 is X+1,
  take_piece(X1-Y,Board,Piece).

verify_up(X-Y,Board,Piece):-
  Y1 is Y-1,
  take_piece(X-Y1,Board,Piece).

verify_down(X-Y,Board,Piece):-
  Y1 is Y+1,
  take_piece(X-Y1,Board,Piece).

verify_downright(X-Y,Board,Piece):-
  Y1 is Y+1,
  X1 is X+1,
  take_piece(X1-Y1,Board,Piece).

verify_downleft(X-Y,Board,Piece):-
  Y1 is Y+1,
  X1 is X-1,
  take_piece(X1-Y1,Board,Piece).

verify_topleft(X-Y,Board,Piece):-
  Y1 is Y-1,
  X1 is X-1,
  take_piece(X1-Y1,Board,Piece).

verify_topright(X-Y,Board,Piece):-
  Y1 is Y-1,
  X1 is X+1,
  take_piece(X1-Y1,Board,Piece).

%%% verifica qual é a peça adjacent à one
check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_left(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('Left').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_right(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('Right').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_up(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('UP').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_down(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('DOWN').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_downright(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('DOWN_RIGHT').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_downleft(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('DOWN_LEFT').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_topleft(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('TOP_LEFT').

check_adjacent(Board,PieceOne,PieceTwo):-
  take_piece(X-Y,Board,PieceOne),
  verify_topright(X-Y,Board,Piece),
  Piece = PieceTwo,
  write('TOP_RIGHT').

%%%% verificar por coordenadas

check_adjacent_coords(Board,X-Y,Piece):-
  verify_right(X-Y,Board,Piece).

check_adjacent_coords(Board,X-Y,Piece):-
  verify_up(X-Y,Board,Piece).

check_adjacent_coords(Board,X-Y,Piece):-
  verify_down(X-Y,Board,Piece).

check_adjacent_coords(Board,X-Y,Piece):-
  verify_downright(X-Y,Board,Piece).

check_adjacent_coords(Board,X-Y,Piece):-
  verify_downleft(X-Y,Board,Piece).

check_adjacent_coords(Board,X-Y,Piece):-
  verify_topleft(X-Y,Board,Piece).

check_adjacent_coords(Board,X-Y,Piece):-
  verify_topright(X-Y,Board,Piece).


%%%%%%%% console utilities

clear_console:-
  clear_console(30),!.

clear_console(0).
clear_console(X):-
  nl,
  X1 is X-1,
  clear_console(X1).

continue:-
  get_char(_).

getChar(Input):-
  get_char(Input),
	get_char(_).

getInt(Input):-
	get_code(TempInput),
	Input is TempInput - 48.
