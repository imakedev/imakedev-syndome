package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the role_type database table.
 * 
 */
@XStreamAlias("RoleType")
public class RoleType extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long rtId;

	private String role;

	private String roleDesc;
	private String type;
	private int order;
	//ext
	private Long rcId;
	private String selected;
	private Long maId;
	/*//bi-directional many-to-many association to RoleContact
	@ManyToMany(mappedBy="roleTypes")
	private Set<RoleContact> roleContacts;*/

    public RoleType() {
    	
    }

	public Long getMaId() {
		return maId;
	}

	public void setMaId(Long maId) {
		this.maId = maId;
	}

	public Long getRtId() {
		return this.rtId;
	}

	public void setRtId(Long rtId) {
		this.rtId = rtId;
	}

	public String getRole() {
		return this.role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getRoleDesc() {
		return this.roleDesc;
	}

	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
	}

	public Long getRcId() {
		return rcId;
	}

	public void setRcId(Long rcId) {
		this.rcId = rcId;
	}

	public String getSelected() {
		return selected;
	}

	public void setSelected(String selected) {
		this.selected = selected;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
	}

	/*public Set<RoleContact> getRoleContacts() {
		return this.roleContacts;
	}

	public void setRoleContacts(Set<RoleContact> roleContacts) {
		this.roleContacts = roleContacts;
	}*/
	
}