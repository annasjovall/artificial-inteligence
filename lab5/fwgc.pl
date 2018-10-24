/*
 * FARMER GOAT WOLF AND CABBAGE PROBLEM
 */ 

/*
 * Go predicate
 * This is the top-level goal.
 * Call as follows:
 *     ?- go(state(e,e,e,e), state(w,w,w,w)).
 */
 
go(Start,Goal) :-
	empty_stack(Empty_visited_stack),
	stack(Start,Empty_visited_stack,Visited_stack),
	path(Start,Goal,Visited_stack).

	
/*
 * Path predicates
 */

path(Goal,Goal,Visited_stack) :-
	write('Solution path in reverse order is:' ), nl,
	write(Visited_stack).

path(State,Goal,Visited_stack) :-
	move(State,Next_state),
	not(member_stack(Next_state,Visited_stack)),
	stack(Next_state,Visited_stack,New_visited_stack),
	path(Next_state,Goal,New_visited_stack).

	
/*
 * Move predicates
 */
% Farmer takes wolf
move(state(X,X,G,C), state(Y,Y,G,C)) :-
   opp(X,Y), 
   not(unsafe(state(Y,Y,G,C))).

% Farmer takes goat
move(state(X,W,X,C), state(Y,W,Y,C)) :- 
	opp(X,Y), 
	not(unsafe(state(Y,W,Y,C))).
	
% Farmer takes cabbage
move(state(X,W,G,X), state(Y,W,G,Y)) :- 
	opp(X,Y), 
	not(unsafe(state(Y,W,G,Y))).
	
% Farmer takes self
move(state(X,W,G,C), state(Y,W,G,C)) :- 
	opp(X,Y), 
	not(unsafe(state(Y,W,G,C))).
	
/*
 * Unsafe predicates
 */
unsafe(state(X,Y,Y,_)) :- opp(X,Y).
unsafe(state(X,_,Y,Y)) :- opp(X,Y).


/*
 * Opp predicates
 */
opp(e,w).
opp(w,e). 

 
/*
 * Stack abstract data type.
 */ 
 
member(X,[X|_]).
member(X,[_|T]) :- member(X,T).

empty_stack([]).
member_stack(E, S) :- member(E, S).
stack(E, S, [E|S]).


/*
 * Definitions of writelist
 */

writelist([]) :- nl.
writelist([H|T]):- 
	write(H), 
	tab(1),  /* "tab(n)" skips n spaces. */
    writelist(T).

 


  
