package com.cinema.repository;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.cinema.exceptions.DbExceptions;
import com.cinema.exceptions.FilmException;
import com.cinema.model.Projection;
import com.cinema.model.Ticket;
import com.cinema.util.BdUtil;

public class ProjectionRepository {

	public static Projection find(Projection projection) throws FilmException, DbExceptions {
	    
		Projection result = null; 
        Session session = null;

        try {
            session = BdUtil.getSessionFactory().openSession();
        } catch (Exception e) {
            throw new DbExceptions("Error al conectar en la base de datos");
        }

        try {
            result = session.find(Projection.class, projection);
            session.close();
        } catch (Exception e) {
            session.close();
            throw new DbExceptions("Error al encontrar la entidad");
        }

        return result;

    }
	
	public static Projection editProjection(Projection projection) throws DbExceptions {
		Transaction transaction = null;
		Session session = BdUtil.getSessionFactory().openSession();
		transaction = (Transaction) session.beginTransaction();

		Projection result = null;
		try {
			result = session.merge(projection);
			transaction.commit();
		} catch (Exception e) {
			System.out.println(e);
			transaction.rollback();
		}
		session.close();

		return result;

	}
	
	public static void add(Projection projection) throws DbExceptions{
        Session session = null;
        Transaction transaction = null;
        try {
            session = BdUtil.getSessionFactory().openSession();
            transaction = session.beginTransaction();
        } catch (Exception e) {
            throw new DbExceptions("Error al conectar en la base de datos");
        }
        try {
                session.persist(projection);
                transaction.commit();
                session.close();
        } catch (Exception e) {
            session.close();
            transaction.rollback();
            throw new DbExceptions("Error al añadir");
        }
    }
	
	public static List<Projection> getActualFilms() throws Exception {
		Session session;
		List<Projection> result = null;
		try {
			session = BdUtil.getSessionFactory().openSession();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("A fail occurred while connecting to database.");
		}
		try {
			//Esta es la query con la que recuepero las room del cine
			SelectionQuery<Projection> query = (SelectionQuery<Projection>)
					session.createNativeQuery("select * from Proyeccion where fecha_estreno+dias_estreno >= CURDATE()+0;",Projection.class);
			result = (ArrayList<Projection>) query.getResultList();
 		}catch (Exception e) {
 			e.printStackTrace();
 			throw new Exception("Error al obtener las cosas:  "+ e.getMessage());
 		}
		session.close();
		return result;
	}
	
}
