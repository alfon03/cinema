<%@page import="com.cinema.model.Jobs"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.model.Task"%>
<%@page import="com.cinema.model.Character"%>
<%@page import="java.util.List"%>
<%@page import="com.cinema.exceptions.FilmException"%>
<%@page import="com.cinema.repository.FilmRepository"%>
<%@page import="com.cinema.model.Film"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Añadir Pelicula</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">
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
//Variables donde alamcenamos la pelicula creada y la respuesta
List<Film> listFilm = null;
List<Character> listCharacters = null;
List<Task> listTask = null;
Jobs job = null;
String answer ="";
String code ="";


try{
	listFilm = DbRepository.findAll(Film.class);
}catch(Exception e){
	response.sendRedirect("../error.jsp?msg=Error al encontrar las peliculas");

}

try{
	listCharacters = DbRepository.findAll(Character.class);
}catch(Exception e){
response.sendRedirect("../error.jsp?msg=Error al encontrar los personajes");
	
}

try{
	listTask = DbRepository.findAll(Task.class);
}catch(Exception e){
	response.sendRedirect("../error.jsp?msg=Error al encontrar las tareas");
}


try{
	
	if(request.getParameter("guardar")!=null){
		if(request.getParameter("film")!=null){
			if(request.getParameter("character")!=null){
				if(request.getParameter("task")!=null){
					job = new Jobs(DbRepository.find(Film.class,request.getParameter("film")), DbRepository.find(Character.class, request.getParameter("character")), DbRepository.find(Task.class, request.getParameter("task")));
					 if(DbRepository.find(Jobs.class, job)!=null){ 
					if(DbRepository.find(Jobs.class, job)==null){
						DbRepository.add(Jobs.class, job);
						code = String.format("<details close><summary>Detalles del trabajo añadido</summary><label>Pelicula: %s, <br>Personaje: %s,  <br>Tarea: %s</label></details>", job.getIdFilm().getName(), job.getNameCharacter().getName(), job.getIdTask().getTask());
					}else{
						answer = "El trabajo ya existe en la base de datos";
					}
				}else{
					answer = "La tarea no puede ser nula";
				}
			}else{
				answer = "El personaje no puede ser nulo ";
			}
		}else{
			answer = "La pelicula no puede ser nula";
		}
	 } 

	}

}catch(Exception e){
	
}

%>
<h2>Añadir Pelicula</h2>
<%

//Cuando pulsemos el boton de guardar aparecera la ventana con los detalles de la ultima pelicula añadida 
if(request.getParameter("guardar")!=null){
	out.print(code);
}
%>	
<form action="addJobs.jsp">
<div class="form-group row">
    <label for="title" class="col-4 col-form-label">Nombre pelicula</label> 
    <div class="col-8">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-address-card"></i>
          </div>
        </div> 
       <select name=film>
       <%for(Film f : listFilm){ %>
       	<option value='<%=f.getId()%>'><%=f.getName() %></option>
       	<%} %>
       </select>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="title" class="col-4 col-form-label">Nombre del actor</label> 
    <div class="col-8">
      <div class="input-group">
        <div class="input-group-prepend">
          <div class="input-group-text">
            <i class="fa fa-address-card"></i>
          </div>
        </div> 
        <select name=character>
        <%for(Character c: listCharacters){ %>
        	<option value='<%=c.getName()%>'><%=c.getName() %></option>
        <%} %>
        </select>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="year" class="col-4 col-form-label">Tareas</label> 
    <div class="col-8">
      <select name="task">
      	<%for(Task t: listTask){ %>
      		<option value='<%=t.getTask()%>'><%=t.getTask() %></option>
      	<%} %>
      </select>
    </div>
  </div>
   <div class="form-group row">
    <label for="respuesta" class="col-4 col-form-label"><%=answer %></label> 
  </div> 
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="guardar" type="submit" class="btn btn-primary">Guardar</button>
    </div>
  </div>
</form>
</body>
</html>