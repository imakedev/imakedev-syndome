package th.co.aoe.imake.pst.rest.resource;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.restlet.representation.Representation;
import org.restlet.representation.Variant;
import org.restlet.resource.ResourceException;
import org.springframework.beans.BeanUtils;

import com.thoughtworks.xstream.annotations.XStreamAlias;

import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.managers.PSTCommonService;
import th.co.aoe.imake.pst.managers.PstJobEmployeeService;
import th.co.aoe.imake.pst.xstream.PstBrand;
import th.co.aoe.imake.pst.xstream.PstModel;
import th.co.aoe.imake.pst.xstream.PstRoadPumpStatus;
import th.co.aoe.imake.pst.xstream.PstRoadPumpType;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

public class PstJobEmployeeResource  extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstJobEmployeeService pstJobEmployeeService; 
	private com.thoughtworks.xstream.XStream xstream; 
	private String[] ignore_id={"id","pstEmployee","pstJob","pstRoadPump"};  
	private String[] ignore_employee_id={"pstPosition","pstTitle","pstRoadPump"};
	private String[] ignore_job_id={"pstConcrete","pstRoadPump"};
	private String[] ignore_roadpump_id={"pstBrandRoad","pstBrandPump","pstModelRoad","pstModelPump","pstRoadPumpStatus","pstRoadPumpType",
			"pstBrandRoadList","pstRoadPumpType","pstBrandRoadList","pstBrandPumpList","pstModelRoadList","pstModelPumpList","pstRoadPumpStatusList",
			"pstRoadPumpTypeList"};
	 
 
	
	public PstJobEmployeeResource() {
		super();
		logger.debug("into constructor PstJobEmployeeResource");
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doInit() throws ResourceException {
		// TODO Auto-generated method stub
		super.doInit();
		logger.debug("into doInit");
	}
	
	@Override
	protected Representation post(Representation entity, Variant variant)
			throws ResourceException {
		// TODO Auto-generated method stub

		// TODO Auto-generated method stub
		logger.debug("into Post PSTCommonResource 2");
		InputStream in = null;
		try {
			in = entity.getStream();
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.PstJobEmployee.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.PstJobEmployee xbpsTerm = new th.co.aoe.imake.pst.xstream.PstJobEmployee();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.aoe.imake.pst.xstream.PstJobEmployee) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.aoe.imake.pst.hibernate.bean.PstJobEmployee bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.PstJobEmployee();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm,ignore_id); 
						
						th.co.aoe.imake.pst.hibernate.bean.PstJobEmployeePK pk =new th.co.aoe.imake.pst.hibernate.bean.PstJobEmployeePK();
						pk.setPeId((xbpsTerm.getPeId()!=null && xbpsTerm.getPeId().intValue()!=0 && xbpsTerm.getPeId().intValue()!=-1)?xbpsTerm.getPeId():null);
						pk.setPjId((xbpsTerm.getPjId()!=null && xbpsTerm.getPjId().intValue()!=0 && xbpsTerm.getPjId().intValue()!=-1)?xbpsTerm.getPjId():null);
						pk.setPrpId((xbpsTerm.getPrpId()!=null && xbpsTerm.getPrpId().intValue()!=0 && xbpsTerm.getPrpId().intValue()!=-1)?xbpsTerm.getPrpId():null);
						bpsTerm.setId(pk);

						if(serviceName.equals(ServiceConstant.PST_JOB_EMPLOYEE_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							th.co.aoe.imake.pst.hibernate.bean.PstJobEmployeePK  returnId=null;
							returnId=(th.co.aoe.imake.pst.hibernate.bean.PstJobEmployeePK) (pstCommonService.save(bpsTerm));
							//xbpsTerm.setPesId(pesId);
							return returnUpdateRecord(entity,xbpsTerm,returnId.getPeId().intValue());
						} 
						else if(serviceName.equals(ServiceConstant.PST_JOB_EMPLOYEE_DELETE)){
								//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_JOB_EMPLOYEE_SEARCH)){
						//	Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings("rawtypes")		
							List result = (List) pstJobEmployeeService.listPstJobEmployees(xbpsTerm.getPjId(), xbpsTerm.getPeId(),xbpsTerm.getPrpId());
					 
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstJobEmployee> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstJobEmployee>) result;
										 
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.aoe.imake.pst.xstream.PstJobEmployee> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstJobEmployee>();
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstJobEmployeeObject(ntcCalendars);
								}
								vresultMessage.setResultListObj(xntcCalendars);
								return getRepresentation(entity, vresultMessage, xstream);
							 
						}
					} else {
					}
				}

			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			logger.debug(" into Finally Call");
			try {
				if (in != null)
					in.close();

			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	
	}
	private Representation returnUpdateRecord(Representation entity,th.co.aoe.imake.pst.xstream.PstJobEmployee xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.PstJobEmployee> xbpsTerms = new ArrayList<th.co.aoe.imake.pst.xstream.PstJobEmployee>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.aoe.imake.pst.xstream.PstJobEmployee> getxPstJobEmployeeObject(
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstJobEmployee> ntcCalendars) {
		List<th.co.aoe.imake.pst.xstream.PstJobEmployee> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstJobEmployee>(
				ntcCalendars.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstJobEmployee missManual : ntcCalendars) {
			th.co.aoe.imake.pst.xstream.PstJobEmployee xmissManual =new th.co.aoe.imake.pst.xstream.PstJobEmployee ();
			BeanUtils.copyProperties(missManual, xmissManual,ignore_id);
			if(missManual.getId()!=null){
				xmissManual.setPeId(missManual.getId().getPeId());
				xmissManual.setPjId(missManual.getId().getPjId());
				xmissManual.setPrpId(missManual.getId().getPrpId());
			}  
			if(missManual.getPstEmployee()!=null){
				th.co.aoe.imake.pst.xstream.PstEmployee xpstEmployee =new th.co.aoe.imake.pst.xstream.PstEmployee (); 
				BeanUtils.copyProperties(missManual.getPstEmployee(), xpstEmployee,ignore_employee_id); 
				
				if(missManual.getPstEmployee().getPstPosition()!=null){
					th.co.aoe.imake.pst.xstream.PstPosition xpstPosition =new th.co.aoe.imake.pst.xstream.PstPosition (); 
					BeanUtils.copyProperties(missManual.getPstEmployee().getPstPosition(),xpstPosition);
					xpstEmployee.setPstPosition(xpstPosition);
				}
				if(missManual.getPstEmployee().getPstTitle()!=null){
					th.co.aoe.imake.pst.xstream.PstTitle xpstTitle =new th.co.aoe.imake.pst.xstream.PstTitle (); 
					BeanUtils.copyProperties(missManual.getPstEmployee().getPstTitle(),xpstTitle);
					xpstEmployee.setPstTitle(xpstTitle);
				}
				if(missManual.getPstEmployee().getPstRoadPump()!=null){
					th.co.aoe.imake.pst.xstream.PstRoadPump xpstRoadPump =new th.co.aoe.imake.pst.xstream.PstRoadPump (); 
					xpstRoadPump.setPrpId(missManual.getPstEmployee().getPstRoadPump().getPrpId());
					xpstRoadPump.setPrpNo(missManual.getPstEmployee().getPstRoadPump().getPrpNo());
					//BeanUtils.copyProperties(missManual.getPstEmployee().getPstRoadPump(),xpstRoadPump);
					xpstEmployee.setPstRoadPump(xpstRoadPump);
				}
				xmissManual.setPstEmployee(xpstEmployee);
			}
			if(missManual.getPstJob()!=null){
				th.co.aoe.imake.pst.xstream.PstJob xpstJob =new th.co.aoe.imake.pst.xstream.PstJob(); 
				BeanUtils.copyProperties(missManual.getPstJob(), xpstJob,ignore_job_id); 
				xmissManual.setPstJob(xpstJob);
			} 
			if(missManual.getPstRoadPump()!=null){
				th.co.aoe.imake.pst.xstream.PstRoadPump xpstRoadPump =new th.co.aoe.imake.pst.xstream.PstRoadPump(); 
				BeanUtils.copyProperties(missManual.getPstRoadPump(), xpstRoadPump,ignore_roadpump_id); 
				xmissManual.setPstRoadPump(xpstRoadPump);
				
			}
				
			xmissManual.setPagging(null);
			xntcCalendars.add(xmissManual);
		} 
		return xntcCalendars;
	} 
	@Override
	protected Representation get(Variant variant) throws ResourceException { 
		return null;
	} 
	


	

	public PstJobEmployeeService getPstJobEmployeeService() {
		return pstJobEmployeeService;
	}

	public void setPstJobEmployeeService(PstJobEmployeeService pstJobEmployeeService) {
		this.pstJobEmployeeService = pstJobEmployeeService;
	}

	public PSTCommonService getPstCommonService() {
		return pstCommonService;
	}

	public void setPstCommonService(PSTCommonService pstCommonService) {
		this.pstCommonService = pstCommonService;
	}

	public com.thoughtworks.xstream.XStream getXstream() {
		return xstream;
	}

	public void setXstream(com.thoughtworks.xstream.XStream xstream) {
		this.xstream = xstream;
	}

}
