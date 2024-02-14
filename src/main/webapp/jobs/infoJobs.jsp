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
String nameCharacter = null;
Character character = null;
List<Jobs> jobsCharacter = null;

try{
	nameCharacter = request.getParameter("characterFilm");
	character = DbRepository.find(Character.class, nameCharacter);
}catch(Exception e){
	response.sendRedirect("../error.jsp?msg=Error al encontrar el personaje");
}

try{
	jobsCharacter = character.getListFilm();
}catch(Exception e){
	response.sendRedirect("../error.jsp?msg=Error al encontrar las peliculas del personaje");
}





%>
<h1>Lista de peliculas</h1>
<table class="table">
  <thead>
    <tr>
      <th scope="col">Titulo de la pelicula</th>
       <th scope="col">Año de lanzamiento</th>
        <th scope="col">Tarea del personaje</th>
    </tr>
  </thead>
  <tbody>
  <!-- Recorremos toda la lista para crear una fila por cada una de ellas y un boton para mostrar toda la informacion -->
  <%for(Jobs j: jobsCharacter) { %>
    <tr>
      <td><%=j.getIdFilm().getName() %></td>
      <td><%=j.getIdFilm().getYear() %></td>
      <td><%=j.getIdTask().getTask() %></td>
    </tr>
    <%} %>
  </tbody>
</table>
</body>
</html>