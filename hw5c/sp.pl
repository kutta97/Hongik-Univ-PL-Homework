edge(1,2,6).
edge(1,3,3).
edge(2,3,2).
edge(2,4,5).
edge(3,4,3).
edge(3,5,4).
edge(4,5,2).
edge(4,6,3).
edge(5,6,5).

path(X,Y,[X,Y],D):- 
    edge(X,Y,D).

path(X,Z,[X|W],D):- 
    edge(X,Y,D1), 
    path(Y,Z,W,D2), 
    D is D1 + D2.

shortestPath(X,X,[X,X],0):- !.
shortestPath(X,Y,MinP,MinD):-
    findall([D,P],path(X,Y,P,D),Set),
    sort(Set,Sorted),
    Sorted = [[MinD,MinP]|_].

sp(X,Y):-
	X < Y ->
	shortestPath(X,Y,Path,Distance),
	write(Path), nl,
	write(Distance);
	shortestPath(Y,X,Path,Distance),
	reverse(Path,ReversedPath),
	write(ReversedPath), nl,
	write(Distance).