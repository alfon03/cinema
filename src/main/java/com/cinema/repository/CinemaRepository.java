package com.cinema.repository;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.query.SelectionQuery;

import com.cinema.model.Room;
import com.cinema.util.BdUtil;

public class CinemaRepository {
	
	public static ArrayList<Room> getRooms(String cinema) throws Exception{
		ArrayList<Room> listRooms = null;
		Session session = null;
		try {
			session = BdUtil.getSessionFactory().openSession();
			SelectionQuery<Room> queryRoom = (SelectionQuery<Room>)
					session.createNativeQuery("select * from Sala where cine = :cine",Room.class);
			queryRoom.setParameter("cine", cinema);
			listRooms = (ArrayList<Room>) queryRoom.getResultList();
			session.close();
 		}catch (Exception e) {
 			session.close();
 			throw new Exception("Error al conectar a la base de datos "+ e.getMessage());
 		}
		session.close();
		return listRooms;
	}
	
}
