%fact1
female(mary).
female(jane).
female(kate).
female(mia).
female(lisa).
male(john).
male(ian).
male(joe).
male(hue).

%fact2
parent(mary, jane).
parent(john, jane).
parent(mia, joe).
parent(ian, joe).
parent(jane, kate).
parent(joe, kate).
parent(kate, lisa).
parent(hue, lisa).

%rule
father(X):-parent(A,X), male(A), write(A).
mother(X):-parent(A,X), female(A), write(A).
grandmother(X):-parent(A,X), parent(B,A), female(B), write(B).
grandfather(X):-parent(A,X), parent(B,A), male(B), write(B).