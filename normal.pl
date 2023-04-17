/**
 * Ana Carolina Mendes Lino - 201865212AC
 * Paula Rinco Rodrigues Pereira -
 */

/**
 * Predicados relacionados as jogadas do desafiante no modo Normal.
 */
pede_jogada_desafiante(Linhas, Colunas, n, Rodada, Tabuleiro) :-
    write('Digite a linha da jogada: '),
    read(Linha),
    write('Digite a coluna da jogada: '),
    read(Coluna),
    validar_jogada_normal(Linha, Linhas, Coluna, Colunas),
    jogada_normal_desafiante(Linha, Coluna, Tabuleiro, TabuleiroAtualizado),

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

jogada_normal_desafiante(Linha, Coluna, Tabuleiro, TabuleiroAtualizado) :-  
    IndiceLinha is Linha - 1,
    length(LinhaPrefixo, IndiceLinha),
    append(LinhaPrefixo, [LinhaSelecionada|TabuleiroRestante], Tabuleiro),

    IndiceColuna is Coluna - 1,
    length(ColunaPrefixo, IndiceColuna),
    append(ColunaPrefixo, [Valor|LinhaRestante], LinhaSelecionada),

    ( Valor \= x, Valor \= c ->
        append(ColunaPrefixo, [x|LinhaRestante], NovaLinha),
        append(LinhaPrefixo, [NovaLinha|TabuleiroRestante], NovoTabuleiro),
        TabuleiroAtualizado = NovoTabuleiro
    ;
        write('Jogada invalida!'),
        nl,
        TabuleiroAtualizado = Tabuleiro,
        pede_jogada_desafiante(Linhas, Colunas, n, Rodada, Tabuleiro)
    ).
        
        