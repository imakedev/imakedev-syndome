package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the role database table.
 * 
 */
@Entity
@Table(name="role",schema="SYNDOME_BPM_DB")
public class Role implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private String id;

	private int role;

	//bi-directional many-to-one association to User
	@ManyToOne
	private User user;

	public Role() {
	}

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getRole() {
		return this.role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}