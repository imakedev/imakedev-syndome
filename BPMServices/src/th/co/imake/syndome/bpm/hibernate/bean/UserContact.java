package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;


/**
 * The persistent class for the user_contact database table.
 * 
 */
@Entity
@Table(name="user_contact",schema="SYNDOME_BPM_DB")
public class UserContact implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;

	private int enabled;

	private String firstName;

	private String lastName;

	@Column(name="MCONTACT_USERNAME")
	private String mcontactUsername;
	
	@Column(name="MCONTACT_ID")
	private Long mcontactId;
	private String password;

	private String type;
	
	 @Column(unique=true)
	private String username;

	//bi-directional many-to-one association to RoleContact
    @OneToOne
	@JoinColumn(name="rc_id")
	private RoleContact roleContact;

    public UserContact() {
    }

	public Long getId() {
		return this.id;
	}

	public Long getMcontactId() {
		return mcontactId;
	}

	public void setMcontactId(Long mcontactId) {
		this.mcontactId = mcontactId;
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