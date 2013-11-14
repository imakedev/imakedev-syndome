package th.co.aoe.imake.pst.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstWorkType;

public class WorkTypeForm extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PstWorkType pstWorkType;
	public WorkTypeForm() {
		pstWorkType=new PstWorkType();
	}
	public PstWorkType getPstWorkType() {
		return pstWorkType;
	}
	public void setPstWorkType(PstWorkType pstWorkType) {
		this.pstWorkType = pstWorkType;
	}

}
