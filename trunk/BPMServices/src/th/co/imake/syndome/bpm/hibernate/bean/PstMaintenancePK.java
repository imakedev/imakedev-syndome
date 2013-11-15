package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The primary key class for the PST_MAINTENANCE database table.
 * 
 */
@Embeddable
public class PstMaintenancePK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;
	@Column(name="PRP_ID")
	private Long prpId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="PMAINTENANCE_CHECK_TIME")
	private java.util.Date pmaintenanceCheckTime;

	@Column(name="PD_ID")
	private Long pdId;

	@Column(name="PWT_ID")
	private Long pwtId;
	
	 
	public PstMaintenancePK() {
	}


	 

	public Long getPrpId() {
		return prpId;
	}




	public void setPrpId(Long prpId) {
		this.prpId = prpId;
	}




	public java.util.Date getPmaintenanceCheckTime() {
		return pmaintenanceCheckTime;
	}


	public void setPmaintenanceCheckTime(java.util.Date pmaintenanceCheckTime) {
		this.pmaintenanceCheckTime = pmaintenanceCheckTime;
	}


	public Long getPdId() {
		return pdId;
	}


	public void setPdId(Long pdId) {
		this.pdId = pdId;
	}


	public Long getPwtId() {
		return pwtId;
	}


	public void setPwtId(Long pwtId) {
		this.pwtId = pwtId;
	}
	 
}