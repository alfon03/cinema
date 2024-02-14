package com.cinema.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.SelectionQuery;

import com.cinema.exceptions.FilmException;
import com.cinema.model.Film;
import com.cinema.model.Jobs;
import com.cinema.util.BdUtil;


public class FilmRepository extends DbRepository{
	
	
	/**
	 * Metodo para añadir una pelicula al base de datos
	 * @param pelicula
	 * @throws FilmException 
	 */
	public static void addFilm (Film a) throws FilmException {
		Transaction transaction = null; //Abrimos la transaccion
		//Comprobamos que la primary key de la pelicula ni los campos obligatorios no sean nulos
		if(a.getId() != null && a.getName()!=null && a.getYear()>0) {
			Session session = BdUtil.getSessionFactory().openSession(); //Abrimos la sesion
			transaction = session.beginTransaction();
			
			try {
				session.persist(a);//Guardamos la pelicula con un persist para que no permita sobreescribir en ella con este metodo
				transaction.commit();//Guardamos
			}catch(Exception e) {
				transaction.rollback();//Si ocurrio algun problema deshacemos el cambio
			}
			
			
			session.close();//Cerramos la sesion
			
		}else {
			//Si los campos no son validos lanzamos una excepcion personalizada
			throw new FilmException("Ocurrio un error al añadir la pelicula");
			
		}
		
	}
	
	
	/**
	 * Metodo para recoger todas las peliculas de la base de datos y almacenarlas en una lista
	 * @return lista de peliculas
	 */
	public static List<Film> getFilms(){
		Session session = BdUtil.getSessionFactory().openSession(); //Abrimos las sesion
		//Hacemos una consulta con HQL para traernos todos las peliculas
		List<Film> c = (List<Film>) session.createSelectionQuery("From Film").getResultList(); 
		return c;
	}
	
	/**
	 * Metodo para que me busque una pelicua en particular a partir del id
	 * @param id
	 * @return pelicula
	 * @throws FilmException 
	 */
	public static Film getFilm(String id) throws FilmException {
		Film result = null; 
		Session session = BdUtil.getSessionFactory().openSession(); //Abrimos la sesion
		//Hacemos consulta HQL donde nos recoga la pelicula con el id que le hemos proporcionado
		SelectionQuery<Film> f = session.createSelectionQuery("From Film where id = :id", Film.class);
		f.setParameter("id", id);//Asignamos el id
		List<Film> films = f.getResultList();//Almacenamos en una lista el resultado, ya que la consulta nos va a devolver una lista
		//Comprobamos que hay algo en ella es decir que existe
		if(films.size()!=0) {
			result = films.get(0);
		}else {
			throw new FilmException("No se recogieron datos");
		}
		
		return result;
		
	}
	
	
	/**
	 * Metodo para modificar la pelicula que le pasamos
	 * @param pelicula
	 * @throws FilmException 
	 */
	public static void modifyFilm(Film f) throws FilmException {
		Transaction transaction = null; //Creamos la transacion
		
		if(f.getId() != null && f.getName()!=null && f.getYear()>0) {//Comprobamos que la pelicula a modificar no es nula
			Session session = BdUtil.getSessionFactory().openSession();  //Abrimos la sesion
			transaction = session.beginTransaction();
		
			try {
				session.merge(f);//Guardamos en la base de datos la pelicula modificada
				transaction.commit();//Persistimos los cambios
			} catch (Exception e) {
				transaction.rollback();//Si ocurre alguna excepcion deshacemos los cambios
			}
			session.close();//Cerramos la sesion 
		}else {
			throw new FilmException("Los campos no son correctos");
		}
		
		
	}
	
	public static void deleteFilm(Film f) throws FilmException {
		Transaction transaction = null; //Creamos la transacion
		List<Jobs> jobs = null;
		
		if(f.getId() != null) {//Comprobamos que la pelicula a modificar no es nula
			Session session = BdUtil.getSessionFactory().openSession();  //Abrimos la sesion
			transaction = session.beginTransaction();
		
			try {
				NativeQuery<Jobs> query = session.createNativeQuery("Select * from Trabajo where cip = ?1", Jobs.class);
				query.setParameter(1, f.getId());
				jobs = query.getResultList();
				for (Jobs j: jobs) {
					session.remove(j);
				}
				session.remove(f);;//Guardamos en la base de datos la pelicula modificada
				transaction.commit();//Persistimos los cambios
				session.close();
			} catch (Exception e) {
				session.close();//Cerramos la sesion
				transaction.rollback();//Si ocurre alguna excepcion deshacemos los cambios
			}
		}else {
			throw new FilmException("La id es nula");
		}
		
		
	}
	
	

}
