/**
 * Ana Carolina Mendes Lino - 201865212AC
 * Paula Rinco Rodrigues Pereira -
 */

/**
 * Predicados relacionados as jogadas do desafiante no modo Simplificado.
 */
pede_jogada_desafiante(Linhas, Colunas, s, Rodada, Tabuleiro) :-
    write('Digite a coluna da jogada: '),
    read(Coluna),
    validar_jogada_simples(Coluna, Colunas),
    jogada_simples_desafiante(Linhas, Coluna, Tabuleiro, TabuleiroAtualizado),
    verifica_se_acabou(Rodada, TabuleiroAtualizado, Linhas, Colunas, Resultado),
    (Resultado = acabou -> 
        imprime_tabuleiro(TabuleiroAtualizado),
        nl,
        write('O desafiante venceu!'),
        nl
    ;
        write('Tabuleiro Atualizado:'),
        nl,
        imprime_tabuleiro(TabuleiroAtualizado),
        nl
        %TODO:  jogada normal computador
        % verifica se o jogo acabou (validar rodada)
        % Imprime o tabuleiro
        % pede_jogada_desafiante(Linhas, Colunas, 'N').
    ).

jogada_simples_desafiante(Linhas, Coluna, [LinhaAtual|RestoTabuleiro], TabuleiroAtualizado) :-
    IndiceLinha is 1,
    IndiceLinhas is Linhas + 1,
    jogada_simples_desafiante_linha(IndiceLinhas, Coluna, IndiceLinha, LinhaAtual, RestoTabuleiro, TabuleiroAtualizado).

jogada_simples_desafiante_linha( Linhas, Coluna, IndiceLinha, Linha, Tabuleiro, TabuleiroAtualizado) :-
    ColunaIndex is Coluna - 1, % Subtrai 1 de Coluna para obter o índice correto em Prolog
    length(LinhaPrefixo, ColunaIndex),
    append(LinhaPrefixo, [Valor|LinhaRestante], Linha),

    ( Valor \= x, Valor \= c, IndiceLinha < Linhas  -> 
        append(LinhaPrefixo, [x|LinhaRestante], NovaLinha),
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
            jogada_simples_desafiante_linha(Linhas, Coluna, IndiceLinhaProx, ProxLinha, ProxTabuleiro, TabuleiroAtualizado)
        ;
            TabuleiroAtualizado = NovoTabuleiro
        )
    ; 
        TabuleiroAtualizado = Tabuleiro
    ).

apaga_jogada_simples_anterior( Coluna, IndiceLinha, Linha, Tabuleiro, NovoTabuleiro ) :-
    ColunaIndex is Coluna - 1, % Subtrai 1 de Coluna para obter o índice correto em Prolog
    length(LinhaPrefixo, ColunaIndex),
    append(LinhaPrefixo, [_|LinhaRestante], Linha),
    append(LinhaPrefixo, [0|LinhaRestante], NovaLinha),
    nth1(IndiceLinha, NovoTabuleiro, NovaLinha, Tabuleiro).

    