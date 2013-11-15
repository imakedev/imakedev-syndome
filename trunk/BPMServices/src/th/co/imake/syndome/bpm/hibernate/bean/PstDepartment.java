package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the PST_DEPARTMENT database table.
 * 
 */
@Entity
@Table(name="PST_DEPARTMENT",schema="PST_DB")
public class PstDepartment implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PD_ID")
	private Long pdId;

	@Column(name="PD_NAME")
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