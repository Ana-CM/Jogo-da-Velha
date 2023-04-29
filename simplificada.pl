/**
 * Ana Carolina Mendes Lino - 201865212AC
 * Paula Rinco Rodrigues Pereira -
 */

/**
 * Predicados relacionados as jogadas do desafiante no modo Simplificado.
 */
pede_jogada_simplificada(Linhas, Colunas, Rodada, Tabuleiro) :-
    write('Digite a coluna da jogada: '),
    read(Coluna),
    validar_jogada_simples(Coluna, Colunas),
    jogada_simples_desafiante(Colunas, Rodada, Linhas, Coluna, Tabuleiro, LinhaJogada, TabuleiroAtualizado),
    verifica_se_acabou(Rodada, TabuleiroAtualizado, Linhas, Colunas, LinhaJogada, Coluna, 'x', Resultado),
    (Resultado = 'empate' -> 
        imprime_tabuleiro(TabuleiroAtualizado),
        nl,
        write('Empate!'),
        nl
    ;
        (Resultado = 'acabou' -> 
            imprime_tabuleiro(TabuleiroAtualizado),
            nl,
            write('O desafiante venceu!'),
            nl
        ;
            write('Tabuleiro Atualizado:'),
            nl,
            imprime_tabuleiro(TabuleiroAtualizado),
            nl,
            jogada_simples_computador(Colunas, Linhas, TabuleiroAtualizado, NovoTabuleiroAtualizado, NovaLinhaJogada, NovaColunaJogada),
            NovaRodada is Rodada + 1,
            %verifica_se_acabou(NovaRodada, NovoTabuleiroAtualizado, Linhas, Colunas, LinhaJogada, Coluna, '0', Resultado),
            imprime_tabuleiro(NovoTabuleiroAtualizado).
            % pede_jogada_desafiante(Linhas, Colunas, 'N').
        )
    ).

jogada_simples_desafiante(Colunas, Rodada, Linhas, Coluna, [LinhaAtual|RestoTabuleiro], Linha, TabuleiroAtualizado) :-
    IndiceLinha is 1,
    IndiceLinhas is Linhas + 1,
    jogada_simples_desafiante_linha( Colunas, Rodada, IndiceLinhas, Coluna, IndiceLinha, LinhaAtual, RestoTabuleiro, Linha, TabuleiroAtualizado).

jogada_simples_desafiante_linha( Colunas, Rodada, Linhas, Coluna, IndiceLinha, Linha, Tabuleiro, LinhaJogada, TabuleiroAtualizado) :-
    ColunaIndex is Coluna - 1, % Subtrai 1 de Coluna para obter o índice correto em Prolog
    length(LinhaPrefixo, ColunaIndex),
    append(LinhaPrefixo, [Valor|LinhaRestante], Linha),

    ( Valor \= 'x', Valor \= 'c', IndiceLinha < Linhas  -> 
        append(LinhaPrefixo, ['x'|LinhaRestante], NovaLinha),
        nth1(IndiceLinha, NovoTabuleiro, NovaLinha, Tabuleiro),

        FimLinhas is Linhas - 1,

        (IndiceLinha \= FimLinhas ->
            IndiceLinhaProx is IndiceLinha + 1,
            nth1(IndiceLinhaProx, NovoTabuleiro, ProxLinha)      
        ;
            ProxLinha = Linha      
        ),
        
        %verica se o indice da linha é 1, se não for, chama o predicado apaga_jogada_simples_anterior
        (IndiceLinha \= 1 -> 
            IndiceLinhaAnt is IndiceLinha - 1,
            nth1(IndiceLinhaAnt, NovoTabuleiro, AntLinha),
            select(AntLinha, NovoTabuleiro, AntTabuleiro),
            apaga_jogada_simples_anterior(Coluna, IndiceLinhaAnt, AntLinha, AntTabuleiro, NovoNovoTabuleiro),  
    
            length(ParteAntes, IndiceLinhaAnt),
            append(ParteAntes, [_|ParteDepois], NovoNovoTabuleiro),
            append(ParteAntes, ParteDepois, ProxTabuleiro)
        ;
            select(ProxLinha, NovoTabuleiro, ProxTabuleiro)
        ),

        
        (IndiceLinha \= FimLinhas ->
            jogada_simples_desafiante_linha(Colunas, Rodada, Linhas, Coluna, IndiceLinhaProx, ProxLinha, ProxTabuleiro, LinhaJogada, TabuleiroAtualizado)
        ;
            TabuleiroAtualizado = NovoTabuleiro,
            LinhaJogada is IndiceLinha
        )
    ; 
        TabuleiroAtualizado = Tabuleiro,
        LinhaJogada is -1,
        write('Jogada inválida!'),
        nl,
        pede_jogada_simplificada(Linhas, Colunas, Rodada, Tabuleiro)
    ).

apaga_jogada_simples_anterior( Coluna, IndiceLinha, Linha, Tabuleiro, NovoTabuleiro ) :-
    ColunaIndex is Coluna - 1, % Subtrai 1 de Coluna para obter o índice correto em Prolog
    length(LinhaPrefixo, ColunaIndex),
    append(LinhaPrefixo, [_|LinhaRestante], Linha),
    append(LinhaPrefixo, [0|LinhaRestante], NovaLinha),
    nth1(IndiceLinha, NovoTabuleiro, NovaLinha, Tabuleiro).

    
/**
 * Predicados relacionados a jogada do computador no modo Simplificado.
 */
jogada_simples_computador(Colunas, Linhas, Tabuleiro, NovoTabuleiro, LinhaJogada, ColunaJogada) :-
    write('Computador jogando...'),
    nl,
    sleep(1),
    jogada_simples_compultador_aux(Colunas, Linhas, Tabuleiro, 0, LinhaJogada, ColunaJogada),
    set_elemento(Tabuleiro, LinhaJogada, ColunaJogada, 'o', NovoTabuleiro).

jogada_simples_compultador_aux(Coluna, Linha, Tabuleiro, Heuristica, PosicaoLinha, PosicaoColuna) :-
    (Coluna > 0 ->
        get_elemento(Tabuleiro, Linha, Coluna, 0, Resultado),
        (NovoResultado = 'true' ->
            calcula_heuristica_simples(Coluna, Linha, Tabuleiro, NovaHeuristica),
            (NovaHeuristica > Heuristica ->
                jogada_simples_compultador_aux(Coluna, Linha, Tabuleiro, NovaHeuristica, Linha, Coluna)
            )
        ;
            Linha_1 is Linha - 1,
            (Linha_1 > 0 ->
                jogada_simples_compultador_aux(Coluna, Linha_1, Tabuleiro, Heuristica, PosicaoLinha, PosicaoColuna)
            ;
                Coluna_1 is Coluna - 1,
                jogada_simples_compultador_aux(Coluna_1, Linha, Tabuleiro, Heuristica, PosicaoLinha, PosicaoColuna)
            )
        )
    ).
    
calcula_heuristica_simples(Coluna, Linha, Tabuleiro, Heuristica) :- !.
    