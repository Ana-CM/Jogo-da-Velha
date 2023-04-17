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

verifica_se_acabou(Rodada, TabuleiroAtualizado, Linhas, Colunas, Resultado) :-
    (Rodada < Colunas ->
        Resultado = continua
    ;
        % verifica_sequencia_horizontal(TabuleiroAtualizado, Linhas, Colunas, Resultado);
        % verifica_sequencia_vertical(TabuleiroAtualizado, Linhas, Colunas, Resultado);
        % verifica_sequencia_diagonal(TabuleiroAtualizado, Linhas, Colunas, Resultado)
        Resultado = continua
    ).
