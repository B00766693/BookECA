package net.aisling.javaee;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


import net.aisling.javaee.Participant;

public class ParticipantDao {
	public int registerParticipant(Participant participant) throws ClassNotFoundException {
        String INSERT_USERS_SQL = "INSERT INTO participant" +
            "  (first_name, last_name, class, parentName, telNo, medicalInfo,  emergencyNo) VALUES " +
            " (?, ?, ?,?,?,?,?);";

        int result = 0;

        Class.forName("com.mysql.jdbc.Driver");
        try (Connection connection = DriverManager
                .getConnection("jdbc:mysql://localhost:3306/mysql_database?useSSL=false", "root", "aisling");

                // Step 2:Create a statement using connection object
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) {
                preparedStatement.setString(1, participant.getFirstName());
                preparedStatement.setString(2, participant.getLastName());
                preparedStatement.setString(3, participant.getSchoolClass());
                preparedStatement.setString(4, participant.getParentName());
                preparedStatement.setString(5, participant.getTelNo());
                preparedStatement.setString(6, participant.getMedInfo());
                preparedStatement.setString(7, participant.getEmergNo());
                
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
                }//while
            }//if
        }//for
	}//printSQLException

	//int method to get participant 
	public static int getId(String pFirstName, String pLastName) 
			throws SQLException {
			
			int participantId = 0;
			
			try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager
	                .getConnection("jdbc:mysql://localhost:3306/mysql_database?useSSL=false", "root", "aisling");

			String sql = "SELECT id FROM participant WHERE first_name = '"+pFirstName+"' AND last_name = '"+pLastName+"'";

			Statement statement = con.createStatement();
			ResultSet resultSet = statement.executeQuery(sql);
				if(resultSet.next()) {
					participantId = resultSet.getInt("id");
				}
				resultSet.close();
				statement.close();
					
		} catch(Exception e) {
			System.out.println(e);
		}
			return participantId;
			}//getId()
	
}
