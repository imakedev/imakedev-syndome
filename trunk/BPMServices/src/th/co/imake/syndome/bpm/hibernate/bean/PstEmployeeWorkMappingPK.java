package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The primary key class for the PST_EMPLOYEE_WORK_MAPPING database table.
 * 
 */
@Embeddable
public class PstEmployeeWorkMappingPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="PE_ID")
	private Long peId;

	

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="PEWM_DATE_TIME")
	private java.util.Date pewmDateTime;

	public PstEmployeeWorkMappingPK() {
	}
	public Long getPeId() {
		return this.peId;
	}
	public void setPeId(Long peId) {
		this.peId = peId;
	}
	 
	public java.util.Date getPewmDateTime() {
		return this.pewmDateTime;
	}
	public void setPewmDateTime(java.util.Date pewmDateTime) {
		this.pewmDateTime = pewmDateTime;
	}
	public PstEmployeeWorkMappingPK(Long peId, 
			Date pewmDateTime) {
		super();
		this.peId = peId;
	 
		this.pewmDateTime = pewmDateTime;
	}

/*	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof PstEmployeeWorkMappingPK)) {
			return false;
		}
		PstEmployeeWorkMappingPK castOther = (PstEmployeeWorkMappingPK)other;
		return 
			(this.peId == castOther.peId)
			&& (this.pesId == castOther.pesId)
			&& this.prpNo.equals(castOther.prpNo)
			&& this.pewmDateTime.equals(castOther.pewmDateTime);
	}*/

	/*public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.peId;
		hash = hash * prime + this.pesId;
		hash = hash * prime + this.prpNo.hashCode();
		hash = hash * prime + this.pewmDateTime.hashCode();
		
		return hash;
	}*/
}