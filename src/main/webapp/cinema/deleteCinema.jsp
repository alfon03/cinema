<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.model.Cinema"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Characters delete</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">

</head>
<body>

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
%>

<%
Cinema c = null;


	//Pasamos un personaje al objeto c
	c = DbRepository.find(Cinema.class, request.getParameter("deleteCinema"));
	if(c==null){%>
		<div class="form-group row">
	    <label for="respuesta" class="col-4 col-form-label">No se encuentra el cine</label> 
	     <a href="${pageContext.request.servletContext.contextPath}/cinema/listCinema.jsp"><button type="button">Volver a la lista de cines</button></a>
	  	</div>  
	<% }else{
	
	String cinema = "";
	String city = "";
	String management = "";
	
	//Controlamos que el objeto c no sea nulo
	try{
	if(c != null){
		cinema = c.getCinema();
		city = c.getCity_cinema();
		management = c.getManagement_cinema();
	}
	}catch(Exception e){
		
	}
	%>


<!-- //Creamos la cabecera y el formulario -->

<header>
        <nav>
            <div class="menu">
            <a href="${pageContext.request.servletContext.contextPath}/film/listFilm.jsp">Peliculas</a>
            <a href="${pageContext.request.servletContext.contextPath}/character/characterList.jsp">Personajes</a>
            <a href="${pageContext.request.servletContext.contextPath}/tasks/listTask.jsp">Tareas</a>
            </div>
        </nav>
       <a href="${pageContext.request.servletContext.contextPath}/cinema/addCinema.jsp"><button type="button">Añadir Cine</button></a>
        <a href="${pageContext.request.servletContext.contextPath}/cinema/listCinema.jsp"><button type="button">Lista de Cines</button></a>  
          
    </header>
<!-- Creamos el formulario con sus respectivos campos de la tabla personaje -->

<form>
<br>
  <div class="form-group row">
  
    <label for="name" class="col-4 col-form-label">Cinema</label> 
    <div class="col-8">
      <input id="cinema" name="deleteCinema" type="text" class="form-control" value='<%=cinema%>' readonly="readonly">
    </div>
  </div>
  <div class="form-group row">
    <label for="nationality" class="col-4 col-form-label">City</label> 
    <div class="col-8">
      <input id="city" name="city" type="text" class="form-control" value='<%=city%>' readonly="readonly">
    </div>
  </div>
  <div class="form-group row">
    <label for="sex" class="col-4 col-form-label">Management</label> 
    <div class="col-8">
      <input id="management" name="management" type="text" class="form-control" value='<%=management%>' readonly="readonly">
    </div>
  </div>
  <p align="center">Deseas continuar con los cambios realizados</p>
  <div class="form-group row">
    <div class="offset-4 col-8">
    <button name="cancel" name="cancel" type="submit" class="btn btn-primary">Cancel</button>
      <button name="submit" name="submit" type="submit" class="btn btn-primary">Submit</button>
    </div>
  </div>
</form>

<%
	if(request.getParameter("submit") != null){
		DbRepository.delete(c);
		response.sendRedirect("listCinema.jsp?delete="+c.getCinema());
	
}

	if(request.getParameter("cancel") != null){
		response.sendRedirect("listCinema.jsp");
	}
	}
%>
</body>
</html>