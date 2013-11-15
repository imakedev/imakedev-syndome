package th.co.imake.syndome.bpm.backoffice.form;

import java.io.Serializable;

public class RoleForm extends CommonForm implements Serializable {
	private static final long serialVersionUID = 1L;
	private Long rcId;
	private String rcActionId;
	
	private String roleName;
	//private Long roleId;
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	/*public Long getRoleId() {
		return roleId;
	}
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}*/
	public Long getRcId() {
		return rcId;
	}
	public void setRcId(Long rcId) {
		this.rcId = rcId;
	}
	public String getRcActionId() {
		return rcActionId;
	}
	public void setRcActionId(String rcActionId) {
		this.rcActionId = rcActionId;
	}
}
