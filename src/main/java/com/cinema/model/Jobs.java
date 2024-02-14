package com.cinema.model;

import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="Trabajo")
public class Jobs {
	
	@Id
	@ManyToOne
	@JoinColumn(name="cip")
	private Film idFilm;
	
	@Id
	@ManyToOne
	@JoinColumn(name="nombre_persona")
	private Character nameCharacter;
	@Id
	@ManyToOne
	@JoinColumn(name="tarea")
	private Task idTask;
	
	public Jobs() {
		super();
	}

	public Jobs(Film idFilm, Character nameCharacter, Task idTask) {
		super();
		this.idFilm = idFilm;
		this.nameCharacter = nameCharacter;
		this.idTask = idTask;
	}

	public Film getIdFilm() {
		return idFilm;
	}

	public void setIdFilm(Film idFilm) {
		this.idFilm = idFilm;
	}

	public Character getNameCharacter() {
		return nameCharacter;
	}

	public void setNameCharacter(Character nameCharacter) {
		this.nameCharacter = nameCharacter;
	}

	public Task getIdTask() {
		return idTask;
	}

	public void setIdTask(Task idTask) {
		this.idTask = idTask;
	}

	@Override
	public int hashCode() {
		return Objects.hash(idFilm, idTask, nameCharacter);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Jobs other = (Jobs) obj;
		return Objects.equals(idFilm, other.idFilm) && Objects.equals(idTask, other.idTask)
				&& Objects.equals(nameCharacter, other.nameCharacter);
	}
	
	
	
	

	
}
