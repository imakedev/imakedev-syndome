package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


/**
 * The persistent class for the PST_JOB database table.
 * 
 */
@Entity
@Table(name="PST_JOB",schema="PST_DB")
public class PstJob implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PJ_ID")
	private Long pjId;

	@Column(name="PJ_CONTRACT_MOBILE_NO")
	private String pjContractMobileNo;

	@Column(name="PJ_CONTRACT_NAME")
	private String pjContractName;

	@Column(name="PJ_CREATED_TIME")
	private Date pjCreatedTime;

	@Column(name="PJ_CUSTOMER_DEPARTMENT")
	private String pjCustomerDepartment;

	@Column(name="PJ_CUSTOMER_NAME")
	private String pjCustomerName;

	@Column(name="PJ_CUSTOMER_NO")
	private String pjCustomerNo;

	@Column(name="PJ_JOB_NO")
	private String pjJobNo;
	
	@Column(name="PJ_REMARK")
	private String pjRemark;

	@Column(name="PJ_UPDATED_TIME")
	private Date pjUpdatedTime;
	
	@Column(name="PJ_CUBIC_AMOUNT")
	private BigDecimal pjCubicAmount;

	//bi-directional many-to-one association to PstConcrete
	@ManyToOne
	@JoinColumn(name="PCONCRETE_ID")
	private PstConcrete pstConcrete;
	
	@ManyToOne
	@JoinColumn(name="PRP_ID")
	private PstRoadPump pstRoadPump;
	
	
	@Column(name="PC_ID")
	private Long pcId;
	
	@Column(name="PCD_ID")
	private Long pcdId;
	
	@Column(name="PCC_ID")
	private Long pccId;
	
	@Column(name="PJ_FEEDBACK_SCORE")
	private BigDecimal pjFeedBackScore;
	
	@Column(name="PJ_TIME_USED")
	private BigDecimal pjTimeUsed;
	
	
	
	


	//bi-directional many-to-one association to PstJobEmployee
	/*@OneToMany(mappedBy="pstJob")
	private List<PstJobEmployee> pstJobEmployees;*/

	/*//bi-directional one-to-one association to PstJobPay
	@OneToOne(mappedBy="pstJob")
	private PstJobPay pstJobPay;

	//bi-directional one-to-one association to PstJobPayExt
	@OneToOne(mappedBy="pstJob")
	private PstJobPayExt pstJobPayExt;

	//bi-directional one-to-one association to PstJobWork
	@OneToOne(mappedBy="pstJob")
	private PstJobWork pstJobWork;*/

	public PstJob() {
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

	public String getPjRemark() {
		return pjRemark;
	}

	public void setPjRemark(String pjRemark) {
		this.pjRemark = pjRemark;
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

/*	public PstJobPay getPstJobPay() {
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