package th.co.aoe.imake.pst.backoffice.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the MISS_SERIES_MAP database table.
 * 
 */
@Embeddable
public class RoleMappingPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="rc_id")
	private Long rcId; 

	@Column(name="rt_id")
	private Long rtId;
 
	
    public RoleMappingPK() {
    }


	public Long getRcId() {
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
	}
	
}