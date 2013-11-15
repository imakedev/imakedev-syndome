package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


/**
 * The persistent class for the PST_EMPLOYEE database table.
 * 
 */
@Entity
@Table(name="PST_EMPLOYEE",schema="PST_DB")
public class PstEmployee implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PE_ID")
	private Long peId;

	@Column(name="PE_FIRST_NAME")
	private String peFirstName;

	@Column(name="PE_LAST_NAME")
	private String peLastName;

	@Column(name="PE_TITLE")
	private String peTitle;

	@Column(name="PE_UID")
	private String peUid;

	@Column(name="PE_WAGE")
	private BigDecimal peWage;

	//bi-directional many-to-one association to PstPosition
	@ManyToOne
	@JoinColumn(name="PP_ID",nullable=true)
	private PstPosition pstPosition;

	//bi-directional many-to-one association to PstTitle
	@ManyToOne
	@JoinColumn(name="PT_ID",nullable=true)
	private PstTitle pstTitle;

	@ManyToOne
	@JoinColumn(name="PRP_ID",nullable=true)
	private PstRoadPump pstRoadPump;
	//bi-directional many-to-one association to PstEmployeeWorkMapping
	/*@OneToMany(mappedBy="pstEmployee")
	private List<PstEmployeeWorkMapping> pstEmployeeWorkMappings;*/

	//bi-directional many-to-one association to PstJobEmployee
	/*@OneToMany(mappedBy="pstEmployee")
	private List<PstJobEmployee> pstJobEmployees;*/

	public PstEmployee() {
	}

	public Long getPeId() {
		return this.peId;
	}

	public void setPeId(Long peId) {
		this.peId = peId;
	}

	public String getPeFirstName() {
		return this.peFirstName;
	}

	public void setPeFirstName(String peFirstName) {
		this.peFirstName = peFirstName;
	}

	public String getPeLastName() {
		return this.peLastName;
	}

	public void setPeLastName(String peLastName) {
		this.peLastName = peLastName;
	}

	public String getPeTitle() {
		return this.peTitle;
	}

	public void setPeTitle(String peTitle) {
		this.peTitle = peTitle;
	}

	public String getPeUid() {
		return this.peUid;
	}

	public void setPeUid(String peUid) {
		this.peUid = peUid;
	}

	public BigDecimal getPeWage() {
		return this.peWage;
	}

	public void setPeWage(BigDecimal peWage) {
		this.peWage = peWage;
	}

	public PstPosition getPstPosition() {
		return this.pstPosition;
	}

	public void setPstPosition(PstPosition pstPosition) {
		this.pstPosition = pstPosition;
	}

	public PstTitle getPstTitle() {
		return this.pstTitle;
	}

	public void setPstTitle(PstTitle pstTitle) {
		this.pstTitle = pstTitle;
	}

	public PstRoadPump getPstRoadPump() {
		return pstRoadPump;
	}

	public void setPstRoadPump(PstRoadPump pstRoadPump) {
		this.pstRoadPump = pstRoadPump;
	}

	/*public List<PstEmployeeWorkMapping> getPstEmployeeWorkMappings() {
		return this.pstEmployeeWorkMappings;
	}

	public void setPstEmployeeWorkMappings(List<PstEmployeeWorkMapping> pstEmployeeWorkMappings) {
		this.pstEmployeeWorkMappings = pstEmployeeWorkMappings;
	}

	public List<PstJobEmployee> getPstJobEmployees() {
		return this.pstJobEmployees;
	}

	public void setPstJobEmployees(List<PstJobEmployee> pstJobEmployees) {
		this.pstJobEmployees = pstJobEmployees;
	}*/

}