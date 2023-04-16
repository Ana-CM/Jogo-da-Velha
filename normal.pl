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
    Indice_Linha is 1,
    Indice_Coluna is 1,
    jogada_normal_desafiante(Linha, Coluna, Tabuleiro, Indice_Linha, Indice_Coluna).
    % verifica se o jogo acabou (validar rodada)
    %TODO:  jogada normal computador
    % verifica se o jogo acabou (validar rodada)
    % Imprime o tabuleiro
    % pede_jogada_desafiante(Linhas, Colunas, 'N').

jogada_normal_desafiante(Linha, Coluna, Tabuleiro, Indice_Linha, Indice_Coluna) :- !.