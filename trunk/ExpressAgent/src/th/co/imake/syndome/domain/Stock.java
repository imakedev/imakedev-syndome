package th.co.imake.syndome.domain;

import java.io.Serializable;

public class Stock implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1749323943302555508L;
	// [IMA_ItemID],[IMA_ItemName],[LocQty],[AcctValAmt],[StdCostAmt],[AvgCostAmt],[LastCostAmt]
	// key==>[IMA_ItemID]_[LocQty]
	private Object[] objectArrays;

	public Object[] getObjectArrays() {
		return objectArrays;
	}

	public void setObjectArrays(Object[] objectArrays) {
		this.objectArrays = objectArrays;
	}
	

}
