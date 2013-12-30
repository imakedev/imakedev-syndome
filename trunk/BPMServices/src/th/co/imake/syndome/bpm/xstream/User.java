package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the user database table.
 * 
 */
@XStreamAlias("User")
public class User  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

 
	private String id;

	private byte enabled;

	private String firstName;

	private String lastName;

	private String password;

	private String type;

	private String username;

	//bi-directional many-to-one association to Role
	/*@OneToMany(mappedBy="user")
	private List<Role> roles;
*/
	//bi-directional many-to-one association to BpmRole
	@ManyToOne
	@JoinColumn(name="BPM_ROLE_ID")
	private BpmRole bpmRole;

	public User() {
	}

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public byte getEnabled() {
		return this.enabled;
	}

	public void setEnabled(byte enabled) {
		this.enabled = enabled;
	}

	public String getFirstName() {
		return this.firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return this.lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	/*public List<Role> getRoles() {
		return this.roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}*/

	/*public Role addRole(Role role) {
		getRoles().add(role);
		role.setUser(this);

		return role;
	}

	public Role removeRole(Role role) {
		getRoles().remove(role);
		role.setUser(null);

		return role;
	}*/

	public BpmRole getBpmRole() {
		return this.bpmRole;
	}

	public void setBpmRole(BpmRole bpmRole) {
		this.bpmRole = bpmRole;
	}

}