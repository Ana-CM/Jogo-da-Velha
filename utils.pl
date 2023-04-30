/**
 * Ana Carolina Mendes Lino - 201865212AC
 * Paula Rinco Rodrigues Pereira -
 */

/**
 * Predicados auxiliares.
 */


/**
 * Valida elemento de uma determinada posição do tabuleiro.
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
                Heuristica is 1
            ;
                Heuristica is 2
            )
        )
    ;
        Heuristica is 0
    ).
        
calcula_heuristica_total_adjacente(Colunas, Linhas, Coluna, Linha, Tabuleiro, Heuristica) :- 
    calcula_heuristica_posicao(Linhas, Colunas, Linha - 1, Coluna - 1, Tabuleiro, Heuristica1),
    calcula_heuristica_posicao(Linhas, Colunas, Linha - 1, Coluna, Tabuleiro, Heuristica2),
    calcula_heuristica_posicao(Linhas, Colunas, Linha - 1, Coluna + 1, Tabuleiro, Heuristica3),
    calcula_heuristica_posicao(Linhas, Colunas, Linha, Coluna - 1, Tabuleiro, Heuristica4),
    calcula_heuristica_posicao(Linhas, Colunas, Linha, Coluna + 1, Tabuleiro, Heuristica5),
    calcula_heuristica_posicao(Linhas, Colunas, Linha + 1, Coluna - 1, Tabuleiro, Heuristica6),
    calcula_heuristica_posicao(Linhas, Colunas, Linha + 1, Coluna, Tabuleiro, Heuristica7),
    calcula_heuristica_posicao(Linhas, Colunas, Linha + 1, Coluna + 1, Tabuleiro, Heuristica8),
    Heuristica is Heuristica1 + Heuristica2 + Heuristica3 + Heuristica4 + Heuristica5 + Heuristica6 + Heuristica7 + Heuristica8.