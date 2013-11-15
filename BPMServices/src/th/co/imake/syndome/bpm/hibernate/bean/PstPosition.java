package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the PST_POSITION database table.
 * 
 */
@Entity
@Table(name="PST_POSITION",schema="PST_DB")
public class PstPosition implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PP_ID")
	private Long ppId;

	@Column(name="PP_NAME")
	private String ppName;

	//bi-directional many-to-one association to PstEmployee
	/*@OneToMany(mappedBy="pstPosition")
	private List<PstEmployee> pstEmployees;*/

	public PstPosition() {
	}

	public Long getPpId() {
		return this.ppId;
	}

	public void setPpId(Long ppId) {
		this.ppId = ppId;
	}

	public String getPpName() {
		return this.ppName;
	}

	public void setPpName(String ppName) {
		this.ppName = ppName;
	}

	/*public List<PstEmployee> getPstEmployees() {
		return this.pstEmployees;
	}

	public void setPstEmployees(List<PstEmployee> pstEmployees) {
		this.pstEmployees = pstEmployees;
	}*/

}