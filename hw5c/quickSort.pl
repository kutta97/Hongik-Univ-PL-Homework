quickSort([]).
quickSort(List):-
	qSortHelper(List,_).

qSortHelper([],[]).
qSortHelper([Pivot|List],Sorted):-
	divide(Pivot,List,Lesser,Greater),
	writeDevide(Pivot,Lesser,Greater),
	qSortHelper(Lesser,SortedLesser),
	qSortHelper(Greater,SortedGreater),
	merge(SortedLesser,[Pivot|SortedGreater],Sorted),
	writeMerge(SortedLesser,Pivot,SortedGreater).

divide(_,[],[],[]).
divide(Pivot,[H|List],Lesser,[H|Greater]):-
	Pivot =< H -> divide(Pivot,List,Lesser,Greater).
divide(Pivot,[H|List],[H|Lesser],Greater):-
	Pivot > H -> divide(Pivot,List,Lesser,Greater).

writeDevide(_,[],[]).
writeDevide(Pivot,Lesser,Greater):-
	write('divide = '), write(Pivot), write(' | '),
	write(Lesser), write(Greater), nl.

writeMerge(SortedLesser,Pivot,SortedGreater):-
	write('merge : '),
	list_empty(SortedLesser,R1),list_empty(SortedGreater,R2),
	R1,R2 ->
	write('['), write(Pivot), write(']'), nl;
	write(SortedLesser),
	write('['), write(Pivot), write(']'),
	write(SortedGreater), nl.

list_empty([],true).
list_empty([_|_],false).
	