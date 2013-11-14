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
import th.co.aoe.imake.pst.managers.PstJobWorkService;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

public class PstJobWorkResource  extends BaseResource {


	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstJobWorkService pstJobWorkService; 
	private com.thoughtworks.xstream.XStream xstream; 
	private String[] ignore_id={"id","pstRoadPump","pstBreakDown","pstJob"};  
	/*private String[] ignore_WORK_id={"pstPosition","pstTitle"};
	  
	 */
	private String[] ignore_job_id={"pstConcrete","pstRoadPump"};
	 
	
	public PstJobWorkResource() {
		super();
		logger.debug("into constructor PstJobWorkResource");
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
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.PstJobWork.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.PstJobWork xbpsTerm = new th.co.aoe.imake.pst.xstream.PstJobWork();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.aoe.imake.pst.xstream.PstJobWork) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.aoe.imake.pst.hibernate.bean.PstJobWork bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.PstJobWork();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm,ignore_id); 
						
						th.co.aoe.imake.pst.hibernate.bean.PstJobWorkPK pk =new th.co.aoe.imake.pst.hibernate.bean.PstJobWorkPK();
						pk.setPrpId((xbpsTerm.getPrpId()!=null && xbpsTerm.getPrpId().intValue()!=0 && xbpsTerm.getPrpId().intValue()!=-1)?xbpsTerm.getPrpId():null);
						pk.setPjId((xbpsTerm.getPjId()!=null && xbpsTerm.getPjId().intValue()!=0 && xbpsTerm.getPjId().intValue()!=-1)?xbpsTerm.getPjId():null);
						bpsTerm.setId(pk);
					

						if(serviceName.equals(ServiceConstant.PST_JOB_WORK_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							th.co.aoe.imake.pst.hibernate.bean.PstJobWorkPK  returnId=null;
							returnId=(th.co.aoe.imake.pst.hibernate.bean.PstJobWorkPK) (pstCommonService.save(bpsTerm));
							//xbpsTerm.setPesId(pesId);
							//System.out.println("ssssssssss");
							return returnUpdateRecord(entity,xbpsTerm,returnId.getPrpId().intValue());
						} 
						else if(serviceName.equals(ServiceConstant.PST_JOB_WORK_DELETE)){
							//	java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_JOB_WORK_SEARCH)){
							//Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings({ "rawtypes" })
							List result = (List) pstJobWorkService.listPstJobWorks(xbpsTerm.getPjId(), xbpsTerm.getPrpId());
					 
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstJobWork> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstJobWork>) result;
										 
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.aoe.imake.pst.xstream.PstJobWork> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstJobWork>();
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstJobWorkObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.aoe.imake.pst.xstream.PstJobWork xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.PstJobWork> xbpsTerms = new ArrayList<th.co.aoe.imake.pst.xstream.PstJobWork>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.aoe.imake.pst.xstream.PstJobWork> getxPstJobWorkObject(
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstJobWork> ntcCalendars) {
		List<th.co.aoe.imake.pst.xstream.PstJobWork> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstJobWork>(
				ntcCalendars.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstJobWork missManual : ntcCalendars) {
			th.co.aoe.imake.pst.xstream.PstJobWork xmissManual =new th.co.aoe.imake.pst.xstream.PstJobWork ();
			BeanUtils.copyProperties(missManual, xmissManual,ignore_id);
			//System.out.println("getPjwHoursOfWork="+xmissManual.getPjwHoursOfWork());
			if(missManual.getId()!=null){
				xmissManual.setPrpId(missManual.getId().getPrpId());
				xmissManual.setPjId(missManual.getId().getPjId());
			}   
			if(missManual.getPstRoadPump()!=null){
				th.co.aoe.imake.pst.xstream.PstRoadPump xpstRoadPump =new th.co.aoe.imake.pst.xstream.PstRoadPump (); 
				missManual.getPstRoadPump().setPstBrandPump(null);
				missManual.getPstRoadPump().setPstBrandRoad(null);
				missManual.getPstRoadPump().setPstModelPump(null);
				missManual.getPstRoadPump().setPstModelRoad(null);
				missManual.getPstRoadPump().setPstRoadPumpStatus(null);
				missManual.getPstRoadPump().setPstRoadPumpType(null);
				BeanUtils.copyProperties(missManual.getPstRoadPump(), xpstRoadPump); 
				xmissManual.setPstRoadPump(xpstRoadPump);
			}
			if(missManual.getPstBreakDown()!=null){
				th.co.aoe.imake.pst.xstream.PstBreakDown xpstBreakDown =new th.co.aoe.imake.pst.xstream.PstBreakDown ();   
				BeanUtils.copyProperties(missManual.getPstBreakDown(), xpstBreakDown); 
				xmissManual.setPstBreakDown(xpstBreakDown);
			}
			if(missManual.getPstJob()!=null){
				th.co.aoe.imake.pst.xstream.PstJob xpstJob =new th.co.aoe.imake.pst.xstream.PstJob(); 
				BeanUtils.copyProperties(missManual.getPstJob(), xpstJob,ignore_job_id); 
				xmissManual.setPstJob(xpstJob);
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
	


	

	public PstJobWorkService getPstJobWorkService() {
		return pstJobWorkService;
	}

	public void setPstJobWorkService(PstJobWorkService pstJobWorkService) {
		this.pstJobWorkService = pstJobWorkService;
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
