package com.cinema.model;

import java.sql.Date;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="Entrada")
public class Ticket {
	
	 static private int autoIncrementId = 0;
	
	 @ManyToOne
	 @JoinColumns({@JoinColumn(name="cine"),@JoinColumn(name="sala"),@JoinColumn(name="cip"),@JoinColumn(name="fecha_estreno")})
	 private Projection projection;
	 
	 @ManyToOne
	 @JoinColumn(name="usuario")
	 private User user;
	 
	 @Id
	 @Column(name="idEntrada")
	 private int id;
	 @Column(name="fecha_compra")
	 private Date buyDate;
	 
	//Constructores
	//Constructor con todos los campos
	public Ticket(Projection projection, User user, Date buyDate) {
		super();
		this.projection = projection;
		this.user = user;
		this.id = autoIncrementId++;
		this.buyDate = buyDate;
	}
	//Constructor con solo las pk y fk
	public Ticket(Projection projection, User user) {
		super();
		this.projection = projection;
		this.user = user;
		this.id = autoIncrementId++;
	}
	//Constructor vacio
	public Ticket() {
		super();
	}
	
	//Getters y setters
	public Projection getProjection() {
		return projection;
	}
	public void setProjection(Projection projection) {
		this.projection = projection;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public int getId() {
		return id;
	}
	public Date getBuyDate() {
		return buyDate;
	}
	public void setBuyDate(Date buyDate) {
		this.buyDate = buyDate;
	}
	
	//HasCode and equals with only the pk's and the fk's
	@Override
	public int hashCode() {
		return Objects.hash(id, projection, user);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Ticket other = (Ticket) obj;
		return id == other.id && Objects.equals(projection, other.projection) && Objects.equals(user, other.user);
	}
	 
}
