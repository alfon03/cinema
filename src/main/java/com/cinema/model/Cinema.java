package com.cinema.model;

import java.util.List;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "Cine")
public class Cinema {
	@Id
	@Column(name = "cine")
	private String cinema;
	@Column(name = "ciudad_cine")
	private String cityCinema;
	@Column(name = "direccion_cine")
	private String managementCinema;
	
	@OneToMany(mappedBy = "cinema")
	private List<Room> rooms;
	
	/**
	 * Contructor vacío
	 */
	public Cinema() {
		super();
	}
	/**
	 * Contructor con los parametros obligatorios
	 */
	
	public Cinema(String cinema, String city_cinema) {
		super();
		this.cinema = cinema;
		this.cityCinema = city_cinema;
	}
	/**
	 * Constructor con todos los parametos
	 */
	public Cinema(String cinema, String city_cinema, String management_cinema) {
		super();
		this.cinema = cinema;
		this.cityCinema = city_cinema;
		this.managementCinema = management_cinema;
	}
	/**
	 * Get && Set
	 */
	public String getCinema() {
		return cinema;
	}
	public void setCinema(String cinema) {
		this.cinema = cinema;
	}
	public String getCity_cinema() {
		return cityCinema;
	}
	public void setCity_cinema(String cityCinema) {
		this.cityCinema = cityCinema;
	}
	public String getManagement_cinema() {
		return managementCinema;
	}
	public void setManagementCinema(String managementCinema) {
		this.managementCinema = managementCinema;
	}
	
	public List<Room> getRooms() {
		return rooms;
	}
	public void setRooms(List<Room> rooms) {
		this.rooms = rooms;
	}
	/**
	 * Equals
	 */
	@Override
	public int hashCode() {
		return Objects.hash(cinema);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Cinema other = (Cinema) obj;
		return Objects.equals(cinema, other.cinema);
	}
	@Override
	public String toString() {
		return "Cinema [cinema=" + cinema + ", cityCinema=" + cityCinema + ", managementCinema=" + managementCinema
				+ ", rooms=" + rooms + "]";
	}
	
	
	
	
	

}
