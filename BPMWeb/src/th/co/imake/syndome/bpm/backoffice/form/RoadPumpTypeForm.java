package th.co.imake.syndome.bpm.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstRoadPumpType;

public class RoadPumpTypeForm extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PstRoadPumpType pstRoadPumpType;
	public RoadPumpTypeForm() {
		pstRoadPumpType=new PstRoadPumpType();
	}
	public PstRoadPumpType getPstRoadPumpType() {
		return pstRoadPumpType;
	}
	public void setPstRoadPumpType(PstRoadPumpType pstRoadPumpType) {
		this.pstRoadPumpType = pstRoadPumpType;
	}
}

