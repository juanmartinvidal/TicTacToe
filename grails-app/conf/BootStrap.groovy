import com.tictactoe.Role
import com.tictactoe.User
import com.tictactoe.UserRole

class BootStrap {

    def init = { servletContext ->

        Role userRole = Role.findAuthority("ROLE_USER") ?: new Role(authority: "ROLE_USER").save()

        User user1 = new User(username: "chuckn",
                password: "asdasd",
                email: "chuck@norris.com",
                fullName: "Chuck Norris",
                enabled: true).save(failOnError: true)
        UserRole.create user1, userRole, true

        User user2 = new User(username: "homers",
                password: "asdasd",
                email: "homer@springfield.com",
                fullName: "Homer Simpson",
                enabled: true).save(failOnError: true)
        UserRole.create user2, userRole, true

        User user3 = new User(username: "batman",
                password: "asdasd",
                email: "batman@gothamcity.com",
                fullName: "The Batman",
                enabled: true).save(failOnError: true)
        UserRole.create user3, userRole, true
    }

    def destroy = {
    }
}
