package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_VENDORS database table.
 * 
 */
@XStreamAlias("BpmVendor")
public class BpmVendor  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private String bvCod;
 
	private String bvAddr; 
	
	private String bvContact; 
	
	private String bvFax;
 
	private String bvName; 
	
	private String bvTel;

	public BpmVendor() {
	}

	public String getBvCod() {
		return this.bvCod;
	}

	public void setBvCod(String bvCod) {
		this.bvCod = bvCod;
	}

	public String getBvAddr() {
		return this.bvAddr;
	}

	public void setBvAddr(String bvAddr) {
		this.bvAddr = bvAddr;
	}

	public String getBvContact() {
		return this.bvContact;
	}

	public void setBvContact(String bvContact) {
		this.bvContact = bvContact;
	}

	public String getBvFax() {
		return this.bvFax;
	}

	public void setBvFax(String bvFax) {
		this.bvFax = bvFax;
	}

	public String getBvName() {
		return this.bvName;
	}

	public void setBvName(String bvName) {
		this.bvName = bvName;
	}

	public String getBvTel() {
		return this.bvTel;
	}

	public void setBvTel(String bvTel) {
		this.bvTel = bvTel;
	}

}