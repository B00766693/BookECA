package net.aisling.javaee;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.aisling.javaee.Participant;
import net.aisling.javaee.ParticipantDao;

/**
 * Servlet implementation class EcaServlet
 */
@WebServlet("/register")
public class EcaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ParticipantDao participantDao;
	
	public void init() {
		participantDao = new ParticipantDao();
    }
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {

		        String firstName = request.getParameter("firstName");
		        String lastName = request.getParameter("lastName");
		        String schoolClass = request.getParameter("schoolClass"); 
		        
		        Participant participant = new Participant();
		        participant.setFirstName(firstName);
		        participant.setLastName(lastName);
		        participant.setSchoolClass(schoolClass);
		        
		        try {
		            participantDao.registerParticipant(participant);
		        } catch (Exception e) {
		            // TODO Auto-generated catch block
		            e.printStackTrace();
		        }
		        
		        RequestDispatcher dispatcher = request.getRequestDispatcher("/bookingDetails.jsp");
		        dispatcher.forward(request,response);
}
}