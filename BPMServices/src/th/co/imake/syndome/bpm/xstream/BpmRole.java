package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_ROLE database table.
 * 
 */
@XStreamAlias("BpmRole")
public class BpmRole  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long bpmRoleId;
 
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