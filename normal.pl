/**
 * Ana Carolina Mendes Lino - 201865212AC
 * Paula Rinco Rodrigues Pereira -
 */

/**
 * Predicados relacionados as jogadas do desafiante no modo Normal.
 */
pede_jogada_normal(Window, Linhas, Colunas, Rodada, Tabuleiro) :-
    write('Digite a linha da jogada: '),
    read(Linha),
    write('Digite a coluna da jogada: '),
    read(Coluna),
    validar_jogada_normal(Linha, Linhas, Coluna, Colunas),
    jogada_normal_desafiante(Linhas, Colunas, Rodada, Linha, Coluna, Tabuleiro, TabuleiroAtualizado),

    verifica_se_acabou(Rodada, TabuleiroAtualizado, Linhas, Colunas, Linha, Coluna, 'x', Resultado),
    imprime_tabuleiro(Window, TabuleiroAtualizado, Linhas, Colunas),
    nl,
    (Resultado = 'empate' -> 
        write('Empate!'),
        nl
    ;
        ( Resultado = 'acabou' ->
            write('O desafiante venceu!'),
            nl
        ;
            %TODO:  jogada normal computador
            % verifica se o jogo acabou (validar rodada)
            % Imprime o tabuleiro
            NovaRodada is Rodada + 1,
            pede_jogada_normal(Window, Linhas, Colunas, NovaRodada, TabuleiroAtualizado)
        )
    ).

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
        
        