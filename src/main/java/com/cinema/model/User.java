package com.cinema.model;

import java.util.List;
import java.util.Objects;

import org.apache.commons.codec.digest.DigestUtils;

import com.cinema.repository.TicketRepository;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="Usuario")
public class User {
	@Id
	@Column(name="usuario")
	private String username;
	private String email;
	private String password;
	@Column(name="nombre")
	private String name;
	@Column(name="apellidos")
	private String surnames;
	private String role;
	
	@OneToMany(mappedBy = "user")
	private List<Ticket> tickets;
	
	public User(String username, String email, String password, String name, String surnames, String role) {
		super();
		this.username = username;
		this.email = email;
		this.password = DigestUtils.md5Hex(password);
		this.name = name;
		this.surnames = surnames;
		this.role = role;
	}

	public User() {
		super();
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = DigestUtils.md5Hex(password);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurnames() {
		return surnames;
	}

	public void setSurnames(String surnames) {
		this.surnames = surnames;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public List<Object[]> getTickets() throws Exception {
		return TicketRepository.getTickets(this.username);
	}

	public void setTickets(List<Ticket> tickets) {
		this.tickets = tickets;
	}

	@Override
	public int hashCode() {
		return Objects.hash(username);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return Objects.equals(username, other.username);
	}
	
}
