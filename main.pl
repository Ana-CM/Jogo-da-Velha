/**
 * Ana Carolina Mendes Lino - 201865212AC
 * Paula Rinco Rodrigues Pereira - 201865559C
 */

/**
 * Importa a biblioteca XPCE para exibir o tabuleiro.
 */
:- use_module(library(pce)).

/**
 * Importa os arquivos que contém os predicados utilizados.
 */
:- ensure_loaded(utils).
:- ensure_loaded(tabuleiro).
:- ensure_loaded(validacoes).
:- ensure_loaded(normal).
:- ensure_loaded(simplificada).

/**
 * Predicado principal do programa.
 */
inicio :-
    write('Digite a quantidade de linhas do Tabuleiro: '), 
    read(Linhas),
    validar_linhas(Linhas),
    write('Digite o modo de jogo (n ou s): '),
    read(Modo),
    validar_modo(Modo),
    Colunas is Linhas + 1,
    criar_tabuleiro(Linhas, Colunas, Tabuleiro),
    new(Window, picture('Jogo da Velha')),
    SizeHeight is Linhas * 100,
    SizeWidth is Colunas *100,
    send(Window, size, size(SizeWidth, SizeHeight)),
    Rodada is 1,
    (
        Modo == 'n' -> 
            pede_jogada_normal(Window, Linhas, Colunas, Rodada, Tabuleiro);
        Modo == 's' ->
            pede_jogada_simplificada(Window, Linhas, Colunas, Rodada, Tabuleiro)
    ).
