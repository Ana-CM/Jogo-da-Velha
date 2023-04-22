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
           verifica_sequencia_diagonal(Tabuleiro, Colunas, Coluna, Simbolo, Final, Linhas, Linha, NovoNovoResultado),
            (NovoNovoResultado = 'acabou' ->
                Resultado = 'acabou'
            ;
                Resultado = 'continua'
            )
        )
    ).

/**
 * Verifica se existe uma sequencia horizontal de simbolos iguais.
 */
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

/**
 * Verifica se existe uma sequencia diagonal de simbolos iguais.
 */
verifica_sequencia_diagonal(Tabuleiro, Colunas, Coluna, Simbolo, Final, Linhas, Linha, Resultado) :-
    verifica_sequencia_diagonal_secundaria(Tabuleiro, Colunas, Linhas, Simbolo, Final, ResultadoSecundario),
    (ResultadoSecundario = 'acabou' ->
        Resultado = 'acabou'
    ;
        verifica_sequencia_diagonal_principal(Tabuleiro, Colunas, Coluna, Linhas, Linha, Simbolo, Final, ResultadoPrincipal),
        (ResultadoPrincipal = 'acabou' ->
            Resultado = 'acabou'
        ;
            Resultado = 'continua'
        )
    ).

verifica_sequencia_diagonal_secundaria(Tabuleiro, Colunas, Linhas, Simbolo, Final, Resultado) :-
    verifica_sequencia_diagonal_secundaria_aux(Tabuleiro, Colunas, Linhas, Simbolo, 1, 0, Final, Quantidade),
    (Quantidade >= Final ->
        Resultado = 'acabou'
    ;
        Colunas_1 is Colunas - 1,
        verifica_sequencia_diagonal_secundaria_aux(Tabuleiro, Colunas_1, Linhas, Simbolo, 1, 0, Final, NovaQuantidade),
        (NovaQuantidade >= Final ->
            Resultado = 'acabou'
        ;
            Resultado = 'continua'
        )
    ).

verifica_sequencia_diagonal_secundaria_aux(Tabuleiro, Colunas, Linhas, Simbolo, LinhaInicial, Contador, Final, Quantidade) :-
    ( Colunas > 0, Linhas > 0, LinhaInicial =< Linhas, Contador =< Final ->
        get_elemento(Tabuleiro, LinhaInicial, Colunas, Simbolo, Resultado),
        (Resultado = 'true' ->
            ContadorAux is Contador + 1,
            LinhaInicialAux is LinhaInicial + 1,
            ColunasAux is Colunas - 1,
            verifica_sequencia_diagonal_secundaria_aux(Tabuleiro, ColunasAux, Linhas, Simbolo, LinhaInicialAux, ContadorAux, Final, Quantidade)
        ;
            Quantidade is 0
        )
    ;
        Quantidade = Contador
    ). 

verifica_sequencia_diagonal_principal(Tabuleiro, Colunas, Coluna, Linhas, Linha, Simbolo, Final, Resultado) :-
    ( Coluna =:= Linha ->
        verifica_sequencia_diagonal_principal_aux(Tabuleiro, Colunas, Linhas, Simbolo, 1, 1, 0, Final, Quantidade),
        (Quantidade >= Final ->
            Resultado = 'acabou'
        ;
            Resultado = 'continua'
        )
    ; 
        Linha_1 is Linha + 1,
        ( Linha_1 =:= Coluna ->
            verifica_sequencia_diagonal_principal_aux(Tabuleiro, Colunas, Linhas, Simbolo, 1, 2, 0, Final, NovaQuantidade),
            (NovaQuantidade >= Final ->
                Resultado = 'acabou'
            ;
                Resultado = 'continua'
            )
        ;
            Resultado = 'continua'
        )
    ).

verifica_sequencia_diagonal_principal_aux(Tabuleiro, Colunas, Linhas, Simbolo, LinhaInicial, ColunaInicial, Contador, Final, Quantidade) :-
    ( Colunas > 0, Linhas > 0, LinhaInicial =< Linhas, ColunaInicial =< Colunas, Contador =< Final ->
        get_elemento(Tabuleiro, LinhaInicial, ColunaInicial, Simbolo, Resultado),
        (Resultado = 'true' ->
            ContadorAux is Contador + 1,
            LinhaInicialAux is LinhaInicial + 1,
            ColunaInicialAux is ColunaInicial + 1,
            verifica_sequencia_diagonal_principal_aux(Tabuleiro, Colunas, Linhas, Simbolo, LinhaInicialAux, ColunaInicialAux, ContadorAux, Final, Quantidade)
        ;
            Quantidade is 0
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
