/**
 * Ana Carolina Mendes Lino - 201865212AC
 * Paula Rinco Rodrigues Pereira -
 */

/**
 * Predicados auxiliares.
 */


/**
 * Pega o elemento de uma determinada posição do tabuleiro.
 */
get_elemento(Tabuleiro, Linha, Coluna, Simbolo, Resultado) :-
    IndiceLinha is Linha - 1,
    length(LinhaPrefixo, IndiceLinha),
    append(LinhaPrefixo, [LinhaSelecionada|_], Tabuleiro),

    IndiceColuna is Coluna - 1,
    length(ColunaPrefixo, IndiceColuna),
    append(ColunaPrefixo, [Valor|_], LinhaSelecionada),

    (Valor = Simbolo ->
        Resultado = 'true'
    ;
        Resultado = 'false'
    ).

/**
 * Seta o elemento de uma determinada posição do tabuleiro.
 */
set_elemento(Tabuleiro, Linha, Coluna, Simbolo, TabuleiroAtualizado) :-
    IndiceLinha is Linha - 1,
    length(LinhaPrefixo, IndiceLinha),
    append(LinhaPrefixo, [LinhaSelecionada|LinhaSufixo], Tabuleiro),

    IndiceColuna is Coluna - 1,
    length(ColunaPrefixo, IndiceColuna),
    append(ColunaPrefixo, [_|ColunaSufixo], LinhaSelecionada),

    append(ColunaPrefixo, [Simbolo|ColunaSufixo], NovaLinhaSelecionada),
    append(LinhaPrefixo, [NovaLinhaSelecionada|LinhaSufixo], NovoTabuleiro),
    TabuleiroAtualizado = NovoTabuleiro.

/**
 * Retorna o valor da heurística de uma determinada posição do tabuleiro.
 */
calcula_heuristica_posicao(Linhas, Colunas, Linha, Coluna, Tabuleiro, Heuristica) :-
    ( Linha > 0, Coluna > 0, Linha =< Linhas, Coluna =< Colunas ->
        get_elemento(Tabuleiro, Linha, Coluna, 'o', Resultado),
        ( Resultado = 'true' ->
            Heuristica is 3
        ;
            get_elemento(Tabuleiro, Linha, Coluna, 0, Resultado2),
            ( Resultado2 = 'true' ->
                Heuristica is 2
            ;
                Heuristica is 1
            )
        )
    ;
        Heuristica is 0
    ).
        