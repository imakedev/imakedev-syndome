package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_DEPARTMENT database table.
 * 
 */
@XStreamAlias("PstDepartment")
public class PstDepartment extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long pdId;

	private String pdName;

	//bi-directional many-to-one association to PstCheckingMapping
	/*@OneToMany(mappedBy="pstDepartment")
	private List<PstCheckingMapping> pstCheckingMappings;

	//bi-directional many-to-one association to PstMaintenance
	@OneToMany(mappedBy="pstDepartment")
	private List<PstMaintenance> pstMaintenances;

	//bi-directional many-to-one association to PstRoadPumpDeactiveMapping
	@OneToMany(mappedBy="pstDepartment")
	private List<PstRoadPumpDeactiveMapping> pstRoadPumpDeactiveMappings;

	//bi-directional many-to-one association to PstWorkType
	@OneToMany(mappedBy="pstDepartment")
	private List<PstWorkType> pstWorkTypes;*/

	public PstDepartment() {
	}

	public PstDepartment(Long pdId, String pdName) {
		super();
		this.pdId = pdId;
		this.pdName = pdName;
	}

	public Long getPdId() {
		return this.pdId;
	}

	public void setPdId(Long pdId) {
		this.pdId = pdId;
	}

	public String getPdName() {
		return this.pdName;
	}

	public void setPdName(String pdName) {
		this.pdName = pdName;
	}

	/*public List<PstCheckingMapping> getPstCheckingMappings() {
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

	public List<PstWorkType> getPstWorkTypes() {
		return this.pstWorkTypes;
	}

	public void setPstWorkTypes(List<PstWorkType> pstWorkTypes) {
		this.pstWorkTypes = pstWorkTypes;
	}*/

}