%parent relation where parent(x,y) where x is the parent of y
parent(tom,bob).
parent(pam,tom).
parent(tom,jim).

male(bob).
male(jim).
male(tom).

female(pam).

offspring(Y,X) :- parent(X,Y).

isSibling(X,Y) :-
	parent(Z,X),
	parent(Z,Y).

brother(X,Y) :-
	isSibling(X,Y),
	male(X).

sister(X,Y) :-
	isSibling(X,Y),
	female(X).

someone_has_child :- parent(_,_). %example of annonymous variables

%example of a structure
date(1,may,2001).

%more structure examples
triangle(point(2,3), point(4,6), point(6,2)).
horizontal(seg(point(X,Y),point(X1,Y))).

%list operations
member(X, L).

