<%@page import="com.cinema.repository.ProjectionRepository"%>
<%@page import="com.cinema.model.Projection"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cinema.model.Film"%>
<%@page import="com.cinema.model.Room"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.model.Cinema"%>
<%@page import="com.cinema.exceptions.ProjectionException"%>
<%@page import="java.nio.file.attribute.AclEntryType"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add projection</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="../styles/styleSheet.css">
</head>
<body>
<%@include file="../nav.jsp" %>
<%
if (session.getAttribute("roleUser") != null) {
	if (!session.getAttribute("roleUser").equals("admin")) {
		response.sendRedirect("/pruebaHibernate/index.jsp");
		return;
	}
}
else {
	response.sendRedirect("/pruebaHibernate/index.jsp");
	return;
}
ArrayList<Cinema> listCinema = null;
ArrayList<Film> listFilm = null;
Room room1 = null;
Film film = null;
Cinema cinema = null;
Date premiereDays = null;
int releaseDays = 0;
int viewers = 0;
int takings = 0;
String answer = "";
String answerClass = "okMessage";
	try{
		listCinema = (ArrayList<Cinema>) DbRepository.findAll(Cinema.class);
		listFilm = (ArrayList<Film>) DbRepository.findAll(Film.class);
		
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg="+e.getMessage());
		return;
	}
	try{
		if(request.getParameter("add") != null){
			room1 = DbRepository.find(request.getParameter("cine"), Integer.valueOf(request.getParameter("sala")));
			film = DbRepository.find(Film.class, request.getParameter("film"));
			
			try{
				premiereDays = Date.valueOf(request.getParameter("premiereDays"));
				releaseDays = Integer.valueOf(request.getParameter("releaseDays"));
				viewers = Integer.valueOf(request.getParameter("viewers"));
				takings = Integer.valueOf(request.getParameter("takings"));
			}catch(Exception e){
				response.sendRedirect("../error.jsp?msg="+e.getMessage());
				return;
			}
			
			try{
				Projection projection = new Projection(room1,film,premiereDays,releaseDays,viewers,takings);
				
				if(ProjectionRepository.find(projection) != null){
					answer = "No puedes insertar dos proyecciones iguales";
					answerClass = "errorMessage";
				}
				ProjectionRepository.add(projection);
				answer = "Proyección añadida correctamente";
			}catch(ProjectionException e){
				answer = e.getMessage();
				answerClass = "errorMessage";
			}
		}
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg="+e.getMessage());
		return;
	} 
%>
<%
	if(request.getParameter("elegirSala") == null){%>
		<div class="mainWrap">
		<form action="addProjection.jsp">
			<div class="form-group row">
			  <label for="elegirCine" class="col-4 col-form-label">Cine</label> 
			  <div class="col-8">
				<select name="Elegircine">
				<% 
				for(Cinema cinemas : listCinema){
					%><option value="<%=cinemas.getCinema()%>" selected="selected"><%=cinemas.getCinema() %></option><%
				}%> 
				</select>
			  </div>
			</div>
		<button name="elegirSala" type="submit" class="btn btn-success">Elegir sala</button>
		</form>
		</div>
	<%}else if(request.getParameter("elegirSala") != null){
		List<Room> listRoom = null;	
		try{
			listRoom = DbRepository.findAll(Room.class);
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg=No se ha encontrado ese cine");
			return;
		}
%>
<div class="mainWrap">
<form>
  <div class="form-group row">
    <label for="cine" class="col-4 col-form-label">Cine</label> 
    <div class="col-8">
		<input id="cine" name="cine" type="text" class="form-control" value="<%=request.getParameter("Elegircine") %>" readonly>
      </div>
    </div>
  <div class="form-group row">
    <label for="sala" class="col-4 col-form-label">Sala</label> 
    <div class="col-8">
      <select class="sala" name="sala" required>
        <% 
        for(Room room : listRoom){
        	if(room.getCinema().getCinema().equals(request.getParameter("Elegircine"))){
        	%><option value="<%=room.getIdRoom()%>"><%=room.getIdRoom() %></option><%
        }}
        	%> 
        </select>
    </div>
  </div>
  <div class="form-group row">
    <label for="cip" class="col-4 col-form-label">Cip</label> 
    <div class="col-8">
      <select class="cip" name="film" required>
        	<% 
        for(Film films : listFilm){
        	%><option value="<%=films.getId()%>"><%=films.getName() %></option><%
        }
        	%>
        </select>
    </div>
  </div>
  <div class="form-group row">
    <label for="premiereDays" class="col-4 col-form-label">Fecha_Estreno</label> 
    <div class="col-8">
       <input id="premiereDays" name="premiereDays" type="date" class="form-control" required>
    </div>
  </div>
  <div class="form-group row">
    <label for="releaseDays" class="col-4 col-form-label">Dias de estreno</label> 
    <div class="col-8">
      <input id="releaseDays" name="releaseDays" type="number" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    <label for="viewers" class="col-4 col-form-label">Espectadores</label> 
    <div class="col-8">
      <input id="viewers" name="viewers" type="number" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    <label for="takings" class="col-4 col-form-label">Recaudacion</label> 
    <div class="col-8">
      <input id="takings" name="takings" type="number" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="add" type="submit" class="btn btn-success">Añadir proyeccion</button>
       <a href="listCharacters.jsp"><button name="list" type="button" class="btn btn-info">Ver listado</button></a>
    </div>
  </div>
</form>
</div>
<%} %>
</body>
</html>