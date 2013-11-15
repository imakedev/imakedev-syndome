package th.co.imake.syndome.bpm.backoffice.form;

import java.io.Serializable;


public class UserForm  extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private th.co.aoe.imake.pst.xstream.User user;
	public UserForm() {
		user=new th.co.aoe.imake.pst.xstream.User();
	}
	public th.co.aoe.imake.pst.xstream.User getUser() {
		return user;
	}
	public void setUser(th.co.aoe.imake.pst.xstream.User user) {
		this.user = user;
	}
	
}
