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
    jogada_simples_desafiante(Coluna, Tabuleiro),
    imprime_tabuleiro(Tabuleiro).
    % verifica se o jogo acabou (validar rodada)
    %TODO:  jogada normal computador
    % verifica se o jogo acabou (validar rodada)
    % Imprime o tabuleiro
    % pede_jogada_desafiante(Linhas, Colunas, 'N').


jogada_simples_desafiante(Coluna, [LinhaAtual|RestoTabuleiro]) :-
    jogada_simples_desafiante_linha(RestoTabuleiro, LinhaAtual, Coluna),
    (Continuar == sim -> jogada_simples_desafiante_aux(Coluna, RestoTabuleiro, LinhaAtual); !).

jogada_simples_desafiante_aux(_, [], _) :- !.
jogada_simples_desafiante_aux(Coluna, [LinhaAtual|RestoTabuleiro], LinhaAnterior) :-
    jogada_simples_desafiante_linha(RestoTabuleiro, LinhaAtual, Coluna, Continuar),
    (
        Continuar == sim ->
        apaga_jogada_simples_anterior(Coluna, LinhaAnterior),
        jogada_simples_desafiante_aux(Coluna, RestoTabuleiro, LinhaAtual),
        LinhaAnterior = LinhaAtual
        ; !
    ).

jogada_simples_desafiante_linha(RestoTabuleiro, Linha, Coluna) :-
    nth1(Coluna, Linha, Elemento),
    (
        Elemento =:= 0 ->
        nth1(Coluna, Linha, 1, NovaLinha),
        replace(Linha, Coluna, NovaLinha, NovaNovaLinha),
        append([NovaNovaLinha], RestoTabuleiro, NovoTabuleiro),
        Continuar = sim
        ; Continuar = nao
    ).

apaga_jogada_simples_anterior(Coluna, Linha) :-
    nth1(Coluna, Linha, 0, NovaLinha).
