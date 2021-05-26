hanoi(N):-
	N > 0 ->
	move(N,1,2,3).	

move(N,Start,End,Via):-
	N =:= 1 ->
	print(N,Start,End);
	N1 is N - 1,
	move(N1,Start,Via,End),
	print(N,Start,End),
	move(N1,Via,End,Start).

print(N,Start,End):-
	write(N), write('->['),
	write(Start), write(','),
	write(End), write(']'), nl.