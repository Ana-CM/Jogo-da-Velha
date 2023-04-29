/**
 * Ana Carolina Mendes Lino - 201865212AC
 * Paula Rinco Rodrigues Pereira -
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
    Rodada is 1,
    (
        Modo == 'n' -> 
            pede_jogada_normal(Linhas, Colunas, Rodada, Tabuleiro);
        Modo == 's' ->
            pede_jogada_simplificada(Linhas, Colunas, Rodada, Tabuleiro)
    ).
