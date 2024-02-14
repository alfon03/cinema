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
<title>Borrar Tarea</title>
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
	Task t = (Task)session.getAttribute("task")!=null ? (Task)session.getAttribute("task"):null;
	String task = "";
	String message = "";
	String gender = "";
	String advert = "<span style='color: yellow;'>Esta apunto de borrar una tarea, ¿Esta seguro de su accion?</span>";
	String delStatus = "del";
	String backValue = "Cancelar";
	String delDisable = "";

	// Comprobamos parametros, para evitar que nos manipulen la URL e introduzcan un valor falso.
	if(request.getParameter("delTask")!=null){
		task = request.getParameter("delTask");
		
		try{
			
		t=TaskRepository.getTaskInstance(task);
		}catch(TaskException te){
			message = "<span style='color: red'>La tarea no se encuentra en la base de datos o no contiene datos</span>";
		}
		// Si conseguimos rescatar valores de la base de datos guardamos los datos planos en variables para su posterior tratamiento.
		if(t!=null){
			task = t.getTask();
			gender = String.valueOf(t.getTaskGender());
			session.setAttribute("task", t);

		}else {
			// Si falla, bien por manipulacion o porque no exista en la base de datos, mostramos mensaje de error.
			message = "<span style='color: red'>No existe esa tarea</span>";
		}
	}
	
	// Si por primera vez elegimos borrar, la pagina volvera a pedir una nueva confirmacion
	 if(request.getParameter("del")!=null && request.getParameter("del").equals("Borrar") && t!=null){
		// Como se ha actualizado, debemos ver la informacion guardada la primera vez que obtuvimos la tarea. Y guardar sus valores para
		// que se muestren en los campos input.
		task = t.getTask();
		gender = String.valueOf(t.getTaskGender());
		advert = "<span style='color: yellow;'>¿Realmente desea borrar la tarea?</span>";
		delStatus = "conf";
	
	// Nuevamente miraremos si se ha vuelto a pulsar el boton de borrar, y entonces llamaremos a nuestra funcion para borrar
	}else if(request.getParameter("conf")!=null && request.getParameter("conf").equals("Borrar") && t!=null){
		task = t.getTask();
		gender = String.valueOf(t.getTaskGender());
		try{
			
		TaskRepository.delTask(t);
		// Una vez borrado liberamos la session.
		session.removeAttribute("task");
		// Mostramos mensaje de borrado
		advert = "";
		message = "Borrado con exito!";
		// Modificamos el valor de los botones, para que una vez borrado, solo muestre volver para comprobar que se ha eliminado de la base de datos.
		backValue = "Volver";
		delDisable = "disabled";
		}catch (TaskException te){
			message = te.getMessage();
		}
	}
%>
    <main>
            <form id="userForm">
                <label for="name">Nombre Tarea:</label>
                <input type="text" id="name" name="task" value='<%=task %>' readonly="readonly">
                <label for="gender">Sexo:</label>
                <br>
                <input type="text" id="gender" name="gender" value='<%= gender%>' disabled> 
               
                <br>
                <br>
                <%= advert %>
                <br>
                <input type="submit" name='<%=delStatus %>' value="Borrar" <%=delDisable %>>
                <a href="${pageContext.request.servletContext.contextPath}/tasks/listTask.jsp"><button type="button"><%=backValue %></button></a>  
                <br>
            	<%= message %>
              </form>
        </main>
</body>
</html>