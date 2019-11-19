package net.aisling.javaee;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
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
		        
		        try {
		            participantDao.registerParticipant(participant);
		        } catch (Exception e) {
		            // TODO Auto-generated catch block
		            e.printStackTrace();
		        }
		        
		        RequestDispatcher dispatcher = request.getRequestDispatcher("/bookingDetails.jsp");
		        dispatcher.forward(request,response);
	}//submitData
}