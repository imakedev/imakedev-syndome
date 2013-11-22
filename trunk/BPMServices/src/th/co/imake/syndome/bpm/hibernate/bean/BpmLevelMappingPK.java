package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the BPM_LEVEL_MAPPING database table.
 * 
 */
@Embeddable
public class BpmLevelMappingPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="BL_ID")
	private Long blId;

	@Column(name="BL_USERID")
	private Long blUserid;

	public BpmLevelMappingPK() {
	}
	public Long getBlId() {
		return this.blId;
	}
	public void setBlId(Long blId) {
		this.blId = blId;
	}
	public Long getBlUserid() {
		return this.blUserid;
	}
	public void setBlUserid(Long blUserid) {
		this.blUserid = blUserid;
	}

 
	 
}