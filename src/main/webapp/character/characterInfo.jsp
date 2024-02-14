<%@page import="com.cinema.repository.CharacterRepository"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.exceptions.FilmException"%>
<%@page import="com.cinema.repository.FilmRepository"%>
<%@page import="com.cinema.model.Character"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Informacion Pelicula</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">
</head>
<body>

<%@include file="../nav.jsp" %>
<%

//En este jps haremos algo similar a listFilm, con la diferencia de que mostraremos la informacion de la pelicula seleccionada
Character show = null;

try{
	
	//Una vez tenemos la lista de peliculas, recuperamos la pelicula seleccionada en el boton
	show = DbRepository.find(Character.class, request.getParameter("idCharacter"));
	
}catch(FilmException e){
	response.sendRedirect("../error?msg=Error al encontrar al personaje");
	return;
}


%>
<div class="mainWrap">
	<form>
  <div class="form-group row">
    <label for="text" class="col-4 col-form-label">Nombre</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="cip" name="cip" type="text" class="form-control" value="<%=show.getName()%>" readonly>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">Nacionalidad</label> 
    <div class="col-8">
      <input id="title_p" name="title_p" type="text" class="form-control" value="<%=show.getNationality() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text2" class="col-4 col-form-label">Genero</label> 
    <div class="col-8">
      <input id="film" name="year_production" type="text" class="form-control" value="<%=show.getSex() %>" readonly>
    </div>
  </div>
  </form>
  <div>
  <%if (session.getAttribute("roleUser").toString().equals("admin")) { %>
  <form action="characterEdit.jsp">
		<div class="form-group row">
		  <div class="offset-4 col-8">
		  <input type="text" name="idCharacter" value="<%=show.getName()%>" hidden>
		    <button name="submit" type="submit" class="btn btn-warning">Editar</button>
		  </div>
		</div>
		</form>
	<form action="characterDelete.jsp">
	<div class="form-group row">
	  <div class="offset-4 col-8">
	 <input type="text" name="characterDelete" value="<%=show.getName()%>" hidden>
	    <button name="submit" type="submit" class="btn btn-danger">Borrar</button>
	  </div>
	</div>
	</form>
	<%} %>
	<form action="../jobs/infoJobs.jsp">
	<div class="form-group row">
	  <div class="offset-4 col-8">
	  <input type="text" name="characterFilm" value="<%=show.getName()%>" hidden>
	    <button name="submit" type="submit" class="btn btn-info">Ver peliculas del personaje</button>
	  </div>
	</div>
	</form>
	</div>
  </div>



</body>
</html>
</body>
</html>