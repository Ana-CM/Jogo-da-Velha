/**
 * Ana Carolina Mendes Lino - 201865212AC
 * Paula Rinco Rodrigues Pereira -
 */

/**
 * Predicados relacionados as jogadas no modo Normal.
 */
pede_jogada_normal(Window, Linhas, Colunas, Rodada, Tabuleiro) :-
    write('Digite a linha da jogada: '),
    read(Linha),
    write('Digite a coluna da jogada: '),
    read(Coluna),
    validar_jogada_normal(Linha, Linhas, Coluna, Colunas),
    jogada_normal_desafiante(Linhas, Colunas, Rodada, Linha, Coluna, Tabuleiro, TabuleiroAtualizado),
    imprime_tabuleiro(Window, TabuleiroAtualizado, Linhas, Colunas),
    nl,

    verifica_se_acabou(Rodada, TabuleiroAtualizado, Linhas, Colunas, Linha, Coluna, 'x', Resultado),
    (Resultado = 'empate' -> 
        write('Empate!'),
        nl
    ;
        (Resultado = 'acabou' ->
            write('O desafiante venceu!'),
            nl
        ;
            write('Computador jogando...'),
            sleep(1),
            jogada_normal_computador(Linhas, Colunas, Rodada, TabuleiroAtualizado, LinhaJogada, ColunaJogada, NovoTabuleiro),
            nl,
            write('Computador jogou na linha: '),
            write(LinhaJogada),
            write(' e na coluna: '),
            write(ColunaJogada),
            nl, nl,
            imprime_tabuleiro(Window, NovoTabuleiro, Linhas, Colunas),
            verifica_se_acabou(Rodada, NovoTabuleiro, Linhas, Colunas, LinhaJogada, ColunaJogada, 'o', NovoResultado),
            (NovoResultado = 'empate' -> 
                write('Empate!'),
                nl
            ;
                (NovoResultado = 'acabou' ->
                    write('O computador venceu!'),
                    nl
                ;
                    NovaRodada is Rodada + 1,
                    pede_jogada_normal(Window, Linhas, Colunas, NovaRodada, NovoTabuleiro)
                )
            )
        )
    ).

/**
 * Predicado relacionado a jogada do desafiante no modo Normal.
 */
jogada_normal_desafiante(Linhas, Colunas, Rodada, Linha, Coluna, Tabuleiro, TabuleiroAtualizado) :-  
    IndiceLinha is Linha - 1,
    length(LinhaPrefixo, IndiceLinha),
    append(LinhaPrefixo, [LinhaSelecionada|TabuleiroRestante], Tabuleiro),

    IndiceColuna is Coluna - 1,
    length(ColunaPrefixo, IndiceColuna),
    append(ColunaPrefixo, [Valor|LinhaRestante], LinhaSelecionada),

    ( Valor \= 'x', Valor \= 'o' ->
        append(ColunaPrefixo, ['x'|LinhaRestante], NovaLinha),
        append(LinhaPrefixo, [NovaLinha|TabuleiroRestante], NovoTabuleiro),
        TabuleiroAtualizado = NovoTabuleiro
    ;
        write('Jogada invalida!'),
        nl,
        write('Digite a linha da jogada: '),
        read(NovaLinha),
        write('Digite a coluna da jogada: '),
        read(NovaColuna),
        validar_jogada_normal(NovaLinha, Linhas, NovaColuna, Colunas),
        jogada_normal_desafiante(Linhas, Colunas, Rodada, NovaLinha, NovaColuna, Tabuleiro, TabuleiroAtualizado)
    ).
        
/**
 * Predicado relacionado a jogada do computador no modo Normal.
 */
jogada_normal_computador(Linhas, Colunas, Rodada, Tabuleiro, LinhaJogada, ColunaJogada, NovoTabuleiro) :-
    jogada_normal_computador_aux(Linhas, Colunas, Rodada, Tabuleiro, 0, 1, 1, 0, 0, LinhaJogada, ColunaJogada),
    set_elemento(Tabuleiro, LinhaJogada, ColunaJogada, 'o', NovoTabuleiro).

jogada_normal_computador_aux(Linhas, Colunas, Rodada, Tabuleiro, Heuristica, Linha, Coluna, AuxLinha, AuxColuna, LinhaJogada, ColunaJogada) :-
    (Linhas >= Linha ->
        get_elemento(Tabuleiro, Linha, Coluna, 0, Resultado),
        ( Resultado = 'true' ->
            calcula_heuristica_total_adjacente(Colunas, Linhas, Coluna, Linha, Tabuleiro, NovaHeuristica),
            (NovaHeuristica > Heuristica ->
                NovaLinha is Linha,
                NovaColuna is Coluna,
                NovaHeuristicaAtualizada is NovaHeuristica
            ;
                NovaLinha is AuxLinha,
                NovaColuna is AuxColuna,
                NovaHeuristicaAtualizada is Heuristica
            )
        ;
            NovaLinha is AuxLinha,
            NovaColuna is AuxColuna,
            NovaHeuristicaAtualizada is Heuristica
        ),

        Coluna_1 is Coluna + 1,
        (Coluna_1 =< Colunas ->
            jogada_normal_computador_aux(Linhas, Colunas, Rodada, Tabuleiro, NovaHeuristicaAtualizada, Linha, Coluna_1, NovaLinha, NovaColuna, LinhaJogada, ColunaJogada)
        ;
            Linha_1 is Linha + 1,
            jogada_normal_computador_aux(Linhas, Colunas, Rodada, Tabuleiro, NovaHeuristicaAtualizada, Linha_1, 1, NovaLinha, NovaColuna, LinhaJogada, ColunaJogada)
        )
    ;
         ( AuxLinha =< 0; AuxColuna =< 0; AuxLinha > Linhas; AuxColuna > Colunas  ->
            write('Erro ao calcular a jogada do computador!'),
            nl,
            fail
        ;
            LinhaJogada is AuxLinha,
            ColunaJogada is AuxColuna
        )
    ).


        
