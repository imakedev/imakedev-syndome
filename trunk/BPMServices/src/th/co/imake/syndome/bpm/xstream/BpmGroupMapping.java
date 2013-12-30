package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_GROUP_MAPPING database table.
 * 
 */
@XStreamAlias("BpmGroupMapping")
public class BpmGroupMapping  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
 
	private Long bgId;
 
	private Long bgUserid;
 
	private Long bglId;

	public BpmGroupMapping() {
	}

	public Long getBgId() {
		return bgId;
	}

	public void setBgId(Long bgId) {
		this.bgId = bgId;
	}

	public Long getBgUserid() {
		return bgUserid;
	}

	public void setBgUserid(Long bgUserid) {
		this.bgUserid = bgUserid;
	}

	public Long getBglId() {
		return bglId;
	}

	public void setBglId(Long bglId) {
		this.bglId = bglId;
	}

	 

}