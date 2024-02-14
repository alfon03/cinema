package com.cinema.repository;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.cinema.model.Projection;
import com.cinema.model.Ticket;
import com.cinema.model.User;
import com.cinema.util.BdUtil;
import com.cinema.util.DBUtil;

import jakarta.persistence.Query;

public class TicketRepository {
	
	public static List<Object[]> getTickets(String username) throws Exception{
		Session session;
		List<Object[]> result = null;
		try {
			session = BdUtil.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Failed to connect to database");
		}
		try {
			//Esta es la query con la que recuepero las room del cine
			@SuppressWarnings({ "unchecked", "deprecation" })
			SelectionQuery<Object[]> query = (SelectionQuery<Object[]>)
			session.createNativeQuery("SELECT * FROM Entrada WHERE usuario='"+username+"';");
			result = (ArrayList<Object[]>) query.getResultList();
 		}catch (Exception e) {
 			throw new Exception("Error al conectar a la base de datos "+ e.getMessage());
 		}
		session.close();
		return result;
	}
	
//	public static List<Ticket> getTicketsFail(User user) throws Exception {
//	    Session session = null;
//	    List<Ticket> listTickets = new ArrayList<>();
//	    try {
//	        session = DBUtil.getSessionFactory().openSession();
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	        throw new Exception("Error al conectar a la base de datos " + e.getMessage());
//	    }
//	    try {
//	        @SuppressWarnings({ "unchecked", "deprecation" })
//			NativeQuery<Object[]> query = session.createNativeQuery("SELECT * FROM Entrada WHERE usuario = :user");
//	        query.setParameter("user", user.getUsername());
//	        List<Object[]> resultList = query.getResultList();
//	        for (Object[] result : resultList) {
//	            // Crear manualmente un objeto Ticket y asignar los valores
//	            Ticket ticket = new Ticket();
//	            ticket.setId((int) result[4]); // Ajusta el índice según la posición de idEntrada en tu consulta
//	            ticket.setBuyDate((java.sql.Date) result[6]); // Ajusta el índice según la posición de fecha_compra en tu consulta
//	            String cine = (String) result[0];
//	            String sala = result[1].toString();
//	            String cip = (String) result[2];
//	            String fecha_estreno = result[3].toString();
//	            @SuppressWarnings("unchecked")
//				SelectionQuery<Projection> queryProjection =
//	            		(SelectionQuery<Projection>)
//	            		session.createSelectionQuery("FROM `Proyeccion` WHERE cine = '" + cine + "' and sala = " + sala + " and cip = '" + cip + "' and fecha_estreno = '" + fecha_estreno + "';");
//	            List<Projection> listProjection = queryProjection.getResultList();
//	            Projection projection = listProjection.get(0);
//	            ticket.setProjection(projection);
//	            ticket.setUser(user);
//	            // Ajusta otros campos según sea necesario
//	            // Agregar el objeto Ticket a la lista
//	            listTickets.add(ticket);
//	        }
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	        throw new Exception("Error al obtener las entradas: " + e.getMessage());
//	    } finally {
//	        session.close();
//	    }
//	    return listTickets;
//	}
	
	public static void addTicket(Ticket ticket) throws Exception{
		Transaction transaction = null; 
		Session session = null;

		try {
			session = BdUtil.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			throw new Exception("Failed to connect to database");
		}

		try {
			String query = "INSERT INTO Entrada(cine, sala, cip, fecha_estreno, idEntrada, usuario, fecha_compra) VALUES ('"+ticket.getProjection().getRoom().getCinema().getCinema()+
					"','"+ticket.getProjection().getRoom().getIdRoom()+
					"','"+ticket.getProjection().getFilm().getId()+
					"','"+ticket.getProjection().getReleaseDate()+
					"','"+ticket.getId()+
					"','"+ticket.getUser().getUsername()+
					"','"+ticket.getBuyDate()+"');";
			
			@SuppressWarnings("deprecation")
			Query persistableQuery = session.createNativeQuery(query);
			persistableQuery.executeUpdate();
			
			transaction.commit();
 		}catch (Exception e) {
 			transaction.rollback();
 			throw new Exception("Error al conectar a la base de datos "+ e.getMessage());
 		}
		session.close();
	}
	
	public static List<Ticket> findByProjection(Projection projection) throws Exception{
		Session session;
		List<Ticket> result = null;
		try {
			session = BdUtil.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Failed to connect to database");
		}
		try {
			//Esta es la query con la que recuepero las room del cine
			SelectionQuery<Ticket> query = (SelectionQuery<Ticket>)

			session.createNativeQuery("SELECT * FROM Entrada WHERE cine=\""+projection.getRoom().getCinema().getCinema()+"\" and sala=\""+projection.getRoom().getIdRoom()+"\" and cip=\""+projection.getFilm().getId()+"\" and fecha_estreno="+projection.getReleaseDate()+";",Ticket.class);
			result = (ArrayList<Ticket>) query.getResultList();
 		}catch (Exception e) {
 			throw new Exception("Error al conectar a la base de datos "+ e.getMessage());
 		}
		session.close();
		return result;
	}

}
