package th.co.imake.syndome.bpm.backoffice.domain;

import java.io.Serializable;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="role_mapping")
public class RoleMapping  implements Serializable {
	private static final long serialVersionUID = 1L;
	/*@Column(name="rc_id")
	private Long rcId; 

	@Column(name="rt_id")
	private Long rtId;*/
	@EmbeddedId
	private RoleMappingPK id;
	public RoleMappingPK getId() {
		return id;
	}
	public void setId(RoleMappingPK id) {
		this.id = id;
	}

	/*public Long getRcId() {
		return rcId;
	}

	public void setRcId(Long rcId) {
		this.rcId = rcId;
	}

	public Long getRtId() {
		return rtId;
	}

	public void setRtId(Long rtId) {
		this.rtId = rtId;
	}*/
	
	
}
