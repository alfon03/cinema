<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.exceptions.FilmException"%>
<%@page import="com.cinema.repository.FilmRepository"%>
<%@page import="com.cinema.model.Film"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Borrar Pelicula</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">
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
//Variables donde almacenamos: 
Film film = null; //La pelicula que queremos editar
Film newFilm = null;//La nueva pelicula editada
String answer = "";//La respuesta
String code=""; //Codigo de inyeccion

	try{
		film = DbRepository.find(Film.class, request.getParameter("idFilm"));	
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Error al encontrar la pelicula");
		return;
	}
	

	try{
		//Si pulsamos a que estamos seguro
		if(request.getParameter("confirmDelete") != null){
			
				FilmRepository.deleteFilm(film);
				answer ="Se ha eliminado correctamente";
		}	
		
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Error al encontrar borrar la pelicula");
		return;
	}

%>
 <div class="mainWrap">
	<form>
  <div class="form-group row">
    <label for="text" class="col-4 col-form-label">Id</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="id" name="idFilm" type="text" class="form-control" value="<%=film.getId() %>" readonly>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">Titulo</label> 
    <div class="col-8">
      <input id="title" name="title" type="text" class="form-control" value="<%=film.getName() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text2" class="col-4 col-form-label">Año de produccion</label> 
    <div class="col-8">
      <input id="film" name="film" type="text" class="form-control" value="<%=film.getYear() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text3" class="col-4 col-form-label">Titulo secundario</label> 
    <div class="col-8">
      <input id="releaseDate" name="releaseDate" type="text" class="form-control" value="<%=film.getSecundaryName()%>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text4" class="col-4 col-form-label">Nacionalidad</label> 
    <div class="col-8">
      <input id="premiereDays" name="premiereDays" type="text" class="form-control" value="<%=film.getNacionality() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">Presupuesto</label> 
    <div class="col-8">
      <input id="viewers" name="viewers" type="text" class="form-control" value="<%=film.getPresupuesto() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text6" class="col-4 col-form-label">Duracion</label> 
    <div class="col-8">
      <input id="takings" name="takings" type="text" class="form-control" value="<%=film.getDuration() %>" readonly>
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
      </div>
  </form>
  </div>
</body>
</html>