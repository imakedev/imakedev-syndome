package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Lob;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_CUSTOMER database table.
 * 
 */
@XStreamAlias("PstCustomer")
public class PstCustomer extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="PC_ID")
	private Long pcId;

	@Lob
	@Column(name="PC_ADDRESS")
	private String pcAddress;

	@Column(name="PC_NAME")
	private String pcName;

	@Column(name="PC_NO")
	private String pcNo;

	//bi-directional many-to-one association to PstCustomerDivision
/*	@OneToMany(mappedBy="pstCustomer")
	private List<PstCustomerDivision> pstCustomerDivisions;*/

	public PstCustomer() {
	}

	public Long getPcId() {
		return this.pcId;
	}

	public void setPcId(Long pcId) {
		this.pcId = pcId;
	}

	public String getPcAddress() {
		return this.pcAddress;
	}

	public void setPcAddress(String pcAddress) {
		this.pcAddress = pcAddress;
	}

	public String getPcName() {
		return this.pcName;
	}

	public void setPcName(String pcName) {
		this.pcName = pcName;
	}

	public String getPcNo() {
		return this.pcNo;
	}

	public void setPcNo(String pcNo) {
		this.pcNo = pcNo;
	}

	/*public List<PstCustomerDivision> getPstCustomerDivisions() {
		return this.pstCustomerDivisions;
	}

	public void setPstCustomerDivisions(List<PstCustomerDivision> pstCustomerDivisions) {
		this.pstCustomerDivisions = pstCustomerDivisions;
	}*/

	/*public PstCustomerDivision addPstCustomerDivision(PstCustomerDivision pstCustomerDivision) {
		getPstCustomerDivisions().add(pstCustomerDivision);
		pstCustomerDivision.setPstCustomer(this);

		return pstCustomerDivision;
	}

	public PstCustomerDivision removePstCustomerDivision(PstCustomerDivision pstCustomerDivision) {
		getPstCustomerDivisions().remove(pstCustomerDivision);
		pstCustomerDivision.setPstCustomer(null);

		return pstCustomerDivision;
	}
*/
}