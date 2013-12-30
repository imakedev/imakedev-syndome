package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_LEVEL database table.
 * 
 */
@XStreamAlias("BpmLevel")
public class BpmLevel  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long blId;
 
	private String blName;

	public BpmLevel() {
	}

	public Long getBlId() {
		return this.blId;
	}

	public void setBlId(Long blId) {
		this.blId = blId;
	}

	public String getBlName() {
		return this.blName;
	}

	public void setBlName(String blName) {
		this.blName = blName;
	}

}