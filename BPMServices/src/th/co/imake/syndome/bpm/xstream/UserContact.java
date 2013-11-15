package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the user_contact database table.
 * 
 */
@XStreamAlias("UserContact")
public class UserContact extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long id;

	private int enabled;

	private String firstName;

	private String lastName;

	private String mcontactUsername;
	private Long mcontactId;

	private String password;

	private String type;
	
	private String username;

	@XStreamAlias("roleContact")
	private RoleContact roleContact;

    public UserContact() {
    }

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getEnabled() {
		return this.enabled;
	}

	public void setEnabled(int enabled) {
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

	public String getMcontactUsername() {
		return this.mcontactUsername;
	}

	public void setMcontactUsername(String mcontactUsername) {
		this.mcontactUsername = mcontactUsername;
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

	public Long getMcontactId() {
		return mcontactId;
	}

	public void setMcontactId(Long mcontactId) {
		this.mcontactId = mcontactId;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public RoleContact getRoleContact() {
		return this.roleContact;
	}

	public void setRoleContact(RoleContact roleContact) {
		this.roleContact = roleContact;
	}
	
}