package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;
import java.util.List;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("PstObject")
public class PstObject extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;
	public PstObject() {
		 
	}
	public PstObject(String[] query) {
		super();
		this.query = query;
	}
	private String[] query;
	private String[] queryUpdate;
	private String[] queryDelete;
	private List<String[]> values;
	
	//ext
	  
	private String mode;
	public String[] getQuery() {
		return query;
	}
	public void setQuery(String[] query) {
		this.query = query;
	}
	public String[] getQueryUpdate() {
		return queryUpdate;
	}
	public void setQueryUpdate(String[] queryUpdate) {
		this.queryUpdate = queryUpdate;
	}
	public String[] getQueryDelete() {
		return queryDelete;
	}
	public void setQueryDelete(String[] queryDelete) {
		this.queryDelete = queryDelete;
	}
	 
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public List<String[]> getValues() {
		return values;
	}
	public void setValues(List<String[]> values) {
		this.values = values;
	}
	

}
