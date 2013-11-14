package th.co.aoe.imake.pst.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstBrand;

public class BrandForm extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PstBrand pstBrand;
	public BrandForm() {
		pstBrand=new PstBrand();
	}
	public PstBrand getPstBrand() {
		return pstBrand;
	}
	public void setPstBrand(PstBrand pstBrand) {
		this.pstBrand = pstBrand;
	}

}
