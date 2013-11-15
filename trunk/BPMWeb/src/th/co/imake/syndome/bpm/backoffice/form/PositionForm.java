package th.co.imake.syndome.bpm.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstPosition;

public class PositionForm  extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PstPosition pstPosition;
	public PositionForm() {
		pstPosition=new PstPosition();
	}
	public PstPosition getPstPosition() {
		return pstPosition;
	}
	public void setPstPosition(PstPosition pstPosition) {
		this.pstPosition = pstPosition;
	}
	
}
