:- use_module(library(clpfd)).
:- use_module(library(pio)).
:- set_prolog_flag(double_quotes,codes).

all_chars([Head]) --> [Head], {[Head] \= "\n"}.
all_chars([Head|Tail]) --> [Head], {[Head] \= "\n"}, all_chars(Tail).
parse([Line]) --> all_chars(Line), "\n".
parse([Line|Tail]) --> all_chars(Line), "\n", parse(Tail).

count([_, _, _], Count, Count).
count([First, Second, Third, Fourth|Tail], Count, Result) :-
    Fourth #> First,
    IncreasedCount #= Count + 1,
    count([Second, Third, Fourth|Tail], IncreasedCount, Result).
count([First, Second, Third, Fourth|Tail], Count, Result) :-
    Fourth #=< First,
    count([Second, Third, Fourth|Tail], Count, Result).

solve(ListOfNumbers, Result) :- 
    count(ListOfNumbers, 0, Result).
    
main :-
    phrase_from_file(parse(ListOfNumbersAsStrings), "input"),
    maplist(number_codes, ListOfNumbers, ListOfNumbersAsStrings),
    solve(ListOfNumbers, Result),
    writeln(Result).