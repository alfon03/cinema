<%@page import="com.cinema.exceptions.FilmException"%>
<%@page import="com.cinema.repository.FilmRepository"%>
<%@page import="com.cinema.model.Film"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Editar Pelicula</title>
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
String code ="";


try{
	//Capturamos la pelicula
	film = DbRepository.find(Film.class, request.getParameter("idFilm"));
	newFilm = film;
}catch(Exception e){
	response.sendRedirect("../error.jsp?msg=Error al encontrar la pelicula");
	return;
}
	
	try{
	//Si pulsamos el boton de modificar
	if(request.getParameter("mod")!=null){
		//Comprobamos que los parametros requeridos no son nulos
		if( request.getParameter("idFilm")!=null && request.getParameter("title")!=null && request.getParameter("year")!=null){
			//Creamos la nueva pelicula con los nuevos parametros introducidos
			newFilm = new Film (request.getParameter("id"),request.getParameter("title"),request.getParameter("year"), request.getParameter("st"), request.getParameter("nacionality"), request.getParameter("cost"), request.getParameter("duration"));
			//La modificamos
			FilmRepository.modifyFilm(newFilm);
			answer ="Se ha editado correctamente";
		}else{
			answer ="Rellena los campos obligatorios";
		}
		
		//Por codigo de inyeccion introducimos los datos de la pelicla que hemos editado  en un despleglable
		code = String.format("<details close><summary>Detalles de la pelicula editada</summary><label>Id: %s, <br>Nombre: %s,  <br>Año: %s,<br>Titulo Secundario: %s,  <br>Nacionalidad: %s, <br> Presupuesto: %s, <br> Duracion: %s</label></details>", newFilm.getId(), newFilm.getName(), newFilm.getYear(), newFilm.getSecundaryName(), newFilm.getNacionality(), newFilm.getPresupuesto(), newFilm.getDuration());
	}
		
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Error al editar la pelicula");
		return;
	}
	
	



%>
 <div class="mainWrap">
	<form>
  <div class="form-group row">
    <label for="text" class="col-4 col-form-label">Id</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="id" name="idFilm" type="text" class="form-control" value="<%=newFilm.getId()%>" readonly>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">Titulo</label> 
    <div class="col-8">
      <input id="title" name="title" type="text" class="form-control" value="<%=newFilm.getName() %>" >
    </div>
  </div>
  <div class="form-group row">
    <label for="text2" class="col-4 col-form-label">Año de produccion</label> 
    <div class="col-8">
      <input id="year" name="year" type="text" class="form-control" value="<%=newFilm.getYear() %>" >
    </div>
  </div>
  <div class="form-group row">
    <label for="text3" class="col-4 col-form-label">Titulo secundario</label> 
    <div class="col-8">
      <input id="st" name="st" type="text" class="form-control" value="<%=newFilm.getSecundaryName()%>" >
    </div>
  </div>
  <div class="form-group row">
    <label for="text4" class="col-4 col-form-label">Nacionalidad</label> 
    <div class="col-8">
      <input id="nacionality" name="nacionality" type="text" class="form-control" value="<%=newFilm.getNacionality() %>" >
    </div>
  </div>
  <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">Presupuesto</label> 
    <div class="col-8">
      <input id="cost" name="cost" type="text" class="form-control" value="<%=newFilm.getPresupuesto() %>" >
    </div>
  </div>
  <div class="form-group row">
    <label for="text6" class="col-4 col-form-label">Duracion</label> 
    <div class="col-8">
      <input id="duration" name="duration" type="text" class="form-control" value="<%=newFilm.getDuration() %>" >
    </div>
  </div>
  </form>
  <%if(request.getParameter("mod")!=null){ %>
   <div class="form-group row">
    <label for="text5" class="col-4 col-form-label okMessage"><%=answer %></label> 
  </div>
  <%} %>
  <div>
  <form>
		<div class="form-group row">
		  <div class="offset-4 col-8">
		    <button name="mod" type="submit" class="btn btn-warning">Editar</button>
		  </div>
		</div>
		</form>
	</div>
  </div>
</body>
</html>