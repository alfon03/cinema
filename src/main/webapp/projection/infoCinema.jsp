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
<title>Listado personajes e info</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">

</head>
<body>
<%@include file="../nav.jsp" %>
	<% 
		if(request.getParameter("list") != null){
			response.sendRedirect("listProjection.jsp");
			return;
		}
		//Le pasamos una lista de personajes a result
		Cinema cinema = null;
		try{
			cinema = DbRepository.find(Cinema.class, request.getParameter("cinema"));
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg="+e.getMessage());
		}
	%>
<!-- 	Creamos el formulario y dentro de el hacemos un for para que nos recorra result e imprima todos los personajes -->
<div class="mainWrap">
	<form>
<br>
  <div class="form-group row">
  
    <label for="name" class="col-4 col-form-label">Cinema</label> 
    <div class="col-8">
      <input id="cinema" name="deleteCinema" type="text" class="form-control" value='<%=cinema.getCinema()%>' readonly="readonly">
    </div>
  </div>
  <div class="form-group row">
    <label for="nationality" class="col-4 col-form-label">City</label> 
    <div class="col-8">
      <input id="city" name="city" type="text" class="form-control" value='<%=cinema.getCity_cinema()%>' readonly="readonly">
    </div>
  </div>
  <div class="form-group row">
    <label for="sex" class="col-4 col-form-label">Management</label> 
    <div class="col-8">
      <input id="management" name="management" type="text" class="form-control" value='<%=cinema.getManagement_cinema()%>' readonly="readonly">
    </div>
  </div>
      	<button name="list" type="submit" class="btn btn-info">Volver</button>
</form>
</div>
</body>
</html>