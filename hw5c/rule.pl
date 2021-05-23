father(X):-parent(A,X), male(A), write(A).
mother(X):-parent(A,X), female(A), write(A).
grandfather(X):-parent(A,X), parent(B,A), male(B), write(B).
grandmother(X):-parent(A,X), parent(B,A), female(B), write(B).