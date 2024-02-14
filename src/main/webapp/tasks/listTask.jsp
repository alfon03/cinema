<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
<title>Tareas</title>
</head>
<%@include file="../nav.jsp" %>
<body>
<%
	// Variables
	List<Task> tasks = new ArrayList();
	String info = "";
	Task infoTask = null;
	String buttonEdit = "";
	String buttonDel = "";
	// Cargamos en nuestra lista, todas las tareas de la base de datos.
	if(tasks.isEmpty()){
		try{
			
		tasks = TaskRepository.getTasks();
		}catch (TaskException te){
			out.print(te.getLocalizedMessage());
		}
	}
	// Comprobamos cada vez que pulsamos un boton de mostrar informacion que contenga datos
	if(request.getParameter("info")!=null && request.getParameter("taskId")!=null){
		// Creamos la instancia del objeto del cual queremos extraer datos.
		infoTask = TaskRepository.getTaskInstance(request.getParameter("taskId"));
		// Si no existe o tratan de introducir informacion falsa lo comunicamos al usuario.
		if(infoTask == null){
			info = "<span style='color: red'>Esta intentando acceder a una tarea no existente.</span> ";
		// En caso de que exista, extraemos la informacion del objeto.
		}else{
			info = String.format("<strong>Informacion de la tarea</strong><p>Tarea: %s</p><p>Genero: %s</p>", infoTask.getTask(), infoTask.getTaskGender());
				if (session.getAttribute("roleUser").equals("admin")) {
					buttonEdit = String.format("<form action='editTask.jsp'><button type='submit' name='task' value='%s'>Editar</button></form>", infoTask.getTask());
					buttonDel = String.format("<form action='delTask.jsp'><button type='submit' name='delTask' value='%s'>Borrar</button></form>", infoTask.getTask());
			}
		}
		
	}
	
%>
    	<main>    
 		<table>
  <thead>
    <tr>
      <th>Tarea </th>
    </tr>
  </thead>
  <tbody>

<%
//Creamos las filas con el nombre de la tarea y un boton para cada tarea.
for(Task t:tasks){ %>
	<tr><td>
	<%=t.getTask()%></td>
	<td>
	<form>
	<!-- Usaremos un campo de texto escondido con la informacion de cada usuario para poder mandarlo por get -->
	<input type="text" name="taskId" value="<%= t.getTask()%>" hidden>
	<input type="submit" name="info" value="Mostrar Informacion">
	</form>
	</td>
	</tr>
<%}%>


</tbody>
		<aside>
		<%= info %>
		<span style="display: flex;">
		<%= buttonEdit %>
		<%= buttonDel %>
		</span>
		</aside>
</table>


</main>
</body>
</html>