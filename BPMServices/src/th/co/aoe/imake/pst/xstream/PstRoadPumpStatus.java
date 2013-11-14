package th.co.aoe.imake.pst.xstream;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the PST_ROAD_PUMP_STATUS database table.
 * 
 */
@XStreamAlias("PstRoadPumpStatus")
public class PstRoadPumpStatus extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;


	private Long prpsId;

	private String prpsName;

	//bi-directional many-to-one association to PstRoadPump
	/*@OneToMany(mappedBy="pstRoadPumpStatus")
	private List<PstRoadPump> pstRoadPumps;*/

	public PstRoadPumpStatus() {
	}

	public PstRoadPumpStatus(Long prpsId, String prpsName) {
		super();
		this.prpsId = prpsId;
		this.prpsName = prpsName;
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