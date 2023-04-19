/**
 * Ana Carolina Mendes Lino - 201865212AC
 * Paula Rinco Rodrigues Pereira -
 */

/**
 * Predicados Relacionadas a validações.
 */
validar_linhas(Linhas) :-
    integer(Linhas),
    Linhas > 0.

validar_modo(Modo) :-
    (Modo = 'n'; Modo = 's').

validar_jogada_normal(Linha, Linhas, Coluna, Colunas) :-
    integer(Linha),
    integer(Coluna),
    Linha > 0,
    Linha =< Linhas,
    Coluna > 0,
    Coluna =< Colunas.

validar_jogada_simples(Coluna, Colunas) :-
    integer(Coluna),
    Coluna > 0,
    Coluna =< Colunas.

/**
 * Valida se o jogo acabou.
 */
verifica_se_acabou(Rodada, Tabuleiro, Linhas, Colunas, Linha, Coluna, Simbolo, Resultado) :-
    (Rodada < Linhas ->
        Resultado = 'continua'
    ;
        verifica_sequencias(Tabuleiro, Colunas, Coluna, Simbolo, Linhas, Linhas, Linha, Resultado)
        %verifica_sequencia_vertical(Tabuleiro, Linhas, Colunas, Simbolo, Colunas, Resultado)
        %verifica_sequencia_diagonal(Tabuleiro, Linhas, Colunas, Simbolo, Resultado)
    ).

verifica_sequencias(Tabuleiro, Colunas, Coluna, Simbolo, Final, Linhas, Linha, Resultado) :-
    verifica_sequencia_horizontal(Tabuleiro, Colunas, 1, Simbolo, Linha, 0, Final, Quantidade),
    (Quantidade >= Final ->
        Resultado = 'acabou'
    ;
       verifica_sequencia_vertical(Tabuleiro, Linhas, Coluna, Simbolo, Final, NovoResultado), 
        (NovoResultado = 'acabou' ->
            Resultado = 'acabou'
        ;
            Resultado = 'continua'  
        )
    ).

verifica_sequencia_horizontal(Tabuleiro, Colunas, ColunaInicial, Simbolo, Linha, Contador, Final, Quantidade) :-
    (ColunaInicial =< Colunas, Contador < Final ->
        get_elemento(Tabuleiro, Linha, ColunaInicial, Simbolo, Resultado),
        (Resultado = 'true' ->
            ContadorAux is Contador + 1,
            ColunaInicialAux is ColunaInicial + 1,
            verifica_sequencia_horizontal(Tabuleiro, Colunas, ColunaInicialAux, Simbolo, Linha, ContadorAux, Final, Quantidade)
        ;
            ColunaInicialAux is ColunaInicial + 1,
            verifica_sequencia_horizontal(Tabuleiro, Colunas, ColunaInicialAux, Simbolo, Linha, 0, Final, Quantidade)
        )
    ;
        Quantidade = Contador
    ).

/**
 * Verifica se existe uma sequencia vertical de simbolos iguais.
 */
verifica_sequencia_vertical(Tabuleiro, Linhas, Coluna, Simbolo, Final, Resultado) :-
    verifica_sequencia_vertical_aux(Tabuleiro, Linhas, Coluna, Simbolo, 1, 0, Final, Quantidade),
    (Quantidade >= Final ->
        Resultado = 'acabou'
    ;
        Resultado = 'continua'
        %verifica_sequencia_diagonal(Tabuleiro, Linhas, Colunas, Simbolo, Resultado)
    ).

verifica_sequencia_vertical_aux(Tabuleiro, Linhas, Coluna, Simbolo, LinhaInicial, Contador, Final, Quantidade) :-
    (LinhaInicial =< Linhas, Contador < Final ->
        get_elemento(Tabuleiro, LinhaInicial, Coluna, Simbolo, Resultado),
        (Resultado = 'true' ->
            ContadorAux is Contador + 1,
            LinhaInicialAux is LinhaInicial + 1,
            verifica_sequencia_vertical_aux(Tabuleiro, Linhas, Coluna, Simbolo, LinhaInicialAux, ContadorAux, Final, Quantidade)
        ;
            LinhaInicialAux is LinhaInicial + 1,
            verifica_sequencia_vertical_aux(Tabuleiro, Linhas, Coluna, Simbolo, LinhaInicialAux, 0, Final, Quantidade)
        )
    ;
        Quantidade = Contador
    ).

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
