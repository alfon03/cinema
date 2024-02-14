<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.exceptions.FilmException"%>
<%@page import="com.cinema.repository.FilmRepository"%>
<%@page import="com.cinema.model.Film"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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

Film result = null;
Film showFilm = null;

try{
	
	showFilm = DbRepository.find(Film.class, request.getParameter("idFilm"));

}catch(FilmException e){
	response.sendRedirect("../error.jsp?msg=Error al encontrar la pelicula");	
}


%>

<div class="mainWrap">
	<form>
  <div class="form-group row">
    <label for="text" class="col-4 col-form-label">Id</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="cip" name="cip" type="text" class="form-control" value="<%=showFilm.getId() %>" readonly>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">Titulo</label> 
    <div class="col-8">
      <input id="title_p" name="title_p" type="text" class="form-control" value="<%=showFilm.getName() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text2" class="col-4 col-form-label">Año de produccion</label> 
    <div class="col-8">
      <input id="film" name="year_production" type="text" class="form-control" value="<%=showFilm.getYear() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text3" class="col-4 col-form-label">Titulo secundario</label> 
    <div class="col-8">
      <input id="title_s" name="title_s" type="text" class="form-control" value="<%=showFilm.getSecundaryName()%>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text4" class="col-4 col-form-label">Nacionalidad</label> 
    <div class="col-8">
      <input id="nacionality" name="nacionality" type="text" class="form-control" value="<%=showFilm.getNacionality() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">Presupuesto</label> 
    <div class="col-8">
      <input id="budget" name="budget" type="text" class="form-control" value="<%=showFilm.getPresupuesto() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text6" class="col-4 col-form-label">Duracion</label> 
    <div class="col-8">
      <input id="duration" name="duration" type="text" class="form-control" value="<%=showFilm.getDuration() %>" readonly>
    </div>
  </div>
  </form>
  <div>
  <%if (session.getAttribute("roleUser").equals("admin")) { %>
  <form action="editFilm.jsp">
		<div class="form-group row">
		  <div class="offset-4 col-8">
		  <input type="text" name="idFilm" value="<%=showFilm.getId()%>" hidden>
		    <button name="submit" type="submit" class="btn btn-warning">Editar</button>
		  </div>
		</div>
		</form>
	<form action="deleteFilm.jsp">
	<div class="form-group row">
	  <div class="offset-4 col-8">
	  <input type="text" name="idFilm" value="<%=showFilm.getId()%>" hidden>
	    <button name="submit" type="submit" class="btn btn-danger">Borrar</button>
	  </div>
	</div>
	</form>
	<%} %>
	<form action="../jobs/listJobs.jsp">
	<div class="form-group row">
	  <div class="offset-4 col-8">
	  <input type="text" name="id" value="<%=showFilm.getId()%>" hidden>
	    <button name="submit" type="submit" class="btn btn-info">Ver personajes</button>
	  </div>
	</div>
	</form>
	</div>
  </div>
</body>
</html>
</body>
</html>