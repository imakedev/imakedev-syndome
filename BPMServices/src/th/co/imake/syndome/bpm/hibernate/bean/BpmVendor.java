package th.co.imake.syndome.bpm.hibernate.bean;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the BPM_VENDORS database table.
 * 
 */
@Entity
@Table(name="BPM_VENDORS",schema="SYNDOME_BPM_DB")
public class BpmVendor implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="BV_COD")
	private String bvCod;

	@Column(name="BV_ADDR")
	private String bvAddr;

	@Column(name="BV_CONTACT")
	private String bvContact;

	@Column(name="BV_FAX")
	private String bvFax;

	@Column(name="BV_NAME")
	private String bvName;

	@Column(name="BV_TEL")
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