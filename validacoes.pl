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
    (Modo = n; Modo = s).

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

% Jogo acaba quando o tabuleiro está cheio ou existir uma sequência de 4 símbolos iguais.
verifica_se_acabou(Rodada, Tabuleiro, Linhas, Colunas, Simbolo, Resultado) :-
    (Rodada < Linhas ->
        Resultado = continua
    ;
        verifica_sequencia_horizontal(Tabuleiro, Linhas, Colunas, Simbolo, Linhas, Resultado)
        % verifica_sequencia_vertical(TabuleiroAtualizado, Linhas, Colunas, Resultado);
        % verifica_sequencia_diagonal(TabuleiroAtualizado, Linhas, Colunas, Resultado)
    ).

verifica_sequencia_horizontal(Tabuleiro, Linhas, Colunas, Simbolo, Final, Resultado) :-
    verifica_sequencia_horizontal_aux(Tabuleiro, Linhas, Colunas, Simbolo, Final, 1, 1, 0, Resultado).

verifica_sequencia_horizontal_aux(Tabuleiro, Linhas, Colunas, Simbolo, Final, Linha, Coluna, Contador, Resultado) :-
    (Final > Contador -> 
        (Linha =< Linhas -> 
            (Coluna =< Colunas -> 
                get_elemento(Tabuleiro, Linha, Coluna, Simbolo, Igual),

                ( Igual -> 
                    ContadorAtualizado is Contador + 1,
                    ColunaAtualizada is Coluna + 1,
                    verifica_sequencia_horizontal_aux(Tabuleiro, Linhas, Colunas, Simbolo, Final, Linha, ColunaAtualizada, ContadorAtualizado, Resultado)
                ;
                    ( Colunas - Coluna >= Final ->
                        ColunaAtualizada is Coluna + 1,
                        verifica_sequencia_horizontal_aux(Tabuleiro, Linhas, Colunas, Simbolo, Final, Linha, ColunaAtualizada, 0, Resultado)
                    ;
                        LinhaAtualizada is Linha + 1,
                        verifica_sequencia_horizontal_aux(Tabuleiro, Linhas, Colunas, Simbolo, Final, LinhaAtualizada, 1, 0, Resultado)
                    )
                )
            ;
                LinhaAtualizada is Linha + 1,
                verifica_sequencia_horizontal_aux(Tabuleiro, Linhas, Colunas, Simbolo, Final, LinhaAtualizada, 1, 0, Resultado)
            )
        ;
            Resultado = continua
        )
    ;
        Resultado = acabou
    ).

get_elemento(Tabuleiro, Linha, Coluna, Simbolo, Resultado) :-
    IndiceLinha is Linha - 1,
    length(LinhaPrefixo, IndiceLinha),
    append(LinhaPrefixo, [LinhaSelecionada|TabuleiroRestante], Tabuleiro),

    IndiceColuna is Coluna - 1,
    length(ColunaPrefixo, IndiceColuna),
    append(ColunaPrefixo, [Valor|LinhaRestante], LinhaSelecionada),

    (Valor = Simbolo ->
        Resultado = true
    ;
        Resultado = false
    ).
