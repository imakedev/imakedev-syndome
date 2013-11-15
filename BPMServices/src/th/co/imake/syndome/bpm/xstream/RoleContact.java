package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the role_contact database table.
 * 
 */
@XStreamAlias("RoleContact")
public class RoleContact extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
	private Long rcId;

	private Long maId;

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