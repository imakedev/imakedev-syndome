package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_GROUP database table.
 * 
 */
@XStreamAlias("BpmGroup")
public class BpmGroup  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	 
	private Long bgId;
 
	private String bgName;

	public BpmGroup() {
	}

	public Long getBgId() {
		return this.bgId;
	}

	public void setBgId(Long bgId) {
		this.bgId = bgId;
	}

	public String getBgName() {
		return this.bgName;
	}

	public void setBgName(String bgName) {
		this.bgName = bgName;
	}

}