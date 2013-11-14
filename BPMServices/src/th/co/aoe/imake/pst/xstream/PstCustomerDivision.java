package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_CUSTOMER_DIVISION database table.
 * 
 */
@XStreamAlias("PstCustomerDivision")
public class PstCustomerDivision extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="PCD_ID")
	private Long pcdId;

	@Column(name="PCD_NAME")
	private String pcdName;

	//bi-directional many-to-one association to PstCustomerContact
	/*@OneToMany(mappedBy="pstCustomerDivision")
	private List<PstCustomerContact> pstCustomerContacts;*/

	//bi-directional many-to-one association to PstCustomer
	@XStreamAlias("pstCustomer")
	private PstCustomer pstCustomer;

	public PstCustomerDivision() {
	}

	public Long getPcdId() {
		return this.pcdId;
	}

	public void setPcdId(Long pcdId) {
		this.pcdId = pcdId;
	}

	public String getPcdName() {
		return this.pcdName;
	}

	public void setPcdName(String pcdName) {
		this.pcdName = pcdName;
	}

	
	public PstCustomer getPstCustomer() {
		return this.pstCustomer;
	}

	public void setPstCustomer(PstCustomer pstCustomer) {
		this.pstCustomer = pstCustomer;
	}

}