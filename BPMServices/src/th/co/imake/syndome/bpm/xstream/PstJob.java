package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_JOB database table.
 * 
 */
@XStreamAlias("PstJob")
public class PstJob  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;


	private Long pjId;

	private String pjContractMobileNo;

	private String pjContractName;

	private Date pjCreatedTime;

	private String pjCustomerDepartment;

	private String pjCustomerName;

	private String pjCustomerNo;

	private String pjJobNo;
	private String pjRemark;
	
	private Date pjUpdatedTime;
	private BigDecimal pjCubicAmount;

	//bi-directional many-to-one association to PstConcrete
	@XStreamAlias("pstConcrete")
	private PstConcrete pstConcrete;
	
	@XStreamAlias("pstRoadPump")
	private PstRoadPump pstRoadPump;
	
	private String prpNo;
	
	
	@XStreamAlias("pstBreakDownList")
	private List<PstBreakDown> pstBreakDownList;
	
	@XStreamAlias("pstEmployeeList")
	private List<PstEmployee> pstEmployeeList;
	
	@XStreamAlias("pstCostList")
	private List<PstCost> pstCostList; 
 
	private Long pcId;
	 
	private Long pcdId;
	 
	private Long pccId;
	private BigDecimal pjFeedBackScore;
	private BigDecimal pjTimeUsed;
	//ext
	private String cubicAmount;
	private String payAmount;
	private String payExtAmount;
	private String payAll;
	
	
	//bi-directional many-to-one association to PstJobEmployee
	/*@OneToMany(mappedBy="pstJob")
	private List<PstJobEmployee> pstJobEmployees;*/

	/*//bi-directional one-to-one association to PstJobPay
	@XStreamAlias("pstJobPay")
	private PstJobPay pstJobPay;

	//bi-directional one-to-one association to PstJobPayExt
	@XStreamAlias("pstJobPayExt")
	private PstJobPayExt pstJobPayExt;

	//bi-directional one-to-one association to PstJobWork
	@XStreamAlias("pstJobWork")
	private PstJobWork pstJobWork;*/

	public String getPayAll() {
		return payAll;
	}
	public void setPayAll(String payAll) {
		this.payAll = payAll;
	}
	public String getCubicAmount() {
		return cubicAmount;
	}
	public void setCubicAmount(String cubicAmount) {
		this.cubicAmount = cubicAmount;
	}
	public String getPayAmount() {
		return payAmount;
	}
	public void setPayAmount(String payAmount) {
		this.payAmount = payAmount;
	}
	public String getPayExtAmount() {
		return payExtAmount;
	}
	public void setPayExtAmount(String payExtAmount) {
		this.payExtAmount = payExtAmount;
	}
	public PstJob() {
	} 
	public PstJob(Long pjId, String pjContractMobileNo, String pjContractName,
			Timestamp pjCreatedTime, String pjCustomerDepartment,
			String pjCustomerName, String pjCustomerNo, String pjJobNo,
			Timestamp pjUpdatedTime, PstConcrete pstConcrete,String pjRemark,BigDecimal pjCubicAmount
			//PstJobPay pstJobPay, PstJobPayExt pstJobPayExt,
			//PstJobWork pstJobWork
			) {
		super();
		this.pjId = pjId;
		this.pjContractMobileNo = pjContractMobileNo;
		this.pjContractName = pjContractName;
		this.pjCreatedTime = pjCreatedTime;
		this.pjCustomerDepartment = pjCustomerDepartment;
		this.pjCustomerName = pjCustomerName;
		this.pjCustomerNo = pjCustomerNo;
		this.pjJobNo = pjJobNo;
		this.pjUpdatedTime = pjUpdatedTime;
		this.pstConcrete = pstConcrete;
		this.pjRemark = pjRemark;
		this.pjCubicAmount=pjCubicAmount;
		/*this.pstJobPayExt = pstJobPayExt;
		this.pstJobWork = pstJobWork;*/
	}

	public String getPjRemark() {
		return pjRemark;
	}

	public void setPjRemark(String pjRemark) {
		this.pjRemark = pjRemark;
	}

	public Long getPjId() {
		return this.pjId;
	}

	public void setPjId(Long pjId) {
		this.pjId = pjId;
	}

	public String getPjContractMobileNo() {
		return this.pjContractMobileNo;
	}

	public void setPjContractMobileNo(String pjContractMobileNo) {
		this.pjContractMobileNo = pjContractMobileNo;
	}

	public String getPjContractName() {
		return this.pjContractName;
	}

	public void setPjContractName(String pjContractName) {
		this.pjContractName = pjContractName;
	}

	public Date getPjCreatedTime() {
		return this.pjCreatedTime;
	}

	public void setPjCreatedTime(Date pjCreatedTime) {
		this.pjCreatedTime = pjCreatedTime;
	}

	public String getPjCustomerDepartment() {
		return this.pjCustomerDepartment;
	}

	public void setPjCustomerDepartment(String pjCustomerDepartment) {
		this.pjCustomerDepartment = pjCustomerDepartment;
	}

	public String getPjCustomerName() {
		return this.pjCustomerName;
	}

	public void setPjCustomerName(String pjCustomerName) {
		this.pjCustomerName = pjCustomerName;
	}

	public String getPjCustomerNo() {
		return this.pjCustomerNo;
	}

	public void setPjCustomerNo(String pjCustomerNo) {
		this.pjCustomerNo = pjCustomerNo;
	}

	public String getPjJobNo() {
		return this.pjJobNo;
	}

	public void setPjJobNo(String pjJobNo) {
		this.pjJobNo = pjJobNo;
	}

	public Date getPjUpdatedTime() {
		return this.pjUpdatedTime;
	}

	public void setPjUpdatedTime(Date pjUpdatedTime) {
		this.pjUpdatedTime = pjUpdatedTime;
	}

	public PstConcrete getPstConcrete() {
		return this.pstConcrete;
	}

	public void setPstConcrete(PstConcrete pstConcrete) {
		this.pstConcrete = pstConcrete;
	}

	public String getPrpNo() {
		return prpNo;
	}

	public void setPrpNo(String prpNo) {
		this.prpNo = prpNo;
	}

	public List<PstBreakDown> getPstBreakDownList() {
		return pstBreakDownList;
	}

	public void setPstBreakDownList(List<PstBreakDown> pstBreakDownList) {
		this.pstBreakDownList = pstBreakDownList;
	}

	public List<PstEmployee> getPstEmployeeList() {
		return pstEmployeeList;
	}

	public void setPstEmployeeList(List<PstEmployee> pstEmployeeList) {
		this.pstEmployeeList = pstEmployeeList;
	}

	public List<PstCost> getPstCostList() {
		return pstCostList;
	}

	public void setPstCostList(List<PstCost> pstCostList) {
		this.pstCostList = pstCostList;
	}
	public BigDecimal getPjCubicAmount() {
		return pjCubicAmount;
	}
	public void setPjCubicAmount(BigDecimal pjCubicAmount) {
		this.pjCubicAmount = pjCubicAmount;
	}
	public Long getPcId() {
		return pcId;
	}
	public void setPcId(Long pcId) {
		this.pcId = pcId;
	}
	public Long getPcdId() {
		return pcdId;
	}
	public void setPcdId(Long pcdId) {
		this.pcdId = pcdId;
	}
	public Long getPccId() {
		return pccId;
	}
	public void setPccId(Long pccId) {
		this.pccId = pccId;
	}
	public PstRoadPump getPstRoadPump() {
		return pstRoadPump;
	}
	public void setPstRoadPump(PstRoadPump pstRoadPump) {
		this.pstRoadPump = pstRoadPump;
	}
	public BigDecimal getPjFeedBackScore() {
		return pjFeedBackScore;
	}
	public void setPjFeedBackScore(BigDecimal pjFeedBackScore) {
		this.pjFeedBackScore = pjFeedBackScore;
	}
	public BigDecimal getPjTimeUsed() {
		return pjTimeUsed;
	}
	public void setPjTimeUsed(BigDecimal pjTimeUsed) {
		this.pjTimeUsed = pjTimeUsed;
	}

	/*public List<PstJobEmployee> getPstJobEmployees() {
		return this.pstJobEmployees;
	}

	public void setPstJobEmployees(List<PstJobEmployee> pstJobEmployees) {
		this.pstJobEmployees = pstJobEmployees;
	}*/

	/*public PstJobPay getPstJobPay() {
		return this.pstJobPay;
	}

	public void setPstJobPay(PstJobPay pstJobPay) {
		this.pstJobPay = pstJobPay;
	}

	public PstJobPayExt getPstJobPayExt() {
		return this.pstJobPayExt;
	}

	public void setPstJobPayExt(PstJobPayExt pstJobPayExt) {
		this.pstJobPayExt = pstJobPayExt;
	}

	public PstJobWork getPstJobWork() {
		return this.pstJobWork;
	}

	public void setPstJobWork(PstJobWork pstJobWork) {
		this.pstJobWork = pstJobWork;
	}*/

}