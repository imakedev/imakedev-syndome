package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_GROUP_LEVEL database table.
 * 
 */
@XStreamAlias("BpmGroupLevel")
public class BpmGroupLevel  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long bglId;
 
	private String bglName;

	public BpmGroupLevel() {
	}

	public Long getBglId() {
		return this.bglId;
	}

	public void setBglId(Long bglId) {
		this.bglId = bglId;
	}

	public String getBglName() {
		return this.bglName;
	}

	public void setBglName(String bglName) {
		this.bglName = bglName;
	}

}