package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the PST_ROAD_PUMP_TYPE database table.
 * 
 */
@Entity
@Table(name="PST_ROAD_PUMP_TYPE",schema="PST_DB")
public class PstRoadPumpType implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="PRPT_ID")
	private Long prptId;

	@Column(name="PRPT_NAME")
	private String prptName;

	//bi-directional many-to-one association to PstRoadPump
	/*@OneToMany(mappedBy="pstRoadPumpType")
	private List<PstRoadPump> pstRoadPumps;*/

	public PstRoadPumpType() {
	}

	public Long getPrptId() {
		return this.prptId;
	}

	public void setPrptId(Long prptId) {
		this.prptId = prptId;
	}

	public String getPrptName() {
		return this.prptName;
	}

	public void setPrptName(String prptName) {
		this.prptName = prptName;
	}

	/*public List<PstRoadPump> getPstRoadPumps() {
		return this.pstRoadPumps;
	}

	public void setPstRoadPumps(List<PstRoadPump> pstRoadPumps) {
		this.pstRoadPumps = pstRoadPumps;
	}*/

}