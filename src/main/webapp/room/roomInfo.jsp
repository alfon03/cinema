<%@page import="com.cinema.model.Room"%>
<%@page import="com.cinema.repository.RoomRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Room info</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="../styles/styleSheet.css">
</head>
<body>

	<%@ include file="../nav.jsp" %>

<h1 align="center">Información de sala</h1>
	

	<%
	if (request.getParameter("roomId") == null && request.getParameter("cinemaRoom") == null) {
		response.sendRedirect("./listRooms.jsp");//comprobamos que haya entrado desde un listado para que no meta datos nulos
		return;
	}
	
	String roomId = request.getParameter("roomId");//obtenemos la id de sala
	String cinemaRoom = request.getParameter("cinemaRoom");//obtenemos el cine en el que esta la sala
	Room room = RoomRepository.findRoom(cinemaRoom, roomId);
	String capacityShown = String.valueOf(room.getCapacity());
	
	%>
<div class="mainWrap">
<form action="./updateRoom.jsp" method="post">
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
</form>
<div class="form-group row">
	    <div class="offset-4 col-8">
	    <%if (session.getAttribute("roleUser").equals("admin")) { %>
	      <a href="./updateRoom.jsp?cinemaRoom=<%=cinemaRoom%>&newRoomId=<%=roomId%>"><button name="editRoomBtn" value="edit" type="submit" class="btn btn-warning">Editar</button></a>
			<a href="./deleteRoom.jsp?cinemaRoom=<%=cinemaRoom%>&newRoomId=<%=roomId%>&newCapacity=<%=capacityShown%>"><button name="deleteRoomBtn" value="delete" type="submit" class="btn btn-danger">Borrar</button></a>
	    <%} %>
	    </div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>	
</body>
</html>
