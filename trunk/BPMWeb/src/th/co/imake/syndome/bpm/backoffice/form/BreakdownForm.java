package th.co.imake.syndome.bpm.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstBreakDown;

public class BreakdownForm extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    private String pbdIdArray;
	private PstBreakDown pstBreakDown;
	public BreakdownForm() {
		pstBreakDown=new PstBreakDown();
	}
	public PstBreakDown getPstBreakDown() {
		return pstBreakDown;
	}
	public void setPstBreakDown(PstBreakDown pstBreakDown) {
		this.pstBreakDown = pstBreakDown;
	}
	public String getPbdIdArray() {
		return pbdIdArray;
	}
	public void setPbdIdArray(String pbdIdArray) {
		this.pbdIdArray = pbdIdArray;
	}

}
