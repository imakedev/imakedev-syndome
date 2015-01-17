package th.co.imake.syndome.bpm.rest.resource;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.restlet.data.MediaType;
import org.restlet.representation.Representation;
import org.restlet.representation.Variant;
import org.restlet.resource.ResourceException;
import org.springframework.beans.BeanUtils;

import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.managers.BpmCallCenterService;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

public class BpmCallCenterResource extends BaseResource {
	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER); 
	private BpmCallCenterService bpmCallCenterService;
	private com.thoughtworks.xstream.XStream xstream;
	private com.thoughtworks.xstream.XStream jsonXstream;
	private static final String[] id_ignore=new String[]{"coopAccount","coopGroup"};
	private static final String[]  id_ignore_account=new String[]{"coopGroup","coopExpressRegister" };
	private static final String[]  id_ignore_account_return=new String[]{"coopGroup","coopExpressRegister","caToken"};
	
	public BpmCallCenterResource() {
		super();
		logger.debug("into constructor BpmCallCenterResource");
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
		logger.debug("into Post CoopMessageResource 2");
		InputStream in = null;
		try {
			in = entity.getStream();
			jsonXstream.processAnnotations(th.co.imake.syndome.bpm.xstream.BpmCallCenter.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.imake.syndome.bpm.xstream.BpmCallCenter xbpsTerm = new th.co.imake.syndome.bpm.xstream.BpmCallCenter();
			Object ntcCalendarObj = jsonXstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.imake.syndome.bpm.xstream.BpmCallCenter) ntcCalendarObj;
				if (xbpsTerm != null) {
					th.co.imake.syndome.bpm.hibernate.bean.BpmCallCenter bpsTerm = new th.co.imake.syndome.bpm.hibernate.bean.BpmCallCenter();
					
					BeanUtils.copyProperties(xbpsTerm,bpsTerm,id_ignore); 
					/*if(xbpsTerm.getCoopGroup()!=null && xbpsTerm.getCoopGroup().getCgId()!=null){
						th.co.imake.vcoop.hibernate.bean.CoopGroup missTheme = new th.co.imake.vcoop.hibernate.bean.CoopGroup();						
						BeanUtils.copyProperties(xbpsTerm.getCoopGroup(),missTheme); 
						bpsTerm.setCoopGroup(missTheme);
					}*/
					 
					String mediaType=xbpsTerm.getMediaType();
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						if(serviceName.equals(ServiceConstant.BPM_CALL_CENTER_GET_JOB_STATUS)){ //findCoopMessageById
							VResultMessage vresultMessage = new VResultMessage();
							
								th.co.imake.syndome.bpm.xstream.BpmCallCenter xntcCalendarReturn  = bpmCallCenterService.findBpmCallCenterById(xbpsTerm.getBccNo());
								logger.debug(" object return ="+xntcCalendarReturn);
									if(xntcCalendarReturn!=null){
										
										List<th.co.imake.syndome.bpm.xstream.BpmCallCenter> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.BpmCallCenter>(1);
										 
										xntcCalendarReturn.setPagging(null); 
										xntcCalendars.add(xntcCalendarReturn);
										vresultMessage.setResultListObj(xntcCalendars);
										
									}
							 
							if(mediaType!=null && mediaType.equals("json"))
								return getJsonRepresentation(entity, vresultMessage, jsonXstream);
							else
								return getJsonRepresentation(entity, vresultMessage, jsonXstream);
						}
						else if(serviceName.equals(ServiceConstant.BPM_CALL_CENTER_OPEN_JOB)){// saveCoopMessage
							int updateRecord=0;
							
								java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								bpsTerm.setBccCreatedTime(timeStampStartDate);
								bpsTerm.setBccUpdatedTime(timeStampStartDate);
								String bccNo=bpmCallCenterService.saveBpmCallCenter(bpsTerm);
							//	System.out.println("caId->"+caId); 
								xbpsTerm.setBccNo(bccNo);
						 	
							return returnUpdateRecord(entity,xbpsTerm,updateRecord,mediaType);
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

	
	@Override
	protected Representation get(Variant variant) throws ResourceException {
		// TODO Auto-generated method stub
		logger.debug("test2"+variant.getMediaType()+","+MediaType.TEXT_PLAIN);
		logger.debug("into GET CoopMessageResource");
		String bccNo=getQuery().getValues("bccNo");
	//	Pagging page =new Pagging(); 
	//	th.co.imake.syndome.bpm.hibernate.bean.BpmCallCenter bpsTerm = new th.co.imake.syndome.bpm.hibernate.bean.BpmCallCenter(); 
	//	@SuppressWarnings("rawtypes")
		th.co.imake.syndome.bpm.xstream.BpmCallCenter result = (th.co.imake.syndome.bpm.xstream.BpmCallCenter) bpmCallCenterService.findBpmCallCenterById(bccNo);
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.BpmCallCenter> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.BpmCallCenter>();
		   result.setPagging(null);
			xntcCalendars.add(result);

		 
			vresultMessage.setResultListObj(xntcCalendars);
			//System.out.println("xxx");
			return getJsonRepresentation(null, vresultMessage, jsonXstream);
			//return getRepresentation(null, vresultMessage, xstream);
	}
	private List<th.co.imake.syndome.bpm.xstream.BpmCallCenter> getxCoopMessageObject(
			java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.BpmCallCenter> ntcCalendars) {
		List<th.co.imake.syndome.bpm.xstream.BpmCallCenter> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.BpmCallCenter>(
				ntcCalendars.size());
		for (th.co.imake.syndome.bpm.hibernate.bean.BpmCallCenter coopMessage : ntcCalendars) {
			th.co.imake.syndome.bpm.xstream.BpmCallCenter xcoopMessage =new th.co.imake.syndome.bpm.xstream.BpmCallCenter ();
			BeanUtils.copyProperties(coopMessage, xcoopMessage,id_ignore);
			//CoopGroup coopGroup;
			 
			xcoopMessage.setPagging(null);
			xntcCalendars.add(xcoopMessage);
		}
		return xntcCalendars;
	} 

	private Representation returnUpdateRecord(Representation entity,th.co.imake.syndome.bpm.xstream.BpmCallCenter xbpsTerm,int updateRecord,String mediaType){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.BpmCallCenter> xbpsTerms = new ArrayList<th.co.imake.syndome.bpm.xstream.BpmCallCenter>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		if(mediaType!=null && mediaType.equals("json"))
			return getJsonRepresentation(entity, vresultMessage, jsonXstream);
		else
			return getJsonRepresentation(entity, vresultMessage, jsonXstream);
		//return getRepresentation(entity, vresultMessage, xstream);
	}
 
	 

	public BpmCallCenterService getBpmCallCenterService() {
		return bpmCallCenterService;
	}

	public void setBpmCallCenterService(BpmCallCenterService bpmCallCenterService) {
		this.bpmCallCenterService = bpmCallCenterService;
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
