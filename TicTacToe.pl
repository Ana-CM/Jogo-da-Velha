/**
 * Ana Carolina Mendes Lino - 201865212AC
 * Paula Rinco Rodrigues Pereira -
 */

%Importa a biblioteca XPCE para exibir o tabuleiro.
:- use_module(library(pce)).

inicio :-
    write('Digite a quantidade de linhas do Tabuleiro: '), 
    read(Linhas),
    validar_linhas(Linhas),
    write('Digite o modo de jogo (N ou S): '),
    read(Modo),
    validar_modo(Modo),
    Colunas is Linhas + 1,
    criar_tabuleiro(Linhas, Colunas).
    %pede_jogada_desafiante(Linhas, Colunas, Modo).

criar_tabuleiro(Linhas, Colunas) :-
    criar_tabuleiro_vazio(Linhas, Colunas, Tabuleiro). 
  %TODO:  imprime_tabuleiro(Tabuleiro).

criar_tabuleiro_vazio(0, _, _) :- !.
criar_tabuleiro_vazio(Linhas, Colunas, [LinhaAtualTabuleiro|ProximasLinhasTabuleiro]) :-
    criar_linha_vazia(Colunas, LinhaAtualTabuleiro),
    ProximasLinhas is Linhas - 1,
    criar_tabuleiro_vazio(ProximasLinhas, Colunas, ProximasLinhasTabuleiro).

criar_linha_vazia(0, _) :- !.
criar_linha_vazia(Colunas, [null|LinhaAtualTabuleiro]) :-
    ProximasColunas is Colunas - 1,
    criar_linha_vazia(ProximasColunas, LinhaAtualTabuleiro).

validar_linhas(Linhas) :-
    integer(Linhas),
    Linhas > 0.

validar_modo(Modo) :-
    (Modo == 'N'; Modo == 'S').
