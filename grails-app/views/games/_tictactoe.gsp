<g:if test="${game?.winner}">
    <g:hiddenField name="gameFinished" value="true"/>

    <g:if test="${currentUser == game.winner}">
        You WON! <g:link controller="hall" action="hall">Play again?</g:link>
    </g:if>
    <g:else>
        Player ${game.winner.username} Won the Game!! <g:link controller="hall" action="hall">Play again?</g:link>
    </g:else>
</g:if>
<g:elseif test="${game.finished}">
    There are no possible movements left. It's a draw!
</g:elseif>
<g:else>
    <g:if test="${game.nextTurn == currentUser}">
        It's your Turn
    </g:if>
    <g:else>
        It's user ${currentUser.username}'s turn
    </g:else>
</g:else>

<table style="border: 1px solid;">
    <g:each in="${(0..2)}" var="i">
        <tr style="border: 1px solid;">
            <g:each in="${(0..2)}" var="j">
                <g:if test="${game.board[i][j] == 1}">
                    <td style="border: 1px solid;" id="${i}-${j}" class="selected">
                        X
                    </td>
                </g:if>
                <g:elseif test="${game.board[i][j] == -1}">
                    <td style="border: 1px solid;" id="${i}-${j}" class="selected">
                        O
                    </td>
                </g:elseif>
                <g:else>
                    <td style="border: 1px solid;" id="${i}-${j}"></td>
                </g:else>
            </g:each>
        </tr>
    </g:each>
</table>
