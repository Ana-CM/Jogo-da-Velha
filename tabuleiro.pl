/**
 * Predicados relacionadas a criação do tabuleiro.
 */
criar_tabuleiro(Linhas, Colunas, Tabuleiro) :-
    criar_tabuleiro_vazio(Linhas, Colunas, Tabuleiro).

criar_tabuleiro_vazio(0, _, _) :- !.
criar_tabuleiro_vazio(Linhas, Colunas, [LinhaAtualTabuleiro|ProximasLinhasTabuleiro]) :-
    criar_linha_vazia(Colunas, LinhaAtualTabuleiro),
    ProximasLinhas is Linhas - 1,
    criar_tabuleiro_vazio(ProximasLinhas, Colunas, ProximasLinhasTabuleiro).

criar_linha_vazia(0, _) :- !.
criar_linha_vazia(Colunas, [0|LinhaAtualTabuleiro]) :-
    ProximasColunas is Colunas - 1,
    criar_linha_vazia(ProximasColunas, LinhaAtualTabuleiro).


% Predicado TEMPORARIO para imprimir o tabuleiro. // REMOVER DEPOIS
imprime_tabuleiro([]).
imprime_tabuleiro([Linha|Resto]) :-
    imprime_linha(Linha),
    nl,
    imprime_tabuleiro(Resto).

imprime_linha([]) :- !.
imprime_linha([Elemento|Resto]) :-
    write('|'),
    write(Elemento),
    imprime_linha(Resto).


replace([], _, _, []) :- !.
replace([_|T], 1, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 1,
    I1 is I - 1,
    replace(T, I1, X, R).
