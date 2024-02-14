<%@page import="com.cinema.model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Users list</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	
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
	
	ArrayList<User> users = null;
	try {
		users = (ArrayList<User>)DbRepository.findAll(User.class);
	} catch (Exception e) {
		e.printStackTrace();
		response.sendRedirect("../error.jsp?msg=Error al obtener los usuarios");
	}
	
	%>
	
<table class="table">
  <thead class="thead-dark">
    <tr>
      <th scope="col">Usuario</th>
      <th scope="col">Email</th>
      <th scope="col">Role</th>
      <th scope="col">Edit</th>
    </tr>
  </thead>
  <tbody>
  <%for (User user : users) { %>
    <tr>
    	<td scope="row"><%= user.getUsername() %></td>
    	<td><%= user.getEmail() %></td>
    	<td><%= user.getRole() %></td>
    	<td>
    		<form action="./adminEditUser.jsp" method="post">
    			<input name="username" id="username" value='<%= user.getUsername() %>' hidden="hidden">
    			<button type="submit" class="btn btn-primary">Edit user</button>
    		</form>
    	</td>
    </tr>
    <%} %>
  </tbody>
</table>
</body>
</html>