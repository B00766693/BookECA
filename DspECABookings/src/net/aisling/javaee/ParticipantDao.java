package net.aisling.javaee;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import net.aisling.javaee.Participant;

public class ParticipantDao {
	public int registerParticipant(Participant participant) throws ClassNotFoundException {
        String INSERT_USERS_SQL = "INSERT INTO participant" +
            "  (first_name, last_name, class) VALUES " +
            " (?, ?, ?);";

        int result = 0;

        Class.forName("com.mysql.jdbc.Driver");
        try (Connection connection = DriverManager
                .getConnection("jdbc:mysql://localhost:3306/mysql_database?useSSL=false", "root", "aisling");

                // Step 2:Create a statement using connection object
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) {
                preparedStatement.setString(1, participant.getFirstName());
                preparedStatement.setString(2, participant.getLastName());
                preparedStatement.setString(3, participant.getSchoolClass());
                
                System.out.println(preparedStatement);
                // Step 3: Execute the query or update query
                result = preparedStatement.executeUpdate();

            } catch (SQLException e) {
                // process sql exception
                printSQLException(e);
            }
            return result;
        }
	
	private void printSQLException(SQLException ex) {
        for (Throwable e: ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
	
	
}
