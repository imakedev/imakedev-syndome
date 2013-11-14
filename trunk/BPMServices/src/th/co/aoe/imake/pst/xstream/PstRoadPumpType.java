package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_ROAD_PUMP_TYPE database table.
 * 
 */
@XStreamAlias("PstRoadPumpType")
public class PstRoadPumpType extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long prptId;

	private String prptName;

	//bi-directional many-to-one association to PstRoadPump
	/*@OneToMany(mappedBy="pstRoadPumpType")
	private List<PstRoadPump> pstRoadPumps;*/

	public PstRoadPumpType() {
	}

	public PstRoadPumpType(Long prptId, String prptName) {
		super();
		this.prptId = prptId;
		this.prptName = prptName;
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