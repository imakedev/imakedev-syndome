package th.co.imake.syndome.bpm.xstream.common;

import java.io.Serializable;
import java.util.Map;

import com.thoughtworks.xstream.annotations.XStreamAlias;
/**
 * @author Chatchai Pimtun (Admin)
 *
 */
@XStreamAlias("vservicexml")
public class VServiceXML implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@XStreamAlias("servicename")
	private String serviceName;
	
	private String ids;
	
	@XStreamAlias("fieldId")
	private String fieldId;
	
	private Integer updateRecord;
	
	public String getFieldId() {
		return fieldId;
	}
	public void setFieldId(String fieldId) {
		this.fieldId = fieldId;
	}
	@SuppressWarnings("rawtypes")
	@XStreamAlias("likeExpression")
	private Map likeExpression;
	
	@SuppressWarnings("rawtypes")
	@XStreamAlias("likeFirstExpression")
	private Map likeFirstExpression;
	@SuppressWarnings("rawtypes")
	@XStreamAlias("likeEndExpression")
	private Map likeEndExpression;
	
	@SuppressWarnings("rawtypes")
	@XStreamAlias("leExpression")
	private Map leExpression;
	
	@SuppressWarnings("rawtypes")
	@XStreamAlias("geExpression")
	private Map geExpression;
	@SuppressWarnings("rawtypes")
	@XStreamAlias("neExpression")
	private Map neExpression;
	
	@XStreamAlias("pagging")
	private Pagging pagging;
	
/*	@XStreamAlias("vcriteria")
	private VCriteria vcriteria;*/
	
	public VServiceXML() {
		pagging = new Pagging();
		//vcriteria = new VCriteria();
		
	}
	/*public VCriteria getVcriteria() {
		return vcriteria;
	}
	public void setVcriteria(VCriteria vcriteria) {
		this.vcriteria = vcriteria;
	}*/
	public Pagging getPagging() {
		return pagging;
	}
	public void setPagging(Pagging pagging) {
		this.pagging = pagging;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	@SuppressWarnings("rawtypes")
	public Map getLikeExpression() {
		return likeExpression;
	}
	public void setLikeExpression(@SuppressWarnings("rawtypes") Map likeExpression) {
		this.likeExpression = likeExpression;
	}
	@SuppressWarnings("rawtypes")
	public Map getLeExpression() {
		return leExpression;
	}
	public void setLeExpression(@SuppressWarnings("rawtypes") Map leExpression) {
		this.leExpression = leExpression;
	}
	@SuppressWarnings("rawtypes")
	public Map getGeExpression() {
		return geExpression;
	}
	public void setGeExpression(@SuppressWarnings("rawtypes") Map geExpression) {
		this.geExpression = geExpression;
	}
	@SuppressWarnings("rawtypes")
	public Map getLikeFirstExpression() {
		return likeFirstExpression;
	}
	public void setLikeFirstExpression(@SuppressWarnings("rawtypes") Map likeFirstExpression) {
		this.likeFirstExpression = likeFirstExpression;
	}
	@SuppressWarnings("rawtypes")
	public Map getLikeEndExpression() {
		return likeEndExpression;
	}
	public void setLikeEndExpression(@SuppressWarnings("rawtypes") Map likeEndExpression) {
		this.likeEndExpression = likeEndExpression;
	}
	@SuppressWarnings("rawtypes")
	public Map getNeExpression() {
		return neExpression;
	}
	public void setNeExpression(@SuppressWarnings("rawtypes") Map neExpression) {
		this.neExpression = neExpression;
	}
	public Integer getUpdateRecord() {
		return updateRecord;
	}
	public void setUpdateRecord(Integer updateRecord) {
		this.updateRecord = updateRecord;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}

}
