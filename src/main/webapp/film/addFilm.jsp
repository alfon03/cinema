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
<title>Añadir Pelicula</title>
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
//Variables donde alamcenamos la pelicula creada y la respuesta
Film film = null;
String answer ="";
String code ="";




//Cuando pulsemos el boton
if(request.getParameter("add")!=null){
	//Comprobamos que los campos obligatorios estan rellenados
	if( request.getParameter("idFilm")!=null && request.getParameter("title")!=null && request.getParameter("year")!=null){
		try{
			film = DbRepository.find(Film.class, request.getParameter("idFilm"));
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg=Error al analizar la pelicula");
			return;
		}
		
		if(film==null){
			//Creamos la pelicula y la añadimos a la base de datos utilizando el metodo creado con anterioridad
			try{
				film = new Film (request.getParameter("idFilm"),request.getParameter("title"),request.getParameter("year"), request.getParameter("st"), request.getParameter("nacionality"),request.getParameter("cost"), request.getParameter("duration"));
				try{
					DbRepository.add(Film.class, film);
					answer= "Pelicula añadida correctamete";
					code = String.format("<details close><summary>Detalles de la pelicula añadida</summary><label>Id: %s, <br>Nombre: %s,  <br>Año: %s,<br>Titulo Secundario: %s,  <br>Nacionalidad: %s, <br> Presupuesto: %s, <br> Duracion: %s</label></details>", film.getId(), film.getName(), film.getYear(), film.getSecundaryName(), film.getNacionality(), film.getPresupuesto(), film.getDuration());
				}catch(Exception e){
					response.sendRedirect("../error.jsp?msg=Error al añadir la pelicula");
					return;
				}
			}catch(FilmException e){
				answer=e.getMessage();
			}
			
		}else{
			answer = "La pelicula ya existe en la base de datos";
		}
	}else{
		answer = "Añade los campos obligatorios";
	}
			
}



%>
<h2>Añadir Pelicula</h2>
<%

//Cuando pulsemos el boton de guardar aparecera la ventana con los detalles de la ultima pelicula añadida 
if(request.getParameter("add")!=null){
	out.print(code);
}

%>	
<div class="mainWrap">
	<form>
	 <div class="form-group row">
    <label for="text" class="col-4 col-form-label">Id</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="id" name="idFilm" type="text" class="form-control" required="required">
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">Titulo</label> 
    <div class="col-8">
      <input id="title" name="title" type="text" class="form-control" required="required">
    </div>
  </div>
  <div class="form-group row">
    <label for="text2" class="col-4 col-form-label">Año de produccion</label> 
    <div class="col-8">
      <input id="year" name="year" type="text" class="form-control" required="required">
    </div>
  </div>
  <div class="form-group row">
    <label for="text3" class="col-4 col-form-label">Titulo secundario</label> 
    <div class="col-8">
      <input id="st" name="st" type="text" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    <label for="text4" class="col-4 col-form-label">Nacionalidad</label> 
    <div class="col-8">
      <input id="nacionality" name="nacionality" type="text" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">Presupuesto</label> 
    <div class="col-8">
      <input id="cost" name="cost" type="text" class="form-control" min="0">
    </div>
  </div>
  <div class="form-group row">
    <label for="text6" class="col-4 col-form-label">Duracion</label> 
    <div class="col-8">
      <input id="duration" name="duration" type="text" class="form-control" min="0">
    </div>
    <div class="form-group row">
    <label for="respuesta" class="col-4 col-form-label"><%=answer %></label> 
  </div> 
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="add" type="submit" class="btn btn-success">Añadir Pelicula</button>
       <a href="listFilm.jsp"><button name="list" type="button" class="btn btn-info">Volver</button></a>
    </div>
  </div>
  </form>
  </div>
</body>
</html>