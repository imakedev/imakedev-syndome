package th.co.imake.syndome.bpm.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstModel;

public class ModelForm extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PstModel pstModel;
	public ModelForm() {
		pstModel=new PstModel();
	}
	public PstModel getPstModel() {
		return pstModel;
	}
	public void setPstModel(PstModel pstModel) {
		this.pstModel = pstModel;
	}

}
