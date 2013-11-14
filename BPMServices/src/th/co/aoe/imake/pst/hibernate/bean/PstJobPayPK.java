package th.co.aoe.imake.pst.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the PST_JOB_PAY database table.
 * 
 */
@Embeddable
public class PstJobPayPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="PJ_ID")
	private Long pjId;

	@Column(name="PC_ID")
	private Long pcId;

	public PstJobPayPK() {
	}
	public Long getPjId() {
		return this.pjId;
	}
	public void setPjId(Long pjId) {
		this.pjId = pjId;
	}
	public Long getPcId() {
		return this.pcId;
	}
	public void setPcId(Long pcId) {
		this.pcId = pcId;
	}

	/*public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof PstJobPayPK)) {
			return false;
		}
		PstJobPayPK castOther = (PstJobPayPK)other;
		return 
			(this.pjId == castOther.pjId)
			&& (this.pcId == castOther.pcId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.pjId;
		hash = hash * prime + this.pcId;
		
		return hash;
	}*/
}