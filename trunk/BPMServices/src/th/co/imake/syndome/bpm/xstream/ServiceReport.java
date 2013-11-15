package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;
import java.util.List;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamImplicit;
@XStreamAlias("ServiceReport")
public class ServiceReport  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	private String year;
	private String month;
	private String mode;

	@XStreamImplicit(itemFieldName="serySystemUsed")
	private List<List<String>> serySystemUsed;
	
	@XStreamImplicit(itemFieldName="seryPercentReactive")
	//private List<String[]> seryPercentReactive;
	private List<List<String>> seryPercentReactive;
	
	@XStreamImplicit(itemFieldName="seryCountReactive")
	private List<List<String>> seryCountReactive;
	
	@XStreamImplicit(itemFieldName="browsers")
	private List<String> browsers;
	
	@XStreamImplicit(itemFieldName="seryProblem")
	private List<String> seryProblem;

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public List<List<String>> getSerySystemUsed() {
		return serySystemUsed;
	}

	public void setSerySystemUsed(List<List<String>> serySystemUsed) {
		this.serySystemUsed = serySystemUsed;
	}

	public List<List<String>> getSeryPercentReactive() {
		return seryPercentReactive;
	}

	public void setSeryPercentReactive(List<List<String>> seryPercentReactive) {
		this.seryPercentReactive = seryPercentReactive;
	}

	public List<List<String>> getSeryCountReactive() {
		return seryCountReactive;
	}

	public void setSeryCountReactive(List<List<String>> seryCountReactive) {
		this.seryCountReactive = seryCountReactive;
	}

	public List<String> getBrowsers() {
		return browsers;
	}

	public void setBrowsers(List<String> browsers) {
		this.browsers = browsers;
	}

	public List<String> getSeryProblem() {
		return seryProblem;
	}

	public void setSeryProblem(List<String> seryProblem) {
		this.seryProblem = seryProblem;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}
}
