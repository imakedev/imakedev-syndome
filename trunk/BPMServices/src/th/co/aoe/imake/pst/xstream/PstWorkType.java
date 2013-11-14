package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_WORK_TYPE database table.
 * 
 */
@XStreamAlias("PstWorkType")
public class PstWorkType extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;


	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PWT_ID")
	private Long pwtId;

	@Column(name="PWT_CONCRETE")
	private BigDecimal pwtConcrete;

	@Column(name="PWT_HOURS_OF_WORK")
	private BigDecimal pwtHoursOfWork;

	@Column(name="PWT_MILE")
	private BigDecimal pwtMile;

	@Column(name="PWT_NAME")
	private String pwtName;

	@Column(name="PWT_PERIOD")
	private BigDecimal pwtPeriod;

	/*//bi-directional many-to-one association to PstCheckingMapping
	@OneToMany(mappedBy="pstWorkType")
	private List<PstCheckingMapping> pstCheckingMappings;

	//bi-directional many-to-one association to PstMaintenance
	@OneToMany(mappedBy="pstWorkType")
	private List<PstMaintenance> pstMaintenances;

	//bi-directional many-to-one association to PstRoadPumpDeactiveMapping
	@OneToMany(mappedBy="pstWorkType")
	private List<PstRoadPumpDeactiveMapping> pstRoadPumpDeactiveMappings;*/

	//bi-directional many-to-one association to PstDepartment
	@XStreamAlias("pstDepartment")
	private PstDepartment pstDepartment;

	public PstWorkType() {
		pstDepartment=new PstDepartment(-1l,null);
	}

	public Long getPwtId() {
		return this.pwtId;
	}

	public void setPwtId(Long pwtId) {
		this.pwtId = pwtId;
	}

	public BigDecimal getPwtConcrete() {
		return this.pwtConcrete;
	}

	public void setPwtConcrete(BigDecimal pwtConcrete) {
		this.pwtConcrete = pwtConcrete;
	}

	public BigDecimal getPwtHoursOfWork() {
		return this.pwtHoursOfWork;
	}

	public void setPwtHoursOfWork(BigDecimal pwtHoursOfWork) {
		this.pwtHoursOfWork = pwtHoursOfWork;
	}

	public BigDecimal getPwtMile() {
		return this.pwtMile;
	}

	public void setPwtMile(BigDecimal pwtMile) {
		this.pwtMile = pwtMile;
	}

	public String getPwtName() {
		return this.pwtName;
	}

	public void setPwtName(String pwtName) {
		this.pwtName = pwtName;
	}

	public BigDecimal getPwtPeriod() {
		return this.pwtPeriod;
	}

	public void setPwtPeriod(BigDecimal pwtPeriod) {
		this.pwtPeriod = pwtPeriod;
	}
/*
	public List<PstCheckingMapping> getPstCheckingMappings() {
		return this.pstCheckingMappings;
	}

	public void setPstCheckingMappings(List<PstCheckingMapping> pstCheckingMappings) {
		this.pstCheckingMappings = pstCheckingMappings;
	}

	public List<PstMaintenance> getPstMaintenances() {
		return this.pstMaintenances;
	}

	public void setPstMaintenances(List<PstMaintenance> pstMaintenances) {
		this.pstMaintenances = pstMaintenances;
	}

	public List<PstRoadPumpDeactiveMapping> getPstRoadPumpDeactiveMappings() {
		return this.pstRoadPumpDeactiveMappings;
	}

	public void setPstRoadPumpDeactiveMappings(List<PstRoadPumpDeactiveMapping> pstRoadPumpDeactiveMappings) {
		this.pstRoadPumpDeactiveMappings = pstRoadPumpDeactiveMappings;
	}
*/
	public PstDepartment getPstDepartment() {
		return this.pstDepartment;
	}

	public void setPstDepartment(PstDepartment pstDepartment) {
		this.pstDepartment = pstDepartment;
	}

}