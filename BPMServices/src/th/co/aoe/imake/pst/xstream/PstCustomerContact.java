package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_CUSTOMER_CONTACT database table.
 * 
 */
@XStreamAlias("PstCustomerContact")
public class PstCustomerContact extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="PCC_ID")
	private Long pccId;

	@Column(name="PCC_MOBILE_NO")
	private String pccMobileNo;

	@Column(name="PCC_NAME")
	private String pccName;

	//bi-directional many-to-one association to PstCustomerDivision
	@XStreamAlias("pstCustomerDivision")
	private PstCustomerDivision pstCustomerDivision;

	public PstCustomerContact() {
	}

	public Long getPccId() {
		return this.pccId;
	}

	public void setPccId(Long pccId) {
		this.pccId = pccId;
	}

	public String getPccMobileNo() {
		return this.pccMobileNo;
	}

	public void setPccMobileNo(String pccMobileNo) {
		this.pccMobileNo = pccMobileNo;
	}

	public String getPccName() {
		return this.pccName;
	}

	public void setPccName(String pccName) {
		this.pccName = pccName;
	}

	public PstCustomerDivision getPstCustomerDivision() {
		return this.pstCustomerDivision;
	}

	public void setPstCustomerDivision(PstCustomerDivision pstCustomerDivision) {
		this.pstCustomerDivision = pstCustomerDivision;
	}

}