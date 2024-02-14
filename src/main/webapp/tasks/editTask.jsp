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
<title>Modificar Tarea</title>
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
	// Variables
	Task t = null;
	String task = "";
	String gender = "";
	String message = "";
	String checked = "";
	String confirmationText = "";
	Task modTask = null;
	String info = "";
	String disabled = "";


	// Comprobamos parametros, para evitar que nos manipulen la URL e introduzcan un valor falso.
	if(request.getParameter("task")!=null){
		task = request.getParameter("task");
		try{
			t=TaskRepository.getTaskInstance(task);
		}catch (TaskException te){
			out.print(te.getMessage());
		}
	
		// Si conseguimos rescatar valores de la base de datos guardamos los datos planos en variables para su posterior tratamiento.
		if(t!=null){
			task = t.getTask();
			gender = String.valueOf(t.getTaskGender());
		}
	}else {
		// Si falla, bien por manipulacion o porque no exista en la base de datos, mostramos mensaje de error.
		message = "<span style='color: red'>No existe esa tarea</span>";
	}

	// Cuando pulsemos en el boton guardar, almacenamos los valores que introducimos por los inputs, para poder crear el objeto nuevo.
	if(request.getParameter("edit")!=null && request.getParameter("gender")!=null && request.getParameter("task")!=null){
		task = request.getParameter("task");
		gender = request.getParameter("gender");
		// Comprobamos que no modifiquen el parametro de entrada get, si el objeto anterior tiene un id diferente
		// al pasado por parametro evitamos que se modifique o inserte en la base de datos.
		if(t!=null && task!=null && t.getTask().equals(task) && "HMO".indexOf(gender)!=-1){
			// Creamos el objeto modificado que vamos a sustituir en la base de datos.
			modTask = new Task(task, gender);
			try{
				
			TaskRepository.modTask(modTask);
			}catch(TaskException te){
				message = te.getMessage();
			}
			message = "El cambio se ha realizado exitosamente";
			info = String.format("<strong>Informacion de la tarea</strong><p>Tarea: %s</p><p>Genero: %s</p>", modTask.getTask(), modTask.getTaskGender());
			disabled="disabled";
		}else {
			// Mostramos mensaje de error si intentan cambiar el valor id en la URL.
			message = "<span style='color: red'>El sexo es invalido o el nombre de tarea no coincide con el original</span>";
		}
	}
%>
    <main>
			<aside><%= info %></aside>
            <form id="userForm">
                <label for="name">Nombre Tarea:</label>
                <input type="text" id="name" name="task" value='<%= task %>' readonly="readonly">
                <label for="gender">Sexo:</label>
                <br>
                <input type="radio" name="gender" value="H" <% out.print(gender.equals("H")?"checked":"");%> <%=disabled %> > Hombre
                <input type="radio" name="gender" value="M" <% out.print(gender.equals("M")?"checked":"");%> <%=disabled %>> Mujer
                <input type="radio" name="gender" value="O" <% out.print(gender.equals("O")?"checked":"");%> <%=disabled %>> Otro
                <br>
                <br>
                <input type="submit" name="edit" value="Guardar" <%=disabled %>>
                <a href="${pageContext.request.servletContext.contextPath}/tasks/listTask.jsp"><button type="button">Atras</button></a>  
                <br>
                <%= message %>
              </form>

              <br>


        </main>

</body>
</html>