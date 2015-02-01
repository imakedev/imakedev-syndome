package th.co.imake.syndome.domain;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * The persistent class for the ACCOUNT_ADDRESS database table.
 * 
 */

public class AccountAddress implements Serializable {
	private static final long serialVersionUID = 1L;

	//@Id
	//@Column(name="address_code")
	private String addressCode;

	//@Column(name="account_name")
	private String accountName;

	//@Column(name="account_type")
	private String accountType;

	//@Column(name="alt_address")
	private String altAddress;

	//@Column(name="alt_address_city")
	private String altAddressCity;
	
	//@Column(name="alt_address_state")
	private String altAddressState;

	//@Column(name="alt_province")
	private String altProvince;

	//@Column(name="contact_name")
	private String contactName;

	//@Column(name="contact_phone")
	private String contactPhone;

	//@Column(name="contact_phone_other")
	private String contactPhoneOther;

	//@Column(name="country_name")
	private String countryName;

	private String description;

	//@Column(name="effective_date")
	private Timestamp effectiveDate;

	//@Column(name="is_bill_to")
	private String isBillTo;

	//@Column(name="is_correspond_to")
	private String isCorrespondTo;

	//@Column(name="is_ship_to")
	private String isShipTo;

	//@Column(name="phone_fax")
	private String phoneFax;

	//@Column(name="postcode_name")
	private String postcodeName;

	//@Column(name="primary_address")
	private String primaryAddress;

	//@Column(name="primary_address_city")
	private String primaryAddressCity;

	//@Column(name="primary_address_state")
	private String primaryAddressState;

	//@Column(name="primary_province")
	private String primaryProvince;

	private String status;

	private String type;

	public AccountAddress() {
	}

	public String getAddressCode() {
		return this.addressCode;
	}

	public void setAddressCode(String addressCode) {
		this.addressCode = addressCode;
	}

	public String getAccountName() {
		return this.accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getAccountType() {
		return this.accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	public String getAltAddress() {
		return this.altAddress;
	}

	public void setAltAddress(String altAddress) {
		this.altAddress = altAddress;
	}

	public String getAltAddressCity() {
		return this.altAddressCity;
	}

	public void setAltAddressCity(String altAddressCity) {
		this.altAddressCity = altAddressCity;
	}

	public String getAltAddressState() {
		return this.altAddressState;
	}

	public void setAltAddressState(String altAddressState) {
		this.altAddressState = altAddressState;
	}

	public String getAltProvince() {
		return this.altProvince;
	}

	public void setAltProvince(String altProvince) {
		this.altProvince = altProvince;
	}

	public String getContactName() {
		return this.contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getContactPhone() {
		return this.contactPhone;
	}

	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	public String getContactPhoneOther() {
		return this.contactPhoneOther;
	}

	public void setContactPhoneOther(String contactPhoneOther) {
		this.contactPhoneOther = contactPhoneOther;
	}

	public String getCountryName() {
		return this.countryName;
	}

	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Timestamp getEffectiveDate() {
		return this.effectiveDate;
	}

	public void setEffectiveDate(Timestamp effectiveDate) {
		this.effectiveDate = effectiveDate;
	}

	public String getIsBillTo() {
		return this.isBillTo;
	}

	public void setIsBillTo(String isBillTo) {
		this.isBillTo = isBillTo;
	}

	public String getIsCorrespondTo() {
		return this.isCorrespondTo;
	}

	public void setIsCorrespondTo(String isCorrespondTo) {
		this.isCorrespondTo = isCorrespondTo;
	}

	public String getIsShipTo() {
		return this.isShipTo;
	}

	public void setIsShipTo(String isShipTo) {
		this.isShipTo = isShipTo;
	}

	public String getPhoneFax() {
		return this.phoneFax;
	}

	public void setPhoneFax(String phoneFax) {
		this.phoneFax = phoneFax;
	}

	public String getPostcodeName() {
		return this.postcodeName;
	}

	public void setPostcodeName(String postcodeName) {
		this.postcodeName = postcodeName;
	}

	public String getPrimaryAddress() {
		return this.primaryAddress;
	}

	public void setPrimaryAddress(String primaryAddress) {
		this.primaryAddress = primaryAddress;
	}

	public String getPrimaryAddressCity() {
		return this.primaryAddressCity;
	}

	public void setPrimaryAddressCity(String primaryAddressCity) {
		this.primaryAddressCity = primaryAddressCity;
	}

	public String getPrimaryAddressState() {
		return this.primaryAddressState;
	}

	public void setPrimaryAddressState(String primaryAddressState) {
		this.primaryAddressState = primaryAddressState;
	}

	public String getPrimaryProvince() {
		return this.primaryProvince;
	}

	public void setPrimaryProvince(String primaryProvince) {
		this.primaryProvince = primaryProvince;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

}