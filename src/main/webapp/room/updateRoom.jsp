<%@page import="com.cinema.model.Projection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cinema.model.Cinema"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
    <%@ page import="com.cinema.model.Room" %>
    <%@ page import="com.cinema.repository.DbRepository" %>
    <%@ page import="com.cinema.repository.RoomRepository" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Room info</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="../styles/styleSheet.css">
</head>
<body>
	<%@ include file="../nav.jsp" %>
	<h1>Editar sala</h1>
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
	if (request.getParameter("roomId") == null && request.getParameter("cinemaRoom") == null) {
		response.sendRedirect("./listRooms.jsp");//comprobamos que haya entrado desde un listado para que no meta datos nulos
		return;
	}
	Room roomAux = null;
	String cinemaRoom = null;
	String roomId = null;
	String capacityShown = "";
	String message = "";
	if (request.getParameter("editBtn") == null) {//si es la primera vez que entramos
		roomId = request.getParameter("newRoomId");//obtenemos la id de sala
		cinemaRoom = request.getParameter("cinemaRoom");//obtenemos el cine en el que esta la sala
		Room room = null;
		int capacity = 0;
		try {
			Cinema cinema = DbRepository.find(Cinema.class, cinemaRoom);//encontramos el cine
			room = new Room(cinema, Integer.parseInt(roomId), 1);//creamos una sala que contenga las claves primarias
			roomAux = DbRepository.find(Room.class, room);//encontramos la sala por las claves primarias y la guardamos en una variable auxiliar
			session.setAttribute("room", roomAux);//guardamos una variable de session con la sala
			capacityShown = String.valueOf(roomAux.getCapacity());
		} catch (Exception e) {//si da un error
			response.sendRedirect("../error.jsp?msg=Error al obtener la sala.");
			e.printStackTrace();
			return;
		}
	}
	else if (request.getParameter("editBtn") != null) {//si le da a editar
		roomAux = (Room)session.getAttribute("room");//recogemos la sala
		if (RoomRepository.findRoom(request.getParameter("cinemaRoom"), request.getParameter("newRoomId")) == null) {//si no existe ninguna con ese id
			ArrayList<Projection> projecciones = (ArrayList<Projection>)roomAux.getListProjection();//guardamos sus projecciones
			Room newRoom = new Room(roomAux.getCinema(), roomAux.getIdRoom(), roomAux.getCapacity(), projecciones);
			newRoom.setIdRoom(Integer.parseInt(request.getParameter("newRoomId")));
			newRoom.setCapacity(Integer.parseInt(request.getParameter("newCapacity")));
			RoomRepository.deleteRoom(roomAux.getCinema().getCinema(), roomAux.getIdRoom());
			DbRepository.add(Room.class, newRoom);
			cinemaRoom = newRoom.getCinema().getCinema();//le damos valor a estas variables para mostrar los nuevos datos
			roomId = String.valueOf(newRoom.getIdRoom());
			capacityShown = String.valueOf(newRoom.getCapacity());
			session.setAttribute("room", newRoom);
			message = "Room updated succesfully.";
		}
		else {// si ya existe una con ese id
			ArrayList<Room> rooms = null;
			try {
				rooms = (ArrayList<Room>)DbRepository.findAll(Room.class);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("../error.jsp?msg=No se han podido obtener las salas");
			}
			roomAux = (Room)session.getAttribute("room");
			boolean esta = false;
			for (Room room : rooms) {
				if (room.getIdRoom() == roomAux.getIdRoom()) {
					esta = true;
				}
			}
			if (esta) {//si es la que vamos a meter, modificamos la capacidad
				roomAux.setCapacity(Integer.parseInt(request.getParameter("newCapacity")));
				DbRepository.update(Room.class, roomAux);
				message = "Room updated succesfully.";
			} else {//sino, da error
				message = "This room can't be added because another room with that id already exists.";
			}
			session.setAttribute("room", roomAux);
			cinemaRoom = roomAux.getCinema().getCinema();
			roomId = String.valueOf(roomAux.getIdRoom());
			capacityShown = String.valueOf(roomAux.getCapacity());
		}
	}
	
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
      <input id="roomId" name="newRoomId" value="<%= roomId %>" type="number" class="form-control" max="99" min="1" required="required">
    </div>
  </div>
  <div class="form-group row">
    <label for="capacity" class="col-4 col-form-label">Capacity</label> 
    <div class="col-8">
      <input id="capacity" name="newCapacity" value='<%= capacityShown %>' type="number" class="form-control" max="9999" min="1" required="required">
    </div>
  </div> 
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="editBtn" type="submit" class="btn btn-warning">Editar</button>
    </div>
  </div>
</form>
<div class="form-group row">
    <div class="offset-4 col-8">
      <a href="./listRooms.jsp"><button class="btn btn-info">Volver</button></a>
    </div>
</div>
<%if (message != null){
	if (message != "") {
		%><%= message %><%
	}
}
%>
</div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

</body>
</html>
