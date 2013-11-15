package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the PST_EMPLOYEE_STATUS database table.
 * 
 */
@Entity
@Table(name="PST_EMPLOYEE_STATUS",schema="PST_DB")
public class PstEmployeeStatus implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PES_ID")
	private Long pesId;

	@Column(name="PES_NAME")
	private String pesName;

	@Column(name="PES_WAGE_RATE")
	private Long pesWageRate;

	//bi-directional many-to-one association to PstEmployeeWorkMapping
	/*@OneToMany(mappedBy="pstEmployeeStatus")
	private List<PstEmployeeWorkMapping> pstEmployeeWorkMappings;*/

	public PstEmployeeStatus() {
	}

	public Long getPesId() {
		return this.pesId;
	}

	public void setPesId(Long pesId) {
		this.pesId = pesId;
	}

	public String getPesName() {
		return this.pesName;
	}

	public void setPesName(String pesName) {
		this.pesName = pesName;
	}

	public Long getPesWageRate() {
		return this.pesWageRate;
	}

	public void setPesWageRate(Long pesWageRate) {
		this.pesWageRate = pesWageRate;
	}

	/*public List<PstEmployeeWorkMapping> getPstEmployeeWorkMappings() {
		return this.pstEmployeeWorkMappings;
	}

	public void setPstEmployeeWorkMappings(List<PstEmployeeWorkMapping> pstEmployeeWorkMappings) {
		this.pstEmployeeWorkMappings = pstEmployeeWorkMappings;
	}*/

}