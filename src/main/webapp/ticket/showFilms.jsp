<%@page import="com.cinema.model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cinema.model.Projection"%>
<%@page import="com.cinema.model.Room"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.model.Film"%>
<%@page import="com.cinema.model.Cinema"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cinema.repository.ProjectionRepository" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Films</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%@ include file="../nav.jsp" %>
	<%
	User user = null;
	if (session.getAttribute("user") == null) {
		response.sendRedirect("../index.jsp");
		return;
	}
	else {
		user = DbRepository.find(User.class, session.getAttribute("user").toString());
	}
	
	ArrayList<Projection> projections = null;
	try {
		projections = (ArrayList<Projection>)ProjectionRepository.getActualFilms();
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	%>

<table class="table">
  <thead>
    <tr>
      <th scope="col">Cine</th>
      <th scope="col">Sala</th>
      <th scope="col">Pelicula</th>
      <th scope="col">Direccion del cine</th>
      <th scope="col">Buy</th>
    </tr>
  </thead>
<%for (Projection projection : projections) { %>
  <tbody>
  	<tr>
  		<td><%= projection.getRoom().getCinema().getCinema() %></td>
  		<td><%= projection.getRoom().getIdRoom() %></td>
  		<td><%= projection.getFilm().getName() %></td>
  		<td><%= projection.getRoom().getCinema().getCity_cinema() %></td>
  		<td>
  			<a href="./buyFilm.jsp?projectionCinema=<%= projection.getRoom().getCinema().getCinema() %>&projectionRoom=<%= projection.getRoom().getIdRoom() %>&projectionFilm=<%= projection.getFilm().getId() %>&projectionReleaseDate=<%= projection.getReleaseDate() %>"><button type="button" class="btn btn-primary">Buy</button></a>
  		</td>
  	</tr>
<%} %>
  </tbody>
</table>
</body>
</html>