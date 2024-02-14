<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="./styles/navStyle.css">
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
  <a class="navbar-brand" href="/pruebaHibernate/index.jsp">Cine Currito</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
      <div class="navbar-nav">
        <a class=" nav-link" href="${pageContext.request.servletContext.contextPath}/film/listFilm.jsp">Listado de peliculas</a>
        <a class=" nav-link" href="${pageContext.request.servletContext.contextPath}/film/addFilm.jsp">Añadir pelicula</a>
        <a class=" nav-link" href="${pageContext.request.servletContext.contextPath}/character/listCharacters.jsp">Listado de personaje</a>
        <a class=" nav-link" href="${pageContext.request.servletContext.contextPath}/character/addCharacter.jsp">Añadir personaje</a>
        <a class=" nav-link" href="${pageContext.request.servletContext.contextPath}/tasks/listTask.jsp">Listado de tarea</a>
        <a class=" nav-link" href="${pageContext.request.servletContext.contextPath}/tasks/addTask.jsp">Añadir tarea</a>
        <%if (session.getAttribute("user") == null) { %>
        <div class="imgContainer">
    		<a href="/pruebaHibernate/logIn.jsp"><img class="userImg" src="/pruebaHibernate/img/usuario (1).png"></a>
  		</div>
  		<%} else { %>
  		<div class="imgContainer">
    		<a href="/pruebaHibernate/user/infoUser.jsp"><img class="userImg" src="/pruebaHibernate/img/usuario (1).png"></a>
  		</div>
  		<%} %>
      </div>
    </div>
  </div>
</nav>
</body>
</html>