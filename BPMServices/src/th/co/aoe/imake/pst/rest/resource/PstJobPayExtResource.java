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
import th.co.aoe.imake.pst.managers.PstJobPayExtService;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

public class PstJobPayExtResource  extends BaseResource {


	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstJobPayExtService pstJobPayExtService; 
	private com.thoughtworks.xstream.XStream xstream; 
	private String[] ignore_id={"id","pstJob"};   
	private String[] ignore_job_id={"pstConcrete","pstRoadPump"};
	 
	public PstJobPayExtResource() {
		super();
		logger.debug("into constructor PstJobPayExtResource");
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
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.PstJobPayExt.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.PstJobPayExt xbpsTerm = new th.co.aoe.imake.pst.xstream.PstJobPayExt();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.aoe.imake.pst.xstream.PstJobPayExt) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.aoe.imake.pst.hibernate.bean.PstJobPayExt bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.PstJobPayExt();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm,ignore_id); 
						
						th.co.aoe.imake.pst.hibernate.bean.PstJobPayExtPK pk =new th.co.aoe.imake.pst.hibernate.bean.PstJobPayExtPK();
						pk.setPjpeNo((xbpsTerm.getPjpeNo()!=null && xbpsTerm.getPjpeNo().intValue()!=0 && xbpsTerm.getPjpeNo().intValue()!=-1)?xbpsTerm.getPjpeNo():null);
						pk.setPjId((xbpsTerm.getPjId()!=null && xbpsTerm.getPjId().intValue()!=0 && xbpsTerm.getPjId().intValue()!=-1)?xbpsTerm.getPjId():null);
						bpsTerm.setId(pk);
					

						if(serviceName.equals(ServiceConstant.PST_JOB_PAY_EXT_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							th.co.aoe.imake.pst.hibernate.bean.PstJobPayExtPK  returnId=null;
							 
							Long pjNo=pstJobPayExtService.getNextPjpeNo(bpsTerm.getId().getPjId());
							bpsTerm.getId().setPjpeNo(pjNo);
							returnId=(th.co.aoe.imake.pst.hibernate.bean.PstJobPayExtPK) (pstCommonService.save(bpsTerm));
							//xbpsTerm.setPesId(pesId);
							return returnUpdateRecord(entity,xbpsTerm,returnId.getPjpeNo().intValue());
						} 
						else if(serviceName.equals(ServiceConstant.PST_JOB_PAY_EXT_DELETE)){
								//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							//System.out.println(bpsTerm.getId().getPjId()+","+bpsTerm.getId().getPjpeNo());
							bpsTerm.getId().setPjpeNo(xbpsTerm.getPjpeNo());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_JOB_PAY_EXT_SEARCH)){
							//Pagging page = xbpsTerm.getPagging(); 
							
							@SuppressWarnings("rawtypes")
							List result = (List) pstJobPayExtService.listPstJobPayExts(xbpsTerm.getPjId(), xbpsTerm.getPjpeNo());
					 
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstJobPayExt> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstJobPayExt>) result;
										 
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.aoe.imake.pst.xstream.PstJobPayExt> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstJobPayExt>();
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstJobPayExtObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.aoe.imake.pst.xstream.PstJobPayExt xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.PstJobPayExt> xbpsTerms = new ArrayList<th.co.aoe.imake.pst.xstream.PstJobPayExt>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.aoe.imake.pst.xstream.PstJobPayExt> getxPstJobPayExtObject(
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstJobPayExt> ntcCalendars) {
		List<th.co.aoe.imake.pst.xstream.PstJobPayExt> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstJobPayExt>(
				ntcCalendars.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstJobPayExt missManual : ntcCalendars) {
			th.co.aoe.imake.pst.xstream.PstJobPayExt xmissManual =new th.co.aoe.imake.pst.xstream.PstJobPayExt ();
			BeanUtils.copyProperties(missManual, xmissManual,ignore_id);
			if(missManual.getId()!=null){
				xmissManual.setPjpeNo(missManual.getId().getPjpeNo());
				xmissManual.setPjId(missManual.getId().getPjId());
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
	


	

	public PstJobPayExtService getPstJobPayExtService() {
		return pstJobPayExtService;
	}

	public void setPstJobPayExtService(PstJobPayExtService pstJobPayExtService) {
		this.pstJobPayExtService = pstJobPayExtService;
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
