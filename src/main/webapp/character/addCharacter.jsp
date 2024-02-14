<%@page import="com.cinema.repository.CharacterRepository"%>
<%@page import="com.cinema.model.Character"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Characters</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">
</head>
<body>
<%@include file="/nav.jsp" %>
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

<!-- Creamos las variables y objeto que usaremos para llamar a los datos del comentario  -->
<%
String answer = "Add required fields";
String name ="";
String nationality ="";
String sex ="";
String details = "No character has been created";
Character c = null;

try{
	if(request.getParameter("submit") != null){
		name = request.getParameter("name");
		nationality = request.getParameter("nationality");
		sex = request.getParameter("sex");
// 		Controlamos que las excepciones del campo sexo se cumplan
	if(sex.equals("H") || sex.equals("M") || sex.equals("O")){
	c = new Character(name, nationality, sex);
	CharacterRepository.addCharacter(c);
	answer = "Add Character correctly";
	details = String.format("El ultimo personaje creado tiene de nombre: %s , nacionalidad: %s y sexo: %s." , name, nationality, sex);
	}
	}
}catch(Exception e){
	e.getMessage();
}
%>

<!-- Creamos el formulario con sus respectivos campos de la tabla personaje -->
<form action="addCharacter.jsp">
  <div class="form-group row">
    <label for="name" class="col-4 col-form-label">Name</label> 
    <div class="col-8">
      <input id="name" name="name" type="text" class="form-control" required="required">
    </div>
  </div>
  <div class="form-group row">
    <label for="nationality" class="col-4 col-form-label">Nacionality</label> 
    <div class="col-8">
      <input id="nationality" name="nationality" type="text" class="form-control" required="required">
    </div>
  </div>
  <div class="form-group row">
    <label for="sex" class="col-4 col-form-label">Sex</label> 
    <div class="col-8">
      <input id="sex" name="sex" type="text" class="form-control" required="required">
    </div>
  </div>
  <div class="form-group row">
    <label for="respuesta" class="col-4 col-form-label"><%=answer %></label> 
  </div>  
   <div class="form-group row">
    <label for="respuesta" class="col-4 col-form-label"><%=details %></label> 
  </div>  
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" name="submit" type="submit" class="btn btn-primary">Submit</button>
    </div>
  </div>
</form>
</body>
</html>