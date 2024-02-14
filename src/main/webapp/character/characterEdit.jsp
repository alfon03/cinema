<%@page import="com.cinema.exceptions.CharacterException"%>
<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="com.cinema.repository.CharacterRepository"%>
<%@page import="com.cinema.model.Character"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Characters edit</title>

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
%>
<%
Character character = null;
Character characterFind = null;
String answer = "";

//Pasamos un personaje al objeto c
try{
	character = DbRepository.find(Character.class, request.getParameter("idCharacter"));
}catch(Exception e){
	response.sendRedirect("../error?msg=Error al encontrar al personaje");
	return;
}
	

//Aqui especificamos que si pulsan el boton con name submit nos edite el personaje y despues nos devuelta al lista de personajes
		if(request.getParameter("mod") != null && request.getParameter("idCharacter")!=null){
			try{
				character = new Character(request.getParameter("idCharacter"),request.getParameter("nationality"),request.getParameter("sex"));
			}catch(CharacterException e){
				answer = e.getMessage();
			}
			
			try{
				characterFind = DbRepository.find(Character.class, character);
			}catch(Exception e){
				response.sendRedirect("../error?msg=Error al analizar al personaje");
				return;
			}
			
			if(characterFind!=null){
				try{
					DbRepository.update(Character.class, character);
					answer="Actualizado correctamente";
				}catch(Exception e){
					response.sendRedirect("../error?msg=Error al actualizar el personaje");
					return;
				}
			
				
			}
			
		}

%>
<!-- Creamos el formulario con sus respectivos campos de la tabla personaje -->
<div class="mainWrap">
	<form>
  <div class="form-group row">
    <label for="text" class="col-4 col-form-label">Nombre</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="idCharacter" name="idCharacter" type="text" class="form-control" value="<%=character.getName()%>" readonly>
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
  </form>
</div>
<div>
  <form>
		<div class="form-group row">
		  <div class="offset-4 col-8">
		    <button name="mod" type="submit" class="btn btn-warning">Editar</button>
		  </div>
		</div>
		</form>
	</div>
  </div>
</body>
</html>