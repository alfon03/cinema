<%@page import="com.cinema.exceptions.ProjectionException"%>
<%@page import="com.cinema.repository.ProjectionRepository"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cinema.model.Film"%>
<%@page import="com.cinema.model.Room"%>
<%@page import="com.cinema.model.Projection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Borrar</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="../styles/styleSheet.css">
</head>
<body>
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
	Projection projection = null;
	Projection projection1 = null;
	Room room = null;
	Film film = null;
	Date releaseDate = null;
	String answer = "";
	String answerClass = "okMessage";
	
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
		if(request.getParameter("confirmDelete") != null){
			try{
				DbRepository.delete(projection);
				answer = "Borrado correctamente";
			}catch(ProjectionException e) {
				answer = e.getMessage();
				answerClass = "errorMessage";
			}
		}
		else if(request.getParameter("list") != null){
			response.sendRedirect("listProjection.jsp");
		}
	%>
<div class="mainWrap">
	<form>
  <div class="form-group row">
    <label for="text" class="col-4 col-form-label">Cine</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="cinema" name="cinema" type="text" class="form-control" value="<%=projection.getRoom().getCinema().getCinema() %>" readonly>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">Sala</label> 
    <div class="col-8">
      <input id="room" name="room" type="text" class="form-control" value="<%=projection.getRoom().getIdRoom() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text2" class="col-4 col-form-label">Pelicula</label> 
    <div class="col-8">
      <input id="film" name="film" type="text" class="form-control" value="<%=projection.getFilm().getId() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text3" class="col-4 col-form-label">Fecha de Estreno</label> 
    <div class="col-8">
      <input id="releaseDate" name="releaseDate" type="text" class="form-control" value="<%=projection.getReleaseDate()%>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text4" class="col-4 col-form-label">Dias de estreno</label> 
    <div class="col-8">
      <input id="premiereDays" name="premiereDays" type="text" class="form-control" value="<%=projection.getPremiereDays() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">Espectadores</label> 
    <div class="col-8">
      <input id="viewers" name="viewers" type="text" class="form-control" value="<%=projection.getViewers() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text6" class="col-4 col-form-label">Recaudacion</label> 
    <div class="col-8">
      <input id="takings" name="takings" type="text" class="form-control" value="<%=projection.getTakings() %>" readonly>
    </div>
  </div>
  <%
    if(request.getParameter("delete") == null && request.getParameter("confirmDelete") == null){//Si no hemos pulsado el boton de borrar ni el de confirmar
    	%>
    	<button name="delete" type="submit" class="btn btn-danger">Borrar</button>
    <% }
    else if(request.getParameter("confirmDelete") == null){//Si el boton de confirmar es nulo nos mostrará los siguientes botones
    	%>
    	<button name="confirmDelete" type="submit" class="btn btn-danger">Confirmar</button>
    	<button name="list" type="submit" class="btn btn-info">Volver</button>
    	<% 
    }else if(request.getParameter("confirmDelete") != null){//Si hemos pulsado el boton de borrar, nos mostrará el siguiente botón
    	%>
    	<button name="list" type="submit" class="btn btn-info">Volver</button>
    <%}

      %>
  </form>
  </div>
</body>
</html>