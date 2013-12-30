package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_APPLICATION_LOG database table.
 * 
 */
@XStreamAlias("BpmApplicationLog")
public class BpmApplicationLog  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	 
	private Long balId;
 
	private Long balType;
 
	private Long balRef;
 
	private String balAction;
 
	private String balCreatedDate;
 
	private String balStatus;

	public BpmApplicationLog() {
	}

 

	public Long getBalId() {
		return balId;
	}



	public void setBalId(Long balId) {
		this.balId = balId;
	}



	public Long getBalType() {
		return balType;
	}



	public void setBalType(Long balType) {
		this.balType = balType;
	}



	public Long getBalRef() {
		return balRef;
	}



	public void setBalRef(Long balRef) {
		this.balRef = balRef;
	}



	public String getBalAction() {
		return this.balAction;
	}

	public void setBalAction(String balAction) {
		this.balAction = balAction;
	}

	public String getBalCreatedDate() {
		return this.balCreatedDate;
	}

	public void setBalCreatedDate(String balCreatedDate) {
		this.balCreatedDate = balCreatedDate;
	}

	public String getBalStatus() {
		return this.balStatus;
	}

	public void setBalStatus(String balStatus) {
		this.balStatus = balStatus;
	}

}