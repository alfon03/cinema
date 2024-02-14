<%@page import="com.cinema.model.Film"%>
<%@page import="java.util.List"%>
<%@page import="com.cinema.model.User"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.repository.TicketRepository"%>
<%@page import="com.cinema.model.Ticket"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Your shopping cart</title>
<link rel="shortcut icon" href="/pruebaHibernate/img/cart.webp" type="image/x-icon">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%@ include file="../nav.jsp" %>
	<%
	User user = null;
	if (session.getAttribute("user") == null) {
		response.sendRedirect("../index.jsp");
		return;
	}
	else {
		user = DbRepository.find(User.class, session.getAttribute("user").toString());
	}
	
	List<Object[]> tickets = null;
	try {
		tickets = user.getTickets();
	} catch (Exception e) {
		e.printStackTrace();
		response.sendRedirect("../error.jsp?msg=Error al obtener las entradas.");
		return;
	}
	
	%>
<table class="table">
  <thead>
    <tr>
      <th scope="col">Cine</th>
      <th scope="col">Sala</th>
      <th scope="col">Cip</th>
      <th scope="col">Fecha de estreno</th>
      <th scope="col">ID Entrada</th>
      <th scope="col">Fecha de compra</th>
    </tr>
  </thead>
	<tbody>
 <%
for (Object[] ticket : tickets) {
	Film film = DbRepository.find(Film.class,ticket[2].toString());
%>
		<tr>
			<td><%=ticket[0]%></td>
			<td><%=ticket[1]%></td>
			<td><%=film.getName()%></td>
			<td><%=ticket[3]%></td>
			<td><%=ticket[4]%></td>
			<td><%=ticket[6]%></td>
		</tr>
<% }%>
  </tbody>
</table>
</body>
</html>