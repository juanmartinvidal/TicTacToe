package tictactoe

import com.tictactoe.User

class HallController {
    def sessionRegistry
    def sessionFactory
    def springSecurityService

    def index() {
        redirect(action: 'hall')
    }

    def hall() {
        User currentUser = springSecurityService.currentUser
        def loggedInUsers = User.findAllByIdInListAndIdNotEqual(sessionRegistry.getAllPrincipals()*.id, currentUser.id)

        // Get the statistics
        def users = User.findAllByIdNotEqual(currentUser.id)

        def statistics = []
        users.each {User user ->
            def games = com.tictactoe.TicTacToe.findAll("from TicTacToe where ((player1 = :user and player2 =:currentUser) or (player1 = :currentUser and player2 =:user)) and finished = true", [user: user, currentUser: currentUser]).size()
            if (games) {
                def wonGames = com.tictactoe.TicTacToe.findAll("from TicTacToe where ((player1 = :user and player2 =:currentUser) or (player1 = :currentUser and player2 =:user)) and winner = :currentUser and finished = true", [user: user, currentUser: currentUser]).size()
                statistics << [user: user.username, games: games, wonGames: wonGames]
            }
        }

        // Get all my open games
        def openGames = com.tictactoe.TicTacToe.findAll("from TicTacToe where (player1 =:currentUser or player2 = :currentUser) and finished = false", [currentUser: currentUser])

        [loggedInUsers: loggedInUsers, statistics: statistics, openGames: openGames, currentUser: currentUser]
    }
}
