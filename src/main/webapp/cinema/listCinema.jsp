<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cinema.model.Cinema"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Listado personajes</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">

</head>
<body>
	<% 
		//Le pasamos una lista de cines a result
		List<Cinema> result = new ArrayList();
		try{
		
		result = DbRepository.findAll(Cinema.class);
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg="+e.getMessage());
			return;
		}
	
	%>
	
<!-- 	Creamos el formulario y dentro de el hacemos un for para que nos recorra result e imprima todos los cines -->

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
<%if(request.getParameter("delete")!=null){ %>
<div class="form-group row">
    <label for="respuesta" class="col-4 col-form-label">El cine <%=request.getParameter("delete") %> se ha borrado con exito</label> 
  </div>  
<%} %>
<%if(request.getParameter("update")!=null){ %>
<div class="form-group row">
    <label for="respuesta" class="col-4 col-form-label">El cine <%=request.getParameter("update") %> se ha actualizado con exito</label> 
  </div>  
<%} %>
	<table class="table">
		<thread>
			<tr>
				<th scope="col">Name</th>
				
			</tr>
		</thread>
		<%for(Cinema c : result){
		%>
				<tr>
					<td><%=c.getCinema()%> 
					<form action="cinemaInfo.jsp">
					<input id="info" name="info" type="text" class="form-control" value='<%=c.getCinema()%>' hidden>
					<button name="submit" type="submit" class="btn btn-primary">Info</button>
		  			</form>
		  			</td>
				</tr>
		<% }%>
		
		
		
		
		
		
		
		
		
	</table>
</body>
</html>