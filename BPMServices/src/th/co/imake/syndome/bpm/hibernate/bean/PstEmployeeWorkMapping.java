package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the PST_EMPLOYEE_WORK_MAPPING database table.
 * 
 */
@Entity
@Table(name="PST_EMPLOYEE_WORK_MAPPING",schema="PST_DB")
public class PstEmployeeWorkMapping implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private PstEmployeeWorkMappingPK id;
	@Column(name="PES_ID")
	private Long pesId;

	@Column(name="PRP_NO")
	private String prpNo;
	//bi-directional many-to-one association to PstEmployee
	@ManyToOne
	@JoinColumn(name="PE_ID",insertable=false,updatable=false)
	private PstEmployee pstEmployee;

	//bi-directional many-to-one association to PstEmployeeStatus
	@ManyToOne
	@JoinColumn(name="PES_ID",insertable=false,updatable=false)
	private PstEmployeeStatus pstEmployeeStatus;

	public PstEmployeeWorkMapping() {
	}

	public PstEmployeeWorkMappingPK getId() {
		return this.id;
	}

	public void setId(PstEmployeeWorkMappingPK id) {
		this.id = id;
	}

	public PstEmployee getPstEmployee() {
		return this.pstEmployee;
	}

	public void setPstEmployee(PstEmployee pstEmployee) {
		this.pstEmployee = pstEmployee;
	}

	public PstEmployeeStatus getPstEmployeeStatus() {
		return this.pstEmployeeStatus;
	}

	public void setPstEmployeeStatus(PstEmployeeStatus pstEmployeeStatus) {
		this.pstEmployeeStatus = pstEmployeeStatus;
	}

	public Long getPesId() {
		return pesId;
	}

	public void setPesId(Long pesId) {
		this.pesId = pesId;
	}

	public String getPrpNo() {
		return prpNo;
	}

	public void setPrpNo(String prpNo) {
		this.prpNo = prpNo;
	}

}