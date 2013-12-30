package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;
import javax.persistence.*;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the role database table.
 * 
 */
@XStreamAlias("Role")
public class Role  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	 
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