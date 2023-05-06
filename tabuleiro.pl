/**
 * Ana Carolina Mendes Lino - 201865212AC
 * Paula Rinco Rodrigues Pereira - 201865559C
 */

/**
 * Predicados relacionadas a criação do tabuleiro.
 */
criar_tabuleiro(Linhas, Colunas, Tabuleiro) :-
    criar_tabuleiro_vazio(Linhas, Colunas, Tabuleiro).

criar_tabuleiro_vazio(0, _, _) :- !.
criar_tabuleiro_vazio(Linhas, Colunas, [LinhaAtualTabuleiro|ProximasLinhasTabuleiro]) :-
    criar_linha_vazia(Colunas, LinhaAtualTabuleiro),
    ProximasLinhas is Linhas - 1,
    criar_tabuleiro_vazio(ProximasLinhas, Colunas, ProximasLinhasTabuleiro).

criar_linha_vazia(0, []) :- !.
criar_linha_vazia(Colunas, [0|LinhaAtualTabuleiro]) :-
    ProximasColunas is Colunas - 1,
    criar_linha_vazia(ProximasColunas, LinhaAtualTabuleiro).

/**
  * Predicados usando a biblioteca de interface gráfica, XPCE, para desenhar o tabuleiro.
  */
imprime_tabuleiro(Window, Tabuleiro, NumeroLinhas, NumeroColunas) :-
    draw_board(Window, Tabuleiro, NumeroLinhas, NumeroColunas, 1, 1),
    send(Window, open).

draw_board(_, [], _, _, _, _).
draw_board(Window, [Linha|Resto], NumeroLinhas, NumeroColunas, LinhaAtual, ColunaAtual) :-
    draw_line(Window, Linha, NumeroLinhas, NumeroColunas, LinhaAtual, ColunaAtual),
    ProximaLinhaAtual is LinhaAtual + 1,
    draw_board(Window, Resto, NumeroLinhas, NumeroColunas, ProximaLinhaAtual, ColunaAtual).

draw_line(_, [], _, _, _, _).
draw_line(Window, [Elemento|Resto], NumeroLinhas, NumeroColunas, LinhaAtual, ColunaAtual) :-
    draw_element(Window, Elemento, LinhaAtual, ColunaAtual),
    ProximaColunaAtual is ColunaAtual + 1,
    draw_line(Window, Resto, NumeroLinhas, NumeroColunas, LinhaAtual, ProximaColunaAtual).

draw_element(Window, Elemento, LinhaAtual, ColunaAtual) :-
    Height is LinhaAtual * 50,
    Width is ColunaAtual * 50,
    new(Box, box(50, 50)),
    send(Box, fill_pattern, colour(white)),
    send(Window, display, Box, point(Width, Height)),
    draw_element_inside_box(Window, Elemento, Box, Width, Height).

draw_element_inside_box(_, 0, _, _, _).
draw_element_inside_box(Window, Elemento, Box, Width, Height) :-
    new(Text, text(Elemento)),
    send(Text, font, font(times, roman, 20)),
    send(Window, display, Text, point(Width, Height)),
    send(Box, fill_pattern, colour(white)).