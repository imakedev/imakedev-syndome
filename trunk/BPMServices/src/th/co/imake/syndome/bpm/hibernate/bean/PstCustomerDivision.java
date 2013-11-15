package th.co.imake.syndome.bpm.hibernate.bean;

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
 * The persistent class for the PST_CUSTOMER_DIVISION database table.
 * 
 */
@Entity
@Table(name="PST_CUSTOMER_DIVISION",schema="PST_DB")
public class PstCustomerDivision implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PCD_ID")
	private Long pcdId;

	@Column(name="PCD_NAME")
	private String pcdName;

	//bi-directional many-to-one association to PstCustomerContact
	/*@OneToMany(mappedBy="pstCustomerDivision")
	private List<PstCustomerContact> pstCustomerContacts;*/

	//bi-directional many-to-one association to PstCustomer
	@ManyToOne
	@JoinColumn(name="PC_ID")
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