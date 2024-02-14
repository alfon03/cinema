<!DOCTYPE html>
<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.model.User"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils" %>
<html>
<head>
<meta charset="UTF-8">
<title>Log in</title>
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
	if (request.getParameter("submit") != null) {//si le da al boton de iniciar sesion
		String username = request.getParameter("username");
		String password = DigestUtils.md5Hex(request.getParameter("password"));
		User user = DbRepository.find(User.class, username);
		if (user != null) {//si no existe un usuario con ese username
			if (user.getPassword().equals(password)) {//si mete bien la contraseña
				session.setAttribute("user", user.getUsername());//guardamos el nombre de usuario
				session.setAttribute("roleUser", user.getRole());//y el role del mismo
				response.sendRedirect("index.jsp");//y lo llevamos al index.jsp
			}
			else {//si la contraseña esta mal
				message = "La contraseña introducida no es correcta";
			}
		}
		else {
			message = "El usuario introducido es incorrecto o no existe";
			user = null;
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
    <label for="password" class="col-4 col-form-label">Password</label> 
    <div class="col-8 form-field">
      <input id="password" name="password" type="password" class="form-control" required="required">
      <small></small>
    </div>
  </div>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" type="submit" class="btn btn-primary">Log in</button>
    </div>
  </div>
</form>
<p>Don't have an account yet?<a href="./signUp.jsp"> Sign Up Here</a></p>
<p><% if (message != null && !message.isBlank()) { %><%= message %><% } %></p>
<script src="./scripts/validacionLogIn.js"></script>
</body>
</html>