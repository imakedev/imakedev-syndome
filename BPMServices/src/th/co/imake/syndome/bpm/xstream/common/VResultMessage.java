package th.co.imake.syndome.bpm.xstream.common;

import java.io.Serializable;
import java.util.List;

import com.thoughtworks.xstream.annotations.XStreamAlias;
 
/**
 * @author Chatchai Pimtun 
 *
 */
@XStreamAlias("vresultMessage")
public class VResultMessage implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@XStreamAlias("resultMessage") 
	private VMessage resultMessage;
	
	//@XStreamImplicit(itemFieldName="resultListObj")
	@SuppressWarnings("rawtypes")
	@XStreamAlias("resultListObj") 
	private List resultListObj;
	
	@XStreamAlias("maxRow")
	private String maxRow;
	
	@XStreamAlias("lastpage")
	private String lastpage;
	
	@XStreamAlias("returnId")
	private String returnId;
	
	private Integer updateRecord;
	
	public String getReturnId() {
		return returnId;
	}
	public void setReturnId(String returnId) {
		this.returnId = returnId;
	}
	public VMessage getResultMessage() {
		return resultMessage;
	}
	public void setResultMessage(VMessage resultMessage) {
		this.resultMessage = resultMessage;
	}
	 
	@SuppressWarnings("rawtypes")
	public List getResultListObj() {
		return resultListObj;
	}
	public void setResultListObj(@SuppressWarnings("rawtypes") List  resultListObj) {
		this.resultListObj = resultListObj;
	}
	public String getMaxRow() {
		return maxRow;
	}
	public void setMaxRow(String maxRow) {
		this.maxRow = maxRow;
	}
	public String getLastpage() {
		return lastpage;
	}
	public void setLastpage(String lastpage) {
		this.lastpage = lastpage;
	}
	public Integer getUpdateRecord() {
		return updateRecord;
	}
	public void setUpdateRecord(Integer updateRecord) {
		this.updateRecord = updateRecord;
	}
	
	
}
