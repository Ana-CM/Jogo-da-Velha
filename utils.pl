/**
 * Predicados auxiliares.
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

set_elemento(Tabuleiro, Linha, Coluna, Simbolo, NovoTabuleiro) :-
    IndiceLinha is Linha - 1,
    length(LinhaPrefixo, IndiceLinha),
    append(LinhaPrefixo, [LinhaSelecionada|LinhaSufixo], Tabuleiro),

    IndiceColuna is Coluna - 1,
    length(ColunaPrefixo, IndiceColuna),
    append(ColunaPrefixo, [_|ColunaSufixo], LinhaSelecionada),

    append(ColunaPrefixo, [Simbolo|ColunaSufixo], NovaLinhaSelecionada),
    append(LinhaPrefixo, [NovaLinhaSelecionada|LinhaSufixo], NovoTabuleiro).
