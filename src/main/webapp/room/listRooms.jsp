<%@page import="com.cinema.repository.CinemaRepository"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="java.util.List" %>
    <%@ page import="com.cinema.model.Room" %>
    <%@ page import="com.cinema.model.Cinema" %>
    <%@ page import="com.cinema.repository.CinemaRepository" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List room</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%@ include file="../nav.jsp" %>
	<%
	
	List<Cinema> cinemas = null;
	List<Room> rooms = null;
	try {
		cinemas = (ArrayList<Cinema>)DbRepository.findAll(Cinema.class);
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	%>

<table class="table">
	<thead>
<%
for (Cinema cinema : cinemas) {
	rooms = cinema.getRooms();
%>
		<tr><th><h2>Cinema: <%= cinema.getCinema() %></h2></th></tr>
		<tr>
			<th scope="col">Room ID</th>
			<th scope="col">Capacity</th>
			<th scope="col">Details</th>
		</tr>
	</thead>
<%
for (Room room : CinemaRepository.getRooms(cinema.getCinema())) {
%>
	<tbody>
	<tr>
		<td>Room: <%= room.getIdRoom() %></td>
		<td>Capacity: <%= room.getCapacity() %></td>
		<%if (session.getAttribute("roleUser").equals("admin")) { %>
		<td><a href="./roomInfo.jsp"><button class="btn btn-primary">Details</button></a></td>
		<%} %>
	</tr>
<%}}%>
</tbody>
</table>	
</body>
</html>