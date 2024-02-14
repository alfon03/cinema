package com.cinema.repository;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.hibernate.query.SelectionQuery;

import com.cinema.model.Projection;
import com.cinema.model.Room;
import com.cinema.util.BdUtil;


public class RoomRepository extends DbRepository {

/**
 * Metodo para obtener todas las salas
 * @param nombre del cine
 * @param id de la sala
 * @return lista de todas las salas
 * @throws Exception
 */
public static ArrayList<Projection> getProjection(String cinema, int sala) throws Exception{
		
		ArrayList<Projection> listProjection = null;
		Session session = null;
		
		try {
			session = BdUtil.getSessionFactory().openSession();
			
			SelectionQuery<Projection> projection = session.createNativeQuery("Select * from Proyeccion where cine = :cine and sala = :sala",Projection.class);
			projection.setParameter("cine", cinema);
			projection.setParameter("sala", sala);
			
			listProjection = (ArrayList<Projection>) projection.getResultList();
			session.close();
		} catch (Exception e) {
			session.close();
			throw new Exception(e.getMessage());
		}
		return listProjection;
	}
	
/**
 * Metodo para encontrar una sala
 * @param nombre del cine
 * @param nombre de la sala
 * @return sala encontrada
 */
	public static Room findRoom(String cinema, String room) {
	    Session session = null;
	    Room result = null;

	    try {
	        session = BdUtil.getSessionFactory().openSession();

	        String queryString = "SELECT * FROM Sala WHERE Sala.cine = :cinema AND Sala.sala = :room";
	        Query<Room> query = session.createNativeQuery(queryString, Room.class);
	        query.setParameter("cinema", cinema);
	        query.setParameter("room", Integer.parseInt(room));

	        List<Room> listRoom = query.getResultList();
	        if (listRoom.size() == 1) {
	            result = listRoom.get(0);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        if (session != null) {
	            session.close();
	        }
	    }

	    return result;
	}
	
	/**
	 * Metodo para borrar sala y todas sus proyecciones
	 * @param nombre del cine
	 * @param id de la sala
	 * @return sala
	 */
	public static Room deleteRoom(String cinemaName, int roomId) {
	    Session session = null;//Creamos las variables necesarias
	    Transaction transaction = null;
	    Room result = null;

	    try {//les damos valores a la sesion y a la transaccion
	        session = BdUtil.getSessionFactory().openSession();
	        transaction = session.beginTransaction();

	        // Utilizamos directamente el método uniqueResult para obtener el resultado único.
	        String queryString = "FROM Room WHERE cinema.cinema = :cinemaName AND idRoom = :roomId";
	        Query<Room> query = session.createQuery(queryString, Room.class);
	        query.setParameter("cinemaName", cinemaName);//le damos parametros a la query
	        query.setParameter("roomId", roomId);
	        result = query.uniqueResult();//recogemos el resultado

	        if (result != null) {
	            session.remove(result);
	            transaction.commit();
	        }
	    } catch (Exception e) {
	        if (transaction != null) {
	            transaction.rollback();
	        }
	        e.printStackTrace();
	    } finally {
	        if (session != null) {
	            session.close();
	        }
	    }

	    return result;
	}
	
}
