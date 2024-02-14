<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Information about you</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

	<%
	User user = null;
	if (session.getAttribute("user") == null) {//si no ha iniciado sesion
		response.sendRedirect("../index.jsp");
		return;
	}
	else {//si si ha iniciado sesion
		try {
			user = DbRepository.find(User.class, session.getAttribute("user").toString());
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("../error.jsp?msg=Error inesperado");
			return;
		}
	}
	
	if (request.getParameter("logOutBtn") != null) {
		session.removeAttribute("user");
		session.removeAttribute("roleUser");
		response.sendRedirect("/pruebaHibernate/index.jsp");
		return;
	}
	
	%>

<form method="post">
  <div class="form-group row">
    <label for="username" class="col-4 col-form-label">Username</label> 
    <div class="col-8">
      <input id="username" name="username" value='<%= user.getUsername() %>' type="text" class="form-control" required="required" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="email" class="col-4 col-form-label">Email</label> 
    <div class="col-8">
      <input id="email" name="email" value='<%= user.getEmail() %>' type="text" class="form-control" required="required" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="password" class="col-4 col-form-label">Password</label> 
    <div class="col-8">
      <input id="password" name="password" value="*******" type="text" class="form-control" required="required" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="name" class="col-4 col-form-label">Name</label> 
    <div class="col-8">
      <input id="name" name="name" value='<%= user.getName() %>' type="text" required="required" class="form-control" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="surnames" class="col-4 col-form-label">Surnames</label> 
    <div class="col-8">
      <input id="surnames" name="surnames" value='<%= user.getSurnames() %>' type="text" class="form-control" readonly>
    </div>
  </div> 
  <div class="form-group row">
    <div class="offset-4 col-8">
      <a href="./editUser.jsp"><button name="submit" type="button" class="btn btn-primary">Edit</button></a>
    </div>
  </div>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="logOutBtn" value="logOut" type="submit" class="btn btn-primary">Log out</button>
    </div>
  </div>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <a href="../index.jsp"><button name="backBtn" type="button" class="btn btn-primary">Go back</button></a>
    </div>
  </div>
</form>
</body>
</html>