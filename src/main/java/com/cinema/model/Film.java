package com.cinema.model;

import java.util.List;
import java.util.Objects;

import com.cinema.exceptions.DbExceptions;
import com.cinema.exceptions.FilmException;
import com.cinema.repository.JobsRepository;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;


@Entity
@Table(name="Pelicula")
public class Film {
	
	@Id
	@Column(name="cip")
	private String id;
	@Column(name="titulo_p")
	private String name;
	@Column(name="ano_produccion")
	private int year;
	@Column(name="titulo_s")
	private String secundaryName;
	@Column(name="nacionalidad")
	private String nacionality;
	@Column(name="presupuesto")
	private int cost;
	@Column(name="duracion")
	private int duration;
	
	@OneToMany(mappedBy="film")
	private List<Projection> listProjection;

	
	@OneToMany(mappedBy="idFilm")
	private List<Jobs> listCharacter;

	public Film () {
		super();
	}
	
	public Film(String id, String name, String year, String secundaryName, String nacionality, String cost,
			String duracion) throws FilmException {
		super();
		setId(id);
		setName(name);
		setYear(year);
		setSecundaryName(secundaryName);
		setNacionality(nacionality);
		setPresupuesto(cost);
		setDuration(duracion);
	}

	
	
	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	public List<Jobs> getListCharacter() throws DbExceptions {
		return JobsRepository.findFilm(this.id);
	}

	public void setListCharacter(List<Jobs> listCharacter) {
		this.listCharacter = listCharacter;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) throws FilmException {
		if(id.isEmpty() || id==null) {
			throw new FilmException("El id no puede estar vacio");
		}else {
			this.id = id;
		}
		
	}

	public String getName() {
		return name;
	}

	public void setName(String name) throws FilmException {
		if(name.isEmpty() || name==null) {
			throw new FilmException("El nombre no puede estar vacio");
		}else {
			this.name = name;
		}
		
	}

	public int getYear() {
		return year;
	}

	public void setYear(String year) throws FilmException {
		if(year.isEmpty() || year==null) {
			throw new FilmException("El año no puede estar vacio");
		}else {
			try {
				
				this.year = Integer.parseInt(year);
			}catch(NumberFormatException ne) {
				throw new FilmException("El año debe ser numerico");
			}
		}
		
	}

	public String getSecundaryName() {
		return secundaryName;
	}

	public void setSecundaryName(String secundaryName) {
		if(secundaryName==null) {
			secundaryName = "";
		}
		this.secundaryName = secundaryName;
	}

	public String getNacionality() {
		return nacionality;
	}

	public void setNacionality(String nacionality) {
		if(nacionality==null) {
			nacionality = "";
		}
		this.nacionality = nacionality;
	}

	public int getPresupuesto() {
		return cost;
	}

	public void setPresupuesto(String cost) throws FilmException {
		if(cost==null || cost.isEmpty()) {
			cost = "0";
		}else {
			if(Integer.parseInt(cost)>=0) {
				try {
					
					this.cost = Integer.parseInt(cost);
				}catch(NumberFormatException ne) {
					throw new FilmException("El presupuesto debe ser numerico");
				}
			}else {
				throw new FilmException("El presupuesto no puede ser negativo");
			}
		}
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(String duration) throws FilmException {
		if(duration==null || duration.isEmpty()) {
			duration = "0";
		}else {
			if(Integer.parseInt(duration)>=0) {
				try {
					this.duration = Integer.parseInt(duration);
					
				}catch(NumberFormatException ne) {
					throw new FilmException("El presupuesto debe ser numerico");
				}
			}else {
				throw new FilmException("La duracion no puede ser negativo");
			}
		}
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Film other = (Film) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "Movie [id=" + id + ", name=" + name + ", year=" + year + ", secundaryName=" + secundaryName
				+ ", nacionality=" + nacionality + ", presupuesto=" + cost + ", duration=" + duration + "]";
	}
	
	
	

}

