package th.co.aoe.imake.pst.backoffice.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the role_type database table.
 * 
 */
@Entity
@Table(name="role_type")
public class RoleType implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="rt_id")
	private Long rtId;

	private String role;

	@Column(name="role_desc")
	private String roleDesc;
	
	@Column(name="type")
	private String type;
	
	@Column(name="order")
	private int order;

	/*//bi-directional many-to-many association to RoleContact
	@ManyToMany(mappedBy="roleTypes")
	private Set<RoleContact> roleContacts;*/

    public RoleType() {
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