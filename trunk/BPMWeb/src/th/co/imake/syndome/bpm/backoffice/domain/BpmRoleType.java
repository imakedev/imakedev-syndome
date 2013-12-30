package th.co.imake.syndome.bpm.backoffice.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the BPM_ROLE_TYPE database table.
 * 
 */
@Entity
@Table(name="BPM_ROLE_TYPE",schema="SYNDOME_BPM_DB")
public class BpmRoleType implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BPM_ROLE_TYPE_ID")
	private Long bpmRoleTypeId;

	@Column(name="BPM_ROLE_TYPE_DESC")
	private String bpmRoleTypeDesc;

	@Column(name="BPM_ROLE_TYPE_NAME")
	private String bpmRoleTypeName;

	@Column(name="BPM_ROLE_TYPE_ORDER")
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