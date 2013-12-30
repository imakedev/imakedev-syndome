package th.co.imake.syndome.bpm.backoffice.form;

import java.io.Serializable;


public class UserForm  extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private th.co.imake.syndome.bpm.xstream.User user;
	public UserForm() {
		user=new th.co.imake.syndome.bpm.xstream.User();
	}
	public th.co.imake.syndome.bpm.xstream.User getUser() {
		return user;
	}
	public void setUser(th.co.imake.syndome.bpm.xstream.User user) {
		this.user = user;
	}
	
}
