<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to the Tic-Tac-Toe Game Center</title>
    <script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>

    <script type="text/javascript">
        $("td").live('click', function () {
            if (!$(this).hasClass('selected') && !$('#gameFinished').val()) {
                var data = {};
                data.id = $("#id").val();
                data.tdId = $(this).attr("id");
                $.ajax({
                    url:"${g.createLink(controller: 'ticTacToe', action: 'handleMove')}",
                    data:data,
                    success:function (data) {
                        $('.game-container').html(data);
                    }
                });
            }
        });

        $(function () {
            var intervalId = setInterval(refreshBoard, 1000);
        });

        function refreshBoard() {
            var data = {};
            data.id = $("#id").val();
            data.refresh = true;

            $.ajax({
                url:"${g.createLink(controller: 'ticTacToe', action: 'playGame')}",
                data:data,
                success:function (data) {
                    $('.game-container').html(data);
                }
            });
        }
    </script>

    <style type="text/css">
    table {
        width: auto;
    }

    tr {
        height: 50px;
    }

    td {
        width: 50px;
        text-align: center;
        padding: 0px !important;
        vertical-align: middle;
    }
    </style>
</head>

<body>
Player 1: ${game.player1.username} ${currentUser == game.player1 ? '<b>(You are the X)</b>' : ''}<br/>
Player 2: ${game.player2.username} ${currentUser == game.player2 ? '<b>(You are the O)</b>' : ''}<br/>

<g:hiddenField name="id" value="${game.id}"/>

<div class="game-container">
    <g:render template="/games/tictactoe" model="[game: game, currentUser: currentUser]"/>
</div>
</body>
</html>
