<%@page import="com.cinema.repository.RoomRepository"%>
<%@page import="com.cinema.model.Room"%>
<%@page import="com.cinema.model.Cinema"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.repository.RoomRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Room</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="../styles/styleSheet.css">
</head>
<body>
	<%@ include file="../nav.jsp" %>
	<h1 align="center">Borrar sala</h1>
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
	boolean deleted = false;
	if (request.getParameter("roomId") == null && request.getParameter("cinemaRoom") == null) {
		response.sendRedirect("./listRooms.jsp");//comprobamos que haya entrado desde un listado para que no meta datos nulos
		return;
	}
	else if(request.getParameter("lista") != null){
		response.sendRedirect("./listRooms.jsp");
		return;
	}
	String cinemaRoom = "";
	String roomId = "";
	String capacityShown = "";
	String message = "";
	String messageClass = "";
	if (request.getParameter("submit") == null) {//si es la primera vez que entra
		try {
			roomId = request.getParameter("newRoomId");//obtenemos la id de sala
			cinemaRoom = request.getParameter("cinemaRoom");//obtenemos el cine en el que esta la sala
			Room room = RoomRepository.findRoom(cinemaRoom, roomId);
			capacityShown = String.valueOf(room.getCapacity());
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("../error.jsp?msg=Error al obtener la sala&rout=room/listRooms.jsp");
			return;
		}
	}
	else if (request.getParameter("submit").equals("yes")) {
		try {
			RoomRepository.deleteRoom(request.getParameter("cinemaRoom"), Integer.parseInt(request.getParameter("newRoomId")));
			message = "Room deleted succesfully";
			deleted = true;
			messageClass = "alert alert-success";
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("../error.jsp?msg=Error al eliminar la sala&rout=room/listRooms.jsp");
			return;
		}
	}
	
	%>
	<div class="mainWrap">
<form>
	<div class="form-group row">
    <label for="cinema" class="col-4 col-form-label">Cinema</label> 
    <div class="col-8">
      <input id="cinema" name="cinemaRoom" value='<%= cinemaRoom %>' type="text" class="form-control" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="roomId" class="col-4 col-form-label">Room ID</label> 
    <div class="col-8">
      <input id="roomId" name="newRoomId" value="<%= roomId %>" type="number" class="form-control" max="99" min="1" required="required" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="capacity" class="col-4 col-form-label">Capacity</label> 
    <div class="col-8">
      <input id="capacity" name="newCapacity" value='<%= capacityShown %>' type="number" class="form-control" max="9999" min="1" required="required" readonly>
    </div>
  </div>
<%if (deleted == false) { %>
  <p class="alert alert-danger">¿Estás seguro de que quieres borrar?</p>
	<div class="form-group row">
	    <div class="offset-4 col-8">
	      <button name="submit" value="yes" type="submit" class="btn btn-danger">Confirmar</button>
	    </div>
	</div>
</form>
<form action="./roomInfo.jsp" method="post">
<div class="form-group row">
	    <div class="offset-4 col-8">
	    	<input id="cinema" name="cinemaRoom" value='<%= cinemaRoom %>' type="text" class="form-control" hidden>
	    	<input id="roomId" name="roomId" value="<%= roomId %>" type="number" class="form-control" max="99" min="1" required="required" hidden>
	      <a href="./roomInfo.jsp"><button name="submit" value="no" type="submit" class="btn btn-info">Volver</button></a>
	    </div>
	</div>
</form>
<% } else { %>
	<button class="btn btn-info" name="lista">Volver</button>
<% } %>
<%if (message != null) { %>
	<%if (message != "") { %>
		<input type="text" class="<%=messageClass%>" value="<%= message %>">
	<%} %> 
<%} %>
</div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
