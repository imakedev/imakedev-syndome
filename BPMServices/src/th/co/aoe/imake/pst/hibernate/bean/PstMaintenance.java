package th.co.aoe.imake.pst.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


/**
 * The persistent class for the PST_MAINTENANCE database table.
 * 
 */
@Entity
@Table(name="PST_MAINTENANCE",schema="PST_DB")
public class PstMaintenance implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private PstMaintenancePK id;
	@Lob
	@Column(name="PMAINTENANCE_DETAIL")
	private String pmaintenanceDetail;

	@Column(name="PMAINTENANCE_STATUS")
	private String pmaintenanceStatus;
	
	 

	//bi-directional many-to-one association to PstDepartment
	@ManyToOne
	@JoinColumn(name="PD_ID",insertable=false,updatable=false)
	private PstDepartment pstDepartment;
	
	@ManyToOne
	@JoinColumn(name="PRP_ID",insertable=false,updatable=false)
	private PstRoadPump pstRoadPump;


	//bi-directional many-to-one association to PstWorkType
	@ManyToOne
	@JoinColumn(name="PWT_ID",insertable=false,updatable=false)
	private PstWorkType pstWorkType;

	public PstMaintenance() {
	}

	public PstMaintenancePK getId() {
		return this.id;
	}

	public void setId(PstMaintenancePK id) {
		this.id = id;
	}

	 

	public String getPmaintenanceStatus() {
		return this.pmaintenanceStatus;
	}

	public void setPmaintenanceStatus(String pmaintenanceStatus) {
		this.pmaintenanceStatus = pmaintenanceStatus;
	}

	public PstDepartment getPstDepartment() {
		return this.pstDepartment;
	}

	public void setPstDepartment(PstDepartment pstDepartment) {
		this.pstDepartment = pstDepartment;
	}

	public PstWorkType getPstWorkType() {
		return this.pstWorkType;
	}

	public void setPstWorkType(PstWorkType pstWorkType) {
		this.pstWorkType = pstWorkType;
	}

	public String getPmaintenanceDetail() {
		return pmaintenanceDetail;
	}

	public void setPmaintenanceDetail(String pmaintenanceDetail) {
		this.pmaintenanceDetail = pmaintenanceDetail;
	}

}