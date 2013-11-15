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
import th.co.imake.syndome.bpm.managers.PstEmployeeStatusService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.json.JettisonMappedXmlDriver;

public class PstEmployeeStatusResource  extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstEmployeeStatusService pstEmployeeStatusService; 
	private com.thoughtworks.xstream.XStream xstream; 
	private com.thoughtworks.xstream.XStream jsonXstream;
	private com.thoughtworks.xstream.XStream _xstream;
	
	public PstEmployeeStatusResource() {
		super();
		logger.debug("into constructor PstEmployeeStatusResource");
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
		
		 //System.out.println("getMediaType->"+entity.getMediaType());
		logger.debug("into Post PSTCommonResource 2"); 
		String mediaType=entity.getMediaType().toString();
		 if(mediaType.indexOf("json")!=-1)
			 _xstream=jsonXstream;
		 else
			 _xstream=xstream;
		InputStream in = null;
		try {
			in = entity.getStream();
			_xstream.processAnnotations(th.co.imake.syndome.bpm.xstream.PstEmployeeStatus.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.imake.syndome.bpm.xstream.PstEmployeeStatus xbpsTerm = new th.co.imake.syndome.bpm.xstream.PstEmployeeStatus();
			Object ntcCalendarObj = _xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.imake.syndome.bpm.xstream.PstEmployeeStatus) ntcCalendarObj;
				if (xbpsTerm != null) { 
					//System.out.println("x->"+xbpsTerm);
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus bpsTerm = new th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm); 
						if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_STATUS_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPesId());
							if(obj!=null){
								th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus pstEmployeeStatus = (th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus)obj;
								BeanUtils.copyProperties(pstEmployeeStatus, xbpsTerm) ;
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.imake.syndome.bpm.xstream.PstEmployeeStatus> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstEmployeeStatus>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentationCommon(entity, vresultMessage, _xstream,mediaType);
						}else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_STATUS_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long pesId=0l;
							pesId=(Long) (pstCommonService.save(bpsTerm));
							xbpsTerm.setPesId(pesId);
							return returnUpdateRecord(entity,xbpsTerm,pesId.intValue(),mediaType);
						} else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_STATUS_UPDATE)){
					//		java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord,mediaType);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_STATUS_ITEMS_DELETE)){
							/*int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
							
							String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus item = new th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus();
								item.setPesId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord,mediaType);
						}
						else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_STATUS_DELETE)){
								//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord,mediaType);
						}else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_STATUS_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings("rawtypes")
							List result = (List) pstEmployeeStatusService.searchPstEmployeeStatus(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus> ntcCalendars = (java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.imake.syndome.bpm.xstream.PstEmployeeStatus> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstEmployeeStatus>();
								if (faqs_size != null && faqs_size.length()!=0)
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstEmployeeStatusObject(ntcCalendars);
								}
								vresultMessage.setResultListObj(xntcCalendars);
								return getRepresentationCommon(entity, vresultMessage, _xstream,mediaType);
							}
						}else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_STATUS_LIST)){
							@SuppressWarnings("rawtypes")
							List result = pstEmployeeStatusService.listPstEmployeeStatuses();
							@SuppressWarnings("unchecked")
							java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus> ntcCalendars = (java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus>) result;
									
							VResultMessage vresultMessage = new VResultMessage();
							List<th.co.imake.syndome.bpm.xstream.PstEmployeeStatus> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstEmployeeStatus>();
							if (ntcCalendars != null && ntcCalendars.size() > 0) {
								xntcCalendars = getxPstEmployeeStatusObject(ntcCalendars);
							}
							vresultMessage.setResultListObj(xntcCalendars);
							return getRepresentationCommon(entity, vresultMessage, _xstream,mediaType);
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
	private Representation returnUpdateRecord(Representation entity,th.co.imake.syndome.bpm.xstream.PstEmployeeStatus xbpsTerm,int updateRecord,String mediaType){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.PstEmployeeStatus> xbpsTerms = new ArrayList<th.co.imake.syndome.bpm.xstream.PstEmployeeStatus>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentationCommon(entity, vresultMessage, _xstream,mediaType);
	}
	private List<th.co.imake.syndome.bpm.xstream.PstEmployeeStatus> getxPstEmployeeStatusObject(
			java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus> ntcCalendars) {
		List<th.co.imake.syndome.bpm.xstream.PstEmployeeStatus> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstEmployeeStatus>(
				ntcCalendars.size());
		for (th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus missManual : ntcCalendars) {
			th.co.imake.syndome.bpm.xstream.PstEmployeeStatus xmissManual =new th.co.imake.syndome.bpm.xstream.PstEmployeeStatus ();
			BeanUtils.copyProperties(missManual, xmissManual);
			xmissManual.setPagging(null);
			xntcCalendars.add(xmissManual);
		}
		return xntcCalendars;
	} 
	@Override
	protected Representation get(Variant variant) throws ResourceException {
		// TODO Auto-generated method stub
		//System.out.println("sss");
		//System.out.println("getMediaType get->"+variant.getMediaType());
		th.co.imake.syndome.bpm.xstream.PstEmployeeStatus  xbpsTerm =new th.co.imake.syndome.bpm.xstream.PstEmployeeStatus();
		th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus pstEmployeeStatus =new  th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus();
		xbpsTerm.setPesId(1l);
		Object obj= pstCommonService.findById(pstEmployeeStatus.getClass(), xbpsTerm.getPesId());
		if(obj!=null){
			 pstEmployeeStatus = (th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus)obj;
			BeanUtils.copyProperties(pstEmployeeStatus, xbpsTerm) ;
		}
	//logger.debug(" object return ="+ntcCalendarReturn);
	VResultMessage vresultMessage = new VResultMessage();
		if(xbpsTerm!=null){
			List<th.co.imake.syndome.bpm.xstream.PstEmployeeStatus> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstEmployeeStatus>(1);
			xbpsTerm.setPagging(null);							 
			xntcCalendars.add(xbpsTerm);
			vresultMessage.setResultListObj(xntcCalendars);
		}
		//save
		//Long pesId=(Long) (pstCommonService.save(pstEmployeeStatus));
		
		//update
		/*pstEmployeeStatus.setPbdUid("updated");
		pstCommonService.update(pstEmployeeStatus);*/
		
		// delete
		//pstCommonService.delete(pstEmployeeStatus);
		 XStream xstreamx = new XStream(new JettisonMappedXmlDriver());
		 xstreamx.setMode(XStream.NO_REFERENCES);
		 
			return getJsonRepresentation(null, vresultMessage, xstreamx);
		 
	} 
	


	

	public PstEmployeeStatusService getPstEmployeeStatusService() {
		return pstEmployeeStatusService;
	}

	public void setPstEmployeeStatusService(PstEmployeeStatusService pstEmployeeStatusService) {
		this.pstEmployeeStatusService = pstEmployeeStatusService;
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

	public com.thoughtworks.xstream.XStream getJsonXstream() {
		return jsonXstream;
	}

	public void setJsonXstream(com.thoughtworks.xstream.XStream jsonXstream) {
		this.jsonXstream = jsonXstream;
	}

	
}
