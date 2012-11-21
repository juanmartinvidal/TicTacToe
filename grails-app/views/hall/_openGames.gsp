<h1>Open games:</h1>
<table id="open-games-table">
    <thead>
    <tr>
        <th>
            Playing against
        </th>
        <th>
            Action
        </th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${openGames}" var="openGame">
        <tr>
            <td>
                <g:if test="${currentUser == openGame.player1}">
                    ${openGame.player2.username}
                </g:if>
                <g:else>
                    ${openGame.player1.username}
                </g:else>
            </td>
            <td><g:link controller="ticTacToe" action="playGame" id="${openGame.id}">Play Now!</g:link></td>
        </tr>
    </g:each>
    </tbody>
</table>
