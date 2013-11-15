package th.co.imake.syndome.bpm.rest.resource;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.restlet.representation.Representation;
import org.restlet.representation.Variant;
import org.restlet.resource.ResourceException;
import org.springframework.beans.BeanUtils;

import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.managers.PSTCommonService;
import th.co.imake.syndome.bpm.managers.PstJobPayService;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

public class PstJobPayResource  extends BaseResource {


	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstJobPayService pstJobPayService; 
	private com.thoughtworks.xstream.XStream xstream; 
	private String[] ignore_id={"id","pstCost","pstJob"};   
	private String[] ignore_job_id={"pstConcrete","pstRoadPump"};
	 
	public PstJobPayResource() {
		super();
		logger.debug("into constructor PstJobPayResource");
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
			xstream.processAnnotations(th.co.imake.syndome.bpm.xstream.PstJobPay.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.imake.syndome.bpm.xstream.PstJobPay xbpsTerm = new th.co.imake.syndome.bpm.xstream.PstJobPay();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.imake.syndome.bpm.xstream.PstJobPay) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.imake.syndome.bpm.hibernate.bean.PstJobPay bpsTerm = new th.co.imake.syndome.bpm.hibernate.bean.PstJobPay();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm,ignore_id); 
						
						th.co.imake.syndome.bpm.hibernate.bean.PstJobPayPK pk =new th.co.imake.syndome.bpm.hibernate.bean.PstJobPayPK();
						pk.setPcId((xbpsTerm.getPcId()!=null && xbpsTerm.getPcId().intValue()!=0 && xbpsTerm.getPcId().intValue()!=-1)?xbpsTerm.getPcId():null);
						pk.setPjId((xbpsTerm.getPjId()!=null && xbpsTerm.getPjId().intValue()!=0 && xbpsTerm.getPjId().intValue()!=-1)?xbpsTerm.getPjId():null);
						bpsTerm.setId(pk);
					

						if(serviceName.equals(ServiceConstant.PST_JOB_PAY_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							th.co.imake.syndome.bpm.hibernate.bean.PstJobPayPK  returnId=null;
							returnId=(th.co.imake.syndome.bpm.hibernate.bean.PstJobPayPK) (pstCommonService.save(bpsTerm));
							//xbpsTerm.setPesId(pesId);
							return returnUpdateRecord(entity,xbpsTerm,returnId.getPcId().intValue());
						} 
						else if(serviceName.equals(ServiceConstant.PST_JOB_PAY_DELETE)){
								//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_JOB_PAY_SEARCH)){
							//Pagging page = xbpsTerm.getPagging(); 
							
							@SuppressWarnings("rawtypes")
							List result = (List) pstJobPayService.listPstJobPays(xbpsTerm.getPjId(), xbpsTerm.getPcId());
					 
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstJobPay> ntcCalendars = (java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstJobPay>) result;
										 
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.imake.syndome.bpm.xstream.PstJobPay> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstJobPay>();
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstJobPayObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.imake.syndome.bpm.xstream.PstJobPay xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.PstJobPay> xbpsTerms = new ArrayList<th.co.imake.syndome.bpm.xstream.PstJobPay>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.imake.syndome.bpm.xstream.PstJobPay> getxPstJobPayObject(
			java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstJobPay> ntcCalendars) {
		List<th.co.imake.syndome.bpm.xstream.PstJobPay> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstJobPay>(
				ntcCalendars.size());
		for (th.co.imake.syndome.bpm.hibernate.bean.PstJobPay missManual : ntcCalendars) {
			th.co.imake.syndome.bpm.xstream.PstJobPay xmissManual =new th.co.imake.syndome.bpm.xstream.PstJobPay ();
			BeanUtils.copyProperties(missManual, xmissManual,ignore_id);
			if(missManual.getId()!=null){
				xmissManual.setPcId(missManual.getId().getPcId());
				xmissManual.setPjId(missManual.getId().getPjId());
			}  
			if(missManual.getPstCost()!=null){
				th.co.imake.syndome.bpm.xstream.PstCost xpstCost =new th.co.imake.syndome.bpm.xstream.PstCost (); 
				BeanUtils.copyProperties(missManual.getPstCost(), xpstCost); 
				xmissManual.setPstCost(xpstCost);
			}
			if(missManual.getPstJob()!=null){
				th.co.imake.syndome.bpm.xstream.PstJob xpstJob =new th.co.imake.syndome.bpm.xstream.PstJob(); 
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
	


	

	public PstJobPayService getPstJobPayService() {
		return pstJobPayService;
	}

	public void setPstJobPayService(PstJobPayService pstJobPayService) {
		this.pstJobPayService = pstJobPayService;
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
