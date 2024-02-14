<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.cinema.repository.CharacterRepository"%>
<%@page import="com.cinema.model.Character"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
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
<%@include file="/nav.jsp" %>
<% 
	//Le pasamos una lista de persbonajes a result
	List<Character> result = new ArrayList();
try{
	result = DbRepository.findAll(Character.class);
	
}catch(Exception e){
	response.sendRedirect("../error?msg=Error al encontrar los personajes");
}

%>
	
<!-- 	Creamos el formulario y dentro de el hacemos un for para que nos recorra result e imprima todos los personajes -->

<h1>Lista de peliculas</h1>
<table class="table">
  <thead>
    <tr>
      <th scope="col">Titulo</th>
    </tr>
  </thead>
  <tbody>
  <!-- Recorremos toda la lista para crear una fila por cada una de ellas y un boton para mostrar toda la informacion -->
  <%for(Character character: result) { %>
    <tr>
      <td><%=character.getName() %></td>
      <td>
      <form action="characterInfo.jsp">
      <!-- Le proporcionamos al boton al cual llamara al showFilm.jsp, el valor del id de la pelicula en especifico en 
      la que ha pulsado -->
      <input id="id" name="idCharacter" type="text" class="form-control" value= '<%=character.getName()%>' hidden>
		<div class="form-group row">
		  <div class="offset-4 col-8">
		    <button name="submit" type="submit" class="btn btn-primary">Ver personaje</button>
		  </div>
		</div>
      </form>
      </td>
    </tr>
    <%} %>
  </tbody>
</table>
</body>
</html>