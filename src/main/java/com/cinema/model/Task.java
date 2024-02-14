package com.cinema.model;

import java.util.List;
import java.util.Objects;

import com.cinema.exceptions.TaskException;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "Tarea")
public class Task {

	@Id
	@Column(name = "tarea")
	private String task;
	@Column(name = "sexo_tarea")
	private char taskGender;
	/*
	@OneToMany(mappedBy="idTask")
	private List<Jobs> listCharacterFilm;
	*/
	
	
	public Task() {
		super();
	}
	/**
	 * Constructor de tarea
	 * @param task
	 * @param taskGender
	 * @throws TaskException
	 */
	public Task(String task, String taskGender) throws TaskException {
		super();
		// Llamamos a los metodos set para verificar en la parte servidor que contiene datos antes de crear el objeto.
		setTask(task);
		setTaskGender(taskGender);
	}
	public String getTask() {
		return task;
	}
	public void setTask(String task) throws TaskException {
		// Comprobamos antes de crear el objeto, que contenga informacion.
		if(task==null) {
			throw new TaskException("Debe introducir nombre de tarea");
		}
		this.task = task;
	}

	
	
	public char getTaskGender() {
		return taskGender;
	}
	public void setTaskGender(String taskGender) throws TaskException {
		//Comprobamos que el genero sea uno de los permitidos en las especificaciones
		if(!taskGender.equals("H") && !taskGender.equals("M") && !taskGender.equals("O")) {
			throw new TaskException("Solo se permite H, M u O");
		}
		this.taskGender = taskGender.charAt(0);
	}
	@Override
	public int hashCode() {
		return Objects.hash(task, taskGender);
	}
	@Override
	public boolean equals(Object obj) {
		Task other = (Task) obj;
		return this.hashCode()==other.hashCode();
	}
	@Override
	public String toString() {
		return String.format("Task task=%s, taskSex=%s", task, taskGender);
	}
	
	
	
	
	
	
}
