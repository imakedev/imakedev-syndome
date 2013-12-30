package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_POSITION database table.
 * 
 */
@XStreamAlias("BpmPosition")
public class BpmPosition  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long bpId;
 
	private String bpName;

	public BpmPosition() {
	}

	public Long getBpId() {
		return this.bpId;
	}

	public void setBpId(Long bpId) {
		this.bpId = bpId;
	}

	public String getBpName() {
		return this.bpName;
	}

	public void setBpName(String bpName) {
		this.bpName = bpName;
	}

}