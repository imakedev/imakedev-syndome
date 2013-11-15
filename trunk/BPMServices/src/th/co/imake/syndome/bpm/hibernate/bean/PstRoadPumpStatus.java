package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the PST_ROAD_PUMP_STATUS database table.
 * 
 */
@Entity
@Table(name="PST_ROAD_PUMP_STATUS",schema="PST_DB")
public class PstRoadPumpStatus implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PRPS_ID")
	private Long prpsId;

	@Column(name="PRPS_NAME")
	private String prpsName;

	//bi-directional many-to-one association to PstRoadPump
	/*@OneToMany(mappedBy="pstRoadPumpStatus")
	private List<PstRoadPump> pstRoadPumps;*/

	public PstRoadPumpStatus() {
	}

	public Long getPrpsId() {
		return this.prpsId;
	}

	public void setPrpsId(Long prpsId) {
		this.prpsId = prpsId;
	}

	public String getPrpsName() {
		return this.prpsName;
	}

	public void setPrpsName(String prpsName) {
		this.prpsName = prpsName;
	}

	/*public List<PstRoadPump> getPstRoadPumps() {
		return this.pstRoadPumps;
	}

	public void setPstRoadPumps(List<PstRoadPump> pstRoadPumps) {
		this.pstRoadPumps = pstRoadPumps;
	}*/

}