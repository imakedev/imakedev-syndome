package th.co.aoe.imake.pst.backoffice.form;

import java.io.Serializable;

import th.co.aoe.imake.pst.xstream.PstJob;
import th.co.aoe.imake.pst.xstream.PstJobEmployee;
import th.co.aoe.imake.pst.xstream.PstJobPay;
import th.co.aoe.imake.pst.xstream.PstJobPayExt;
import th.co.aoe.imake.pst.xstream.PstJobWork;

public class JobForm extends CommonForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PstJob pstJob;
	private String pjIdArray;
	private String prpNo;
	private String pjCreatedTime;
	private PstJobPayExt pstJobPayExt;
	private PstJobPay pstJobPay;
	private PstJobEmployee pstJobEmployee;
	private PstJobWork pstJobWork;
	private String part;
	
	//ext  
	private Long pccId;
	private String pccName; 
	 
	private Long pcdId; 
	private String pcdName; 
	
	private Long pcId; 
	
	 
	public JobForm() {
		//super();
		this.pstJob = new PstJob();
		this.pstJobPayExt=new PstJobPayExt();
		this.pstJobPay =new PstJobPay();
		this.pstJobEmployee =new PstJobEmployee();
		this.pstJobWork =new PstJobWork();
	}
	public Long getPccId() {
		return pccId;
	}
	public void setPccId(Long pccId) {
		this.pccId = pccId;
	}
	public String getPccName() {
		return pccName;
	}
	public void setPccName(String pccName) {
		this.pccName = pccName;
	}
	public Long getPcdId() {
		return pcdId;
	}
	public void setPcdId(Long pcdId) {
		this.pcdId = pcdId;
	}
	public String getPcdName() {
		return pcdName;
	}
	public void setPcdName(String pcdName) {
		this.pcdName = pcdName;
	}
	public Long getPcId() {
		return pcId;
	}
	public void setPcId(Long pcId) {
		this.pcId = pcId;
	}
	public PstJob getPstJob() {
		return pstJob;
	}
	public void setPstJob(PstJob pstJob) {
		this.pstJob = pstJob;
	}
	public String getPjIdArray() {
		return pjIdArray;
	}
	public void setPjIdArray(String pjIdArray) {
		this.pjIdArray = pjIdArray;
	}
	public String getPrpNo() {
		return prpNo;
	}
	public void setPrpNo(String prpNo) {
		this.prpNo = prpNo;
	}
	public String getPjCreatedTime() {
		return pjCreatedTime;
	}
	public void setPjCreatedTime(String pjCreatedTime) {
		this.pjCreatedTime = pjCreatedTime;
	}
	public PstJobPayExt getPstJobPayExt() {
		return pstJobPayExt;
	}
	public void setPstJobPayExt(PstJobPayExt pstJobPayExt) {
		this.pstJobPayExt = pstJobPayExt;
	}
	public PstJobPay getPstJobPay() {
		return pstJobPay;
	}
	public void setPstJobPay(PstJobPay pstJobPay) {
		this.pstJobPay = pstJobPay;
	}
	public PstJobEmployee getPstJobEmployee() {
		return pstJobEmployee;
	}
	public void setPstJobEmployee(PstJobEmployee pstJobEmployee) {
		this.pstJobEmployee = pstJobEmployee;
	}
	public PstJobWork getPstJobWork() {
		return pstJobWork;
	}
	public void setPstJobWork(PstJobWork pstJobWork) {
		this.pstJobWork = pstJobWork;
	}
	public String getPart() {
		return part;
	}
	public void setPart(String part) {
		this.part = part;
	}
	
	//pstEmployeeStatus=new PstEmployeeStatus();
}
