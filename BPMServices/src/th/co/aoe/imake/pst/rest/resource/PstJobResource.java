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

import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.managers.PSTCommonService;
import th.co.aoe.imake.pst.managers.PstJobService;
import th.co.aoe.imake.pst.xstream.common.Pagging;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

public class PstJobResource  extends BaseResource {
 

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private static String[] ignore={"pstConcrete","pstRoadPump"};  
	private static final String[] ignore_employee=	 {"pstPosition","pstTitle","pstRoadPump"};
	private PSTCommonService pstCommonService;
	private PstJobService pstJobService; 
	private com.thoughtworks.xstream.XStream xstream; 
	public PstJobResource() {
		super();
		logger.debug("into constructor PstJobResource");
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doInit() throws ResourceException {
		// TODO Auto-generated method stub
		super.doInit();
		logger.debug("into doInit");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	protected Representation post(Representation entity, Variant variant)
			throws ResourceException {
		// TODO Auto-generated method stub

		// TODO Auto-generated method stub
		logger.debug("into Post PSTCommonResource 2");
		InputStream in = null;
		try {
			in = entity.getStream();
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.PstJob.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.PstJob xbpsTerm = new th.co.aoe.imake.pst.xstream.PstJob();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				//String className=ntcCalendarObj.getClass().toString();
				/*if("th.co.aoe.imake.pst.xstream.ProductReport".equals(className)){
					
				}else if(){
					
				}*/
				xbpsTerm = (th.co.aoe.imake.pst.xstream.PstJob) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.aoe.imake.pst.hibernate.bean.PstJob bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.PstJob();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm,ignore); 
						if(xbpsTerm.getPstConcrete()!=null && xbpsTerm.getPstConcrete().getPconcreteId()!=null &&  xbpsTerm.getPstConcrete().getPconcreteId().intValue()!=-1){
							th.co.aoe.imake.pst.hibernate.bean.PstConcrete pstConcrete = new th.co.aoe.imake.pst.hibernate.bean.PstConcrete();
							BeanUtils.copyProperties(xbpsTerm.getPstConcrete(),pstConcrete); 
							bpsTerm.setPstConcrete(pstConcrete);
						}
						if(xbpsTerm.getPstRoadPump()!=null && xbpsTerm.getPstRoadPump().getPrpId()!=null &&  xbpsTerm.getPstRoadPump().getPrpId().intValue()!=-1){
							th.co.aoe.imake.pst.hibernate.bean.PstRoadPump pstRoadPump = new th.co.aoe.imake.pst.hibernate.bean.PstRoadPump();
							pstRoadPump.setPrpId(xbpsTerm.getPstRoadPump().getPrpId());
							pstRoadPump.setPrpNo(xbpsTerm.getPstRoadPump().getPrpNo());
							//private String prpNo;
							//BeanUtils.copyProperties(xbpsTerm.getPstRoadPump(),pstRoadPump); 
							bpsTerm.setPstRoadPump(pstRoadPump);
						}
						if(serviceName.equals(ServiceConstant.PST_JOB_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPjId());
							if(obj!=null){
								th.co.aoe.imake.pst.hibernate.bean.PstJob pstJob = (th.co.aoe.imake.pst.hibernate.bean.PstJob)obj;
								BeanUtils.copyProperties(pstJob, xbpsTerm,ignore) ;
								if(pstJob.getPstConcrete()!=null && pstJob.getPstConcrete().getPconcreteId()!=null ){
									th.co.aoe.imake.pst.xstream.PstConcrete pstConcrete = new th.co.aoe.imake.pst.xstream.PstConcrete();
									BeanUtils.copyProperties(pstJob.getPstConcrete(),pstConcrete); 
									xbpsTerm.setPstConcrete(pstConcrete);
								}
								if(pstJob.getPstRoadPump()!=null && pstJob.getPstRoadPump().getPrpId()!=null &&  pstJob.getPstRoadPump().getPrpId().intValue()!=-1){
									th.co.aoe.imake.pst.xstream.PstRoadPump pstRoadPump = new th.co.aoe.imake.pst.xstream.PstRoadPump();
									pstRoadPump.setPrpId(pstJob.getPstRoadPump().getPrpId());
									pstRoadPump.setPrpNo(pstJob.getPstRoadPump().getPrpNo());
									
									if(pstJob.getPstRoadPump().getPstRoadPumpType()!=null){
										th.co.aoe.imake.pst.xstream.PstRoadPumpType pstRoadPumpType = new th.co.aoe.imake.pst.xstream.PstRoadPumpType();
										BeanUtils.copyProperties(pstJob.getPstRoadPump().getPstRoadPumpType(), pstRoadPumpType) ;
										pstRoadPump.setPstRoadPumpType(pstRoadPumpType);
									}
									
									//private String prpNo;
									//BeanUtils.copyProperties(pstJob.getPstRoadPump(),pstRoadPump); 
									xbpsTerm.setPstRoadPump(pstRoadPump);
								}
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.aoe.imake.pst.xstream.PstJob> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstJob>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_JOB_SAVE)){
						//	java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long pjId=0l;
							pjId=(Long) (pstCommonService.save(bpsTerm));
							th.co.aoe.imake.pst.hibernate.bean.PstJobWork pstJobWork=new th.co.aoe.imake.pst.hibernate.bean.PstJobWork();
							th.co.aoe.imake.pst.hibernate.bean.PstJobWorkPK pk =new th.co.aoe.imake.pst.hibernate.bean.PstJobWorkPK();
							pk.setPjId(pjId);
							pk.setPrpId(bpsTerm.getPstRoadPump().getPrpId());
							pstJobWork.setId(pk);
							pstCommonService.save(pstJobWork);
							xbpsTerm.setPjId(pjId);
							return returnUpdateRecord(entity,xbpsTerm,pjId.intValue());
						} else if(serviceName.equals(ServiceConstant.PST_JOB_UPDATE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_JOB_ITEMS_DELETE)){
							/*int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
							
							String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.aoe.imake.pst.hibernate.bean.PstJob item = new th.co.aoe.imake.pst.hibernate.bean.PstJob();
								item.setPjId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.PST_JOB_DELETE)){
							//	java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_JOB_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings("rawtypes")
							List result = (List) pstJobService.searchPstJob(bpsTerm,xbpsTerm.getPrpNo(), page);
							if (result != null && result.size() == 2) { 
								/*java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstJob> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstJob>) result
										.get(0);*/
								List<th.co.aoe.imake.pst.xstream.PstJob> xntcCalendars  = (java.util.ArrayList<th.co.aoe.imake.pst.xstream.PstJob>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
							//	List<th.co.aoe.imake.pst.xstream.PstJob> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstJob>();
								if (faqs_size != null && faqs_size.length()!=0)
									vresultMessage.setMaxRow(faqs_size);
								//if (ntcCalendars != null && ntcCalendars.size() > 0) {
								//	xntcCalendars = getxPstJobObject(ntcCalendars);
								//}
								vresultMessage.setResultListObj(xntcCalendars);
								return getRepresentation(entity, vresultMessage, xstream);
							}
						}else if(serviceName.equals(ServiceConstant.PST_JOB_LIST_MASTER)){
							@SuppressWarnings({ "rawtypes"})
							List pstBreakDownList= getxPstBreakDownObject(pstCommonService.listObject(" select pstBreakDown from PstBreakDown pstBreakDown "));
							@SuppressWarnings({ "rawtypes"})
							List pstEmployeeList= getxPstEmployeeObject(pstCommonService.listObject(" select pstEmployee from PstEmployee pstEmployee "));
							@SuppressWarnings({ "rawtypes"})
							List pstCostList= getxPstCostObject(pstCommonService.listObject(" select pstCost from PstCost pstCost "));
							
							VResultMessage vresultMessage = new VResultMessage();
							xbpsTerm.setPstBreakDownList(pstBreakDownList);
							xbpsTerm.setPstEmployeeList(pstEmployeeList);
							xbpsTerm.setPstCostList(pstCostList); 
							List<th.co.aoe.imake.pst.xstream.PstJob> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstJob>();
							xntcCalendars.add(xbpsTerm);
							//logger.error("xbpsTerm-"+xbpsTerm);
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
	private Representation returnUpdateRecord(Representation entity,th.co.aoe.imake.pst.xstream.PstJob xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.PstJob> xbpsTerms = new ArrayList<th.co.aoe.imake.pst.xstream.PstJob>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.aoe.imake.pst.xstream.PstJob> getxPstJobObject(
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstJob> ntcCalendars) {
		List<th.co.aoe.imake.pst.xstream.PstJob> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstJob>(
				ntcCalendars.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstJob missManual : ntcCalendars) {
			th.co.aoe.imake.pst.xstream.PstJob xmissManual =new th.co.aoe.imake.pst.xstream.PstJob ();
			BeanUtils.copyProperties(missManual, xmissManual,ignore);
			if(missManual.getPstConcrete()!=null && missManual.getPstConcrete().getPconcreteId()!=null ){
				th.co.aoe.imake.pst.xstream.PstConcrete pstConcrete = new th.co.aoe.imake.pst.xstream.PstConcrete();
				BeanUtils.copyProperties(missManual.getPstConcrete(),pstConcrete); 
				xmissManual.setPstConcrete(pstConcrete);
			}
			if(missManual.getPstRoadPump()!=null && missManual.getPstRoadPump().getPrpId()!=null &&  missManual.getPstRoadPump().getPrpId().intValue()!=-1){
				th.co.aoe.imake.pst.xstream.PstRoadPump pstRoadPump = new th.co.aoe.imake.pst.xstream.PstRoadPump();
				pstRoadPump.setPrpId(missManual.getPstRoadPump().getPrpId());
				pstRoadPump.setPrpNo(missManual.getPstRoadPump().getPrpNo());
				//private String prpNo;
				//BeanUtils.copyProperties(missManual.getPstRoadPump(),pstRoadPump); 
				xmissManual.setPstRoadPump(pstRoadPump);
			}
			xmissManual.setPagging(null);
			xntcCalendars.add(xmissManual);
		}
		return xntcCalendars;
	} 
	
	private List<th.co.aoe.imake.pst.xstream.PstBreakDown> getxPstBreakDownObject(
			java.util.List<th.co.aoe.imake.pst.hibernate.bean.PstBreakDown> pstBreakDowns){
		List<th.co.aoe.imake.pst.xstream.PstBreakDown> xpstBreakDowns = new ArrayList<th.co.aoe.imake.pst.xstream.PstBreakDown>(
				pstBreakDowns.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstBreakDown pstBreakDown : pstBreakDowns) {
			th.co.aoe.imake.pst.xstream.PstBreakDown xpstBreakDown =new th.co.aoe.imake.pst.xstream.PstBreakDown ();
			BeanUtils.copyProperties(pstBreakDown, xpstBreakDown);
			xpstBreakDowns.add(xpstBreakDown);
		}
		return xpstBreakDowns;
	}
	private List<th.co.aoe.imake.pst.xstream.PstEmployee> getxPstEmployeeObject(
			java.util.List<th.co.aoe.imake.pst.hibernate.bean.PstEmployee> pstEmployees){
		List<th.co.aoe.imake.pst.xstream.PstEmployee> xpstEmployees = new ArrayList<th.co.aoe.imake.pst.xstream.PstEmployee>(
				pstEmployees.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstEmployee pstEmployee : pstEmployees) {
			th.co.aoe.imake.pst.xstream.PstEmployee xpstEmployee =new th.co.aoe.imake.pst.xstream.PstEmployee (); 
			pstEmployee.setPstPosition(null);
			pstEmployee.setPstTitle(null);
			//BeanUtils.copyProperties(pstEmployee, xpstEmployee);
			BeanUtils.copyProperties(pstEmployee, xpstEmployee,ignore_employee) ;
			if(pstEmployee.getPstPosition()!=null && pstEmployee.getPstPosition().getPpId()!=null && pstEmployee.getPstPosition().getPpId().intValue()!=0)
			{
				th.co.aoe.imake.pst.xstream.PstPosition pstPosition = new th.co.aoe.imake.pst.xstream.PstPosition(); 
				BeanUtils.copyProperties(pstEmployee.getPstPosition(),pstPosition); 	
				xpstEmployee.setPstPosition(pstPosition);
			}
			if(pstEmployee.getPstTitle()!=null && pstEmployee.getPstTitle().getPtId()!=null && pstEmployee.getPstTitle().getPtId().intValue()!=0)
			{
				th.co.aoe.imake.pst.xstream.PstTitle pstTitle = new th.co.aoe.imake.pst.xstream.PstTitle(); 
				BeanUtils.copyProperties(pstEmployee.getPstTitle(),pstTitle); 	
				xpstEmployee.setPstTitle(pstTitle);
			}
			if(pstEmployee.getPstRoadPump()!=null && pstEmployee.getPstRoadPump().getPrpId()!=null && pstEmployee.getPstRoadPump().getPrpId().intValue()!=0)
			{
				th.co.aoe.imake.pst.xstream.PstRoadPump pstRoadPump = new th.co.aoe.imake.pst.xstream.PstRoadPump(); 
				//BeanUtils.copyProperties(pstEmployee.getPstRoadPump(),pstRoadPump); 	
				pstRoadPump.setPrpId(pstEmployee.getPstRoadPump().getPrpId());
				pstRoadPump.setPrpNo(pstEmployee.getPstRoadPump().getPrpNo());
				
				if(pstEmployee.getPstRoadPump().getPstRoadPumpType()!=null){
					th.co.aoe.imake.pst.xstream.PstRoadPumpType pstRoadPumpType = new th.co.aoe.imake.pst.xstream.PstRoadPumpType();
					BeanUtils.copyProperties(pstEmployee.getPstRoadPump().getPstRoadPumpType(), pstRoadPumpType) ;
					pstRoadPump.setPstRoadPumpType(pstRoadPumpType);
				}
				xpstEmployee.setPstRoadPump(pstRoadPump);
			}
			xpstEmployees.add(xpstEmployee);
		}
		return xpstEmployees;
	}
	private List<th.co.aoe.imake.pst.xstream.PstCost> getxPstCostObject(
			java.util.List<th.co.aoe.imake.pst.hibernate.bean.PstCost> pstCosts){
		List<th.co.aoe.imake.pst.xstream.PstCost> xpstCosts = new ArrayList<th.co.aoe.imake.pst.xstream.PstCost>(
				pstCosts.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstCost pstCost : pstCosts) {
			th.co.aoe.imake.pst.xstream.PstCost xpstCost =new th.co.aoe.imake.pst.xstream.PstCost ();
			BeanUtils.copyProperties(pstCost, xpstCost);
			xpstCosts.add(xpstCost);
		}
		return xpstCosts;
	}


	public PstJobService getPstJobService() {
		return pstJobService;
	}

	public void setPstJobService(PstJobService pstJobService) {
		this.pstJobService = pstJobService;
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
