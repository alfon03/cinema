<%@page import="com.cinema.model.Jobs"%>
<%@page import="com.cinema.model.Character"%>
<%@page import="com.cinema.model.Film"%>
<%@page import="java.util.List"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">
</head>
<body>
<%@include file="../nav.jsp" %>
<%
String idFilm = null;
Film film = null;
List<Jobs> jobsFilm = null;

try{
	idFilm = request.getParameter("id");
	film = DbRepository.find(Film.class, idFilm);
}catch(Exception e){
	response.sendRedirect("../error.jsp?msg=Error al encontrar la pelicula");
	return;
}

try{
	jobsFilm = film.getListCharacter();
}catch(Exception e){
	response.sendRedirect("../error.jsp?msg=Error al encontrar los personajes de la pelicula");
	return;
}





%>
<h1>Lista de personajes</h1>
<table class="table">
  <thead>
    <tr>
      <th scope="col">Nombre del actor</th>
       <th scope="col">Papel que interpreto</th>
    </tr>
  </thead>
  <tbody>
  <!-- Recorremos toda la lista para crear una fila por cada una de ellas y un boton para mostrar toda la informacion -->
  <%for(Jobs j: jobsFilm) { %>
    <tr>
      <td><%=j.getNameCharacter().getName() %></td>
      <td><%=j.getIdTask().getTask() %></td>
    </tr>
    <%} %>
  </tbody>
</table>
</body>
</html>