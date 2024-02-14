<%@page import="com.cinema.model.Cinema"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Characters edit</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">

</head>
<body>



<%
String city = "";
String management = "";
Cinema c = null;

//Pasamos un personaje al objeto c
	c = DbRepository.find(Cinema.class, request.getParameter("cinemaEdit")) ;
	
	String cinema = "";
	//Controlamos que el objeto c no sea nulo
	if(c == null){%>
		<div class="form-group row">
	    <label for="respuesta" class="col-4 col-form-label">No se encuentra el cine</label> 
	     <a href="${pageContext.request.servletContext.contextPath}/cinema/listCinema.jsp"><button type="button">Volver a la lista de cines</button></a>
	  	</div>
		
	<% }else{
	cinema = c.getCinema();
	city = c.getCity_cinema();
	management = c.getManagement_cinema();
	%>




<header>
        <nav>
            <div class="menu">
            <a href="${pageContext.request.servletContext.contextPath}/film/listFilm.jsp">Peliculas</a>
            <a href="${pageContext.request.servletContext.contextPath}/character/characterList.jsp">Personajes</a>
            <a href="${pageContext.request.servletContext.contextPath}/tasks/listTask.jsp">Tareas</a>
            </div>
        </nav>
        <a href="${pageContext.request.servletContext.contextPath}/character/addCharacter.jsp"><button type="button">Añadir Personaje</button></a>
        <a href="${pageContext.request.servletContext.contextPath}/character/characterList.jsp"><button type="button">Lista de Personaje</button></a>  
          
    </header>
<!-- Creamos el formulario con sus respectivos campos de la tabla cine -->
<form>
<br>
  <div class="form-group row">
    <label for="name" class="col-4 col-form-label">Cinema</label> 
    <div class="col-8">
      <input id="cinema" name="cinemaEdit" type="text" class="form-control" value='<%=cinema%>' readonly="readonly">
    </div>
  </div>
  <div class="form-group row">
    <label for="nationality" class="col-4 col-form-label">City</label> 
    <div class="col-8">
      <input id="city" name="city" type="text" class="form-control" required="required" value="<%=city %>">
    </div>
  </div>
  <div class="form-group row">
    <label for="sex" class="col-4 col-form-label">Management</label> 
    <div class="col-8">
      <input id="management" name="management" type="text" class="form-control" required="required" value="<%=management %>">
    </div>
  </div>
  <p align="center">Deseas continuar con los cambios realizados</p>
  <div class="form-group row">
    <div class="offset-4 col-8">
    <button name="cancel" name="cancel" type="submit" class="btn btn-primary">Cancel</button>
    	<%if (session.getAttribute("userRole").equals("admin")) { %>
      <button name="submit" name="submit" type="submit" class="btn btn-primary">Submit</button>
      <%} %>
    </div>
  </div>
</form>
<% if (request.getParameter("submit") != null && request.getParameter("city").trim().isEmpty()){%>
<div class="form-group row">
    <label for="respuesta" class="col-4 col-form-label">Add required fields</label> 
  </div> 
<%
	}
//Aqui especificamos que si pulsan el boton con cine submit nos edite el cine y despues nos devuelta al lista de cine
		if(request.getParameter("submit") != null && !request.getParameter("city").trim().isEmpty()){
			Cinema c2 = new Cinema(request.getParameter("cinemaEdit"),request.getParameter("city"),request.getParameter("management"));
			DbRepository.update(Cinema.class, c2);
			
			response.sendRedirect("listCinema.jsp?update="+c2.getCinema());
		}
//Si se pulsa el boton cancelar nos devuelve a la lista de cines
		if(request.getParameter("cancel") != null){
			response.sendRedirect("listCinema.jsp");
		}
	}
		%>
		


</body>
</html>