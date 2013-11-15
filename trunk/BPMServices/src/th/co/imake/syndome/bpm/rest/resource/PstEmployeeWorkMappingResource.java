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
import th.co.imake.syndome.bpm.managers.PstEmployeeWorkMappingService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

public class PstEmployeeWorkMappingResource  extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstEmployeeWorkMappingService pstEmployeeWorkMappingService; 
	private com.thoughtworks.xstream.XStream xstream; 
	public PstEmployeeWorkMappingResource() {
		super();
		logger.debug("into constructor PstEmployeeWorkMappingResource");
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
			xstream.processAnnotations(th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping xbpsTerm = new th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {

						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping bpsTerm = new th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm); 
						//System.out.println(xbpsTerm.getPewmDateTime());
						if(xbpsTerm.getPeId()!=null || xbpsTerm.getPesId()!=null ||
								xbpsTerm.getPrpNo()!=null || xbpsTerm.getPewmDateTime()!=null){
							th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMappingPK pk =
									new th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMappingPK(xbpsTerm.getPeId(), 
											 xbpsTerm.getPewmDateTime());
							bpsTerm.setId(pk);
						}
						 
 
						if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_WORK_MAPPING_FIND_BY_ID)){/*
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPcId());
							if(obj!=null){
								th.co.aoe.imake.pst.hibernate.bean.PstEmployeeWorkMapping pstEmployeeWorkMapping = (th.co.aoe.imake.pst.hibernate.bean.PstEmployeeWorkMapping)obj;
								BeanUtils.copyProperties(pstEmployeeWorkMapping, xbpsTerm) ;
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.aoe.imake.pst.xstream.PstEmployeeWorkMapping> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstEmployeeWorkMapping>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						*/}else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_WORK_MAPPING_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMappingPK pk=null;
							pk=(th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMappingPK) (pstCommonService.save(bpsTerm));
							//xbpsTerm.setPcId(pcId);
							return returnUpdateRecord(entity,xbpsTerm,pk.getPeId().intValue());
						} else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_WORK_MAPPING_UPDATE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_WORK_MAPPING_ITEMS_DELETE)){/*
							int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
							String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.aoe.imake.pst.hibernate.bean.PstEmployeeWorkMapping item = new th.co.aoe.imake.pst.hibernate.bean.PstEmployeeWorkMapping();
								item.setPcId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						*/}
						else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_WORK_MAPPING_DELETE)){
								//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_WORK_MAPPING_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings("rawtypes")
							List result = (List) pstEmployeeWorkMappingService.searchPstEmployeeWorkMapping(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping> xntcCalendars = (java.util.ArrayList<th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
							//	List<th.co.aoe.imake.pst.xstream.PstEmployeeWorkMapping> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstEmployeeWorkMapping>();
								if (faqs_size != null && faqs_size.length()!=0)
									vresultMessage.setMaxRow(faqs_size);
								/*if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstEmployeeWorkMappingObject(ntcCalendars);
								}*/
								//System.err.println(xntcCalendars);
								vresultMessage.setResultListObj(xntcCalendars);
								return getRepresentation(entity, vresultMessage, xstream);
							}
						}else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_WORK_MAPPING_SET)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updatedRecord=pstEmployeeWorkMappingService.setPstEmployeeWorkMapping(xbpsTerm.getPeIds(), xbpsTerm.getPesIds(), xbpsTerm.getPrpNos(),
									xbpsTerm.getPewmDateTime());
							 
							//xbpsTerm.setPcId(pcId);
							return returnUpdateRecord(entity,xbpsTerm,updatedRecord);
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
	private Representation returnUpdateRecord(Representation entity,th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping> xbpsTerms = new ArrayList<th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	@SuppressWarnings("unused")
	private List<th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping> getxPstEmployeeWorkMappingObject(
			java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping> ntcCalendars) {
		List<th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping>(
				ntcCalendars.size());
		for (th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping missManual : ntcCalendars) {
			th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping xmissManual =new th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping ();
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
		//Long pcId=(Long) (pstCommonService.save(pstEmployeeWorkMapping));
		
		//update
		/*pstEmployeeWorkMapping.setPbdUid("updated");
		pstCommonService.update(pstEmployeeWorkMapping);*/
		
		// delete
		//pstCommonService.delete(pstEmployeeWorkMapping);
		return getRepresentation(null, null, xstream);
		// return null;
	} 
	


	

	public PstEmployeeWorkMappingService getPstEmployeeWorkMappingService() {
		return pstEmployeeWorkMappingService;
	}

	public void setPstEmployeeWorkMappingService(PstEmployeeWorkMappingService pstEmployeeWorkMappingService) {
		this.pstEmployeeWorkMappingService = pstEmployeeWorkMappingService;
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
