<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link   href="asset/css/style.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<img src="asset/images/2465.jpg" alt="DSP Logo" width="175" height="100" >
<a href="timetable.jsp" class="button3">Add Details to Calendar - placeholder of timetable.jsp</a>
<a href=<%= request.getContextPath() %>/register" class="button2">Book Another Child</a>

<h1>Booking is Successful</h1>
 <%
String firstName = request.getParameter("firstName");
String schoolClass = request.getParameter("schoolClass"); 
String parentName = request.getParameter("parentName"); 
%> 
<h3>You have booked <font color=green> <%= firstName%> </font> <% %>  <% %>of <font color=green><%= schoolClass%> </font>into: </h3>


<fieldset>
	<legend>Classes and Activities :  Booked   </legend>
	<table>
  <tr>
    <th>Day</th>
    <th>Name</th>
    <th>Time</th>
    <th>Cost</th>
    
  </tr>
  <c:forEach var="activity" items="${listBookedActivity}">
                <tr>
                    <td><c:out value="${activity.dayOn}" /></td>
                    <td><c:out value="${activity.activityName}" /></td>
                    <td><c:out value="${activity.classTime}" /></td>
                    <td>€<c:out value="${activity.cost}" /></td>
                </tr>
            </c:forEach>
  </table>	
 </fieldset>
 <br>
 <h3>The total amount due is <font color=blue>  <% %> €  <%= request.getAttribute("totalCost")%></font> </h3> 

<p>
Please transfer the amount due to:<br><br>
DSP PTA<br>
Allied Irish Banks<br>
21 Castle Street Dalkey<br>
IBAN: IEAIBK933538123456789<br>
<br>
Please use  <span style="font-weight:bold"><%= parentName%></span> as a reference in your bank transfer.
</p>

  <p>Google Calendar API Quickstart</p>


<!--Checkboxes to determine what dates to put in--> 
<p>Select which activity dates you want inserted to your google calendar:</p>
  <input type="checkbox"   name="activity" id="activity" value="1" > Add <font color=blue>1st & 2nd Class Basketball </font>Dates<br>
  <input type="checkbox" name="activity" id="activity" value="2"> Add <font color=blue>Arts  & Crafts </font>Dates<br>
  <input type="checkbox"   name="activity" id="activity" value="3" > Add <font color=blue>3rd Class Basketball</font> Dates<br>
  <input type="checkbox" name="activity" id="activity" value="4"> Add <font color=blue>Hockey </font>Dates<br>
  <input type="checkbox" name="activity" id="activity" value="5"> Add <font color=blue>Swimming </font>Dates<br>
<br><br>
    <!--Add buttons to initiate auth sequence and sign out-->
    <button id="authorize_button" style="display: none;">Authorise</button>
    <button id="signout_button" style="display: none;">Sign Out</button>
    
    <pre id="content" style="white-space: pre-wrap;"></pre>


    <script type="text/javascript">
      // Client ID and API key from the Developer Console
      var CLIENT_ID = '677166826089-eh87ib5vrb7c771s8l18f4f933q9ii43.apps.googleusercontent.com';
      var API_KEY = 'AIzaSyDosdN7907ErYaER9OT_rm6hbSbBjIq-lg';
      //variables to use in if statement
      
	
      // Array of API discovery doc URLs for APIs used by the quickstart
      var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest"];

      // Authorization scopes required by the API; multiple scopes can be
      // included, separated by spaces.
      var SCOPES = "https://www.googleapis.com/auth/calendar";

      var authorizeButton = document.getElementById('authorize_button');
      var signoutButton = document.getElementById('signout_button');

      /**
       *  On load, called to load the auth2 library and API client library.
       */
      function handleClientLoad() {
        gapi.load('client:auth2', initClient);
      }

      /**
       *  Initializes the API client library and sets up sign-in state
       *  listeners.
       */
      function initClient() {
        gapi.client.init({
          apiKey: API_KEY,
          clientId: CLIENT_ID,
          discoveryDocs: DISCOVERY_DOCS,
          scope: SCOPES
        }).then(function () {
          // Listen for sign-in state changes.
          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);

          // Handle the initial sign-in state.
          updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
          authorizeButton.onclick = handleAuthClick;
          signoutButton.onclick = handleSignoutClick;
        }, function(error) {
          appendPre(JSON.stringify(error, null, 2));
        });
      }

      /**
       *  Called when the signed in status changes, to update the UI
       *  appropriately. After a sign-in, the API is called.
       */
      function updateSigninStatus(isSignedIn) {
        if (isSignedIn)  {
          authorizeButton.style.display = 'none';
          signoutButton.style.display = 'block';
          insertEvents();
        } else {
          authorizeButton.style.display = 'block';
          signoutButton.style.display = 'none';
        }
        
      }

      
      /**
       *  Sign in the user upon button click.
       */
      function handleAuthClick(event) {
        gapi.auth2.getAuthInstance().signIn();
      }

      /**
       *  Sign out the user upon button click.
       */
      function handleSignoutClick(event) {
        gapi.auth2.getAuthInstance().signOut();
      }

      /**
       * Append a pre element to the body containing the given message
       * as its text node. Used to display the results of the API call.
       *
       * @param {string} message Text to be placed in pre element.
       */
      function appendPre(message) {
        var pre = document.getElementById('content');
        var textContent = document.createTextNode(message + '\n');
        pre.appendChild(textContent);
      }

       function insertEvents() {
    		
    		var checkboxes = document.getElementsByName("activity");
    		var chosenActivity;
    		
    		for(var i = 0; i < checkboxes.length; i++)   {  
    	        if(checkboxes[i].checked)  {
    	        	chosenActivity = (checkboxes[i].value);
    	        		if (chosenActivity == 1)  {
    	        			insertBasketballFirstSecondEvents(); 
    	        			}
    	        		if (chosenActivity == 2)  {
    	        			insertCraftsEvents(); 
    	        			}
    	        		if (chosenActivity == 3)  {
    	        			insertBasketballThirdEvents(); 
    	        			}
    	        		if (chosenActivity == 4)  {
    	        			insertHockeyEvents(); 
    	        			}
    	        		if (chosenActivity == 5)  {
    	        			insertSwimmingEvents(); 
    	        			}
    			}
    		}
    	}	
    		
    		
    		
       
       function insertBasketballFirstSecondEvents() {
           
       	// Refer to the JavaScript quickstart on how to setup the environment:
       	// https://developers.google.com/calendar/quickstart/js
       	// Change the scope to 'https://www.googleapis.com/auth/calendar' and delete any
       	// stored credentials.

       	var event = {
       	  'summary': 'TestBasketballFirstSecond',
       	  'start': {
       	    'dateTime': '2019-12-07T14:10:00+00:00',
       	    'timeZone': 'Europe/Dublin'
       	  },
       	  'end': {
       	    'dateTime': '2019-12-07T15:00:00+00:00',
       	    'timeZone': 'Europe/Dublin'
       	  },
       	  'recurrence': [
       		'EXDATE;VALUE=DATE:20191222T141000',  
       		'RRULE:FREQ=WEEKLY;UNTIL=20200131T090000Z'
       	  ],
    	  colorId: 5
       	};

       	var request = gapi.client.calendar.events.insert({
       	  'calendarId': 'primary',
       	  'resource': event
       	});

       	request.execute(function(event) {
       	  appendPre('TestBasketball First & Second dates inserted to calendar: ' + event.htmlLink);
       	})  
       	  
         }
       
       function insertBasketballThirdEvents() {
           
       	// Refer to the JavaScript quickstart on how to setup the environment:
       	// https://developers.google.com/calendar/quickstart/js
       	// Change the scope to 'https://www.googleapis.com/auth/calendar' and delete any
       	// stored credentials.

       	var event = {
       	  'summary': 'TestBasketballThird',
       	  'start': {
       	    'dateTime': '2019-12-07T15:00:00+00:00',
       	    'timeZone': 'Europe/Dublin'
       	  },
       	  'end': {
       	    'dateTime': '2019-12-07T15:45:00+00:00',
       	    'timeZone': 'Europe/Dublin'
       	  },
       	  'recurrence': [
       		'EXDATE;VALUE=DATE:20191222T141000',  
       		'RRULE:FREQ=WEEKLY;UNTIL=20200131T090000Z'
       	  ],
    	  colorId: 3
       	};

       	var request = gapi.client.calendar.events.insert({
       	  'calendarId': 'primary',
       	  'resource': event
       	});

       	request.execute(function(event) {
       	  appendPre('TestBasketballThird dates inserted to calendar: ' + event.htmlLink);
       	})  
       	  
         }
      
      function insertSwimmingEvents() {
        
    	// Refer to the JavaScript quickstart on how to setup the environment:
    	// https://developers.google.com/calendar/quickstart/js
    	// Change the scope to 'https://www.googleapis.com/auth/calendar' and delete any
    	// stored credentials.

    	var event = {
    	  'summary': 'TestSwimming',
    	  'start': {
    	    'dateTime': '2019-12-08T14:10:00+00:00',
    	    'timeZone': 'Europe/Dublin'
    	  },
    	  'end': {
    	    'dateTime': '2019-12-08T15:00:00+00:00',
    	    'timeZone': 'Europe/Dublin'
    	  },
    	  'recurrence': [
    		'EXDATE;VALUE=DATE:20191222T141000',  
    		'RRULE:FREQ=WEEKLY;UNTIL=20200131T090000Z'
    	  ],
    	  colorId: 6
    	};

    	var request = gapi.client.calendar.events.insert({
    	  'calendarId': 'primary',
    	  'resource': event
    	});

    	request.execute(function(event) {
    	  appendPre('TestSwimming dates inserted to calendar: ' + event.htmlLink);
    	})  
    	  
      }

      
      function insertHockeyEvents() {
          
      	var event = {
      	  'summary': 'TestHockey',
      	  'start': {
      	    'dateTime': '2019-12-07T14:10:00+00:00',
      	    'timeZone': 'Europe/Dublin'
      	  },
      	  'end': {
      	    'dateTime': '2019-12-07T15:45:00+00:00',
      	    'timeZone': 'Europe/Dublin'
      	  },
      	  'recurrence': [
      		'EXDATE;VALUE=DATE:20191228T141000',  
      		'RRULE:FREQ=WEEKLY;UNTIL=20200131T090000Z'
      	  ],
    	  colorId: 10//colour ok
      	};

      	var request = gapi.client.calendar.events.insert({
      	  'calendarId': 'primary',
      	  'resource': event
      	});

      	request.execute(function(event) {
      	  appendPre('TestHockey dates inserted to calendar: ' + event.htmlLink);
      	})  
      	  
        }

      function insertCraftsEvents() {
          
        	var event = {
        	  'summary': 'TestArts&Crafts',
        	  'start': {
        	    'dateTime': '2019-12-10T14:10:00+00:00',
        	    'timeZone': 'Europe/Dublin'
        	  },
        	  'end': {
        	    'dateTime': '2019-12-10T15:30:00+00:00',
        	    'timeZone': 'Europe/Dublin'
        	  },
        	  'recurrence': [
        		'EXDATE;VALUE=DATE:20191228T141000',  
        		'RRULE:FREQ=WEEKLY;UNTIL=20200131T090000Z'
        	  ],
        	  colorId: 11//colour ok
        	};

        	var request = gapi.client.calendar.events.insert({
        	  'calendarId': 'primary',
        	  'resource': event
        	});

        	request.execute(function(event) {
        	  appendPre('TestArts&Crafts dates inserted to calendar: ' + event.htmlLink);
        	})  
        	  
          }
      
        
    </script>

    <script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>

</body>
</html>