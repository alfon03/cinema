package com.cinema.model;

import java.util.List;
import java.util.Objects;

import com.cinema.exceptions.CharacterException;
import com.cinema.exceptions.DbExceptions;
import com.cinema.repository.JobsRepository;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table (name = "Personaje")
public class Character {
	
//	Creando los atributos y asignando a cada uno su respectiva columna de la tabla de la base de datos
	@Id
	@Column (name = "nombre_persona")
	private String name;
	@Column (name = "nacionalidad_persona")
	private String nationality;
	@Column (name = "sexo_persona")
	private String sex;
/*
	@OneToMany(mappedBy="nameCharacter")
	private List<Jobs> listFilm;
	*/
//	
//	Creacion de los constructores
	
	

	public Character() {
		super();
	}


	public Character(String name, String nationality, String sex) throws CharacterException {
		super();
		this.name = name;
		this.nationality = nationality;
		setSex(sex);
	}

	public List<Jobs> getListFilm() throws DbExceptions {
		return JobsRepository.findCharacter(this.name);
	}

/*
	public void setListFilm(List<Jobs> listFilm) {
		this.listFilm = listFilm;
	}
*/
//	Creacion de setters y getters
	
	public String getName() {
		return name;
	}


	public void setName(String name) throws CharacterException{
		this.name = name;
	}


	public String getNationality() {
		return nationality;
	}


	public void setNationality(String nationality) throws CharacterException {
		this.nationality = nationality;
	}


	public String getSex() {
		return sex;
	}


	public void setSex(String sex) throws CharacterException{
		if(!sex.equals('H') || !sex.equals('M') || !sex.equals('O')) {
			throw new CharacterException("El sexo solo puede tener el valor H, M, O");
		}
		this.sex = sex;
	}

//	Creacion de hashCode y equals

	@Override
	public int hashCode() {
		return Objects.hash(name, nationality, sex);
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Character other = (Character) obj;
		return Objects.equals(name, other.name) && Objects.equals(nationality, other.nationality)
				&& Objects.equals(sex, other.sex);
	}


//	Creacion del String
	
	@Override
	public String toString() {
		return "Character [name=" + name + ", nationality=" + nationality + ", sex=" + sex + "]";
	}
	
	
	
	
}
