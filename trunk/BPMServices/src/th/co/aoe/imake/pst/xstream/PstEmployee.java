package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;
import java.math.BigDecimal;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_EMPLOYEE database table.
 * 
 */
@XStreamAlias("PstEmployee")
public class PstEmployee extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long peId;

	private String peFirstName;

	private String peLastName;

	private String peTitle;

	private String peUid;

	private BigDecimal peWage;

	//bi-directional many-to-one association to PstPosition
	@XStreamAlias("pstPosition")
	private PstPosition pstPosition;

	//bi-directional many-to-one association to PstTitle
	@XStreamAlias("pstTitle")
	private PstTitle pstTitle;
	
	@XStreamAlias("pstRoadPump")
	private PstRoadPump pstRoadPump;

	//bi-directional many-to-one association to PstEmployeeWorkMapping
	/*@OneToMany(mappedBy="pstEmployee")
	private List<PstEmployeeWorkMapping> pstEmployeeWorkMappings;*/

	//bi-directional many-to-one association to PstJobEmployee
	/*@OneToMany(mappedBy="pstEmployee")
	private List<PstJobEmployee> pstJobEmployees;*/

	public PstEmployee() {
	}

	public PstEmployee(Long peId, String peFirstName, String peLastName,
			String peTitle, String peUid, BigDecimal peWage,
			PstPosition pstPosition, PstTitle pstTitle) {
		super();
		this.peId = peId;
		this.peFirstName = peFirstName;
		this.peLastName = peLastName;
		this.peTitle = peTitle;
		this.peUid = peUid;
		this.peWage = peWage;
		this.pstPosition = pstPosition;
		this.pstTitle = pstTitle;
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