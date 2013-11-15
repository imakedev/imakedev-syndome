package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the PST_JOB_PAY_EXT database table.
 * 
 */
@Embeddable
public class PstJobPayExtPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="PJ_ID")
	private Long pjId;

	@Column(name="PJPE_NO")
	private Long pjpeNo;

	public PstJobPayExtPK() {
	}
	public Long getPjId() {
		return this.pjId;
	}
	public void setPjId(Long pjId) {
		this.pjId = pjId;
	}
	public Long getPjpeNo() {
		return this.pjpeNo;
	}
	public void setPjpeNo(Long pjpeNo) {
		this.pjpeNo = pjpeNo;
	}

	/*public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof PstJobPayExtPK)) {
			return false;
		}
		PstJobPayExtPK castOther = (PstJobPayExtPK)other;
		return 
			(this.pjId == castOther.pjId)
			&& (this.pjpeNo == castOther.pjpeNo);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.pjId;
		hash = hash * prime + this.pjpeNo;
		
		return hash;
	}*/
}