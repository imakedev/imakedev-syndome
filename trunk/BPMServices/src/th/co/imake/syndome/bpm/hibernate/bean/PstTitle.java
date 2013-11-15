package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the PST_TITLE database table.
 * 
 */
@Entity
@Table(name="PST_TITLE",schema="PST_DB")
public class PstTitle implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PT_ID")
	private Long ptId;

	@Column(name="PT_NAME")
	private String ptName;

	//bi-directional many-to-one association to PstEmployee
	/*@OneToMany(mappedBy="pstTitle")
	private List<PstEmployee> pstEmployees;*/

	public PstTitle() {
	}

	public Long getPtId() {
		return this.ptId;
	}

	public void setPtId(Long ptId) {
		this.ptId = ptId;
	}

	public String getPtName() {
		return this.ptName;
	}

	public void setPtName(String ptName) {
		this.ptName = ptName;
	}

	/*public List<PstEmployee> getPstEmployees() {
		return this.pstEmployees;
	}

	public void setPstEmployees(List<PstEmployee> pstEmployees) {
		this.pstEmployees = pstEmployees;
	}*/

}