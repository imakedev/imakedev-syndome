package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;
import java.sql.Time;
import java.sql.Timestamp;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_CALL_CENTER database table.
 * 
 */
@XStreamAlias("BpmCallCenter")
public class BpmCallCenter  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private String bccNo;
	private String bccCustomerTicket;
	private String bccSerial;
	private String bccModel;
	private String bccCause;
	private Timestamp bccCreatedTime;
	private String bccSla;
	//0=ไม่อยู่ในประกัน ,1=อยู่ในประกัน,2=อยู่ในประกัน MA เลขที่
	private String bccIsMa; 
	private String bccMaNo;
	private Timestamp bccMaStart;
	private Timestamp bccMaEnd;
	//1=Gold,2=Silver,3=Bronze
	private String bccMaType;
	
	//0=เสนอราคาซ่อม,1=ให้ดำเนินการซ่อม Onsite (ช่าง IT)
	//2=ให้ดำเนินการซ่อม Onsite (ช่างภูมิภาค),3=ให้ซ่อมภายใน SC
	//4=ให้ดำเนินการรับเครื่อง (ขนส่งรับจ้าง),5=ให้ดำเนินการรับเครื่อง (ขนส่งต่างจังหวัด)
	//6=ตรวจสอบเอกสาร
	private String bccStatus;
	
	private String bccRemark;
	private Timestamp bccDueDate;
	private Time bccDueDateStart;
	private Time bccDueDateEnd;
	private String bccCuscode; 
	private String bccCustomerName;
	private String bccLocation;
	private String bccContact;
	private String bccTel;
	private String bccAddr1;
	private String bccAddr2;
	private String bccAddr3; 
	private String bccProvince;
	private String bccZipcode;
	private String bccUpdatedBy; 
	private Timestamp bccUpdatedTime; 
	private String bccUserCreated;
	private String bccState;
	private String bccCancelCause;
	private String bccJobID;
 
	public String getBccJobID() {
		return bccJobID;
	}

	public void setBccJobID(String bccJobID) {
		this.bccJobID = bccJobID;
	}

	private String bccFax;
   
	private String bccQuotaionRemark; 
	 
	private String bccSaleId;  
	private String bsjJobStatus;
	public BpmCallCenter() {
	}

	public String getBccNo() {
		return this.bccNo;
	}

	public void setBccNo(String bccNo) {
		this.bccNo = bccNo;
	}

	public String getBccAddr1() {
		return this.bccAddr1;
	}

	public void setBccAddr1(String bccAddr1) {
		this.bccAddr1 = bccAddr1;
	}

	public String getBccAddr2() {
		return this.bccAddr2;
	}

	public void setBccAddr2(String bccAddr2) {
		this.bccAddr2 = bccAddr2;
	}

	public String getBccAddr3() {
		return this.bccAddr3;
	}

	public void setBccAddr3(String bccAddr3) {
		this.bccAddr3 = bccAddr3;
	}

	public String getBccCancelCause() {
		return this.bccCancelCause;
	}

	public void setBccCancelCause(String bccCancelCause) {
		this.bccCancelCause = bccCancelCause;
	}

	public String getBccCause() {
		return this.bccCause;
	}

	public void setBccCause(String bccCause) {
		this.bccCause = bccCause;
	}

	public String getBccContact() {
		return this.bccContact;
	}

	public void setBccContact(String bccContact) {
		this.bccContact = bccContact;
	}

	public Timestamp getBccCreatedTime() {
		return this.bccCreatedTime;
	}

	public void setBccCreatedTime(Timestamp bccCreatedTime) {
		this.bccCreatedTime = bccCreatedTime;
	}

	public String getBccCuscode() {
		return this.bccCuscode;
	}

	public void setBccCuscode(String bccCuscode) {
		this.bccCuscode = bccCuscode;
	}

	public String getBccCustomerName() {
		return this.bccCustomerName;
	}

	public void setBccCustomerName(String bccCustomerName) {
		this.bccCustomerName = bccCustomerName;
	}

	public String getBccCustomerTicket() {
		return this.bccCustomerTicket;
	}

	public void setBccCustomerTicket(String bccCustomerTicket) {
		this.bccCustomerTicket = bccCustomerTicket;
	}

	public Timestamp getBccDueDate() {
		return this.bccDueDate;
	}

	public void setBccDueDate(Timestamp bccDueDate) {
		this.bccDueDate = bccDueDate;
	}

	public Time getBccDueDateEnd() {
		return this.bccDueDateEnd;
	}

	public void setBccDueDateEnd(Time bccDueDateEnd) {
		this.bccDueDateEnd = bccDueDateEnd;
	}

	public Time getBccDueDateStart() {
		return this.bccDueDateStart;
	}

	public void setBccDueDateStart(Time bccDueDateStart) {
		this.bccDueDateStart = bccDueDateStart;
	}

	public String getBccFax() {
		return this.bccFax;
	}

	public void setBccFax(String bccFax) {
		this.bccFax = bccFax;
	}

	public String getBccIsMa() {
		return this.bccIsMa;
	}

	public void setBccIsMa(String bccIsMa) {
		this.bccIsMa = bccIsMa;
	}

	public String getBccLocation() {
		return this.bccLocation;
	}

	public void setBccLocation(String bccLocation) {
		this.bccLocation = bccLocation;
	}

	public Timestamp getBccMaEnd() {
		return this.bccMaEnd;
	}

	public void setBccMaEnd(Timestamp bccMaEnd) {
		this.bccMaEnd = bccMaEnd;
	}

	public String getBccMaNo() {
		return this.bccMaNo;
	}

	public void setBccMaNo(String bccMaNo) {
		this.bccMaNo = bccMaNo;
	}

	public Timestamp getBccMaStart() {
		return this.bccMaStart;
	}

	public void setBccMaStart(Timestamp bccMaStart) {
		this.bccMaStart = bccMaStart;
	}

	public String getBccMaType() {
		return this.bccMaType;
	}

	public void setBccMaType(String bccMaType) {
		this.bccMaType = bccMaType;
	}

	public String getBccModel() {
		return this.bccModel;
	}

	public void setBccModel(String bccModel) {
		this.bccModel = bccModel;
	}

	public String getBccProvince() {
		return this.bccProvince;
	}

	public void setBccProvince(String bccProvince) {
		this.bccProvince = bccProvince;
	}

	public String getBccQuotaionRemark() {
		return this.bccQuotaionRemark;
	}

	public void setBccQuotaionRemark(String bccQuotaionRemark) {
		this.bccQuotaionRemark = bccQuotaionRemark;
	}

	public String getBccRemark() {
		return this.bccRemark;
	}

	public void setBccRemark(String bccRemark) {
		this.bccRemark = bccRemark;
	}

	public String getBccSaleId() {
		return this.bccSaleId;
	}

	public void setBccSaleId(String bccSaleId) {
		this.bccSaleId = bccSaleId;
	}

	public String getBccSerial() {
		return this.bccSerial;
	}

	public void setBccSerial(String bccSerial) {
		this.bccSerial = bccSerial;
	}

	public String getBccSla() {
		return this.bccSla;
	}

	public void setBccSla(String bccSla) {
		this.bccSla = bccSla;
	}

	public String getBccState() {
		return this.bccState;
	}

	public void setBccState(String bccState) {
		this.bccState = bccState;
	}

	public String getBccStatus() {
		return this.bccStatus;
	}

	public void setBccStatus(String bccStatus) {
		this.bccStatus = bccStatus;
	}

	public String getBccTel() {
		return this.bccTel;
	}

	public void setBccTel(String bccTel) {
		this.bccTel = bccTel;
	}

	public String getBccUpdatedBy() {
		return this.bccUpdatedBy;
	}

	public void setBccUpdatedBy(String bccUpdatedBy) {
		this.bccUpdatedBy = bccUpdatedBy;
	}

	public Timestamp getBccUpdatedTime() {
		return this.bccUpdatedTime;
	}

	public void setBccUpdatedTime(Timestamp bccUpdatedTime) {
		this.bccUpdatedTime = bccUpdatedTime;
	}

	public String getBccUserCreated() {
		return this.bccUserCreated;
	}

	public void setBccUserCreated(String bccUserCreated) {
		this.bccUserCreated = bccUserCreated;
	}

	public String getBccZipcode() {
		return this.bccZipcode;
	}

	public void setBccZipcode(String bccZipcode) {
		this.bccZipcode = bccZipcode;
	}

	public String getBsjJobStatus() {
		return bsjJobStatus;
	}

	public void setBsjJobStatus(String bsjJobStatus) {
		this.bsjJobStatus = bsjJobStatus;
	}

}