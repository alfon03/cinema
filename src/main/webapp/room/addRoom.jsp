<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.cinema.model.Room" %>
    <%@ page import="com.cinema.model.Cinema" %>
    <%@ page import="com.cinema.repository.DbRepository" %>
    <%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add room</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="../styles/styleSheet.css">
</head>
<body>
	<%@ include file="../nav.jsp" %>
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
	//creamos algunas variables y recogemos datos
	String button = request.getParameter("submit");
	String message = "";
	Room room = null;
	String clasMensaje = "";
	
	if (button != null) {
		if (button != "") {
			try {
				Cinema cinema = DbRepository.find(Cinema.class ,request.getParameter("cinema"));
				int idRoom = Integer.parseInt(request.getParameter("idRoom"));
				int capacity = Integer.parseInt(request.getParameter("capacity"));
				if(!request.getParameter("cinema").isEmpty() && request.getParameter("cinema")!=null && idRoom>=1 ){
					room = new Room(cinema, idRoom, capacity);
					
					if (DbRepository.find(Room.class, room) == null) {//comprobamos si la sala ya existe
						DbRepository.add(Room.class, room);//si no existe, la creamos y añadimos a la base de datos
						message = "Sala creada correctamente.";
						clasMensaje = "alert alert-success";
					}
					else {//si ya existe se lo decimos al usuario
						message = "Esta sala ya existe, ingresa un id de sala diferente.";
						clasMensaje = "alert alert-danger";
					}
					
				}else{
					message = "Añade los campos obligatorios";
					clasMensaje = "alert alert-danger";
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				message = "Ha habido un error al crear la sala.";
				clasMensaje = "alert alert-danger";
			}
		}
	}
	
	%>
	<h1>Añadir sala</h1>
<div class="mainWrap">
<form action="./addRoom.jsp">
  <div class="form-group row">
    <label for="cinema" class="col-4 col-form-label">Cinema</label> 
    <div class="col-8">
      <select id="cinema" name="cinema" class="custom-select" required="required">
      	<%
      	ArrayList<Cinema> cinemas = null; 
      	try {
      		cinemas = (ArrayList<Cinema>)DbRepository.findAll(Cinema.class);
      	} catch (Exception e) {
      		response.sendRedirect("../error.jsp?msg="+e.getMessage());
    		return;
      	}
      	for (Cinema c : cinemas) {
      	%>
      	<option value='<%= c.getCinema() %>'><%= c.getCinema() %></option>
      	<%}%>
      </select>
    </div>
  </div>
  <div class="form-group row">
    <label for="room" class="col-4 col-form-label">idRoom</label> 
    <div class="col-8">
      <input id="idRoom" name="idRoom" type="number" class="form-control" required="required" max="99">
    </div>
  </div>
  <div class="form-group row">
    <label for="capacity" class="col-4 col-form-label">Capacity</label> 
    <div class="col-8">
      <input id="capacity" name="capacity" type="number" class="form-control" required="required" max="9999">
    </div>
  </div> 
  <div class="form-group row">
    <label for="respuesta" class="<%=clasMensaje%>"><%=message %></label> 
  </div>
  <br>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" value="add" type="submit" class="btn btn-success">Añadir</button>
    </div>
  </div>
</form>
</div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

</body>
</html>
