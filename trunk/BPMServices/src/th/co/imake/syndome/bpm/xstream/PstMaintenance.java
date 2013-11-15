package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_MAINTENANCE database table.
 * 
 */
@XStreamAlias("PstMaintenance")
public class PstMaintenance extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
	 
	private Long prpId; 
	private java.util.Date pmaintenanceCheckTime; 
	private Long pdId; 
	private Long pwtId;  
	
	
	private String pmaintenanceStatus; 
	private String pmaintenanceDetail;
 
	
	//bi-directional many-to-one association to PstDepartment
	@XStreamAlias("pstDepartment")
	private PstDepartment pstDepartment;

	//bi-directional many-to-one association to PstWorkType
	@XStreamAlias("pstWorkType")
	private PstWorkType pstWorkType;
	
	@XStreamAlias("pstRoadPump")
	private PstRoadPump pstRoadPump;

	public PstMaintenance() {
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

	public String getPmaintenanceStatus() {
		return pmaintenanceStatus;
	}

	public void setPmaintenanceStatus(String pmaintenanceStatus) {
		this.pmaintenanceStatus = pmaintenanceStatus;
	}

	public String getPmaintenanceDetail() {
		return pmaintenanceDetail;
	}

	public void setPmaintenanceDetail(String pmaintenanceDetail) {
		this.pmaintenanceDetail = pmaintenanceDetail;
	}

	public PstDepartment getPstDepartment() {
		return pstDepartment;
	}

	public void setPstDepartment(PstDepartment pstDepartment) {
		this.pstDepartment = pstDepartment;
	}

	public PstWorkType getPstWorkType() {
		return pstWorkType;
	}

	public void setPstWorkType(PstWorkType pstWorkType) {
		this.pstWorkType = pstWorkType;
	}

	public PstRoadPump getPstRoadPump() {
		return pstRoadPump;
	}

	public void setPstRoadPump(PstRoadPump pstRoadPump) {
		this.pstRoadPump = pstRoadPump;
	}

	 

	 

}