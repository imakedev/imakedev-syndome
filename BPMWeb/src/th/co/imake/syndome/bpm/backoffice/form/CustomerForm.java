package th.co.imake.syndome.bpm.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstCustomer;
import th.co.aoe.imake.pst.xstream.PstCustomerContact;
import th.co.aoe.imake.pst.xstream.PstCustomerDivision;

public class CustomerForm  extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PstCustomer pstCustomer;
	private PstCustomerDivision pstCustomerDivision;
	private PstCustomerContact pstCustomerContact;
	public PstCustomer getPstCustomer() {
		return pstCustomer;
	}
	public void setPstCustomer(PstCustomer pstCustomer) {
		this.pstCustomer = pstCustomer; 
	}
	public PstCustomerDivision getPstCustomerDivision() {
		return pstCustomerDivision;
	}
	public void setPstCustomerDivision(PstCustomerDivision pstCustomerDivision) {
		this.pstCustomerDivision = pstCustomerDivision;
	}
	public PstCustomerContact getPstCustomerContact() {
		return pstCustomerContact;
	}
	public void setPstCustomerContact(PstCustomerContact pstCustomerContact) {
		this.pstCustomerContact = pstCustomerContact;
	}
	public CustomerForm() {
		this.pstCustomer = new PstCustomer();
		this.pstCustomerDivision= new PstCustomerDivision();
		this.pstCustomerContact =new PstCustomerContact();
	}
	

}
