package tictactoe

import com.tictactoe.TicTacToe
import com.tictactoe.User

import javax.servlet.http.HttpServletResponse

class TicTacToeController {
    def springSecurityService
    def ticTacToeService

    def startGame() {
        User currentUser = springSecurityService.currentUser
        User player = User.get(params.id)

        TicTacToe game = new TicTacToe(player1: currentUser, player2: player, nextTurn: currentUser).save(flush: true)

        chain(action: 'playGame', id: game.id)
    }

    def playGame() {
        User currentUser = springSecurityService.currentUser

        TicTacToe game = TicTacToe.get(params.id)

        if (currentUser != game.player1 && currentUser != game.player2) {
            flash.message = "You are not a player in this game. Start your own!"
            redirect(controller: 'hall', action: 'hall')
        }

        if (params.refresh) {
            render(template: '../games/tictactoe', model: [game: game, currentUser: currentUser])
            return
        }

        render(view: '../games/game', model: [game: game, currentUser: currentUser])
    }

    def handleMove() {
        User currentUser = springSecurityService.currentUser
        TicTacToe game = TicTacToe.get(params.id)
        String[] boardPosition = params.tdId.split("-")

        ticTacToeService.handleMove(game, currentUser, boardPosition)

        render(template: '../games/tictactoe', model: [game: game, currentUser: currentUser])
    }

    def findOpenGames() {
        User currentUser = springSecurityService.currentUser

        TicTacToe game = TicTacToe.find("from TicTacToe where (player1 = :currentUser or player2 = :currentUser) and finished = false", [currentUser: currentUser])

        if (game) {
            render(status: HttpServletResponse.SC_OK, text: createLink(controller: 'ticTacToe', action: "playGame", id: game.id))
        } else {
            render(status: HttpServletResponse.SC_NOT_FOUND)
        }
    }
}
