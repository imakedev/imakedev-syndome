package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;
import java.math.BigDecimal;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_MAINTENANCE_TRAN database table.
 * 
 */
@XStreamAlias("PstMaintenanceTran")
public class PstMaintenanceTran implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long prpId; 
	private java.util.Date pmaintenanceCheckTime; 
	private String pmaintenanceDocNo; 
	
	private BigDecimal pmaintenanceCubicAmount; 
	private BigDecimal pmaintenanceCubicAmountOld; 
	private BigDecimal pmaintenanceDaysOfWork; 
	private BigDecimal pmaintenanceDaysOfWorkOld; 
	private BigDecimal pmaintenanceHoursOfWork; 
	private BigDecimal pmaintenanceHoursOfWorkOld; 
	private BigDecimal pmaintenanceMile; 
	private BigDecimal pmaintenanceMileOld;
	
	//ext
	private String pmaintenanceCheckTimeOldStr;
	private String pmaintenanceCheckTimeStr; 
	
	@XStreamAlias("pstRoadPump")
	private PstRoadPump pstRoadPump;


	public PstMaintenanceTran() {
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


	public String getPmaintenanceDocNo() {
		return pmaintenanceDocNo;
	}


	public void setPmaintenanceDocNo(String pmaintenanceDocNo) {
		this.pmaintenanceDocNo = pmaintenanceDocNo;
	}


	public BigDecimal getPmaintenanceCubicAmount() {
		return pmaintenanceCubicAmount;
	}


	public void setPmaintenanceCubicAmount(BigDecimal pmaintenanceCubicAmount) {
		this.pmaintenanceCubicAmount = pmaintenanceCubicAmount;
	}


	public BigDecimal getPmaintenanceCubicAmountOld() {
		return pmaintenanceCubicAmountOld;
	}


	public void setPmaintenanceCubicAmountOld(BigDecimal pmaintenanceCubicAmountOld) {
		this.pmaintenanceCubicAmountOld = pmaintenanceCubicAmountOld;
	}


	public BigDecimal getPmaintenanceDaysOfWork() {
		return pmaintenanceDaysOfWork;
	}


	public void setPmaintenanceDaysOfWork(BigDecimal pmaintenanceDaysOfWork) {
		this.pmaintenanceDaysOfWork = pmaintenanceDaysOfWork;
	}


	public BigDecimal getPmaintenanceDaysOfWorkOld() {
		return pmaintenanceDaysOfWorkOld;
	}


	public void setPmaintenanceDaysOfWorkOld(BigDecimal pmaintenanceDaysOfWorkOld) {
		this.pmaintenanceDaysOfWorkOld = pmaintenanceDaysOfWorkOld;
	}


	public BigDecimal getPmaintenanceHoursOfWork() {
		return pmaintenanceHoursOfWork;
	}


	public void setPmaintenanceHoursOfWork(BigDecimal pmaintenanceHoursOfWork) {
		this.pmaintenanceHoursOfWork = pmaintenanceHoursOfWork;
	}


	public BigDecimal getPmaintenanceHoursOfWorkOld() {
		return pmaintenanceHoursOfWorkOld;
	}


	public void setPmaintenanceHoursOfWorkOld(BigDecimal pmaintenanceHoursOfWorkOld) {
		this.pmaintenanceHoursOfWorkOld = pmaintenanceHoursOfWorkOld;
	}


	public BigDecimal getPmaintenanceMile() {
		return pmaintenanceMile;
	}


	public void setPmaintenanceMile(BigDecimal pmaintenanceMile) {
		this.pmaintenanceMile = pmaintenanceMile;
	}


	public BigDecimal getPmaintenanceMileOld() {
		return pmaintenanceMileOld;
	}


	public void setPmaintenanceMileOld(BigDecimal pmaintenanceMileOld) {
		this.pmaintenanceMileOld = pmaintenanceMileOld;
	}


	public PstRoadPump getPstRoadPump() {
		return pstRoadPump;
	}


	public void setPstRoadPump(PstRoadPump pstRoadPump) {
		this.pstRoadPump = pstRoadPump;
	}


	public String getPmaintenanceCheckTimeStr() {
		return pmaintenanceCheckTimeStr;
	}


	public void setPmaintenanceCheckTimeStr(String pmaintenanceCheckTimeStr) {
		this.pmaintenanceCheckTimeStr = pmaintenanceCheckTimeStr;
	}


	public String getPmaintenanceCheckTimeOldStr() {
		return pmaintenanceCheckTimeOldStr;
	}


	public void setPmaintenanceCheckTimeOldStr(String pmaintenanceCheckTimeOldStr) {
		this.pmaintenanceCheckTimeOldStr = pmaintenanceCheckTimeOldStr;
	}

	 
}