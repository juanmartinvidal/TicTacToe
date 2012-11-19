package tictactoe

import com.tictactoe.User

class HallController {
    def sessionRegistry
    def sessionFactory
    def springSecurityService

    private final static String BEGIN_SCRIPT_TAG = "<script type='text/javascript'>\n"
    private final static String END_SCRIPT_TAG = "</script>\n"

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

        [loggedInUsers: loggedInUsers, statistics: statistics]
    }
}
