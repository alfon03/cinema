package com.cinema.repository;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.SelectionQuery;

import com.cinema.util.BdUtil;
import com.cinema.exceptions.CharacterException;
import com.cinema.exceptions.FilmException;
import com.cinema.model.Character;
import com.cinema.model.Film;
import com.cinema.model.Jobs;

public class CharacterRepository {
	
//	Metodo creado para añadir los personajes

	public static Character addCharacter(Character c) {
		Transaction transaction = null;
		Character result = null;
		if(c.getName() != null) {
			Session session = BdUtil.getSessionFactory().openSession();
			transaction = session.beginTransaction();
			try {
				session.persist(c);
				transaction.commit();
			}catch (Exception e) {
				transaction.rollback();
			}
			
			session.close();
		}
		return result;
	}
	
//	Metodo creado para editar los personajes
	
	public static Character editCharacter(Character c){
		Transaction transaction = null;
		Character result = null;
		if(c.getName() != null) {
			Session session = BdUtil.getSessionFactory().openSession();
			transaction = session.beginTransaction();
			try {
				session.merge(c);
				transaction.commit();
			}catch (Exception e) {
				transaction.rollback();
			}
			
			session.close();
		}
		return result;
	}
	
//	Con este metodo devuelvo una lista de los personajes extraidos de la base de datos
	
	public static List<Character> getCharacters(){
		Session session = BdUtil.getSessionFactory().openSession();
		
		List<Character> characters = new ArrayList<Character>();
		
		characters = (List<Character>) session.createSelectionQuery( "From Character" ).getResultList();
		
		session.close();
		
		return characters;
	}
	
//	Con este metodo obtenemos un solo objeto de Personaje
	
	public static Character getCharacter(String nombre_persona) {
		Character result = null;
		Session session = BdUtil.getSessionFactory().openSession();

		SelectionQuery<Character> q =
				session.createSelectionQuery("From Character where name = :name", Character.class);
				q.setParameter("name", nombre_persona);
				List<Character> names = q.getResultList();
				if(names.size() != 0) {
					result = names.get(0);
				}
				return result;
	}
	
	//Metodo creado para borrar los personajes
	
	public static void deleteCharacter(Character c) throws CharacterException {
		Transaction transaction = null; //Creamos la transacion
		List<Jobs> jobs = null;
		
		if(c.getName() != null) {//Comprobamos que la pelicula a modificar no es nula
			Session session = BdUtil.getSessionFactory().openSession();  //Abrimos la sesion
			transaction = session.beginTransaction();
		
			try {
				NativeQuery<Jobs> query = session.createNativeQuery("Select * from Trabajo where nombre_persona = ?1", Jobs.class);
				query.setParameter(1, c.getName());
				jobs = query.getResultList();
				for (Jobs j: jobs) {
					session.remove(j);
				}
				session.remove(c);;//Guardamos en la base de datos la pelicula modificada
				transaction.commit();//Persistimos los cambios
				session.close();
			} catch (Exception e) {
				session.close();//Cerramos la sesion
				transaction.rollback();//Si ocurre alguna excepcion deshacemos los cambios
			}
		}else {
			throw new CharacterException("La id es nula");
		}
		
		
	}
	
}
