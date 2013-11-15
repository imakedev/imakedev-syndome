package th.co.imake.syndome.bpm.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstRoadPump;

public class RoadPumpForm extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	 private String prpIdArray;
		private PstRoadPump pstRoadPump;
		public RoadPumpForm() {
			pstRoadPump=new PstRoadPump();
		}
		public String getPrpIdArray() {
			return prpIdArray;
		}
		public void setPrpIdArray(String prpIdArray) {
			this.prpIdArray = prpIdArray;
		}
		public PstRoadPump getPstRoadPump() {
			return pstRoadPump;
		}
		public void setPstRoadPump(PstRoadPump pstRoadPump) {
			this.pstRoadPump = pstRoadPump;
		}
		
		
}
