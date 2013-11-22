package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the BPM_APPLICATION_LOG database table.
 * 
 */
@Embeddable
public class BpmApplicationLogPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="BAL_ID")
	private Long balId;

	@Column(name="BAL_TYPE")
	private Long balType;

	@Column(name="BAL_REF")
	private Long balRef;

	public BpmApplicationLogPK() {
	}
	public Long getBalId() {
		return this.balId;
	}
	public void setBalId(Long balId) {
		this.balId = balId;
	}
	public Long getBalType() {
		return this.balType;
	}
	public void setBalType(Long balType) {
		this.balType = balType;
	}
	public Long getBalRef() {
		return this.balRef;
	}
	public void setBalRef(Long balRef) {
		this.balRef = balRef;
	}

	 
	 
}