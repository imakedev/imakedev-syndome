package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_ROLE_TYPE database table.
 * 
 */
@XStreamAlias("BpmRoleType")
public class BpmRoleType  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long bpmRoleTypeId;
 
	private String bpmRoleTypeDesc;
 
	private String bpmRoleTypeName; 
	
	private Long bpmRoleTypeOrder;
/*
	//bi-directional many-to-many association to BpmRole
	@ManyToMany
	@JoinTable(
		name="BPM_ROLE_MAPPING"
		, joinColumns={
			@JoinColumn(name="BPM_ROLE_TYPE_ID")
			}
		, inverseJoinColumns={
			@JoinColumn(name="BPM_ROLE_ID")
			}
		)
	private List<BpmRole> bpmRoles;
*/
	public BpmRoleType() {
	}

	public Long getBpmRoleTypeId() {
		return this.bpmRoleTypeId;
	}

	public void setBpmRoleTypeId(Long bpmRoleTypeId) {
		this.bpmRoleTypeId = bpmRoleTypeId;
	}

	public String getBpmRoleTypeDesc() {
		return this.bpmRoleTypeDesc;
	}

	public void setBpmRoleTypeDesc(String bpmRoleTypeDesc) {
		this.bpmRoleTypeDesc = bpmRoleTypeDesc;
	}

	public String getBpmRoleTypeName() {
		return this.bpmRoleTypeName;
	}

	public void setBpmRoleTypeName(String bpmRoleTypeName) {
		this.bpmRoleTypeName = bpmRoleTypeName;
	}

	public Long getBpmRoleTypeOrder() {
		return this.bpmRoleTypeOrder;
	}

	public void setBpmRoleTypeOrder(Long bpmRoleTypeOrder) {
		this.bpmRoleTypeOrder = bpmRoleTypeOrder;
	}

//	


}