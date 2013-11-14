package th.co.aoe.imake.pst.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The primary key class for the PST_MAINTENANCE_TRAN database table.
 * 
 */
@Embeddable
public class PstMaintenanceTranPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="PRP_ID")
	private Long prpId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="PMAINTENANCE_CHECK_TIME")
	private java.util.Date pmaintenanceCheckTime;

	@Column(name="PMAINTENANCE_DOC_NO")
	private String pmaintenanceDocNo;

	public PstMaintenanceTranPK() {
	}
	public Long getPrpId() {
		return this.prpId;
	}
	public void setPrpId(Long prpId) {
		this.prpId = prpId;
	}
	public java.util.Date getPmaintenanceCheckTime() {
		return this.pmaintenanceCheckTime;
	}
	public void setPmaintenanceCheckTime(java.util.Date pmaintenanceCheckTime) {
		this.pmaintenanceCheckTime = pmaintenanceCheckTime;
	}
	public String getPmaintenanceDocNo() {
		return this.pmaintenanceDocNo;
	}
	public void setPmaintenanceDocNo(String pmaintenanceDocNo) {
		this.pmaintenanceDocNo = pmaintenanceDocNo;
	}

	 
	 
}