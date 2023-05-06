# Jogo da velha

Essa é uma implementação do jogo da velha em prolog (swi-prolog v9.4.0).
O jogo permite que um jogador jogue contra a máquina, no qual sempre a primeira jogada é do jogador (`X`) e a segunda da máquina (`O`).


## Como jogar

Para jogar, basta executar o arquivo `main.pl` e chamar o predicado `inicio/0`:
```prolog 
    ?- inicio.
```

Em seguida, o jogo irá perguntar qual a quantidade de linhas do tabuleiro, o tabuleiro terá X linhas e X+1 colunas.
````prolog
    ?- inicio.
    Digite a quantidade de linhas do Tabuleiro:? 3.
`````

Por fim, o jogo irá perguntar qual o modo de jogo, que pode ser  simplificado (`s`) ou normal (`n`)
````prolog
    ?- inicio.
    Digite a quantidade de linhas do Tabuleiro:? 3.
    Digite o modo de jogo (n ou s):? s.
`````

## Modo de jogo

O modo de jogo simplificado é um modo no a jogada é feita escolhendo uma coluna do tabuleiro, e a peça é colocada na primeira linha vazia da coluna escolhida (de cima para baixo).

O modo de jogo normal é um modo no qual a jogada é feita escolhendo uma posição do tabuleiro, e a peça é colocada na posição escolhida.

Em ambos os modos, a máquina sempre irá jogar com a peça `O` e o jogador sempre irá jogar com a peça `X`, as jogadas são feitas alternadamente e o jogador dever escolher uma posição válida para jogar (uma posição que não esteja ocupada), digitando a coluna e/ou linha sendo valido apenas números inteiros maiores que 1.

## Terminando o jogo

O jogo termina quando um dos jogadores ganha ou quando o tabuleiro está completamente preenchido.

A vitória é definida quando um dos jogadores consegue colocar X (número de linhas do tabuleiro) peças em sequência na horizontal, vertical ou em uma das diagonais.

