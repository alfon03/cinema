<%@page import="org.hibernate.exception.ConstraintViolationException"%>
<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@page import="com.cinema.exceptions.TaskException"%>
<%@page import="com.cinema.repository.TaskRepository"%>
<%@page import="com.cinema.model.Task"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">
    
<meta charset="ISO-8859-1">
<title>Añadir Tarea</title>
</head>
<body>
<%@include file="../nav.jsp" %>
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
	// Variables a utilizar
	Task t = null;
	String message="";
	String task = "";
	String gender = "";
	String details = "";
try{
	// Cuando hagamos un submit, recolectamos los datos del formulario.
	if(request.getParameter("add")!=null){
		task = request.getParameter("name");
		gender = request.getParameter("gender");
		// Comprobamos en el front-end que no nos introducen valores erroneos en la URL
		if((gender.equals("H") || gender.equals("M") || gender.equals("O")) && task!=null){
		// Comprobamos en la parte del explorador que el nombre de tarea no este vacio.
		if(task.isEmpty()) {
			message = "<span style='color: red'>El campo de tarea debe tener informacion</span>";
		}else{
			// Si no esta vacio y el genero es correcto, creamos el objeto y lo pasamos al metodo que añadira la tarea.
		t = new Task(request.getParameter("name"), request.getParameter("gender"));
		TaskRepository.addTask(t);
		// Informamos al usuario que todo ha ido correctamente.
		message = "Tarea añadida con exito!";
		// Una vez completado, generamos un desplegable con la informacion del usuario creado.
		details = String.format("<details><summary>Ultima tarea creada</summary><p>Tarea: %s</p><p>Genero: %s</p></details>", t.getTask(), t.getTaskGender());
			
		}
			
		}else message = "<span style='color: red'>Los generos permitidos son H, M u O.</span>";
		
	}
}catch(TaskException e){
	message = "<span style='color: red'>Solo se permite mujer, hombre u otro</span>";
}catch(ConstraintViolationException dup){
	message = "<span style='color: red'>Esa tarea ya existe en la base de datos</span>";
}
%>
    <main>
                  
 			<%=details %>

            <form id="userForm" class="">
                <label for="name">Nombre Tarea:</label>
                <input type="text" id="name" name="name" required> <p><%=message %></p>
                <label for="gender">Sexo:</label>
                <br>
                <input type="radio" name="gender" value="H" checked> Hombre
                <input type="radio" name="gender" value="M"> Mujer
                <input type="radio" name="gender" value="O"> Otro
                <br>
                <br>
                <input type="submit" name="add" value="Guardar">
                
              </form>


        </main>

</body>
</html>