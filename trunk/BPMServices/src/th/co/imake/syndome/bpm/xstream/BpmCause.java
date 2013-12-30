package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_CAUSE database table.
 * 
 */
@XStreamAlias("BpmCause")
public class BpmCause  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long bcauseId;
 
	private String bcauseName;

	public BpmCause() {
	}

	public Long getBcauseId() {
		return this.bcauseId;
	}

	public void setBcauseId(Long bcauseId) {
		this.bcauseId = bcauseId;
	}

	public String getBcauseName() {
		return this.bcauseName;
	}

	public void setBcauseName(String bcauseName) {
		this.bcauseName = bcauseName;
	}

}