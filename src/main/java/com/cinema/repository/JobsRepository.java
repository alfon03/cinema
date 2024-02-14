package com.cinema.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

import com.cinema.exceptions.DbExceptions;
import com.cinema.model.Jobs;
import com.cinema.util.BdUtil;

public class JobsRepository extends DbRepository {

	public static List<Jobs> findCharacter(String name) throws DbExceptions {
		Session session = null;
		List<Jobs> jobs = null;
		
		try {
			session = BdUtil.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new DbExceptions("Error al conectarse en la base de datos");
		}
			
		try {
			NativeQuery<Jobs> query = session.createNativeQuery("Select * from Trabajo where nombre_persona = ?1", Jobs.class);
			query.setParameter(1, name);
			jobs = query.getResultList();
			session.close();
		} catch (Exception e) {
			session.close();
			throw new DbExceptions("Error al encontrar los trabajos");
		}
		
		return jobs;
		
	}
	
	
	public static List<Jobs> findFilm(String name) throws DbExceptions {
		Session session = null;
		List<Jobs> jobs = null;
		
		try {
			session = BdUtil.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new DbExceptions("Error al conectarse en la base de datos");
		}
			
		try {
			NativeQuery<Jobs> query = session.createNativeQuery("Select * from Trabajo where cip = ?1", Jobs.class);
			query.setParameter(1, name);
			jobs = query.getResultList();
			session.close();
		} catch (Exception e) {
			session.close();
			throw new DbExceptions("Error al encontrar los trabajos");
		}
		
		return jobs;
		
	}
	
}
