package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_ROAD_PUMP database table.
 * 
 */
@XStreamAlias("PstRoadPump")
public class PstRoadPump extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long prpId;

	private String prpCarNo;

	private String prpColor;

	private String prpDetail;

	private Date prpExpireDate;
	private String prpExpireDate2;

	private String prpInsuranceNo;

	private String prpMachineNo;

	private String prpNo;

	private String prpRegister;

	private String prpTaxDate;

	//bi-directional many-to-one association to PstJobWork
	/*@OneToMany(mappedBy="pstRoadPump")
	private List<PstJobWork> pstJobWorks;*/

	@XStreamAlias("pstBrandRoad")
	private PstBrand pstBrandRoad;

	@XStreamAlias("pstBrandPump")
	private PstBrand pstBrandPump;
	 
	//bi-directional many-to-one association to PstModel
	@XStreamAlias("pstModelRoad")
	private PstModel pstModelRoad;

	//bi-directional many-to-one association to PstModel
	@XStreamAlias("pstModelPump")
	private PstModel pstModelPump;

	//bi-directional many-to-one association to PstRoadPumpStatus
	@XStreamAlias("pstRoadPumpStatus")
	private PstRoadPumpStatus pstRoadPumpStatus;

	//bi-directional many-to-one association to PstRoadPumpType
	@XStreamAlias("pstRoadPumpType")
	private PstRoadPumpType pstRoadPumpType;
	
	private BigDecimal prpCubicAmount;
	private BigDecimal prpMile;
	private BigDecimal prpHoursOfWork;
	private BigDecimal prpDaysOfWork;
	private Timestamp prpCheckMaintenance;
	
	@XStreamAlias("pstBrandRoadList")
	private List<PstBrand> pstBrandRoadList;
	
	@XStreamAlias("pstBrandPumpList")
	private List<PstBrand> pstBrandPumpList;
	
	@XStreamAlias("pstModelRoadList")
	private List<PstBrand> pstModelRoadList;
	
	@XStreamAlias("pstModelPumpList")
	private List<PstBrand> pstModelPumpList;
	
	@XStreamAlias("pstRoadPumpStatusList")
	private List<PstBrand> pstRoadPumpStatusList;
	
	@XStreamAlias("pstRoadPumpTypeList")
	private List<PstBrand> pstRoadPumpTypeList;

	public PstRoadPump() {
	}

 

	public PstRoadPump(Long prpId, String prpCarNo, String prpColor,
			String prpDetail, Date prpExpireDate, String prpInsuranceNo,
			String prpMachineNo, String prpNo, String prpRegister,
			String prpTaxDate, PstBrand pstBrandRoad, PstBrand pstBrandPump,
			PstModel pstModelRoad, PstModel pstModelPump,
			PstRoadPumpStatus pstRoadPumpStatus, PstRoadPumpType pstRoadPumpType) {
		super();
		this.prpId = prpId;
		this.prpCarNo = prpCarNo;
		this.prpColor = prpColor;
		this.prpDetail = prpDetail;
		this.prpExpireDate = prpExpireDate;
		this.prpInsuranceNo = prpInsuranceNo;
		this.prpMachineNo = prpMachineNo;
		this.prpNo = prpNo;
		this.prpRegister = prpRegister;
		this.prpTaxDate = prpTaxDate;
		this.pstBrandRoad = pstBrandRoad;
		this.pstBrandPump = pstBrandPump;
		this.pstModelRoad = pstModelRoad;
		this.pstModelPump = pstModelPump;
		this.pstRoadPumpStatus = pstRoadPumpStatus;
		this.pstRoadPumpType = pstRoadPumpType;
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



	public List<PstBrand> getPstBrandRoadList() {
		return pstBrandRoadList;
	}



	public void setPstBrandRoadList(List<PstBrand> pstBrandRoadList) {
		this.pstBrandRoadList = pstBrandRoadList;
	}



	public List<PstBrand> getPstBrandPumpList() {
		return pstBrandPumpList;
	}



	public void setPstBrandPumpList(List<PstBrand> pstBrandPumpList) {
		this.pstBrandPumpList = pstBrandPumpList;
	}



	public List<PstBrand> getPstModelRoadList() {
		return pstModelRoadList;
	}



	public void setPstModelRoadList(List<PstBrand> pstModelRoadList) {
		this.pstModelRoadList = pstModelRoadList;
	}



	public List<PstBrand> getPstModelPumpList() {
		return pstModelPumpList;
	}



	public void setPstModelPumpList(List<PstBrand> pstModelPumpList) {
		this.pstModelPumpList = pstModelPumpList;
	}



	public List<PstBrand> getPstRoadPumpStatusList() {
		return pstRoadPumpStatusList;
	}



	public void setPstRoadPumpStatusList(List<PstBrand> pstRoadPumpStatusList) {
		this.pstRoadPumpStatusList = pstRoadPumpStatusList;
	}



	public List<PstBrand> getPstRoadPumpTypeList() {
		return pstRoadPumpTypeList;
	}



	public String getPrpExpireDate2() {
		return prpExpireDate2;
	}



	public void setPrpExpireDate2(String prpExpireDate2) {
		this.prpExpireDate2 = prpExpireDate2;
	}



	public void setPstRoadPumpTypeList(List<PstBrand> pstRoadPumpTypeList) {
		this.pstRoadPumpTypeList = pstRoadPumpTypeList;
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