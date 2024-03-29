/**
 * Ana Carolina Mendes Lino - 201865212AC
 * Paula Rinco Rodrigues Pereira - 201865559C
 */

/**
 * Predicados relacionados as jogadas do modo Simplificado.
 */
pede_jogada_simplificada(Window, Linhas, Colunas, Rodada, Tabuleiro) :-
    write('Digite a coluna da jogada: '),
    read(Coluna),
    validar_jogada_simples(Coluna, Colunas),
    jogada_simples_desafiante(Colunas, Rodada, Linhas, Coluna, Tabuleiro, LinhaJogada, TabuleiroAtualizado),
    verifica_se_acabou(Rodada, TabuleiroAtualizado, Linhas, Colunas, LinhaJogada, Coluna, 'x', Resultado),
    imprime_tabuleiro(Window, TabuleiroAtualizado, Linhas, Colunas),
    nl,
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
            jogada_simples_computador(Colunas, Linhas, TabuleiroAtualizado, NovoTabuleiroAtualizado, NovaLinhaJogada, NovaColunaJogada),
            nl,
            write('Computador jogou na linha: '),
            write(NovaLinhaJogada),
            write(' e na coluna: '),
            write(NovaColunaJogada),
            nl, nl,
            verifica_se_acabou(Rodada, NovoTabuleiroAtualizado, Linhas, Colunas, NovaLinhaJogada, NovaColunaJogada, 'o', NovoResultado),
            NovaRodada is Rodada + 1,
            imprime_tabuleiro(Window, NovoTabuleiroAtualizado, Linhas, Colunas),
            nl,
            (NovoResultado = 'empate' -> 
                write('Empate!'),
                nl
            ;
                (NovoResultado = 'acabou' -> 
                    write('O computador venceu!'),
                    nl
                ;
                    pede_jogada_simplificada(Window, Linhas, Colunas, NovaRodada, NovoTabuleiroAtualizado)
                )
            )
        )
    ).
    
/**
 * Predicados relacionados a jogada do desafiante no modo Simplificado.
 */
jogada_simples_desafiante(Colunas, Rodada, Linhas, Coluna, Tabuleiro, LinhaJogada, TabuleiroAtualizado) :-
    jogada_simples_desafiante_aux(Colunas, Rodada, Linhas, Coluna, Tabuleiro, Linhas, LinhaJogada, TabuleiroAtualizado).

jogada_simples_desafiante_aux( Colunas, Rodada, Linhas, Coluna, Tabuleiro, Linha, LinhaJogada, TabuleiroAtualizado) :-
   (Linha > 0 ->
        get_elemento(Tabuleiro, Linha, Coluna, 0, Resultado),
        (Resultado = 'true' ->
            set_elemento(Tabuleiro, Linha, Coluna, 'x', NovoTabuleiro),
            LinhaJogada is Linha,
            TabuleiroAtualizado = NovoTabuleiro
        ;
            Linha_1 is Linha - 1,
            jogada_simples_desafiante_aux(Colunas, Rodada, Linhas, Coluna, Tabuleiro, Linha_1, LinhaJogada, TabuleiroAtualizado)
        )
    ;
        write('Erro! Jogada inválida!'),
        nl,
        write('Digite a coluna da jogada: '),
        read(NovaColuna),
        validar_jogada_simples(NovaColuna, Colunas),
        jogada_simples_desafiante(Colunas, Rodada, Linhas, NovaColuna, Tabuleiro, LinhaJogada, TabuleiroAtualizado)
    ).


/**
 * Predicados relacionados a jogada do computador no modo Simplificado.
 */
jogada_simples_computador(Colunas, Linhas, Tabuleiro, NovoTabuleiro, LinhaJogada, ColunaJogada) :-
    jogada_simples_computador_aux(Colunas, Linhas, 1, Linhas, Tabuleiro, 0, -1, -1, LinhaJogada, ColunaJogada),
    set_elemento(Tabuleiro, LinhaJogada, ColunaJogada, 'o', NovoTabuleiro).

jogada_simples_computador_aux(Colunas, Linhas, Coluna, Linha, Tabuleiro, Heuristica, AuxLinha, AuxColuna, PosicaoLinha, PosicaoColuna) :-
    (Colunas >= Coluna ->
        Linha_1 is Linha - 1,
        Coluna_1 is Coluna + 1,

        get_elemento(Tabuleiro, Linha, Coluna, 0, Resultado),
        (Resultado = 'true' ->
            calcula_heuristica_total_adjacente(Colunas, Linhas, Coluna, Linha, Tabuleiro, NovaHeuristica),
            (NovaHeuristica > Heuristica ->
                jogada_simples_computador_aux(Colunas, Linhas, Coluna_1, Linhas, Tabuleiro, NovaHeuristica, Linha, Coluna, PosicaoLinha, PosicaoColuna)
            ;
                jogada_simples_computador_aux(Colunas, Linhas, Coluna_1, Linhas, Tabuleiro, Heuristica, AuxLinha, AuxColuna, PosicaoLinha, PosicaoColuna)
            )
        ;
            (Linha_1 > 0 ->
                jogada_simples_computador_aux(Colunas, Linhas, Coluna, Linha_1, Tabuleiro, Heuristica, AuxLinha, AuxColuna, PosicaoLinha, PosicaoColuna)
            ;
                jogada_simples_computador_aux(Colunas, Linhas, Coluna_1, Linhas, Tabuleiro, Heuristica, AuxLinha, AuxColuna, PosicaoLinha, PosicaoColuna)
            )
        )
    ;   
        ( AuxLinha < 0; AuxColuna < 0; AuxLinha > Linhas; AuxColuna > Colunas  ->
            write('Erro ao calcular a jogada do computador!'),
            nl,
            fail
        ;
            PosicaoLinha is AuxLinha,
            PosicaoColuna is AuxColuna
        )
    ).
    

    