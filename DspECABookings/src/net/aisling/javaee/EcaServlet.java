package net.aisling.javaee;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.aisling.javaee.Participant;
import net.aisling.javaee.ParticipantDao;
import net.aisling.javaee.Activity;
import net.aisling.javaee.ActivityDao;

/**
 * Servlet implementation class EcaServlet
 */
@WebServlet("/register")
public class EcaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ParticipantDao participantDao;
	private ActivityDao activityDAO;
	
	public void init() {
		String jdbcURL = "jdbc:mysql://localhost:3306/mysql_database?useSSL=false" ;
		String jdbcUsername = "root" ;
		String jdbcPassword = "aisling" ;
		
		activityDAO = new ActivityDao(jdbcURL, jdbcUsername, jdbcPassword);
		
    }
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		
		String action = request.getServletPath();

		try {
			
			switch (action) {
			case "/register":
				submitData(request,response);
				break;
			default:
				listActivity(request,response);
				break;
			}//switch
		}catch (SQLException ex) {
           throw new ServletException(ex);
		}//catch
	}//doGet
	
	private void listActivity(HttpServletRequest request, HttpServletResponse response)
		    throws SQLException, ServletException, IOException {
		List<Activity> listActivity = activityDAO.listAllActivities();
		request.setAttribute("listActivity",listActivity);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/mainPage.jsp");
        dispatcher.forward(request,response);
	}//listActivity
	
	
		       
	private void submitData(HttpServletRequest request, HttpServletResponse response)
		    throws SQLException, ServletException, IOException {
		
	participantDao = new ParticipantDao();
	
				String firstName = request.getParameter("firstName");
		        String lastName = request.getParameter("lastName");
		        String schoolClass = request.getParameter("schoolClass"); 
		        String parentName = request.getParameter("parentName");
		        String telNo = request.getParameter("telNo");
		        
		        Participant participant = new Participant();
		        participant.setFirstName(firstName);
		        participant.setLastName(lastName);
		        participant.setSchoolClass(schoolClass);
		        participant.setParentName(parentName);
		        participant.setTelNo(telNo);
		        
		        //submit participant details to database
		        try {
		            participantDao.registerParticipant(participant);
		        } catch (Exception e) {
		            // TODO Auto-generated catch block
		            e.printStackTrace();
		        }
		        
		        finally {
		        	//Get the participant ID to insert into the if statement below
		        	int participantId = ParticipantDao.getId(firstName,lastName);
		        		
		        	//Submitting the Id & Activities selected to the bridge table
		        	
		        	String [] ecasSelected = request.getParameterValues("bookingCode");
		        	      	
		        		if ((participantId > 0) && (ecasSelected !=null)){
		        			for(int i=0; i <ecasSelected.length; i++){
		        				String eca = ecasSelected[i];
		        				int ecaConvert = Integer.parseInt(eca.trim());
		        					
		        			try{
		        			Class.forName("com.mysql.jdbc.Driver");
		        			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql_database", "root", "aisling");
		        			Statement st=con.createStatement();
		        			int is=st.executeUpdate("INSERT INTO activity_enrollment(id, activityId) VALUES("+participantId+", "+ecaConvert+")");
		        			System.out.println("Data is successfully inserted into database.");
		        			
		        			}catch(Exception e){
		        			System.out.println(e);
		        			}
		        	}
		        	}
		        	
		        }//finally
		        
		        //create list of all activities inserted to database under participant id
		        List<Activity> listBookedActivity = activityDAO.listAllBookedActivities(firstName,lastName );
				request.setAttribute("listBookedActivity",listBookedActivity);
		        
				//Get the total amount due
				String [] ecasSelected = request.getParameterValues("bookingCode");
				int totalAmount = 0;
				
					if (ecasSelected !=null){
						for(int i=0; i <ecasSelected.length; i++){
							if (ecasSelected[i].equals("1")) 
								totalAmount =totalAmount +70;
							if (ecasSelected[i].equals("2")) 
									totalAmount =totalAmount +120;
							if (ecasSelected[i].equals("3")) 
									totalAmount =totalAmount +70;
							if (ecasSelected[i].equals("4")) 
									totalAmount =totalAmount +130;
							if (ecasSelected[i].equals("5")) 
									totalAmount =totalAmount +115;		
							}//for
					}//if
					
				request.setAttribute("totalCost",totalAmount);
				
				
		        RequestDispatcher dispatcher = request.getRequestDispatcher("/bookingDetails.jsp");
		        dispatcher.forward(request,response);
	}//submitData
	
	
	
	
}//EcaServlet