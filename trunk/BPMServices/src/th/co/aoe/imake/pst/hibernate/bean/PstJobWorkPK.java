package th.co.aoe.imake.pst.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the PST_JOB_WORK database table.
 * 
 */
@Embeddable
public class PstJobWorkPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="PJ_ID")
	private Long pjId;

	@Column(name="PRP_ID")
	private Long prpId;

	

	public PstJobWorkPK() {
	}
	public Long getPjId() {
		return this.pjId;
	}
	public void setPjId(Long pjId) {
		this.pjId = pjId;
	}
	public Long getPrpId() {
		return this.prpId;
	}
	public void setPrpId(Long prpId) {
		this.prpId = prpId;
	}
	/*public Long getPbdId() {
		return this.pbdId;
	}
	public void setPbdId(Long pbdId) {
		this.pbdId = pbdId;
	}*/

	/*public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof PstJobWorkPK)) {
			return false;
		}
		PstJobWorkPK castOther = (PstJobWorkPK)other;
		return 
			(this.pjId == castOther.pjId)
			&& (this.prpId == castOther.prpId)
			&& (this.pbdId == castOther.pbdId);
	}*/

	/*public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.pjId;
		hash = hash * prime + this.prpId;
		hash = hash * prime + this.pbdId;
		
		return hash;
	}*/
}