package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the role_contact database table.
 * 
 */
@Entity
@Table(name="role_contact",schema="SYNDOME_BPM_DB")
public class RoleContact implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="rc_id")
	private Long rcId;

	@Column(name="ma_id")
	private Long maId;

	@Column(name="rc_name")
	private String rcName;

	/*//bi-directional many-to-one association to UserContact
	@OneToMany(mappedBy="roleContact")
	private Set<UserContact> userContacts;*/

	//bi-directional many-to-many association to RoleType
  /*  @ManyToMany
	@JoinTable(
		name="role_mapping"
		, joinColumns={
			@JoinColumn(name="rc_id")
			}
		, inverseJoinColumns={
			@JoinColumn(name="rt_id")
			}
		)*/
	//private Set<RoleType> roleTypes;

    public RoleContact() {
    }

	public Long getRcId() {
		return this.rcId;
	}

	public void setRcId(Long rcId) {
		this.rcId = rcId;
	}

	public Long getMaId() {
		return this.maId;
	}

	public void setMaId(Long maId) {
		this.maId = maId;
	}

	public String getRcName() {
		return this.rcName;
	}

	public void setRcName(String rcName) {
		this.rcName = rcName;
	}

	/*public Set<UserContact> getUserContacts() {
		return this.userContacts;
	}

	public void setUserContacts(Set<UserContact> userContacts) {
		this.userContacts = userContacts;
	}*/
	
/*	public Set<RoleType> getRoleTypes() {
		return this.roleTypes;
	}

	public void setRoleTypes(Set<RoleType> roleTypes) {
		this.roleTypes = roleTypes;
	}*/
	
}