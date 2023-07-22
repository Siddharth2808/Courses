ed(X,Y) :- edge(Y,X); edge(X,Y) .

edge(1,2).
edge(1,4).
edge(1,3).
edge(2,3).
edge(2,5).
edge(3,4).
edge(3,5).
edge(4,5).
edge(2,6).
edge(1,6).

op(P,[V2|P],L,V1,V2) :- 
    ed(V1,V2),
    length([V2|P],L).

op(Visited,Path,L,V1,V2) :-
       ed(V1,C),           
       C \== V2,
       \+member(C,Visited),
       op([C|Visited],Path,L,C,V2).

% here path length b/w two vertices s and t = no of edges while traversing from s to t.
% edges are bidirectional
% so no. of edges b/w s and t must be = k

showpath(L,V1,V2,Path) :-
        L1 is L+1,
        op([V1],Q,L1,V1,V2),  
        reverse(Q,Path).
