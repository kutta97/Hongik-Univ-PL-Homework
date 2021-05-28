nQueen(N):-
	write('n='), write(N), nl,

promising(Q,C,N,[Q|Answer]):-
	C < N -> promising(Q+1,1,N,Answer)