package th.co.aoe.imake.pst.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstRoadPumpStatus;

public class RoadPumpStatusForm extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PstRoadPumpStatus pstRoadPumpStatus;
	public RoadPumpStatusForm() {
		pstRoadPumpStatus=new PstRoadPumpStatus();
	}
	public PstRoadPumpStatus getPstRoadPumpStatus() {
		return pstRoadPumpStatus;
	}
	public void setPstRoadPumpStatus(PstRoadPumpStatus pstRoadPumpStatus) {
		this.pstRoadPumpStatus = pstRoadPumpStatus;
	}
	

}
