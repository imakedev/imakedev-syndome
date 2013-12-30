package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_REPAIRING database table.
 * 
 */
@XStreamAlias("BpmRepairing")
public class BpmRepairing  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long brId;
 
	private Long bcauseId;
 
	private String bpProCod;

	@XStreamAlias("brCloseDate")
	private Timestamp brCloseDate;

	@XStreamAlias("brCustomerCloseDate")
	private Timestamp brCustomerCloseDate;
 
	private String brInfoAcceptBy;
 
	private String brInfoArea;
 
	private Timestamp brInfoBorrowDate;
 
	private String brInfoCause;
 
	private String brInfoComment; 
	
	private Timestamp brInfoCreatedDate;

	private String brInfoFax;

	private String brInfoInformant;

	private String brInfoModelChange;

	private Timestamp brInfoReturnDate;

	private String brInfoSc;

	private String brInfoSerialChange;

	private String brInfoTel;

	private String brInfoWorkarounds;

	private String brInformant;

	private String brInstallationContact;

	private String brInstallationFax;

	private String brInstallationLocation;

	private String brInstallationTel;

	private String brName;

	private String brRepairArea;

	private Timestamp brRepairCanceledDate;

	private String brRepairCause;

	private String brRepairCauseGroup;

	private String brRepairCauseType;

	private String brRepairComment;

	private String brRepairRecommendAddition;

	private String brRepairRecommendRemark;

	private String brRepairRecommendScore;

	private String brRepairSc;

	private String brRepairSolution;

	private String brRepairStatus;

	private String brTicketNo;

	private String bvAddr;

	private String bvCod;

	private String bvContact;

	private String bvFax;

	private String bvName;

	private String bvTel;

	private String cusaddr;

	private String cuscod;

	private String cuscontact;

	private String cusfax;

	private String cusnam;

	private String custel;

	private String productCode;

	private String productDesc;

	private String productIsWarrant;

	private String productModel;

	private String productNc;

	private String productSerial;

	private String productType;

	private String productVersionSoftware;

	private Date productWarrantEnd;

	private Date productWarrantStart;

	private String productWorkOrder;

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