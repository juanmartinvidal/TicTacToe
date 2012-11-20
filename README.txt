Steps to use the application:

1) Start the application by running the grails run-app command. If you need to run it on a specific port add the parameter -Dserver.port=8081 for example.

2) Once it's up go to the url of the application and you should see a login page. These are the available users in the form of user/pass:

chuckn/asdasd
homers/asdasd
batman/asdasd

3) Login and you will see 2 tables. The one on the left shows you the logged in users that you can play with (At the beginning this will be empty if no other user is logged in.
And the right table shows you the statistics of you against the players you have played with.

4) Open anothe browser and repeat steps 2 and 3 using a different user. Now you will see that the first user is on the list. Click on the username link and you will get redirected to the game window.

5) Notice that the first user will be redirected too.

6) Now start playing. You will see that above the board there's a message saying who's turn is it. You can't play if it's not your turn.

7) When someone wins you will get a message saying so and you will see a link to get to the Hall again to start playing again.

8) If no movements are left you will see a message saying that too.


Notes:

This was done in the easiest simplest way but there are some things I noticed that should be improved if this were a real application.

* Use a real database, PostgreSQL perhaps and with that I could improve the code I use today to get the statistics to have only one SQL query to gather all the information at once, among other things.
* Use PUSH to handle the click on the board and the refresh of the users when a click has been done by the opponent. There are a couple of plug-ins for Grails like atmosphere or push-events or cometD.
* Have an Interface to represent a game which should have specific methods for games. All thinking about having more than one type of game.
* Maybe have a parent class called Game to have specific fields that are the same for every game and then one domain class per game type.
* Finally review the way the players are implemented today in the game. Have a more generic way to have "n" players and not player1 and player2. Maybe a Set to allow only unique users to be added?
