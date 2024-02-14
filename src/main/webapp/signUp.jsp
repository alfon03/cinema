<!DOCTYPE html>
<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.model.User"%>
<html>
<head>
<meta charset="UTF-8">
<title>Sign up</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="./formValidator.css" type="text/css">
</head>
<body>
	<%@ include file="./nav.jsp" %>
	
	<%
	
	String message = "";
	
	if (session.getAttribute("user") != null) {
		session.removeAttribute("user");
	}
	if (request.getParameter("submit") != null) {//si le da al boton de registrar
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String retypePassword = request.getParameter("retypePassword");
		String name = request.getParameter("name");
		String surnames = request.getParameter("surnames");
		User user = DbRepository.find(User.class, username);
		if (user == null) {//si el usuario no existe
			user = new User(username, email, password, name, surnames, "user");
			DbRepository.add(User.class, user);
			response.sendRedirect("./logIn.jsp?message=¡Usuario creado correctamente! Inicia sesion aqui.");
		}
		else {//si ya existe el usuario
			message = "Ya existe un usuario con este nombre de usuario, ingresa uno diferente, si ya tienes una" +
		" cuenta puedes iniciar sesion.";
		}
	}
	
	%>


<form id="form">
  <div class="form-group row">
    <label for="user" class="col-4 col-form-label">Username</label> 
    <div class="col-8 form-field">
      <input id="username" name="username" type="text" class="form-control" required="required">
      <small></small>
    </div>
  </div>
  <div class="form-group row">
    <label for="email" class="col-4 col-form-label">Email</label> 
    <div class="col-8 form-field">
      <input id="email" name="email" type="text" class="form-control" required="required">
      <small></small>
    </div>
  </div>
  <div class="form-group row">
    <label for="password" class="col-4 col-form-label">Password</label> 
    <div class="col-8 form-field">
      <input id="password" name="password" type="password" class="form-control" required="required">
      <small></small>
    </div>
  </div>
  <div class="form-group row">
    <label for="retypePassword" class="col-4 col-form-label">Retype password</label> 
    <div class="col-8 form-field">
      <input id="retypePassword" name="retypePassword" type="password" class="form-control" required="required">
      <small></small>
    </div>
  </div>
  <div class="form-group row">
    <label for="name" class="col-4 col-form-label">Name</label> 
    <div class="col-8 form-field">
      <input id="name" name="name" type="text" class="form-control" required="required">
      <small></small>
    </div>
  </div>
  <div class="form-group row">
    <label for="surnames" class="col-4 col-form-label">Surnames</label> 
    <div class="col-8 form-field">
      <input id="surnames" name="surnames" type="text" class="form-control" required="required">
      <small></small>
    </div>
  </div> 
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" type="submit" class="btn btn-primary">Sign up</button>
    </div>
  </div>
</form>
<p>Already have an account?<a href="./logIn.jsp"> Log In Here</a></p>
<p><% if (message != null && !message.isBlank()) { %><%= message %><% } %></p>
<script src="./scripts/validacionSignUp.js"></script>
</body>
</html>