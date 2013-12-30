package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_ASSIGN database table.
 * 
 */
@XStreamAlias("BpmAssign")
public class BpmAssign  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long baType;
 
	private String baCreatedDate;
 
	private String baRef; 
	
	private String baStaff;

	public BpmAssign() {
	}

	public Long getBaType() {
		return this.baType;
	}

	public void setBaType(Long baType) {
		this.baType = baType;
	}

	public String getBaCreatedDate() {
		return this.baCreatedDate;
	}

	public void setBaCreatedDate(String baCreatedDate) {
		this.baCreatedDate = baCreatedDate;
	}

	public String getBaRef() {
		return this.baRef;
	}

	public void setBaRef(String baRef) {
		this.baRef = baRef;
	}

	public String getBaStaff() {
		return this.baStaff;
	}

	public void setBaStaff(String baStaff) {
		this.baStaff = baStaff;
	}

}