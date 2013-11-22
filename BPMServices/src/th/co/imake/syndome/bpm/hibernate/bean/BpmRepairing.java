package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the BPM_REPAIRING database table.
 * 
 */
@Entity
@Table(name="BPM_REPAIRING",schema="SYNDOME_BPM_DB")
public class BpmRepairing implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BR_ID")
	private Long brId;

	@Column(name="BCAUSE_ID")
	private Long bcauseId;

	@Column(name="BP_PRO_COD")
	private String bpProCod;

	@Column(name="BR_CLOSE_DATE")
	private Timestamp brCloseDate;

	@Column(name="BR_CUSTOMER_CLOSE_DATE")
	private Timestamp brCustomerCloseDate;

	@Column(name="BR_INFO_ACCEPT_BY")
	private String brInfoAcceptBy;

	@Column(name="BR_INFO_AREA")
	private String brInfoArea;

	@Column(name="BR_INFO_BORROW_DATE")
	private Timestamp brInfoBorrowDate;

	@Column(name="BR_INFO_CAUSE")
	private String brInfoCause;

	@Column(name="BR_INFO_COMMENT")
	private String brInfoComment;

	@Column(name="BR_INFO_CREATED_DATE")
	private Timestamp brInfoCreatedDate;

	@Column(name="BR_INFO_FAX")
	private String brInfoFax;

	@Column(name="BR_INFO_INFORMANT")
	private String brInfoInformant;

	@Column(name="BR_INFO_MODEL_CHANGE")
	private String brInfoModelChange;

	@Column(name="BR_INFO_RETURN_DATE")
	private Timestamp brInfoReturnDate;

	@Column(name="BR_INFO_SC")
	private String brInfoSc;

	@Column(name="BR_INFO_SERIAL_CHANGE")
	private String brInfoSerialChange;

	@Column(name="BR_INFO_TEL")
	private String brInfoTel;

	@Column(name="BR_INFO_WORKAROUNDS")
	private String brInfoWorkarounds;

	@Column(name="BR_INFORMANT")
	private String brInformant;

	@Column(name="BR_INSTALLATION_CONTACT")
	private String brInstallationContact;

	@Column(name="BR_INSTALLATION_FAX")
	private String brInstallationFax;

	@Column(name="BR_INSTALLATION_LOCATION")
	private String brInstallationLocation;

	@Column(name="BR_INSTALLATION_TEL")
	private String brInstallationTel;

	@Column(name="BR_NAME")
	private String brName;

	@Column(name="BR_REPAIR_AREA")
	private String brRepairArea;

	@Column(name="BR_REPAIR_CANCELED_DATE")
	private Timestamp brRepairCanceledDate;

	@Column(name="BR_REPAIR_CAUSE")
	private String brRepairCause;

	@Column(name="BR_REPAIR_CAUSE_GROUP")
	private String brRepairCauseGroup;

	@Column(name="BR_REPAIR_CAUSE_TYPE")
	private String brRepairCauseType;

	@Column(name="BR_REPAIR_COMMENT")
	private String brRepairComment;

	@Column(name="BR_REPAIR_RECOMMEND_ADDITION")
	private String brRepairRecommendAddition;

	@Column(name="BR_REPAIR_RECOMMEND_REMARK")
	private String brRepairRecommendRemark;

	@Column(name="BR_REPAIR_RECOMMEND_SCORE")
	private String brRepairRecommendScore;

	@Column(name="BR_REPAIR_SC")
	private String brRepairSc;

	@Column(name="BR_REPAIR_SOLUTION")
	private String brRepairSolution;

	@Column(name="BR_REPAIR_STATUS")
	private String brRepairStatus;

	@Column(name="BR_TICKET_NO")
	private String brTicketNo;

	@Column(name="BV_ADDR")
	private String bvAddr;

	@Column(name="BV_COD")
	private String bvCod;

	@Column(name="BV_CONTACT")
	private String bvContact;

	@Column(name="BV_FAX")
	private String bvFax;

	@Column(name="BV_NAME")
	private String bvName;

	@Column(name="BV_TEL")
	private String bvTel;

	@Column(name="CUSADDR")
	private String cusaddr;

	@Column(name="CUSCOD")
	private String cuscod;

	@Column(name="CUSCONTACT")
	private String cuscontact;

	@Column(name="CUSFAX")
	private String cusfax;

	@Column(name="CUSNAM")
	private String cusnam;

	@Column(name="CUSTEL")
	private String custel;

	@Column(name="PRODUCT_CODE")
	private String productCode;

	@Column(name="PRODUCT_DESC")
	private String productDesc;

	@Column(name="PRODUCT_IS_WARRANT")
	private String productIsWarrant;

	@Column(name="PRODUCT_MODEL")
	private String productModel;

	@Column(name="PRODUCT_NC")
	private String productNc;

	@Column(name="PRODUCT_SERIAL")
	private String productSerial;

	@Column(name="PRODUCT_TYPE")
	private String productType;

	@Column(name="PRODUCT_VERSION_SOFTWARE")
	private String productVersionSoftware;

	@Temporal(TemporalType.DATE)
	@Column(name="PRODUCT_WARRANT_END")
	private Date productWarrantEnd;

	@Temporal(TemporalType.DATE)
	@Column(name="PRODUCT_WARRANT_START")
	private Date productWarrantStart;

	@Column(name="PRODUCT_WORK_ORDER")
	private String productWorkOrder;

	@Column(name="SLA")
	private String sla;

	public BpmRepairing() {
	}

	public Long getBrId() {
		return this.brId;
	}

	public void setBrId(Long brId) {
		this.brId = brId;
	}

	public Long getBcauseId() {
		return this.bcauseId;
	}

	public void setBcauseId(Long bcauseId) {
		this.bcauseId = bcauseId;
	}

	public String getBpProCod() {
		return this.bpProCod;
	}

	public void setBpProCod(String bpProCod) {
		this.bpProCod = bpProCod;
	}

	public Timestamp getBrCloseDate() {
		return this.brCloseDate;
	}

	public void setBrCloseDate(Timestamp brCloseDate) {
		this.brCloseDate = brCloseDate;
	}

	public Timestamp getBrCustomerCloseDate() {
		return this.brCustomerCloseDate;
	}

	public void setBrCustomerCloseDate(Timestamp brCustomerCloseDate) {
		this.brCustomerCloseDate = brCustomerCloseDate;
	}

	public String getBrInfoAcceptBy() {
		return this.brInfoAcceptBy;
	}

	public void setBrInfoAcceptBy(String brInfoAcceptBy) {
		this.brInfoAcceptBy = brInfoAcceptBy;
	}

	public String getBrInfoArea() {
		return this.brInfoArea;
	}

	public void setBrInfoArea(String brInfoArea) {
		this.brInfoArea = brInfoArea;
	}

	public Timestamp getBrInfoBorrowDate() {
		return this.brInfoBorrowDate;
	}

	public void setBrInfoBorrowDate(Timestamp brInfoBorrowDate) {
		this.brInfoBorrowDate = brInfoBorrowDate;
	}

	public String getBrInfoCause() {
		return this.brInfoCause;
	}

	public void setBrInfoCause(String brInfoCause) {
		this.brInfoCause = brInfoCause;
	}

	public String getBrInfoComment() {
		return this.brInfoComment;
	}

	public void setBrInfoComment(String brInfoComment) {
		this.brInfoComment = brInfoComment;
	}

	public Timestamp getBrInfoCreatedDate() {
		return this.brInfoCreatedDate;
	}

	public void setBrInfoCreatedDate(Timestamp brInfoCreatedDate) {
		this.brInfoCreatedDate = brInfoCreatedDate;
	}

	public String getBrInfoFax() {
		return this.brInfoFax;
	}

	public void setBrInfoFax(String brInfoFax) {
		this.brInfoFax = brInfoFax;
	}

	public String getBrInfoInformant() {
		return this.brInfoInformant;
	}

	public void setBrInfoInformant(String brInfoInformant) {
		this.brInfoInformant = brInfoInformant;
	}

	public String getBrInfoModelChange() {
		return this.brInfoModelChange;
	}

	public void setBrInfoModelChange(String brInfoModelChange) {
		this.brInfoModelChange = brInfoModelChange;
	}

	public Timestamp getBrInfoReturnDate() {
		return this.brInfoReturnDate;
	}

	public void setBrInfoReturnDate(Timestamp brInfoReturnDate) {
		this.brInfoReturnDate = brInfoReturnDate;
	}

	public String getBrInfoSc() {
		return this.brInfoSc;
	}

	public void setBrInfoSc(String brInfoSc) {
		this.brInfoSc = brInfoSc;
	}

	public String getBrInfoSerialChange() {
		return this.brInfoSerialChange;
	}

	public void setBrInfoSerialChange(String brInfoSerialChange) {
		this.brInfoSerialChange = brInfoSerialChange;
	}

	public String getBrInfoTel() {
		return this.brInfoTel;
	}

	public void setBrInfoTel(String brInfoTel) {
		this.brInfoTel = brInfoTel;
	}

	public String getBrInfoWorkarounds() {
		return this.brInfoWorkarounds;
	}

	public void setBrInfoWorkarounds(String brInfoWorkarounds) {
		this.brInfoWorkarounds = brInfoWorkarounds;
	}

	public String getBrInformant() {
		return this.brInformant;
	}

	public void setBrInformant(String brInformant) {
		this.brInformant = brInformant;
	}

	public String getBrInstallationContact() {
		return this.brInstallationContact;
	}

	public void setBrInstallationContact(String brInstallationContact) {
		this.brInstallationContact = brInstallationContact;
	}

	public String getBrInstallationFax() {
		return this.brInstallationFax;
	}

	public void setBrInstallationFax(String brInstallationFax) {
		this.brInstallationFax = brInstallationFax;
	}

	public String getBrInstallationLocation() {
		return this.brInstallationLocation;
	}

	public void setBrInstallationLocation(String brInstallationLocation) {
		this.brInstallationLocation = brInstallationLocation;
	}

	public String getBrInstallationTel() {
		return this.brInstallationTel;
	}

	public void setBrInstallationTel(String brInstallationTel) {
		this.brInstallationTel = brInstallationTel;
	}

	public String getBrName() {
		return this.brName;
	}

	public void setBrName(String brName) {
		this.brName = brName;
	}

	public String getBrRepairArea() {
		return this.brRepairArea;
	}

	public void setBrRepairArea(String brRepairArea) {
		this.brRepairArea = brRepairArea;
	}

	public Timestamp getBrRepairCanceledDate() {
		return this.brRepairCanceledDate;
	}

	public void setBrRepairCanceledDate(Timestamp brRepairCanceledDate) {
		this.brRepairCanceledDate = brRepairCanceledDate;
	}

	public String getBrRepairCause() {
		return this.brRepairCause;
	}

	public void setBrRepairCause(String brRepairCause) {
		this.brRepairCause = brRepairCause;
	}

	public String getBrRepairCauseGroup() {
		return this.brRepairCauseGroup;
	}

	public void setBrRepairCauseGroup(String brRepairCauseGroup) {
		this.brRepairCauseGroup = brRepairCauseGroup;
	}

	public String getBrRepairCauseType() {
		return this.brRepairCauseType;
	}

	public void setBrRepairCauseType(String brRepairCauseType) {
		this.brRepairCauseType = brRepairCauseType;
	}

	public String getBrRepairComment() {
		return this.brRepairComment;
	}

	public void setBrRepairComment(String brRepairComment) {
		this.brRepairComment = brRepairComment;
	}

	public String getBrRepairRecommendAddition() {
		return this.brRepairRecommendAddition;
	}

	public void setBrRepairRecommendAddition(String brRepairRecommendAddition) {
		this.brRepairRecommendAddition = brRepairRecommendAddition;
	}

	public String getBrRepairRecommendRemark() {
		return this.brRepairRecommendRemark;
	}

	public void setBrRepairRecommendRemark(String brRepairRecommendRemark) {
		this.brRepairRecommendRemark = brRepairRecommendRemark;
	}

	public String getBrRepairRecommendScore() {
		return this.brRepairRecommendScore;
	}

	public void setBrRepairRecommendScore(String brRepairRecommendScore) {
		this.brRepairRecommendScore = brRepairRecommendScore;
	}

	public String getBrRepairSc() {
		return this.brRepairSc;
	}

	public void setBrRepairSc(String brRepairSc) {
		this.brRepairSc = brRepairSc;
	}

	public String getBrRepairSolution() {
		return this.brRepairSolution;
	}

	public void setBrRepairSolution(String brRepairSolution) {
		this.brRepairSolution = brRepairSolution;
	}

	public String getBrRepairStatus() {
		return this.brRepairStatus;
	}

	public void setBrRepairStatus(String brRepairStatus) {
		this.brRepairStatus = brRepairStatus;
	}

	public String getBrTicketNo() {
		return this.brTicketNo;
	}

	public void setBrTicketNo(String brTicketNo) {
		this.brTicketNo = brTicketNo;
	}

	public String getBvAddr() {
		return this.bvAddr;
	}

	public void setBvAddr(String bvAddr) {
		this.bvAddr = bvAddr;
	}

	public String getBvCod() {
		return this.bvCod;
	}

	public void setBvCod(String bvCod) {
		this.bvCod = bvCod;
	}

	public String getBvContact() {
		return this.bvContact;
	}

	public void setBvContact(String bvContact) {
		this.bvContact = bvContact;
	}

	public String getBvFax() {
		return this.bvFax;
	}

	public void setBvFax(String bvFax) {
		this.bvFax = bvFax;
	}

	public String getBvName() {
		return this.bvName;
	}

	public void setBvName(String bvName) {
		this.bvName = bvName;
	}

	public String getBvTel() {
		return this.bvTel;
	}

	public void setBvTel(String bvTel) {
		this.bvTel = bvTel;
	}

	public String getCusaddr() {
		return this.cusaddr;
	}

	public void setCusaddr(String cusaddr) {
		this.cusaddr = cusaddr;
	}

	public String getCuscod() {
		return this.cuscod;
	}

	public void setCuscod(String cuscod) {
		this.cuscod = cuscod;
	}

	public String getCuscontact() {
		return this.cuscontact;
	}

	public void setCuscontact(String cuscontact) {
		this.cuscontact = cuscontact;
	}

	public String getCusfax() {
		return this.cusfax;
	}

	public void setCusfax(String cusfax) {
		this.cusfax = cusfax;
	}

	public String getCusnam() {
		return this.cusnam;
	}

	public void setCusnam(String cusnam) {
		this.cusnam = cusnam;
	}

	public String getCustel() {
		return this.custel;
	}

	public void setCustel(String custel) {
		this.custel = custel;
	}

	public String getProductCode() {
		return this.productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getProductDesc() {
		return this.productDesc;
	}

	public void setProductDesc(String productDesc) {
		this.productDesc = productDesc;
	}

	public String getProductIsWarrant() {
		return this.productIsWarrant;
	}

	public void setProductIsWarrant(String productIsWarrant) {
		this.productIsWarrant = productIsWarrant;
	}

	public String getProductModel() {
		return this.productModel;
	}

	public void setProductModel(String productModel) {
		this.productModel = productModel;
	}

	public String getProductNc() {
		return this.productNc;
	}

	public void setProductNc(String productNc) {
		this.productNc = productNc;
	}

	public String getProductSerial() {
		return this.productSerial;
	}

	public void setProductSerial(String productSerial) {
		this.productSerial = productSerial;
	}

	public String getProductType() {
		return this.productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	public String getProductVersionSoftware() {
		return this.productVersionSoftware;
	}

	public void setProductVersionSoftware(String productVersionSoftware) {
		this.productVersionSoftware = productVersionSoftware;
	}

	public Date getProductWarrantEnd() {
		return this.productWarrantEnd;
	}

	public void setProductWarrantEnd(Date productWarrantEnd) {
		this.productWarrantEnd = productWarrantEnd;
	}

	public Date getProductWarrantStart() {
		return this.productWarrantStart;
	}

	public void setProductWarrantStart(Date productWarrantStart) {
		this.productWarrantStart = productWarrantStart;
	}

	public String getProductWorkOrder() {
		return this.productWorkOrder;
	}

	public void setProductWorkOrder(String productWorkOrder) {
		this.productWorkOrder = productWorkOrder;
	}

	public String getSla() {
		return this.sla;
	}

	public void setSla(String sla) {
		this.sla = sla;
	}

}