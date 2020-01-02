<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="net.aisling.javaee.ParticipantDao" %>

<!DOCTYPE html>
<html>
<head>
<link   href="asset/css/style.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Booking Details</title>
</head>
<body>
<img src="asset/images/2465.jpg" alt="DSP Logo" width="175" height="100" >

<a href="<%= request.getContextPath() %>/default" class="button">Home</a>
<a href="<%= request.getContextPath() %>/default" class="button">Book Another Child</a>

<div class="row">
  <div class="leftcolumn">
  
<h1>Booking is Successful</h1>
 <%
String firstName = request.getParameter("firstName");
String lastName = request.getParameter("lastName");
String schoolClass = request.getParameter("schoolClass"); 
String parentName = request.getParameter("parentName"); 
int participantId = ParticipantDao.getId(request.getParameter("firstName"),request.getParameter("lastName"));
%> 
<h3>You have booked <font color=green> <%= firstName%> <nbsp> <%= lastName%></font> <% %>  <% %>of <font color=green><%= schoolClass%> </font>into: </h3>


<div>
  <fieldset class="fieldset-auto-width">
	<legend>Classes and Activities :  Booked   </legend>
	<table class="table2">
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

</div> <!--//table2--> 

 <br>
 <h3>The total amount due is <font color=blue>  <% %> €  <%= request.getAttribute("totalCost")%></font> </h3> 
 

<p>
Please transfer the amount due to:<br><br>
DSP PTA<br>
Allied Irish Banks<br>
21 Castle Street Dalkey<br>
IBAN: IEAIBK933538123456789<br>
<br>
Please use  <span style="font-weight:bold"><%= parentName%> id: <%= participantId%></span> as a reference in your bank transfer.
</p>
</div><!--//left column--> 


 <!--Google Calendar Integration--> 
 <div class="rightcolumn">
    <div class="card">
 
	<a class="button3">Export to your <br>Google Calendar</a>
<br><br>
<!--Checkboxes to determine what dates to put in--> 
  <input type="checkbox"   name="activity" id="activity" value="1" > <font color=blue>1st & 2nd Class Basketball </font>Dates<br>
  <input type="checkbox" name="activity" id="activity" value="2"> <font color=blue>Arts  & Crafts </font>Dates<br>
  <input type="checkbox"   name="activity" id="activity" value="3" >  <font color=blue>3rd Class Basketball</font> Dates<br>
  <input type="checkbox" name="activity" id="activity" value="4">  <font color=blue>Hockey </font>Dates<br>
  <input type="checkbox" name="activity" id="activity" value="5">  <font color=blue>Swimming </font>Dates<br>
<br>
    <!--Add buttons to initiate auth sequence and sign out-->
    <button id="authorize_button" style="display: none;">Authorise</button>
    <button id="signout_button" style="display: none;">Sign Out</button>
    
    <pre id="content" style="white-space: pre-wrap;"></pre>

</div><!--//card--> 
</div><!--//right column--> 


    <script type="text/javascript">
      // Client ID and API key from the Developer Console
      var CLIENT_ID = '';
      var API_KEY = '';
      
	
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
           
       	var event = {
       	  'summary': 'Basketball - 1st & 2nd Class',
       	  'start': {
       	    'dateTime': '2020-01-13T14:10:00+00:00',
       	    'timeZone': 'Europe/Dublin'
       	  },
       	  'end': {
       	    'dateTime': '2020-01-13T15:00:00+00:00',
       	    'timeZone': 'Europe/Dublin'
       	  },
       	  'recurrence': [
       		'EXDATE;VALUE=DATE:20200217T141000,20200316T141000',  
       		'RRULE:FREQ=WEEKLY;UNTIL=20200404T090000Z'
       	  ],
       	  'reminders':{
       		  'useDefault': false,
       		  'overrides': [
       			  {'method': 'email', 'minutes': 24 * 60},
       			  {'method' : 'popup', 'minutes' : 60}
       		  ]
       	  },
    	  colorId: 5
       	};

       	var request = gapi.client.calendar.events.insert({
       	  'calendarId': 'primary',
       	  'resource': event
       	});

       	request.execute(function(event) {
       	  appendPre('Basketball for 1st & 2nd dates inserted to calendar');
       	})  
       	  
         }
       
       function insertBasketballThirdEvents() {
      
       	var event = {
       	  'summary': 'Basketball 3rd Class',
       	  'start': {
       	    'dateTime': '2020-01-15T15:00:00+00:00',
       	    'timeZone': 'Europe/Dublin'
       	  },
       	  'end': {
       	    'dateTime': '2020-01-15T15:45:00+00:00',
       	    'timeZone': 'Europe/Dublin'
       	  },
       	  'recurrence': [
       		'EXDATE;VALUE=DATE:20200219T150000',  
       		'RRULE:FREQ=WEEKLY;UNTIL=20200404T090000Z'
       	  ],
       	'reminders':{
     		  'useDefault': false,
     		  'overrides': [
     			  {'method': 'email', 'minutes': 24 * 60},
     			  {'method' : 'popup', 'minutes' : 60}
     		  ]
     	  },
    	  colorId: 3
       	};

       	var request = gapi.client.calendar.events.insert({
       	  'calendarId': 'primary',
       	  'resource': event
       	});

       	request.execute(function(event) {
       	  appendPre('Basketball 3rd Class dates inserted to calendar');
       	})  
       	  
         }
      
      function insertSwimmingEvents() {

    	var event = {
    	  'summary': 'Swimming',
    	  'start': {
    	    'dateTime': '2020-01-16T15:00:00+00:00',
    	    'timeZone': 'Europe/Dublin'
    	  },
    	  'end': {
    	    'dateTime': '2020-01-16T15:45:00+00:00',
    	    'timeZone': 'Europe/Dublin'
    	  },
    	  'recurrence': [
    		'EXDATE;VALUE=DATE:20200220T150000',  
    		'RRULE:FREQ=WEEKLY;UNTIL=20200404T090000Z'
    	  ],
    	  'reminders':{
       		  'useDefault': false,
       		  'overrides': [
       			  {'method': 'email', 'minutes': 24 * 60},
       			  {'method' : 'popup', 'minutes' : 60}
       		  ]
    	  },
    	  colorId: 6
    	};

    	var request = gapi.client.calendar.events.insert({
    	  'calendarId': 'primary',
    	  'resource': event
    	});

    	request.execute(function(event) {
    	  appendPre('Swimming dates inserted to calendar');
    	})   
      }

      
      function insertHockeyEvents() {
          
      	var event = {
      	  'summary': 'Hockey',
      	  'start': {
      	    'dateTime': '2020-01-17T14:10:00+00:00',
      	    'timeZone': 'Europe/Dublin'
      	  },
      	  'end': {
      	    'dateTime': '2020-01-17T15:45:00+00:00',
      	    'timeZone': 'Europe/Dublin'
      	  },
      	  'recurrence': [
      		'EXDATE;VALUE=DATE:20200221T141000',  
      		'RRULE:FREQ=WEEKLY;UNTIL=20200401T090000Z'
      	  ],
      	'reminders':{
     		  'useDefault': false,
     		  'overrides': [
     			  {'method': 'email', 'minutes': 24 * 60},
     			  {'method' : 'popup', 'minutes' : 60}
     		  ]
     	  },
    	  colorId: 10
      	};

      	var request = gapi.client.calendar.events.insert({
      	  'calendarId': 'primary',
      	  'resource': event
      	});

      	request.execute(function(event) {
      	  appendPre('Hockey dates inserted to calendar');
      	})  
      	  
        }

      function insertCraftsEvents() {
          
        	var event = {
        	  'summary': 'Arts & Crafts',
        	  'start': {
        	    'dateTime': '2020-01-14T14:10:00+00:00',
        	    'timeZone': 'Europe/Dublin'
        	  },
        	  'end': {
        	    'dateTime': '2020-01-14T15:30:00+00:00',
        	    'timeZone': 'Europe/Dublin'
        	  },
        	  'recurrence': [
        		'EXDATE;VALUE=DATE:20200218T141000,20200317T141000',  
        		'RRULE:FREQ=WEEKLY;UNTIL=20200401T090000Z'
        	  ],
        	  'reminders':{
           		  'useDefault': false,
           		  'overrides': [
           			  {'method': 'email', 'minutes': 24 * 60},
           			  {'method' : 'popup', 'minutes' : 60}
           		  ]
           	  },
        	  colorId: 11
        	};

        	var request = gapi.client.calendar.events.insert({
        	  'calendarId': 'primary',
        	  'resource': event
        	});

        	request.execute(function(event) {
        	  appendPre('Arts & Crafts dates inserted to calendar');
        	})  
        	  
          }
      
        
    </script>

    <script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>


<!--Email Confirmation--> 
<div class="rightcolumn">
    <div class="card">
    <a class="button3">Receive Email  <br>Confirmation of Booking</a>
<form  action= "<%= request.getContextPath() %>/email" method="get">
	<table border="0" width="35%" align="center">
            <tr>
                <td width="50%">Insert email address </td>
                <td><input type="text" name="recipient" size="40"/></td>
            </tr>
            </table>
            <input type ="hidden" id="firstName" name="firstName" value="<%= firstName%>">
			<input type ="hidden" id="lastName" name="lastName" value=<%= lastName%>>
            <input type ="hidden" id="cost" name="cost" value=<%= request.getAttribute("totalCost")%>>
       <input type="submit" value="Send"/>  
    </form>
<h3><%=request.getAttribute("MessageEmail")%></h3>

</div><!--//card--> 
</div><!--//right column--> 

</div><!--//row--> 
</body>
</html>