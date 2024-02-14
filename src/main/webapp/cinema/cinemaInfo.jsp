<%@page import="com.cinema.repository.DbRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cinema.model.Cinema"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Listado personajes e info</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">

</head>
<body>
<%@include file="../nav.jsp" %>
	<% 
		//Le pasamos una lista de personajes a result
		List<Cinema> result = new ArrayList();
		String infoCinema = null;
		
		try{
		result = DbRepository.findAll(Cinema.class);
		
		Cinema info = DbRepository.find(Cinema.class, request.getParameter("info"));	
		infoCinema = info.getCinema();
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg="+e.getMessage());
			return;
		}
	%>
<!-- 	Creamos el formulario y dentro de el hacemos un for para que nos recorra result e imprima todos los personajes -->
	<table class="table">
		<thread>
			<tr>
				<th scope="col">Name</th>
				
			</tr>
		</thread>
		<%for(Cinema c : result){
		
			if(c.getCinema().equals(infoCinema)){%>
				<tr>
					<td><%=c.getCinema()%> 
					<form action="cinemaInfo.jsp">
					<input id="info" name="info" type="text" class="form-control" value= '<%=c.getCinema()%>' hidden>
		
		    <button name="submit" type="submit" class="btn btn-primary">Info</button>
		 
					</form>
					</td>
					<p>Cinema: <%=infoCinema%></p><br>
	     			<p>City: <%=c.getCity_cinema()%></p><br>
	     			<p>Management: <%=c.getManagement_cinema() %></p><br>
						<form action="./updateCinema.jsp">
							<input type="text" name="cinemaEdit" value='<%=c.getCinema()%>' hidden>
							<button type="submit" name="edit">Edit</button>
						</form>
												<form action="./deleteCinema.jsp">
							<input type="text" name="deleteCinema" value='<%=c.getCinema()%>' hidden>
							<button type="submit" name="delete">Delete</button>
						</form>
    
					
				</tr>
		<% }else{%>
		
			<tr>
					<td><%=c.getCinema()%> 
					<form action="cinemaInfo.jsp">
					<input id="info" name="info" type="text" class="form-control" value= '<%=c.getCinema()%>' hidden>
		
		    <button name="submit" type="submit" class="btn btn-primary">Info</button>
		 
					</form>
					</td>
				</tr>
		
		<%}} %>
		
		
		<%if(request.getParameter("delete") != null){
			DbRepository.deleteEntity(Cinema.class, request.getParameter("cinemaDelete"));
			
		}%>
		
		
		
		
		
	</table>
</body>
</html>