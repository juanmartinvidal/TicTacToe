package com.tictactoe

class TicTacToeService {
    final static int X_MARK = 1;
    final static int O_MARK = -1;

    def handleMove(TicTacToe game, User currentUser, String[] boardPosition) {
        if (game.nextTurn == currentUser) {
            // Set the turn
            if (game.player1 == currentUser) {
                game.nextTurn = game.player2
            } else {
                game.nextTurn = game.player1
            }


            if (game.player1 == currentUser) {
                game.board[boardPosition[0].toInteger()][boardPosition[1].toInteger()] = X_MARK
            } else {
                game.board[boardPosition[0].toInteger()][boardPosition[1].toInteger()] = O_MARK
            }

            game.save()

            // Check to see if there's a winner
            boolean areMovementsLeft = false
            User winner = null
            // Columns
            for (int i = 0; i < 3; i++) {
                def result = 0
                for (int j = 0; j < 3; j++) {
                    result += game.board[j][i]
                    if (game.board[j][i] == 0) {
                        areMovementsLeft = true
                    }
                }

                if (result == 3) {
                    winner = game.player1
                    break
                } else if (result == -3) {
                    winner = game.player2
                    break
                }
            }

            // Rows
            if (!winner) {
                for (int i = 0; i < 3; i++) {
                    def result = 0
                    for (int j = 0; j < 3; j++) {
                        result += game.board[i][j]
                    }

                    if (result == 3) {
                        winner = game.player1
                        break
                    } else if (result == -3) {
                        winner = game.player2
                        break
                    }
                }
            }

            // Diagonals
            if (!winner) {
                def result1 = 0
                def result2 = 0
                def c = 2

                for (int i = 0; i < 3; i++) {
                    result1 += game.board[i][i]
                    result2 += game.board[i][c]
                    c--
                }

                if (result1 == 3 || result2 == 3) {
                    winner = game.player1
                } else if (result1 == -3 || result2 == -3) {
                    winner = game.player2
                }
            }

            if (winner) {
                game.winner = winner
                game.finished = true
                game.save()
            } else if (!areMovementsLeft) {
                game.finished = true
                game.save()
            }
        }
    }
}
