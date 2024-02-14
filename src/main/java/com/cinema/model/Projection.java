package com.cinema.model;

import java.sql.Date;
import java.util.List;
import java.util.Objects;

import com.cinema.exceptions.ProjectionException;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "Proyeccion")
public class Projection {
		
	@Id
	@ManyToOne
	@JoinColumns({@JoinColumn(name="sala"),@JoinColumn(name="cine")})
	private Room room;
	
	@Id
	@ManyToOne
	@JoinColumn(name="cip")
	private Film film;
	
	@OneToMany
	private List<Ticket> tickets;
	
	@Id
	@Column(name="fecha_estreno")
	private Date releaseDate;
	
	@Column(name="dias_estreno")
	private int premiereDays;
	@Column(name="espectadores")
	private int viewers;
	@Column(name="recaudacion")
	private int takings;
	
	public Projection() {
		super();
	}

	public Projection(Room room, Film film, Date releaseDate, int premiereDays, int viewers,
			int takings) throws ProjectionException {
		super();
		setRoom(room);
		setFilm(film);
		setReleaseDate(releaseDate);
		setPremiereDays(premiereDays);
		setViewers(viewers);
		setTakings(takings);
	}
	
	public Projection(Room room, Film film, Date releaseDate) throws ProjectionException {
		super();
		setRoom(room);
		setFilm(film);
		setReleaseDate(releaseDate);
	}

	
	@Override
	public int hashCode() {
		return Objects.hash(releaseDate, film, room);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Projection other = (Projection) obj;
		return Objects.equals(releaseDate, other.releaseDate)
				&& Objects.equals(film, other.film) && Objects.equals(room, other.room);
	}

	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) throws ProjectionException {
		if(room == null) {
			throw new ProjectionException("The room cannot be null");
		}
		this.room = room;
	}

	public Film getFilm() {
		return film;
	}

	public void setFilm(Film film) throws ProjectionException {
		if(film == null) {
			throw new ProjectionException("The film cannot be null");
		}
		this.film = film;
	}

	public Date getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(Date releaseDate) throws ProjectionException {
		if(releaseDate == null) {
			throw new ProjectionException("The releaseDate cannot be null");
		}
		this.releaseDate = releaseDate;
	}

	public int getPremiereDays() {
		return premiereDays;
	}

	public void setPremiereDays(int premiereDays) throws ProjectionException {
		if(premiereDays < 0) {
			throw new ProjectionException("The Release Days field cannot contain a negative value");
		}
		else if(premiereDays > 31) {
			throw new ProjectionException("The projection will not be more than a month");
		}
		this.premiereDays = premiereDays;
	}

	public int getViewers() {
		return viewers;
	}

	public void setViewers(int viewers) throws ProjectionException {
		if(viewers < 0) {
			throw new ProjectionException("The viewers field cannot contain a negative value");
		}
		else if(String.valueOf(viewers) == "") {
			throw new ProjectionException("The viewers field cannot be empty");
		}
		this.viewers = viewers;
	}

	public int getTakings() {
		return takings;
	}

	public void setTakings(int takings) throws ProjectionException {
		if(takings < 0) {
			throw new ProjectionException("The viewers field cannot contain a negative value");
		}
		else if(String.valueOf(takings) == "") {
			throw new ProjectionException("The viewers field cannot be empty");
		}
		this.takings = takings;
	}
	
	
}
