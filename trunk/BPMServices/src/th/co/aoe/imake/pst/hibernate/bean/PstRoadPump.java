package th.co.aoe.imake.pst.hibernate.bean;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the PST_ROAD_PUMP database table.
 * 
 */
@Entity
@Table(name="PST_ROAD_PUMP",schema="PST_DB")
public class PstRoadPump implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PRP_ID")
	private Long prpId;

	@Column(name="PRP_CAR_NO")
	private String prpCarNo;

	@Column(name="PRP_COLOR")
	private String prpColor;

	@Column(name="PRP_DETAIL")
	private String prpDetail;

	@Temporal(TemporalType.DATE)
	@Column(name="PRP_EXPIRE_DATE")
	private Date prpExpireDate; 
	
	@Column(name="PRP_EXPIRE_DATE2")
	private String prpExpireDate2;

	@Column(name="PRP_INSURANCE_NO")
	private String prpInsuranceNo;

	@Column(name="PRP_MACHINE_NO")
	private String prpMachineNo;

	@Column(name="PRP_NO")
	private String prpNo;

	@Column(name="PRP_REGISTER")
	private String prpRegister;

	@Column(name="PRP_TAX_DATE")
	private String prpTaxDate;

	//bi-directional many-to-one association to PstJobWork
	/*@OneToMany(mappedBy="pstRoadPump")
	private List<PstJobWork> pstJobWorks;*/

	//bi-directional many-to-one association to PstBrand
	@ManyToOne
	@JoinColumn(name="PB_ROAD_BRAND")
	private PstBrand pstBrandRoad;

	@ManyToOne
	@JoinColumn(name="PM_PUMP_BRAND")
	private PstBrand pstBrandPump;
	//bi-directional many-to-one association to PstBrand
/*	@ManyToOne
	@JoinColumn(name="PM_PUMP_MODEL",insertable=false,updatable=false)
	private PstBrand pstModelPump;*/

	//bi-directional many-to-one association to PstBrand
	

	//bi-directional many-to-one association to PstModel
	@ManyToOne
	@JoinColumn(name="PM_ROAD_MODEL")
	private PstModel pstModelRoad;

	//bi-directional many-to-one association to PstModel
	@ManyToOne
	@JoinColumn(name="PM_PUMP_MODEL")
	private PstModel pstModelPump;

	//bi-directional many-to-one association to PstRoadPumpStatus
	@ManyToOne
	@JoinColumn(name="PRPS_ID")
	private PstRoadPumpStatus pstRoadPumpStatus;

	//bi-directional many-to-one association to PstRoadPumpType
	@ManyToOne
	@JoinColumn(name="PRPT_ID")
	private PstRoadPumpType pstRoadPumpType;
 
	
	@Column(name="PRP_CUBIC_AMOUNT")
	private BigDecimal prpCubicAmount;
	@Column(name="PRP_MILE")
	private BigDecimal prpMile;
	@Column(name="PRP_HOURS_OF_WORK")
	private BigDecimal prpHoursOfWork;
	@Column(name="PRP_DAYS_OF_WORK")
	private BigDecimal prpDaysOfWork;
	@Column(name="PRP_CHECK_MAINTENANCE")
	private Timestamp prpCheckMaintenance;

	public PstRoadPump() {
	}

	public Long getPrpId() {
		return this.prpId;
	}

	public void setPrpId(Long prpId) {
		this.prpId = prpId;
	}

	public String getPrpCarNo() {
		return this.prpCarNo;
	}

	public void setPrpCarNo(String prpCarNo) {
		this.prpCarNo = prpCarNo;
	}

	public String getPrpColor() {
		return this.prpColor;
	}

	public void setPrpColor(String prpColor) {
		this.prpColor = prpColor;
	}

	public String getPrpDetail() {
		return this.prpDetail;
	}

	public void setPrpDetail(String prpDetail) {
		this.prpDetail = prpDetail;
	}

	public Date getPrpExpireDate() {
		return this.prpExpireDate;
	}

	public void setPrpExpireDate(Date prpExpireDate) {
		this.prpExpireDate = prpExpireDate;
	}

	public String getPrpInsuranceNo() {
		return this.prpInsuranceNo;
	}

	public void setPrpInsuranceNo(String prpInsuranceNo) {
		this.prpInsuranceNo = prpInsuranceNo;
	}

	public String getPrpMachineNo() {
		return this.prpMachineNo;
	}

	public void setPrpMachineNo(String prpMachineNo) {
		this.prpMachineNo = prpMachineNo;
	}

	public String getPrpNo() {
		return this.prpNo;
	}

	public void setPrpNo(String prpNo) {
		this.prpNo = prpNo;
	}

	public String getPrpRegister() {
		return this.prpRegister;
	}

	public void setPrpRegister(String prpRegister) {
		this.prpRegister = prpRegister;
	}

	public String getPrpTaxDate() {
		return this.prpTaxDate;
	}

	public void setPrpTaxDate(String prpTaxDate) {
		this.prpTaxDate = prpTaxDate;
	}

	/*public List<PstJobWork> getPstJobWorks() {
		return this.pstJobWorks;
	}

	public void setPstJobWorks(List<PstJobWork> pstJobWorks) {
		this.pstJobWorks = pstJobWorks;
	}
*/
	 
	public PstRoadPumpStatus getPstRoadPumpStatus() {
		return this.pstRoadPumpStatus;
	}

	public PstBrand getPstBrandRoad() {
		return pstBrandRoad;
	}

	public void setPstBrandRoad(PstBrand pstBrandRoad) {
		this.pstBrandRoad = pstBrandRoad;
	}

	public PstBrand getPstBrandPump() {
		return pstBrandPump;
	}

	public void setPstBrandPump(PstBrand pstBrandPump) {
		this.pstBrandPump = pstBrandPump;
	}

	public PstModel getPstModelRoad() {
		return pstModelRoad;
	}

	public void setPstModelRoad(PstModel pstModelRoad) {
		this.pstModelRoad = pstModelRoad;
	}

	public PstModel getPstModelPump() {
		return pstModelPump;
	}

	public void setPstModelPump(PstModel pstModelPump) {
		this.pstModelPump = pstModelPump;
	}

	public void setPstRoadPumpStatus(PstRoadPumpStatus pstRoadPumpStatus) {
		this.pstRoadPumpStatus = pstRoadPumpStatus;
	}

	public PstRoadPumpType getPstRoadPumpType() {
		return this.pstRoadPumpType;
	}

	public void setPstRoadPumpType(PstRoadPumpType pstRoadPumpType) {
		this.pstRoadPumpType = pstRoadPumpType;
	}

	public String getPrpExpireDate2() {
		return prpExpireDate2;
	}

	public void setPrpExpireDate2(String prpExpireDate2) {
		this.prpExpireDate2 = prpExpireDate2;
	}

	public BigDecimal getPrpMile() {
		return prpMile;
	}

	public void setPrpMile(BigDecimal prpMile) {
		this.prpMile = prpMile;
	}

	public BigDecimal getPrpCubicAmount() {
		return prpCubicAmount;
	}

	public void setPrpCubicAmount(BigDecimal prpCubicAmount) {
		this.prpCubicAmount = prpCubicAmount;
	}

	public BigDecimal getPrpHoursOfWork() {
		return prpHoursOfWork;
	}

	public void setPrpHoursOfWork(BigDecimal prpHoursOfWork) {
		this.prpHoursOfWork = prpHoursOfWork;
	}

	public BigDecimal getPrpDaysOfWork() {
		return prpDaysOfWork;
	}

	public void setPrpDaysOfWork(BigDecimal prpDaysOfWork) {
		this.prpDaysOfWork = prpDaysOfWork;
	}

	public Timestamp getPrpCheckMaintenance() {
		return prpCheckMaintenance;
	}

	public void setPrpCheckMaintenance(Timestamp prpCheckMaintenance) {
		this.prpCheckMaintenance = prpCheckMaintenance;
	}

}