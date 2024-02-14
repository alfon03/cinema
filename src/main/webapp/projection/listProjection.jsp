<%@page import="com.cinema.repository.ProjectionRepository"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cinema.model.Film"%>
<%@page import="com.cinema.model.Room"%>
<%@page import="com.cinema.model.Cinema"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.model.Projection"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">
</head>
<body>
<%@include file="../nav.jsp" %>
<%
	List<Projection> listProjection = null;

	try{
		listProjection = DbRepository.findAll(Projection.class);
	}catch(Exception e){
		
	}

%>
<table class="table">
  <thead>
    <tr>
      <th scope="col">Cine</th>
      <th scope="col">Sala</th>
      <th scope="col">Cip</th>
      <th scope="col">Fecha de estreno</th>
      <th scope="col">Dias de estreno</th>
      <th scope="col">Espectadores</th>
      <th scope="col">Recaudacion</th>
    </tr>
  </thead>
  <tbody>
  <!-- Recorremos toda la lista para crear una fila por cada una de ellas y un boton para mostrar toda la informacion -->
  <%for(Projection projection: listProjection) { %>
    <tr>
      <td><%=projection.getRoom().getCinema().getCinema() %></td>
      <td><%=projection.getRoom().getIdRoom() %></td>
      <td><%=projection.getFilm().getName() %></td>
      <td><%=projection.getReleaseDate() %></td>
      <td><%=projection.getPremiereDays() %></td>
      <td><%=projection.getViewers() %></td>
      <td><%=projection.getTakings() %></td>
      <td>
      <form action="infoProjection.jsp">
		<div class="form-group row">
		  <div class="offset-4 col-8">
		  <input type="text" name="cinema" value="<%=projection.getRoom().getCinema().getCinema()%>" hidden>
		  <input type="text" name="room" value="<%=projection.getRoom().getIdRoom()%>" hidden>
		  <input type="text" name="film" value="<%=projection.getFilm().getId()%>" hidden>
		  <input type="text" name="releaseDate" value="<%=projection.getReleaseDate()%>" hidden>
		    <button name="submit" type="submit" class="btn btn-primary">Ver Projección</button>
		  </div>
		</div>
		</form>
      </td>
      <td>
      <form action="infoCinema.jsp">
		<div class="form-group row">
		  <div class="offset-4 col-8">
		  <input type="text" name="cinema" value="<%=projection.getRoom().getCinema().getCinema()%>" hidden>
		    <button name="submit" type="submit" class="btn btn-primary">Ver Cine</button>
		  </div>
		</div>
		</form>
      </td>
    </tr>
    <%} %>
  </tbody>
</table>
</body>
</html>