/*
 * MISSIONARY AND CANNIBALS PROBLEM, SOLVER
 *
 * Created by: Anna Palmqvist Sjövall
 * StudentID: 19832192
 */ 

/*
 * Go predicate
 * This is the top-level goal.
 * Call as follows:
 *     ?- go(state(3,3,e), state(0,0,w)).
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
% Lone cannibal crosses river across
move(state(M,C,B), state(M,CC,BB)) :-
   opp(B,BB), % makes sure boat moved 
   across(C, CC, B),
   not(unsafe(state(M,CC,BB))).

% Lone cannibal crosses river back
move(state(M,C,B), state(M,CC,BB)) :-
    opp(B, BB),
    back(C, CC, B),
    not(unsafe(state(M, CC, BB))).

% Lone missionary crosses river across
move(state(M,C,B), state(MM,C,BB)) :-
   opp(B,BB), % makes sure boat moved 
   across(M, MM, B),
   not(unsafe(state(MM,C,BB))).

% Lone missionary crosses river back
move(state(M,C,B), state(M,CC,BB)) :-
    opp(B, BB),
    back(C, CC, B),
    not(unsafe(state(M, CC, BB))).

% Two cannibals across
move(state(M,C,B), state(M, CC, BB)) :- 
    opp(B, BB), 
    across_x_2(C, CC, B),
	not(unsafe(state(M, CC, B))).
	
% Two cannibals back
move(state(M, C, B), state(M, CC, BB)) :- 
	opp(B, BB), 
    back_x_2(C, CC, B),
	not(unsafe(state(M, CC, BB))).
	
% Two missionaries across
move(state(M, C, B), state(MM, C, BB)) :- 
	opp(B, BB), 
    across_x_2(M, MM, B),
	not(unsafe(state(MM, C, BB))).

% Two missionaries back
move(state(M, C, B), state(MM, C, BB)) :-
    opp(B, BB),
    back_x_2(M, MM, B),
    not(unsafe(state(MM, C, BB))).

% One missionary and one cannibal across
move(state(M, C, B), state(MM, CC, BB)) :-
    opp(B, BB),
    across(C, CC, B),
    across(M, MM, B),
    not(unsafe(state(MM, CC, BB))).

% One missionary and one cannibal back
move(state(M, C, B), state(MM, CC, BB)) :-
    opp(B, BB),
    back(C, CC, B),
    back(M, MM, B),
    not(unsafe(state(MM, CC, BB))).
	
% Move one person across from before -> now
across(Before, Now, e) :-
    Before > 0,
    Now is Before-1.

% Move two persons across from before -> now
across_x_2(Before, Now, e) :-
    Before > 1,
    Now is Before-2.

% Move one person back from before -> now
back(Before, Now, w) :-
    Before < 3,
    Now is Before+1.

% Move two persons back from before -> now
back_x_2(Before, Now, w) :-
    Before < 2,
    Now is Before+2.


/*
 * Unsafe predicates
 */
unsafe(state(M,C,_)) :- 
    M < C,
    A is 3-M, B is 3-C,
    A < B.

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

 


  
