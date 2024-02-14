<%@page import="org.hibernate.boot.spi.AdditionalJaxbMappingProducer"%>
<%@page import="com.cinema.repository.ProjectionRepository"%>
<%@page import="com.cinema.model.Film"%>
<%@page import="com.cinema.model.Room"%>
<%@page import="com.cinema.model.Cinema"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cinema.model.Projection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Info Projection</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="../styles/styleSheet.css">
</head>
<body>
<%@include file="../nav.jsp" %>
	<%
	Projection projection = null;
	Projection projection1 = null;
	Room room = null;
	Film film = null;
	Date releaseDate = null;
	
		try{
			
			room = DbRepository.find(request.getParameter("cinema"), Integer.valueOf(request.getParameter("room")));
			film = DbRepository.find(Film.class, request.getParameter("film"));
			releaseDate = Date.valueOf(request.getParameter("releaseDate"));
			projection = new Projection(room,film,releaseDate);
			projection1 = ProjectionRepository.find(projection);
				
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg="+e.getMessage());
			return;
		}
	%>
<div class="mainWrap">
	<form>
  <div class="form-group row">
    <label for="text" class="col-4 col-form-label">Cine</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="cip" name="cip" type="text" class="form-control" value="<%=projection.getRoom().getCinema().getCinema() %>" readonly>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">Sala</label> 
    <div class="col-8">
      <input id="title_p" name="title_p" type="text" class="form-control" value="<%=projection.getRoom().getIdRoom() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text2" class="col-4 col-form-label">Pelicula</label> 
    <div class="col-8">
      <input id="film" name="year_production" type="text" class="form-control" value="<%=projection.getFilm().getId() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text3" class="col-4 col-form-label">Fecha de Estreno</label> 
    <div class="col-8">
      <input id="title_s" name="title_s" type="text" class="form-control" value="<%=projection.getReleaseDate()%>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text4" class="col-4 col-form-label">Dias de estreno</label> 
    <div class="col-8">
      <input id="nacionality" name="nacionality" type="text" class="form-control" value="<%=projection.getPremiereDays() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">Espectadores</label> 
    <div class="col-8">
      <input id="budget" name="budget" type="text" class="form-control" value="<%=projection.getViewers() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text6" class="col-4 col-form-label">Recaudacion</label> 
    <div class="col-8">
      <input id="duration" name="duration" type="text" class="form-control" value="<%=projection.getTakings() %>" readonly>
    </div>
  </div>
  </form>
  <div>
  <%if (session.getAttribute("roleUser").equals("admin")) { %>
  <form action="editProjection.jsp">
		<div class="form-group row">
		  <div class="offset-4 col-8">
		  <input type="text" name="cinema" value="<%=projection.getRoom().getCinema().getCinema()%>" hidden>
		  <input type="text" name="room" value="<%=projection.getRoom().getIdRoom()%>" hidden>
		  <input type="text" name="film" value="<%=projection.getFilm().getId()%>" hidden>
		  <input type="text" name="releaseDate" value="<%=projection.getReleaseDate()%>" hidden>
		    <button name="submit" type="submit" class="btn btn-warning">Edit</button>
		  </div>
		</div>
		</form>
		<form action="deleteProjection.jsp">
		<div class="form-group row">
		  <div class="offset-4 col-8">
		  <input type="text" name="cinema" value="<%=projection.getRoom().getCinema().getCinema()%>" hidden>
		  <input type="text" name="room" value="<%=projection.getRoom().getIdRoom()%>" hidden>
		  <input type="text" name="film" value="<%=projection.getFilm().getId()%>" hidden>
		  <input type="text" name="releaseDate" value="<%=projection.getReleaseDate()%>" hidden>
		    <button name="submit" type="submit" class="btn btn-danger">Delete</button>
		  </div>
		</div>
		</form>
		<%} %>
		</div>
  </div>
</body>
</html>