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
import th.co.aoe.imake.pst.managers.PstRoadPumpTypeService;
import th.co.aoe.imake.pst.xstream.common.Pagging;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

public class PstRoadPumpTypeResource  extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstRoadPumpTypeService pstRoadPumpTypeService; 
	private com.thoughtworks.xstream.XStream xstream; 
	public PstRoadPumpTypeResource() {
		super();
		logger.debug("into constructor PstRoadPumpTypeResource");
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
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.PstRoadPumpType.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.PstRoadPumpType xbpsTerm = new th.co.aoe.imake.pst.xstream.PstRoadPumpType();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.aoe.imake.pst.xstream.PstRoadPumpType) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm); 
						if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_TYPE_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPrptId());
							if(obj!=null){
								th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType pstRoadPumpType = (th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType)obj;
								BeanUtils.copyProperties(pstRoadPumpType, xbpsTerm) ;
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.aoe.imake.pst.xstream.PstRoadPumpType> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPumpType>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_TYPE_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long prptId=0l;
							prptId=(Long) (pstCommonService.save(bpsTerm));
							xbpsTerm.setPrptId(prptId);
							return returnUpdateRecord(entity,xbpsTerm,prptId.intValue());
						} else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_TYPE_UPDATE)){
						//	java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_TYPE_ITEMS_DELETE)){
							/*int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
							
							String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType item = new th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType();
								item.setPrptId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_TYPE_DELETE)){
							//	java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_TYPE_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							
							@SuppressWarnings("rawtypes")
							List result = (List) pstRoadPumpTypeService.searchPstRoadPumpType(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.aoe.imake.pst.xstream.PstRoadPumpType> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPumpType>();
								if (faqs_size != null && !faqs_size.equals(""))
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstRoadPumpTypeObject(ntcCalendars);
								}
								vresultMessage.setResultListObj(xntcCalendars);
								return getRepresentation(entity, vresultMessage, xstream);
							}
						}else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_TYPE_LIST)){
							@SuppressWarnings({ "rawtypes" })
							List result = pstRoadPumpTypeService.listPstRoadPumpType();
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType>) result;
										
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.aoe.imake.pst.xstream.PstRoadPumpType> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPumpType>();
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstRoadPumpTypeObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.aoe.imake.pst.xstream.PstRoadPumpType xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.PstRoadPumpType> xbpsTerms = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPumpType>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.aoe.imake.pst.xstream.PstRoadPumpType> getxPstRoadPumpTypeObject(
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType> ntcCalendars) {
		List<th.co.aoe.imake.pst.xstream.PstRoadPumpType> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPumpType>(
				ntcCalendars.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType missManual : ntcCalendars) {
			th.co.aoe.imake.pst.xstream.PstRoadPumpType xmissManual =new th.co.aoe.imake.pst.xstream.PstRoadPumpType ();
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
		th.co.aoe.imake.pst.xstream.PstRoadPumpType  xbpsTerm =new th.co.aoe.imake.pst.xstream.PstRoadPumpType();
		th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType pstRoadPumpType =new  th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType();
		xbpsTerm.setPrptId(1l);
		Object obj= pstCommonService.findById(pstRoadPumpType.getClass(), xbpsTerm.getPrptId());
		if(obj!=null){
			 pstRoadPumpType = (th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType)obj;
			BeanUtils.copyProperties(pstRoadPumpType, xbpsTerm) ;
		}
	//logger.debug(" object return ="+ntcCalendarReturn);
	VResultMessage vresultMessage = new VResultMessage();
		if(xbpsTerm!=null){
			List<th.co.aoe.imake.pst.xstream.PstRoadPumpType> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPumpType>(1);
			xbpsTerm.setPagging(null);							 
			xntcCalendars.add(xbpsTerm);
			vresultMessage.setResultListObj(xntcCalendars);
		}
		//save
		//Long prptIdrptId=(Long) (pstCommonService.save(pstRoadPumpType));
		
		//update
		/*pstRoadPumpType.setPbdUid("updated");
		pstCommonService.update(pstRoadPumpType);*/
		
		// delete
		//pstCommonService.delete(pstRoadPumpType);
		return getRepresentation(null, vresultMessage, xstream);
		// return null;
	} 
	


	

	public PstRoadPumpTypeService getPstRoadPumpTypeService() {
		return pstRoadPumpTypeService;
	}

	public void setPstRoadPumpTypeService(PstRoadPumpTypeService pstRoadPumpTypeService) {
		this.pstRoadPumpTypeService = pstRoadPumpTypeService;
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
