<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to the Tic-Tac-Toe Game Center</title>
    <script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="../js/ext-all.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/ext-all.css" media="screen"/>

    <script type="text/javascript">
        //        $(function () {
        //            var intervalId = setInterval(findOpenGames, 1500);
        //        });

        function findOpenGames() {
            $.ajax({
                url:"${g.createLink(controller: 'ticTacToe', action: 'findOpenGames')}",
                success:function (data) {
                    window.location = data;
                }
            });
        }

        Ext.Loader.setConfig({
            enabled:true
        });

        Ext.Loader.setPath('Ext.ux', '../js');

        Ext.require([
            'Ext.data.*',
            'Ext.grid.*',
            'Ext.ux.grid.TransformGrid'
        ]);

        Ext.onReady(function () {
            // create the logged on users grid.
            var grid = Ext.create('Ext.ux.grid.TransformGrid', 'users-table', {
                renderTo:'users-table-container',
                overflowX:"hidden",
                sortableColumns:true,
                minHeight:100,
                width:400,
                viewConfig:{
                    stripeRows:true,
                    enableTextSelection:true
                }
            });

            var grid = Ext.create('Ext.ux.grid.TransformGrid', 'statistics-table', {
                renderTo:'statistics-table-container',
                sortableColumns:true,
                minHeight:100,
                overflowX:"hidden",
                width:500,
                viewConfig:{
                    stripeRows:true,
                    enableTextSelection:true
                }
            });
        });
    </script>
</head>

<body>
<div id="users-table-container" style="width:397px; float: left;">
    <h1>Select a player to play with:</h1>
    <table id="users-table" cellspacing="0" cellpadding="0">
        <thead>
        <tr>
            <th>Username</th>
            <th>Full Name</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${loggedInUsers}" var="user">
            <tr>
                <td>
                    <g:link controller="ticTacToe" action="startGame" id="${user.id}">${user.username}</g:link><br/>
                </td>
                <td>
                    ${user.fullName}
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<div id="statistics-table-container" style="width: 497px; float: right;">
    <h1>Statistics:</h1>
    <table id="statistics-table">
        <thead>
        <tr>
            <th>
                Played against
            </th>
            <th>
                Games played
            </th>
            <th>
                Games won
            </th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${statistics}" var="statistic">
            <tr>
                <td>${statistic.user}</td>
                <td>${statistic.games}</td>
                <td>${statistic.wonGames}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
</body>
</html>
