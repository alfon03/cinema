<%@page import="com.cinema.repository.CharacterRepository"%>
<%@page import="com.cinema.model.Character"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Characters delete</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">

</head>
<body>

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
%>

<%
Character character = null;
String answer = "";

try{
	character = CharacterRepository.getCharacter(request.getParameter("characterDelete"));
}catch(Exception e){
	response.sendRedirect("../error?msg=Error al encontrar al personaje");
	return;
}

if(request.getParameter("confirmDelete") != null && request.getParameter("characterDelete")!=null){
	try{
		CharacterRepository.deleteCharacter(character);
		answer = "Borrado exitosamente";
	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg=Error al borrar el personaje");
		return;
	}
	
	response.sendRedirect("characterList.jsp");

}
	
%>


<!-- //Creamos la cabecera y el formulario -->

<div class="mainWrap">
	<form>
  <div class="form-group row">
    <label for="text" class="col-4 col-form-label">Nombre</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="characterDelete" name="characterDelete" type="text" class="form-control" value="<%=character.getName()%>" readonly>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">Nacionalidad</label> 
    <div class="col-8">
      <input id="nacionality" name="nacionality" type="text" class="form-control" value="<%=character.getNationality() %>">
    </div>
  </div>
  <div class="form-group row">
    <label for="text2" class="col-4 col-form-label">Genero</label> 
    <div class="col-8">
      <input id="sex" name="sex" type="text" class="form-control" value="<%=character.getSex()%>">
    </div>
  </div>
   <div class="form-group row">
    <label for="respuesta" class="col-4 col-form-label"><%=answer %></label> 
  </div>
   <%
    if(request.getParameter("delete") == null && request.getParameter("confirmDelete") == null){//Si no hemos pulsado el boton de borrar ni el de confirmar
    	%>
    	<button name="delete" type="submit" class="btn btn-danger">Borrar</button>
    <% }
    else if(request.getParameter("confirmDelete") == null){//Si el boton de confirmar es nulo nos mostrará los siguientes botones
    	%>
    	<button name="confirmDelete" type="submit" class="btn btn-danger">Confirmar</button>
    	<button name="list" type="submit" class="btn btn-info">Volver</button>
    	<% 
    }else if(request.getParameter("confirmDelete") != null){//Si hemos pulsado el boton de borrar, nos mostrará el siguiente botón
    	%>
    	<button name="list" type="submit" class="btn btn-info">Volver</button>
    <%}

      %>
      </div>
  </form>
 
</div>

</body>
</html>