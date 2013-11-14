package th.co.aoe.imake.pst.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstConcrete;

public class ConcreteForm  extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PstConcrete pstConcrete;
	public ConcreteForm() {
		pstConcrete=new PstConcrete();
	}
	public PstConcrete getPstConcrete() {
		return pstConcrete;
	}
	public void setPstConcrete(PstConcrete pstConcrete) {
		this.pstConcrete = pstConcrete;
	}

}
