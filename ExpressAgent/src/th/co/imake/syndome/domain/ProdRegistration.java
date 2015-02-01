package th.co.imake.syndome.domain;

import java.io.Serializable;


/**
 * The persistent class for the PROD_REGISTRATION database table.
 * 
 */

public class ProdRegistration implements Serializable {
	private static final long serialVersionUID = 1L;

	/*@EmbeddedId
	private ProdRegistrationPK id;*/
	
	//@Column(name="account_code")
	private String accountCode;

	//@Column(name="serial_no")
	private String serialNo;

	//@Column(name="account_name")
	private String accountName;

	//@Column(name="contact_name")
	private String contactName;

	private String model;

	private String note;

	//@Column(name="product_item")
	private String productItem;

	//@Column(name="registration_date")
	private String registrationDate;

	//@Column(name="registration_no")
	private String registrationNo;

	//@Column(name="sales_order_no")
	private String salesOrderNo;

	//@Column(name="so_line_no")
	private String soLineNo;

	private String type;

	//@Column(name="warr_end_date")
	private String warrEndDate;

	//@Column(name="warr_start_date")
	private String warrStartDate;

	//@Column(name="warranty_period")
	private String warrantyPeriod;

	//@Column(name="warranty_type")
	private String warrantyType;

	public ProdRegistration() {
	}

	 

	public String getAccountName() {
		return this.accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getContactName() {
		return this.contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getModel() {
		return this.model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getProductItem() {
		return this.productItem;
	}

	public void setProductItem(String productItem) {
		this.productItem = productItem;
	}

	public String getRegistrationDate() {
		return this.registrationDate;
	}

	public void setRegistrationDate(String registrationDate) {
		this.registrationDate = registrationDate;
	}

	public String getRegistrationNo() {
		return this.registrationNo;
	}

	public void setRegistrationNo(String registrationNo) {
		this.registrationNo = registrationNo;
	}

	public String getSalesOrderNo() {
		return this.salesOrderNo;
	}

	public void setSalesOrderNo(String salesOrderNo) {
		this.salesOrderNo = salesOrderNo;
	}

	public String getSoLineNo() {
		return this.soLineNo;
	}

	public void setSoLineNo(String soLineNo) {
		this.soLineNo = soLineNo;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getWarrEndDate() {
		return this.warrEndDate;
	}

	public void setWarrEndDate(String warrEndDate) {
		this.warrEndDate = warrEndDate;
	}

	public String getWarrStartDate() {
		return this.warrStartDate;
	}

	public void setWarrStartDate(String warrStartDate) {
		this.warrStartDate = warrStartDate;
	}

	public String getWarrantyPeriod() {
		return this.warrantyPeriod;
	}

	public void setWarrantyPeriod(String warrantyPeriod) {
		this.warrantyPeriod = warrantyPeriod;
	}

	public String getWarrantyType() {
		return this.warrantyType;
	}

	public void setWarrantyType(String warrantyType) {
		this.warrantyType = warrantyType;
	}



	public String getAccountCode() {
		return accountCode;
	}



	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}



	public String getSerialNo() {
		return serialNo;
	}



	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

}