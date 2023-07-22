sort1(L1,Sorted) :- findifPerm(L1,Sorted), findif(Sorted).
% to check if a given list is sorted
findif([]).
findif([_]).
findif([X,Y|T]) :- Y>=X, findif([Y|T]).
% Permutation logic
findifPerm(L,L).
findifPerm(L,[H|T]) :-
    append(V,[H|U],L),
    append(V,U,W), findifPerm(W,T).



sort2(L, L).
sort2(L, S) :-
	append(X, [A,B|Y], L),
	A>=B, !,
	append(X, [B,A|Y], M),
	sort2(M,S).