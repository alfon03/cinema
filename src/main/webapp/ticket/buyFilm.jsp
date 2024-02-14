<%@page import="com.cinema.repository.ProjectionRepository"%>
<%@page import="com.cinema.repository.TicketRepository"%>
<%@page import="com.cinema.model.User"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.cinema.model.Ticket"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.model.Room"%>
<%@page import="com.cinema.model.Projection"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cinema.model.Film"%>
<%@page import="com.cinema.model.Cinema"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Buy your tickets</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	
	<%
	User user = null;
	if (session.getAttribute("user") == null) {
		response.sendRedirect("../index.jsp");
		return;
	}
	else {
		user = DbRepository.find(User.class, session.getAttribute("user").toString());
	}
	String message = "";
	Cinema cinema = null;
	Film film = null;
	String error = null;
	Date premiereDate = null;
	Room room = null;
	Projection projection = null;
	try{
		//Busco un cine con el parametro que nos ha pasado
		String cinemaParam = request.getParameter("projectionCinema");
		String roomParam = request.getParameter("projectionRoom");
		String filmParam = request.getParameter("projectionFilm");
		
		try{
			premiereDate = Date.valueOf(request.getParameter("projectionReleaseDate"));
		}catch(Exception e){
			error = "Error Premiere Date not valid";
		}
		
		if(filmParam != null){
			film = DbRepository.find(Film.class,filmParam);					
		}else{
			error = "Error film not valid";
		}
		
		if(cinemaParam != null){
			 cinema = DbRepository.find(Cinema.class, cinemaParam);
		}else{
			error = "Error cinema not valid";
		}
		
		try{
			if(cinema != null){
				room = new Room(cinema,Integer.valueOf(roomParam),23);					
			}else{
				error = "Error cinema not valid";
			}
		}catch(Exception e){
			error = "Error room number not valid";
		}
		
		
	 	if(error == null && room == null){
			error = "Error room not valid";
		}else if(error == null && cinema == null){
			error = "Error cinema not valid";
		}else if(error == null && film == null){
			error = "Error film not valid";
		}
		
		Projection projectionFind = null;
		if(error == null){
			try{
				 projectionFind = new Projection(room,film,premiereDate);
			}catch(Exception e){
				error = e.getMessage();
			}
			projection = DbRepository.find(Projection.class, projectionFind);				
		}
		
	}catch(Exception e){
		//En el caso de que haya un error en la base de datos lo redirecciono a la base de datos con el error correspondiente
		response.sendRedirect("../error.jsp?msg=Failed to connect to database");
		return;
	}
	int realCapacity = projection.getRoom().getCapacity() - TicketRepository.findByProjection(projection).size();
	if (request.getParameter("submit") != null) {
		try {
			for (int i = 0; i < Integer.parseInt(request.getParameter("amount")); i++) {
				Ticket ticket = new Ticket(projection, user, Date.valueOf(LocalDate.now()));
				TicketRepository.addTicket(ticket);
			}
			message = "You shopped this ticket/s succesfully.";
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("../error.jsp?msg=A unspected error ocurred.");
			return;
		}
	}
	
	%>
	
<form method="post">
<div class="form-group row">
    <label for="cinema" class="col-4 col-form-label">Cinema</label> 
    <div class="col-8">
      <input id="cinema" name="cinema" value="<%= projection.getRoom().getCinema().getCinema() %>" type="text" class="form-control" readonly>
    </div>
</div>
<div class="form-group row">
    <label for="room" class="col-4 col-form-label">Room:</label> 
    <div class="col-8">
      <input id="room" name="room" type="text" value="<%= projection.getRoom().getIdRoom() %>" class="form-control" readonly>
    </div>
</div>
<div class="form-group row">
    <label for="date" class="col-4 col-form-label">Date:</label> 
    <div class="col-8">
      <input id="date" name="date" type="text" value="<%= projection.getReleaseDate() %>" class="form-control" readonly>
    </div>
</div>
<div class="form-group row">
    <label for="film" class="col-4 col-form-label">Film</label> 
    <div class="col-8">
      <input id="film" name="film" type="text" value="<%= projection.getFilm().getName() %>" class="form-control" readonly>
    </div>
</div>
<div class="form-group row">
    <label for="amount" class="col-4 col-form-label">Amount:</label> 
    <div class="col-8">
      <input id="amount" name="amount" placeholder="Amount of tickets" type="number" class="form-control" required="required" max="<%= realCapacity %>" min="1">
    </div>
  </div> 
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" type="submit" class="btn btn-primary">Buy</button>
    </div>
  </div>
</form>
<div class="form-group row">
    <div class="offset-4 col-8">
      <a href="./showFilms.jsp"><button type="button" class="btn btn-primary">Go back</button></a>
    </div>
  </div>
<p><% if (message != null && !message.isBlank()) { %><%= message %><% } %></p>
</body>
</html>