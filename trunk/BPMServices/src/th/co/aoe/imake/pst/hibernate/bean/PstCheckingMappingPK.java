package th.co.aoe.imake.pst.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the PST_CHECKING_MAPPING database table.
 * 
 */
@Embeddable
public class PstCheckingMappingPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="PCM_TYPE")
	private String pcmType;

	@Column(name="PCM_REF_TYPE_NO")
	private Long pcmRefTypeNo;

	@Column(name="PD_ID")
	private Long pdId;

	@Column(name="PWT_ID")
	private Long pwtId;

	public PstCheckingMappingPK() {
	}
	public String getPcmType() {
		return this.pcmType;
	}
	public void setPcmType(String pcmType) {
		this.pcmType = pcmType;
	}
	public Long getPcmRefTypeNo() {
		return this.pcmRefTypeNo;
	}
	public void setPcmRefTypeNo(Long pcmRefTypeNo) {
		this.pcmRefTypeNo = pcmRefTypeNo;
	}
	public Long getPdId() {
		return this.pdId;
	}
	public void setPdId(Long pdId) {
		this.pdId = pdId;
	}
	public Long getPwtId() {
		return this.pwtId;
	}
	public void setPwtId(Long pwtId) {
		this.pwtId = pwtId;
	}

	/*public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof PstCheckingMappingPK)) {
			return false;
		}
		PstCheckingMappingPK castOther = (PstCheckingMappingPK)other;
		return 
			this.pcmType.equals(castOther.pcmType)
			&& (this.pcmRefTypeNo == castOther.pcmRefTypeNo)
			&& (this.pdId == castOther.pdId)
			&& (this.pwtId == castOther.pwtId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.pcmType.hashCode();
		hash = hash * prime + this.pcmRefTypeNo;
		hash = hash * prime + this.pdId;
		hash = hash * prime + this.pwtId;
		
		return hash;
	}*/
}