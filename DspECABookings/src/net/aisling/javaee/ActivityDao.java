package net.aisling.javaee;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.aisling.javaee.Activities;

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
	
	public List<Activities> listAllActivities() throws SQLException {
		
		List<Activities> listActivities = new ArrayList<>();
		
		String sql = "SELECT * FROM ecas";
		
		connect();
		Statement statement = jdbcConnection.createStatement();
		ResultSet resultSet = statement.executeQuery(sql);
			while(resultSet.next()) {
				String dayOfWeek = resultSet.getString("dayOfWeek");
				String activityName = resultSet.getString("activityName");
				String classTime = resultSet.getString("classTime");
				String eligibility = resultSet.getString("eligibility");
				int noOfWeeks = resultSet.getInt("noOfWeeks");
				int cost = resultSet.getInt("cost");
				int maxClassSize = resultSet.getInt("maxClassSize");
				int spacesAvailable = resultSet.getInt("spacesAvailable");
				Activities activity = new Activities(dayOfWeek, activityName, classTime, eligibility, noOfWeeks, cost, maxClassSize, spacesAvailable);
				listActivities.add(activity);
			}
			resultSet.close();
			statement.close();
			
			disconnect();
			
			return listActivities;
		}
	
}
