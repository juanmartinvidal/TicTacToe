package com.tictactoe

class TicTacToe {
    User player1
    User player2
    User nextTurn
    User winner
    boolean finished
    int[][] board = new int[3][3];

    static constraints = {
        winner(nullable: true)
    }
}
