package net.aisling.javaee;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.aisling.javaee.Activity;
import net.aisling.javaee.ActivityDao;
import net.aisling.javaee.Participant;
import net.aisling.javaee.ParticipantDao;
import net.aisling.javaee.EmailUtility;

/**
 * Servlet implementation class EcaServlet
 */
@WebServlet("/register")
public class EcaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ParticipantDao participantDao;
	private ActivityDao activityDAO;
	private String host;
	private String port;
	private String user;
	private String pass;

	public void init() {
		String jdbcURL = "jdbc:mysql://localhost:3306/mysql_database?useSSL=false";
		String jdbcUsername = "root";
		String jdbcPassword = "aisling";

		activityDAO = new ActivityDao(jdbcURL, jdbcUsername, jdbcPassword);

		// Reads SMTP server setting from web.xml file
		ServletContext context = getServletContext();
		host = context.getInitParameter("host");
		port = context.getInitParameter("port");
		user = context.getInitParameter("user");
		pass = context.getInitParameter("pass");

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getServletPath();

		try {

			switch (action) {
			case "/register":
				submitData(request, response);
				break;
			case "/download":
				download(request, response);
				break;
			case "/email":
				email(request, response);
				break;
			default:
				listActivity(request, response);
				break;
			}
		} catch (SQLException ex) {
			throw new ServletException(ex);
		} 
	}

	private void email(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		// Reads form fields
		String recipient = request.getParameter("recipient");
		String fName = request.getParameter("firstName");
		String lName = request.getParameter("lastName");
		String cost = request.getParameter("cost");

		// Declare additional variables
		int participantId = ParticipantDao.getId(fName, lName);
		List<Activity> listBookedActivity = activityDAO.listNameOfActivities(fName, lName);

		String content = "";
		String resultMessage = "";

		content = "You have booked " + fName + " " + lName + " into  \n" + "the following activities "
				+ listBookedActivity + " \n\n" + "The total cost is €" + cost + ". \n\n"
				+ "Please transfer the amount due to: \n\n DSP PTA \n Allied Irish Banks \n 21 Castle Street Dalkey \n IBAN: IEAIBK933538123456789 \n\n"
				+ "using your name and the ECA ID number: " + participantId + " as the reference. \n\n"
				+ "Kind regards, \n The ECA Team ";

		try {
			EmailUtility.sendEmail(host, port, user, pass, recipient, content);
			resultMessage = "The e-mail was sent successfully";
		} catch (Exception ex) {
			ex.printStackTrace();
			resultMessage = "There were an error: " + ex.getMessage();
		} finally {
			request.setAttribute("MessageEmail", resultMessage);
			getServletContext().getRequestDispatcher("/bookingDetails.jsp").forward(request, response);
		}
	}// email

	private void listActivity(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		List<Activity> listActivity = activityDAO.listAllActivities();
		request.setAttribute("listActivity", listActivity);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/mainPage.jsp");
		dispatcher.forward(request, response);
	}// listActivity

	private void download(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String filename = "2020Timetable.pdf";
		String filepath = "/Users/aislingobroin/Desktop/Project/";
		response.setContentType("APPLICATION/OCTET-STREAM");
		response.setHeader("Content-Disposition", "inline; filename=\"" + filename + "\"");
		FileInputStream fileInputStream = new FileInputStream(filepath + filename);

		int i;
		while ((i = fileInputStream.read()) != -1) {
			out.write(i);
		}
		fileInputStream.close();
		out.close();
	}// download

	private void submitData(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {

		participantDao = new ParticipantDao();

		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String schoolClass = request.getParameter("schoolClass");
		String parentName = request.getParameter("parentName");
		String telNo = request.getParameter("telNo");
		String medInfo = request.getParameter("medInfo");
		String emergNo = request.getParameter("AlternateTelNo");

		Participant participant = new Participant();
		participant.setFirstName(firstName);
		participant.setLastName(lastName);
		participant.setSchoolClass(schoolClass);
		participant.setParentName(parentName);
		participant.setTelNo(telNo);
		participant.setMedInfo(medInfo);
		participant.setEmergNo(emergNo);

		// Submit participant details to database
		try {
			participantDao.registerParticipant(participant);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		finally {
			// Get the participant ID to insert into the if statement below
			int participantId = ParticipantDao.getId(firstName, lastName);

			// Submitting the Id & Activities selected to the bridge table
			String[] ecasSelected = request.getParameterValues("bookingCode");

			if ((participantId > 0) && (ecasSelected != null)) {
				for (int i = 0; i < ecasSelected.length; i++) {
					String eca = ecasSelected[i];
					int ecaConvert = Integer.parseInt(eca.trim());

					try {
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql_database",
								"root", "aisling");
						Statement st = con.createStatement();
						int is = st.executeUpdate("INSERT INTO activity_enrollment(id, activityId) VALUES("
								+ participantId + ", " + ecaConvert + ")");
						System.out.println("Data is successfully inserted into database.");
						int ib = st.executeUpdate(
								"UPDATE ecas SET spacesAvailable = spacesAvailable - 1 WHERE activityId = " + ecaConvert
										+ " ");
						System.out.println("Spaces Available have been updated in database.");
					} catch (Exception e) {
						System.out.println(e);
					}
				}
			}

		} 

		// Create list of all activities inserted to database under participant id
		List<Activity> listBookedActivity = activityDAO.listAllBookedActivities(firstName, lastName);
		request.setAttribute("listBookedActivity", listBookedActivity);

		// Get the total amount due
		String[] ecasSelected = request.getParameterValues("bookingCode");
		int totalAmount = 0;
		int participantId = ParticipantDao.getId(firstName, lastName);

		if (ecasSelected != null) {
			for (int i = 0; i < ecasSelected.length; i++) {
				if (ecasSelected[i].equals("1"))
					totalAmount = totalAmount + 70;
				if (ecasSelected[i].equals("2"))
					totalAmount = totalAmount + 120;
				if (ecasSelected[i].equals("3"))
					totalAmount = totalAmount + 70;
				if (ecasSelected[i].equals("4"))
					totalAmount = totalAmount + 130;
				if (ecasSelected[i].equals("5"))
					totalAmount = totalAmount + 115;
			}
		}

		// Submit the total amount to the database
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql_database", "root",
					"aisling");
			Statement st = con.createStatement();
			int ic = st.executeUpdate(
					"UPDATE participant SET total_due = " + totalAmount + " WHERE id = " + participantId + " ");
			System.out.println("Total amount is successfully inserted into database.");
		} catch (Exception e) {
			System.out.println(e);
		}

		request.setAttribute("totalCost", totalAmount);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/bookingDetails.jsp");
		dispatcher.forward(request, response);
	}// submitData

}