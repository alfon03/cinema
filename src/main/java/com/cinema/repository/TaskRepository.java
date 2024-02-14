package com.cinema.repository;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.cinema.exceptions.TaskException;
import com.cinema.model.Task;
import com.cinema.utils.BdUtil;


public class TaskRepository {
	
	
	/**
	 * Añade una tarea a la base de datos.
	 * @param t (Objeto Task)
	 * @throws TaskException
	 */
public static void addTask(Task t) throws TaskException {
		// Abrimos la sesion de base de datos
		Transaction transaccion = null;
		Session sesi = (Session) BdUtil.getSessionFactory().openSession();
		transaccion = (Transaction) sesi.beginTransaction();
		
		// Hacemos el insert en la base de datos si es posible
		try {
			sesi.persist(t);		
			transaccion.commit();
		} catch (IllegalStateException e) {
			transaccion.rollback();
			throw new TaskException("No se ha podido añadir");
		}
		sesi.close();
	}



/**
 * Genera una lista a partir de la base de datos Tareas
 * @return List
 * @throws TaskException 
 */
@SuppressWarnings("unchecked")
public static List<Task> getTasks() throws TaskException {
	// Abrimos la sesion de base de datos
	Session sesi = (Session) BdUtil.getSessionFactory().openSession();
	
	// Variables
	List<Task> tasks = new ArrayList<Task>();
	
	try {
		
		// Generamos la lista a partir de una consulta a la base de datos, a la tabla de Tareas.
		tasks = (List<Task>) sesi.createSelectionQuery("From Task").getResultList();
		
	} catch (Exception e) {
		throw new TaskException("Error al conectar la base de datos");
	}
	sesi.close();
	
	return tasks;
}

/**
 * Obtenemos un solo objeto de Tarea.
 * @param task (Campo clave en la base de datos Tarea)
 * @return Task
 * @throws TaskException
 */
public static Task getTaskInstance(String task) throws TaskException {
	// Abrimos la sesion de base de datos
	Session sesi = (Session) BdUtil.getSessionFactory().openSession();
	
	// Variables
	Task taskInstance = null;

	// Nos aseguramos que no introduzcan valores nulos
	if(task.isEmpty()) throw new TaskException("Introduzca campo clave de tarea");
	
	// Si existe en la base de datos, lo devuelve como objeto, si no existe, usaremos el nulo devuelto para comunicarlo al usuario.
	taskInstance = sesi.createSelectionQuery("From Task where task = :task", Task.class).setParameter("task", task).getSingleResultOrNull();
	
	sesi.close();
	
	return taskInstance;
}
/**
 * Modifica una tarea en la base de datos.
 * @param t (Objeto Task)
 * @throws TaskException
 */
public static void modTask(Task t) throws TaskException {
	// Abrimos la sesion de base de datos
	Transaction transaccion = null;
	Session sesi = (Session) BdUtil.getSessionFactory().openSession();
	transaccion = (Transaction) sesi.beginTransaction();
	
	// Aseguramos que introducen tarea.
	if(t==null) throw new TaskException("No se ha introducido ninguna tarea");
	
	// Hacemos la modificacion en la base de datos si es posible
	try {
		sesi.merge(t);		
		transaccion.commit();
	} catch (IllegalStateException e) {
		transaccion.rollback();
		throw new TaskException("No se ha podido modificar");
	}
	sesi.close();
}

/**
 * Borra una tarea en la base de datos.
 * @param t (Objeto Task)
 * @throws TaskException
 */
public static void delTask(Task t) throws TaskException {
	// Abrimos la sesion de base de datos
	Transaction transaccion = null;
	Session sesi = (Session) BdUtil.getSessionFactory().openSession();
	transaccion = (Transaction) sesi.beginTransaction();
	
	// Aseguramos que introducen tarea.
	if(t==null) throw new TaskException("No se ha introducido ninguna tarea");
	
	// Hacemos la modificacion en la base de datos si es posible
	try {
		sesi.remove(t);		
		transaccion.commit();
	} catch (IllegalStateException e) {
		transaccion.rollback();
		throw new TaskException("No se ha podido borrar");
	}
	sesi.close();
}

}
