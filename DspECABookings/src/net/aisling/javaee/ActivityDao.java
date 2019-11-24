package net.aisling.javaee;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.aisling.javaee.Activity;

public class ActivityDao {
	
	private String jdbcURL;
	private String jdbcUsername;
	private String jdbcPassword;
	private Connection jdbcConnection;
	
	public ActivityDao(String jdbcURL, String jdbcUsername, String jdbcPassword) {
		this.jdbcURL = jdbcURL;
		this.jdbcUsername = jdbcUsername;
		this.jdbcPassword = jdbcPassword;
	}
	
	protected void connect() throws SQLException{
		if (jdbcConnection == null || jdbcConnection.isClosed()) {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			}catch (ClassNotFoundException e) {
				throw new SQLException(e);
			}
			jdbcConnection = DriverManager.getConnection(jdbcURL,jdbcUsername, jdbcPassword);
		}
	}
	
	protected void disconnect() throws SQLException{
		if (jdbcConnection != null && !jdbcConnection.isClosed()) {
			jdbcConnection.close();
		}
	}	
	
	public List<Activity> listAllActivities() throws SQLException {
		
		List<Activity> listActivity = new ArrayList<>();
		
		String sql = "SELECT * FROM ecas";
		
		connect();
		Statement statement = jdbcConnection.createStatement();
		ResultSet resultSet = statement.executeQuery(sql);
			while(resultSet.next()) {
				String dayOn = resultSet.getString("dayOn");
				String activityName = resultSet.getString("activityName");
				String classTime = resultSet.getString("classTime");
				String eligibility = resultSet.getString("eligibility");
				int noOfWeeks = resultSet.getInt("noOfWeeks");
				int cost = resultSet.getInt("cost");
				int maxClassSize = resultSet.getInt("maxClassSize");
				int spacesAvailable = resultSet.getInt("spacesAvailable");
				int aId = resultSet.getInt("activityId");
				Activity activity = new Activity( dayOn, activityName, classTime, eligibility, noOfWeeks, cost, maxClassSize, spacesAvailable, aId);
				listActivity.add(activity);
			}
			resultSet.close();
			statement.close();
			
			disconnect();
			
			return listActivity;
		}
	
public List<Activity> listAllBookedActivities() throws SQLException {
		
		List<Activity> listBookedActivity = new ArrayList<>();
		
		String sql = "SELECT  dayOn, activityName, classTime, cost FROM activity_enrollment JOIN ecas ON ecas.activityId = activity_enrollment.activityID JOIN participant ON participant.id = activity_enrollment.id WHERE first_name = 'Bob' AND last_name = 'Smith'";
		
		connect();
		Statement statement = jdbcConnection.createStatement();
		ResultSet resultSet = statement.executeQuery(sql);
			while(resultSet.next()) {
				String dayOn = resultSet.getString("dayOn");
				String activityName = resultSet.getString("activityName");
				String classTime = resultSet.getString("classTime");
				int cost = resultSet.getInt("cost");
				
				Activity activity = new Activity(dayOn, activityName, classTime, cost);
				listBookedActivity.add(activity);
			}
			resultSet.close();
			statement.close();
			
			disconnect();
			
			return listBookedActivity;
		}
	
	
	
	
	
}
