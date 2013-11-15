package th.co.imake.syndome.bpm.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstCost;

public class CostForm extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    private String pcIdArray;
	private PstCost pstCost;
	public CostForm() {
		pstCost=new PstCost();
	}
	public String getPcIdArray() {
		return pcIdArray;
	}
	public void setPcIdArray(String pcIdArray) {
		this.pcIdArray = pcIdArray;
	}
	public PstCost getPstCost() {
		return pstCost;
	}
	public void setPstCost(PstCost pstCost) {
		this.pstCost = pstCost;
	}
	
}
