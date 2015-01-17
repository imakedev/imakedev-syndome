package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;
import java.sql.Time;


/**
 * The persistent class for the BPM_CALL_CENTER database table.
 * 
 */
@Entity
@Table(name="BPM_CALL_CENTER")
public class BpmCallCenter implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BCC_NO")
	private String bccNo;

	@Column(name="BCC_ADDR1")
	private String bccAddr1;

	@Column(name="BCC_ADDR2")
	private String bccAddr2;

	@Column(name="BCC_ADDR3")
	private String bccAddr3;

	@Column(name="BCC_CANCEL_CAUSE")
	private String bccCancelCause;

	@Column(name="BCC_CAUSE")
	private String bccCause;

	@Column(name="BCC_CONTACT")
	private String bccContact;

	@Column(name="BCC_CREATED_TIME")
	private Timestamp bccCreatedTime;

	@Column(name="BCC_CUSCODE")
	private String bccCuscode;

	@Column(name="BCC_CUSTOMER_NAME")
	private String bccCustomerName;

	@Column(name="BCC_CUSTOMER_TICKET")
	private String bccCustomerTicket;

	@Column(name="BCC_DUE_DATE")
	private Timestamp bccDueDate;

	@Column(name="BCC_DUE_DATE_END")
	private Time bccDueDateEnd;

	@Column(name="BCC_DUE_DATE_START")
	private Time bccDueDateStart;

	@Column(name="BCC_FAX")
	private String bccFax;

	@Column(name="BCC_IS_MA")
	private String bccIsMa;

	@Column(name="BCC_LOCATION")
	private String bccLocation;

	@Column(name="BCC_MA_END")
	private Timestamp bccMaEnd;

	@Column(name="BCC_MA_NO")
	private String bccMaNo;

	@Column(name="BCC_MA_START")
	private Timestamp bccMaStart;

	@Column(name="BCC_MA_TYPE")
	private String bccMaType;

	@Column(name="BCC_MODEL")
	private String bccModel;

	@Column(name="BCC_PROVINCE")
	private String bccProvince;

	@Column(name="BCC_QUOTAION_REMARK")
	private String bccQuotaionRemark;

	@Column(name="BCC_REMARK")
	private String bccRemark;

	@Column(name="BCC_SALE_ID")
	private String bccSaleId;

	@Column(name="BCC_SERIAL")
	private String bccSerial;

	@Column(name="BCC_SLA")
	private String bccSla;

	@Column(name="BCC_STATE")
	private String bccState;

	@Column(name="BCC_STATUS")
	private String bccStatus;

	@Column(name="BCC_TEL")
	private String bccTel;

	@Column(name="BCC_UPDATED_BY")
	private String bccUpdatedBy;

	@Column(name="BCC_UPDATED_TIME")
	private Timestamp bccUpdatedTime;

	@Column(name="BCC_USER_CREATED")
	private String bccUserCreated;

	@Column(name="BCC_ZIPCODE")
	private String bccZipcode; 
	
    @Column(name="BCC_JOB_ID")
	private String bccJobID;
	public String getBccJobID() {
		return bccJobID;
	}

	public void setBccJobID(String bccJobID) {
		this.bccJobID = bccJobID;
	}

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

}