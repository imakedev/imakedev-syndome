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
import th.co.aoe.imake.pst.managers.PstRoadPumpDeactiveMappingService;
import th.co.aoe.imake.pst.xstream.common.Pagging;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

public class PstRoadPumpDeactiveMappingResource extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstRoadPumpDeactiveMappingService pstRoadPumpDeactiveMappingService; 
	private com.thoughtworks.xstream.XStream xstream; 
	public PstRoadPumpDeactiveMappingResource() {
		super();
		logger.debug("into constructor PstRoadPumpDeactiveMappingResource");
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
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping xbpsTerm = new th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpDeactiveMapping bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpDeactiveMapping();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm); 
						if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_DEACTIVE_MAPPING_FIND_BY_ID)){
							th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpDeactiveMappingPK pk=
									new th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpDeactiveMappingPK(
											xbpsTerm.getPrpId(),xbpsTerm.getPwtId(),xbpsTerm.getPdId());
							Object obj= pstCommonService.findById(bpsTerm.getClass(), pk);
							if(obj!=null){
								th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpDeactiveMapping pstRoadPumpDeactiveMapping = (th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpDeactiveMapping)obj;
								BeanUtils.copyProperties(pstRoadPumpDeactiveMapping, xbpsTerm) ;
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_DEACTIVE_MAPPING_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							
							th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpDeactiveMappingPK  pk=null;
							pk=(th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpDeactiveMappingPK) (pstCommonService.save(bpsTerm));
							 
							return returnUpdateRecord(entity,xbpsTerm,pk.getPrpId().intValue());
						} else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_DEACTIVE_MAPPING_UPDATE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_DEACTIVE_MAPPING_ITEMS_DELETE)){
							/*int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
							
							return returnUpdateRecord(entity,xbpsTerm,1);
						}
						else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_DEACTIVE_MAPPING_DELETE)){
								//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_DEACTIVE_MAPPING_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings({ "rawtypes" })
							List result = (List) pstRoadPumpDeactiveMappingService.searchPstRoadPumpDeactiveMapping(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpDeactiveMapping> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpDeactiveMapping>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping>();
								if (faqs_size != null && faqs_size.length()!=0)
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstRoadPumpDeactiveMappingObject(ntcCalendars);
								}
								vresultMessage.setResultListObj(xntcCalendars);
								return getRepresentation(entity, vresultMessage, xstream);
							}
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
	private Representation returnUpdateRecord(Representation entity,th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping> xbpsTerms = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping> getxPstRoadPumpDeactiveMappingObject(
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpDeactiveMapping> ntcCalendars) {
		List<th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping>(
				ntcCalendars.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpDeactiveMapping missManual : ntcCalendars) {
			th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping xmissManual =new th.co.aoe.imake.pst.xstream.PstRoadPumpDeactiveMapping ();
			BeanUtils.copyProperties(missManual, xmissManual);
			xmissManual.setPagging(null);
			xntcCalendars.add(xmissManual);
		}
		return xntcCalendars;
	} 
	@Override
	protected Representation get(Variant variant) throws ResourceException {
		// TODO Auto-generated method stub
	
		//save
		//Long pcId=(Long) (pstCommonService.save(pstRoadPumpDeactiveMapping));
		
		//update
		/*pstRoadPumpDeactiveMapping.setPbdUid("updated");
		pstCommonService.update(pstRoadPumpDeactiveMapping);*/
		
		// delete
		//pstCommonService.delete(pstRoadPumpDeactiveMapping);
		return getRepresentation(null, null, xstream);
		// return null;
	} 
	


	

	public PstRoadPumpDeactiveMappingService getPstRoadPumpDeactiveMappingService() {
		return pstRoadPumpDeactiveMappingService;
	}

	public void setPstRoadPumpDeactiveMappingService(PstRoadPumpDeactiveMappingService pstRoadPumpDeactiveMappingService) {
		this.pstRoadPumpDeactiveMappingService = pstRoadPumpDeactiveMappingService;
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
