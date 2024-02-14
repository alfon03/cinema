<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit user accounts here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%@ include file="../nav.jsp" %>
	<%
	if (session.getAttribute("roleUser") == null) {
		response.sendRedirect("../index.jsp");
	}
	String message = "";
	User user = null;
	String password = request.getParameter("password");
	try {
		user = DbRepository.find(User.class, request.getParameter("username"));
	} catch (Exception e) {
		e.printStackTrace();
		response.sendRedirect("../error.jsp?"+e.getMessage());
		return;
	}
	if (request.getParameter("button") != null) {
		if (password != null) {
			if (!password.isBlank()) {
				try {
					user.setPassword(request.getParameter("password"));
					user.setRole(request.getParameter("role"));
					DbRepository.update(User.class, user);
					message = "User edited succesfully";
				} catch (Exception e) {
					e.printStackTrace();
					response.sendRedirect("../error.jsp?"+e.getMessage());
				}
			} else {
				message = "Email o password invalidos";
			}
		} else {
			message = "No puede haber valores nulos";
		}
	}
	
	%>

<form method="post" id="form">
  <div class="form-group row">
    <label for="username" class="col-4 col-form-label">Username</label> 
    <div class="col-8">
      <input id="username" name="username" value='<%= user.getUsername() %>' type="text" class="form-control" required="required" readonly>
    </div>
  </div>
  <%if (session.getAttribute("roleUser").equals("user")) { %>
  <div class="form-group row">
    <label for="email" class="col-4 col-form-label">Email</label> 
    <div class="col-8">
      <input id="email" name="email" value='<%= user.getEmail() %>' type="text" class="form-control" required="required">
    </div>
  </div>
  <%} %>
  <div class="form-group row">
    <label for="password" class="col-4 col-form-label">Password</label> 
    <div class="col-8">
      <input id="password" name="password" value="*******" type="password" class="form-control" required="required">
    </div>
  </div>
  <%if (session.getAttribute("roleUser").equals("admin")) { %>
  <div class="form-group row">
    <label for="role" class="col-4 col-form-label">Role</label> 
    <div class="col-8">
      <select id="role" name="role" class="custom-select">
      	<%if (user.getRole().equals("admin")) { %>
      		<option value="admin" selected="selected">Admin</option>
      		<option value="user">User</option>
      	<%} else { %>
        	<option value="admin">Admin</option>
        	<option value="user" selected="selected">User</option>
        <%} %>
      </select>
    </div>
  </div> 
  <%} %>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="button" type="submit" class="btn btn-primary">Edit</button>
    </div>
  </div>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <a href="/pruebaHibernate/user/listUsers.jsp"><button name="backBtn" type="button" class="btn btn-primary">Back to list</button></a>
    </div>
  </div>
<p><% if (message != null && !message.isBlank()) { %><%= message %><% } %></p>
</form>
<script src="../scripts/editUserValidator.js"></script>
</body>
</html>