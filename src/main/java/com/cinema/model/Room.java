package com.cinema.model;

import java.util.List;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="Sala")
public class Room {
	@Id
	@ManyToOne
	@JoinColumn(name = "cine")
	private Cinema cinema;
	
	@Id
	@Column(name = "sala")
	private int idRoom;
	@Column(name = "aforo")
	private int capacity;

	@OneToMany(mappedBy="room")
	private List<Projection> listProjection;
	
	//Constructores
	public Room(Cinema cinema, int idRoom, int capacity) {
		super();
		this.cinema = cinema;
		this.idRoom = idRoom;
		this.capacity = capacity;
	}
	public Room(Cinema cinema, int idRoom, int capacity, List<Projection> listProjection) {
		super();
		this.cinema = cinema;
		this.idRoom = idRoom;
		this.capacity = capacity;
		this.listProjection = listProjection;
	}
	public Room() {
		super();
	}
	//Getters y setters
	public Cinema getCinema() {
		return cinema;
	}
	public void setCinema(Cinema cinema) {
		this.cinema = cinema;
	}
	public int getIdRoom() {
		return idRoom;
	}
	public void setIdRoom(int idRoom) {
		this.idRoom = idRoom;
	}
	public List<Projection> getListProjection() {
		return listProjection;
	}
	public void setListProjection(List<Projection> listProjection) {
		this.listProjection = listProjection;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	//Hash code and equals con las primary keys
	@Override
	public int hashCode() {
		return Objects.hash(cinema, idRoom);
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Room other = (Room) obj;
		return Objects.equals(cinema, other.cinema) && idRoom == other.idRoom;
	}
	@Override
	public String toString() {
		return "Room [cinema=" + cinema + ", idRoom=" + idRoom + ", capacity=" + capacity + ", listProjection="
				+ listProjection + "]";
	}
	
	
}
