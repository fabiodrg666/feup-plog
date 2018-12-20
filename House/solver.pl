:-use_module(library(clpfd)).
:-use_module(library(lists))

/**/
example(
	[
		[0,0], [2,0], [3,0],
		[2,1], [3,1],
		[2,2],
		[0,3], [3,3] 
	]).


/*
 * P1 - List [X1, Y1]
 * P2 - List [X2, Y2]
 * D? - The computed distance between the two points D1 and D2
*/
distance(P1, P2, D):-
	% element is ~ nth1
	element(1, P1, X1),
	element(2, P1, Y1),
	element(1, P2, X2),
	element(2, P2, Y2),
	D #= abs(X2-X1) * abs(X2-X1) + abs(Y2-Y1) * abs(Y2-Y1).

solver(ListHouses, PuzzleSize):-
	% a list with the two possible distances (distinct) %
	domain([D1,D2], 1, sup),
	all_distinct([D1,D2]),
	% create an auxiliar list with indexes for the list of houses %
	% the elements in list of houses are lists with a pair of values X and Y %
	% the predicate element only works with indexes, thus we need list of houses %
	length(Indexes, PuzzleSize), % fix size, get length list houses %
	domain(Indexes, 1, PuzzleSize),
	all_distinct(Indexes),
	% find the distances %
	findDistances(ListHouses, D1, D2),
	write(D1),
	write(D2).
			

findDistances([], _, _, _).
% The plog  %
findDistances(Indexes, ListHouses, D1, D2):-
	% pick one house %
	element(H1Index, Indexes, H1Index),
	nth1(H1Index, ListHouses, House1),
	% pick second house %
	element(H2Index, Indexes, H2Index),
	nth1(H2Index, ListHouses, House2),
	% compute distance %
	distance(House1, House2, D),
	D #= D1 #\ D #= D2, % attempt to link D to D1 or D2
	% remove the indexes from list %
	delete(Indexes, H1Index, Aux1),
	delete(Aux1, H2Index, Aux2),
	findDistances(Aux2, ListHouses, D1,  D2).