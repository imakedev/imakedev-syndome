package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the BPM_ROLE database table.
 * 
 */
@Entity
@Table(name="BPM_ROLE",schema="SYNDOME_BPM_DB")
public class BpmRole implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BPM_ROLE_ID")
	private Long bpmRoleId;

	@Column(name="BPM_ROLE_NAME")
	private String bpmRoleName;
	/*
	//bi-directional many-to-many association to BpmRoleType
	@ManyToMany(mappedBy="bpmRoles")
	private List<BpmRoleType> bpmRoleTypes;

	
	//bi-directional many-to-one association to User
	@OneToMany(mappedBy="bpmRole")
	private List<User> users;
*/
	public BpmRole() {
	}

	public Long getBpmRoleId() {
		return this.bpmRoleId;
	}

	public void setBpmRoleId(Long bpmRoleId) {
		this.bpmRoleId = bpmRoleId;
	}

	public String getBpmRoleName() {
		return this.bpmRoleName;
	}

	public void setBpmRoleName(String bpmRoleName) {
		this.bpmRoleName = bpmRoleName;
	}
}