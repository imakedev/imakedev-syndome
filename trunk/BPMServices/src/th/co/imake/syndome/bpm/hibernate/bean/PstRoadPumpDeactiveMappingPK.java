package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the PST_ROAD_PUMP_DEACTIVE_MAPPING database table.
 * 
 */
@Embeddable
public class PstRoadPumpDeactiveMappingPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="PRP_ID")
	private Long prpId;

	@Column(name="PWT_ID")
	private Long pwtId;

	@Column(name="PD_ID")
	private Long pdId;

	public PstRoadPumpDeactiveMappingPK() {
	}
	
	public PstRoadPumpDeactiveMappingPK(Long prpId, Long pwtId, Long pdId) {
		super();
		this.prpId = prpId;
		this.pwtId = pwtId;
		this.pdId = pdId;
	}

	public Long getPrpId() {
		return this.prpId;
	}
	public void setPrpId(Long prpId) {
		this.prpId = prpId;
	}
	public Long getPwtId() {
		return this.pwtId;
	}
	public void setPwtId(Long pwtId) {
		this.pwtId = pwtId;
	}
	public Long getPdId() {
		return this.pdId;
	}
	public void setPdId(Long pdId) {
		this.pdId = pdId;
	}

	/*public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof PstRoadPumpDeactiveMappingPK)) {
			return false;
		}
		PstRoadPumpDeactiveMappingPK castOther = (PstRoadPumpDeactiveMappingPK)other;
		return 
			(this.prpId == castOther.prpId)
			&& (this.pwtId == castOther.pwtId)
			&& (this.pdId == castOther.pdId);
	}
*/
	/*public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.prpId;
		hash = hash * prime + this.pwtId;
		hash = hash * prime + this.pdId;
		
		return hash;
	}*/
}