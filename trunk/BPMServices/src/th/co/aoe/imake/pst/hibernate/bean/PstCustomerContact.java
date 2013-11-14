package th.co.aoe.imake.pst.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


/**
 * The persistent class for the PST_CUSTOMER_CONTACT database table.
 * 
 */
@Entity
@Table(name="PST_CUSTOMER_CONTACT",schema="PST_DB")
public class PstCustomerContact implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PCC_ID")
	private Long pccId;

	@Column(name="PCC_MOBILE_NO")
	private String pccMobileNo;

	@Column(name="PCC_NAME")
	private String pccName;

	//bi-directional many-to-one association to PstCustomerDivision
	@ManyToOne
	@JoinColumn(name="PCD_ID")
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