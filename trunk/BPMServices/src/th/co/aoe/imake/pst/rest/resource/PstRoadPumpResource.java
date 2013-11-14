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
import th.co.aoe.imake.pst.managers.PstRoadPumpService;
import th.co.aoe.imake.pst.xstream.common.Pagging;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

public class PstRoadPumpResource extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstRoadPumpService pstRoadPumpService; 
	private com.thoughtworks.xstream.XStream xstream; 
	private static final String[] ignore=	 {"pstRoadPumpStatus","pstRoadPumpType","pstBrandRoad","pstBrandPump","pstModelRoad","pstModelPump"};
	 

	public PstRoadPumpResource() {
		super();
		logger.debug("into constructor PstRoadPumpResource");
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doInit() throws ResourceException {
		// TODO Auto-generated method stub
		super.doInit();
		logger.debug("into doInit");
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	protected Representation post(Representation entity, Variant variant)
			throws ResourceException {
		// TODO Auto-generated method stub

		// TODO Auto-generated method stub
		logger.debug("into Post PSTCommonResource 2");
		InputStream in = null;
		try {
			in = entity.getStream();
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.PstRoadPump.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.PstRoadPump xbpsTerm = new th.co.aoe.imake.pst.xstream.PstRoadPump();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.aoe.imake.pst.xstream.PstRoadPump) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.aoe.imake.pst.hibernate.bean.PstRoadPump bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.PstRoadPump();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm,ignore); 
					//logger.error("(xbpsTerm.getPstRoadPumpStatus()="+xbpsTerm.getPstRoadPumpStatus().getPrpsId());
					if(xbpsTerm.getPstRoadPumpStatus()!=null && xbpsTerm.getPstRoadPumpStatus().getPrpsId()!=null && xbpsTerm.getPstRoadPumpStatus().getPrpsId().intValue()!=0)
					{
						th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpStatus pstRoadPumpStatus = new th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpStatus(); 
						BeanUtils.copyProperties(xbpsTerm.getPstRoadPumpStatus(),pstRoadPumpStatus); 	
						bpsTerm.setPstRoadPumpStatus(pstRoadPumpStatus);
					}
					if(xbpsTerm.getPstRoadPumpType()!=null && xbpsTerm.getPstRoadPumpType().getPrptId()!=null && xbpsTerm.getPstRoadPumpType().getPrptId().intValue()!=0)
					{
						th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType pstRoadPumpType = new th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType(); 
						BeanUtils.copyProperties(xbpsTerm.getPstRoadPumpType(),pstRoadPumpType); 	
						bpsTerm.setPstRoadPumpType(pstRoadPumpType);
					}
					if(xbpsTerm.getPstBrandRoad()!=null && xbpsTerm.getPstBrandRoad().getPbId()!=null && xbpsTerm.getPstBrandRoad().getPbId().intValue()!=0)
					{
						th.co.aoe.imake.pst.hibernate.bean.PstBrand pstBrandRoad = new th.co.aoe.imake.pst.hibernate.bean.PstBrand(); 
						BeanUtils.copyProperties(xbpsTerm.getPstBrandRoad(),pstBrandRoad); 	
						bpsTerm.setPstBrandRoad(pstBrandRoad);
					}
					if(xbpsTerm.getPstBrandPump()!=null && xbpsTerm.getPstBrandPump().getPbId()!=null && xbpsTerm.getPstBrandPump().getPbId().intValue()!=0)
					{
						th.co.aoe.imake.pst.hibernate.bean.PstBrand pstBrandPump = new th.co.aoe.imake.pst.hibernate.bean.PstBrand(); 
						BeanUtils.copyProperties(xbpsTerm.getPstBrandPump(),pstBrandPump); 	
						bpsTerm.setPstBrandPump(pstBrandPump);
					}
					if(xbpsTerm.getPstModelRoad()!=null && xbpsTerm.getPstModelRoad().getPmId()!=null && xbpsTerm.getPstModelRoad().getPmId().intValue()!=0)
					{
						th.co.aoe.imake.pst.hibernate.bean.PstModel pstModelRoad = new th.co.aoe.imake.pst.hibernate.bean.PstModel(); 
						BeanUtils.copyProperties(xbpsTerm.getPstModelRoad(),pstModelRoad); 	
						bpsTerm.setPstModelRoad(pstModelRoad);
					}
					if(xbpsTerm.getPstModelPump()!=null && xbpsTerm.getPstModelPump().getPmId()!=null && xbpsTerm.getPstModelPump().getPmId().intValue()!=0)
					{
						th.co.aoe.imake.pst.hibernate.bean.PstModel pstModelPump = new th.co.aoe.imake.pst.hibernate.bean.PstModel(); 
						BeanUtils.copyProperties(xbpsTerm.getPstModelPump(),pstModelPump); 	
						bpsTerm.setPstModelPump(pstModelPump);
					}
						if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPrpId());
							if(obj!=null){
								th.co.aoe.imake.pst.hibernate.bean.PstRoadPump pstRoadPump = (th.co.aoe.imake.pst.hibernate.bean.PstRoadPump)obj;
								BeanUtils.copyProperties(pstRoadPump, xbpsTerm,ignore) ;
								if(pstRoadPump.getPstRoadPumpStatus()!=null && pstRoadPump.getPstRoadPumpStatus().getPrpsId()!=null && pstRoadPump.getPstRoadPumpStatus().getPrpsId().intValue()!=0)
								{
									th.co.aoe.imake.pst.xstream.PstRoadPumpStatus pstRoadPumpStatus = new th.co.aoe.imake.pst.xstream.PstRoadPumpStatus(); 
									BeanUtils.copyProperties(pstRoadPump.getPstRoadPumpStatus(),pstRoadPumpStatus); 	
									xbpsTerm.setPstRoadPumpStatus(pstRoadPumpStatus);
								}
								if(pstRoadPump.getPstRoadPumpType()!=null && pstRoadPump.getPstRoadPumpType().getPrptId()!=null && pstRoadPump.getPstRoadPumpType().getPrptId().intValue()!=0)
								{
									th.co.aoe.imake.pst.xstream.PstRoadPumpType pstRoadPumpType = new th.co.aoe.imake.pst.xstream.PstRoadPumpType(); 
									BeanUtils.copyProperties(pstRoadPump.getPstRoadPumpType(),pstRoadPumpType); 	
									xbpsTerm.setPstRoadPumpType(pstRoadPumpType);
								}
								if(pstRoadPump.getPstBrandRoad()!=null && pstRoadPump.getPstBrandRoad().getPbId()!=null && pstRoadPump.getPstBrandRoad().getPbId().intValue()!=0)
								{
									th.co.aoe.imake.pst.xstream.PstBrand pstBrandRoad = new th.co.aoe.imake.pst.xstream.PstBrand(); 
									BeanUtils.copyProperties(pstRoadPump.getPstBrandRoad(),pstBrandRoad); 	
									xbpsTerm.setPstBrandRoad(pstBrandRoad);
								}
								if(pstRoadPump.getPstBrandPump()!=null && pstRoadPump.getPstBrandPump().getPbId()!=null && pstRoadPump.getPstBrandPump().getPbId().intValue()!=0)
								{
									th.co.aoe.imake.pst.xstream.PstBrand pstBrandPump = new th.co.aoe.imake.pst.xstream.PstBrand(); 
									BeanUtils.copyProperties(pstRoadPump.getPstBrandPump(),pstBrandPump); 	
									xbpsTerm.setPstBrandPump(pstBrandPump);
								}
								if(pstRoadPump.getPstModelRoad()!=null && pstRoadPump.getPstModelRoad().getPmId()!=null && pstRoadPump.getPstModelRoad().getPmId().intValue()!=0)
								{
									th.co.aoe.imake.pst.xstream.PstModel pstModelRoad = new th.co.aoe.imake.pst.xstream.PstModel(); 
									BeanUtils.copyProperties(pstRoadPump.getPstModelRoad(),pstModelRoad); 	
									xbpsTerm.setPstModelRoad(pstModelRoad);
								}
								if(pstRoadPump.getPstModelPump()!=null && pstRoadPump.getPstModelPump().getPmId()!=null && pstRoadPump.getPstModelPump().getPmId().intValue()!=0)
								{
									th.co.aoe.imake.pst.xstream.PstModel pstModelPump = new th.co.aoe.imake.pst.xstream.PstModel(); 
									BeanUtils.copyProperties(pstRoadPump.getPstModelPump(),pstModelPump); 	
									xbpsTerm.setPstModelPump(pstModelPump);
								}
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.aoe.imake.pst.xstream.PstRoadPump> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPump>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_SAVE)){
						//	java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long prpId=0l;
							prpId=(Long) (pstCommonService.save(bpsTerm));
							xbpsTerm.setPrpId(prpId);
							return returnUpdateRecord(entity,xbpsTerm,prpId.intValue());
						} else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_UPDATE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_ITEMS_DELETE)){
							/*int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
							
							String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.aoe.imake.pst.hibernate.bean.PstRoadPump item = new th.co.aoe.imake.pst.hibernate.bean.PstRoadPump();
								item.setPrpId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_DELETE)){
						//		java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							
							List result = (List) pstRoadPumpService.searchPstRoadPump(bpsTerm, page);
							if (result != null && result.size() == 2) {
								java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstRoadPump> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstRoadPump>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.aoe.imake.pst.xstream.PstRoadPump> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPump>();
								if (faqs_size != null && faqs_size.length()!=0)
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstRoadPumpObject(ntcCalendars);
								}
								vresultMessage.setResultListObj(xntcCalendars);
								return getRepresentation(entity, vresultMessage, xstream);
							}
						}else if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_LIST_MASTER)){ 
								List pstRoadPumpStatusList= getxPstRoadPumpStatusObject(pstCommonService.listObject(" select pstRoadPumpStatus from PstRoadPumpStatus pstRoadPumpStatus "));
								List pstRoadPumpTypeList= getxPstRoadPumpTypeObject(pstCommonService.listObject(" select pstRoadPumpType from PstRoadPumpType pstRoadPumpType "));
								//1=ยี่ห้อรถ\n2=ยี่ห้อปั๊ม
								List pstBrandRoadList= getxPstBrandObject(pstCommonService.listObject(" select pstBrandRoad from PstBrand pstBrandRoad where pstBrandRoad.pbType='1'"));
								List pstBrandPumpList= getxPstBrandObject(pstCommonService.listObject(" select pstBrandPump from PstBrand pstBrandPump where pstBrandPump.pbType='2'"));
								
								//1=รุ่นรถ,\n2=รุ่นปั๊ม
								List pstModelRoadList= getxPstModelObject(pstCommonService.listObject(" select pstModelRoad from PstModel pstModelRoad where pstModelRoad.pmType='1'"));
								List pstModelPumpList= getxPstModelObject(pstCommonService.listObject(" select pstModelPump from PstModel pstModelPump where pstModelPump.pmType='2'"));
								VResultMessage vresultMessage = new VResultMessage();
								xbpsTerm.setPstRoadPumpStatusList(pstRoadPumpStatusList);
								xbpsTerm.setPstRoadPumpTypeList(pstRoadPumpTypeList);
								xbpsTerm.setPstBrandRoadList(pstBrandRoadList);
								xbpsTerm.setPstBrandPumpList(pstBrandPumpList);
								xbpsTerm.setPstModelRoadList(pstModelRoadList);
								xbpsTerm.setPstModelPumpList(pstModelPumpList);
								List<th.co.aoe.imake.pst.xstream.PstRoadPump> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPump>();
								xntcCalendars.add(xbpsTerm);
								//logger.error("xbpsTerm-"+xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
								return getRepresentation(entity, vresultMessage, xstream);
						}else  if(serviceName.equals(ServiceConstant.PST_ROAD_PUMP_NO_LIST)){
							List result = pstRoadPumpService.listPstRoadPumpNo();
							java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstRoadPump> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstRoadPump>) result;
									
							VResultMessage vresultMessage = new VResultMessage();
							List<th.co.aoe.imake.pst.xstream.PstRoadPump> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPump>();
							if (ntcCalendars != null && ntcCalendars.size() > 0) {
								xntcCalendars = getxPstRoadPumpObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.aoe.imake.pst.xstream.PstRoadPump xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.PstRoadPump> xbpsTerms = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPump>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.aoe.imake.pst.xstream.PstBrand> getxPstBrandObject(
			java.util.List<th.co.aoe.imake.pst.hibernate.bean.PstBrand> pstBrands){
		List<th.co.aoe.imake.pst.xstream.PstBrand> xpstBrands = new ArrayList<th.co.aoe.imake.pst.xstream.PstBrand>(
				pstBrands.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstBrand pstBrand : pstBrands) {
			th.co.aoe.imake.pst.xstream.PstBrand xpstBrand =new th.co.aoe.imake.pst.xstream.PstBrand ();
			BeanUtils.copyProperties(pstBrand, xpstBrand,ignore);
			xpstBrands.add(xpstBrand);
		}
		return xpstBrands;
	}
	private List<th.co.aoe.imake.pst.xstream.PstModel> getxPstModelObject(
			java.util.List<th.co.aoe.imake.pst.hibernate.bean.PstModel> pstModels){
		List<th.co.aoe.imake.pst.xstream.PstModel> xpstModels = new ArrayList<th.co.aoe.imake.pst.xstream.PstModel>(
				pstModels.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstModel pstModel : pstModels) {
			th.co.aoe.imake.pst.xstream.PstModel xpstModel =new th.co.aoe.imake.pst.xstream.PstModel ();
			BeanUtils.copyProperties(pstModel, xpstModel,ignore);
			xpstModels.add(xpstModel);
		}
		return xpstModels;
	}
	private List<th.co.aoe.imake.pst.xstream.PstRoadPumpStatus> getxPstRoadPumpStatusObject(
			java.util.List<th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpStatus> pstRoadPumpStatuss){
		List<th.co.aoe.imake.pst.xstream.PstRoadPumpStatus> xpstRoadPumpStatuss = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPumpStatus>(
				pstRoadPumpStatuss.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpStatus pstRoadPumpStatus : pstRoadPumpStatuss) {
			th.co.aoe.imake.pst.xstream.PstRoadPumpStatus xpstRoadPumpStatus =new th.co.aoe.imake.pst.xstream.PstRoadPumpStatus ();
			BeanUtils.copyProperties(pstRoadPumpStatus, xpstRoadPumpStatus,ignore);
			xpstRoadPumpStatuss.add(xpstRoadPumpStatus);
		}
		return xpstRoadPumpStatuss;
	}
	private List<th.co.aoe.imake.pst.xstream.PstRoadPumpType> getxPstRoadPumpTypeObject(
			java.util.List<th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType> pstRoadPumpTypes){
		List<th.co.aoe.imake.pst.xstream.PstRoadPumpType> xpstRoadPumpTypes = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPumpType>(
				pstRoadPumpTypes.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType pstRoadPumpType : pstRoadPumpTypes) {
			th.co.aoe.imake.pst.xstream.PstRoadPumpType xpstRoadPumpType =new th.co.aoe.imake.pst.xstream.PstRoadPumpType ();
			BeanUtils.copyProperties(pstRoadPumpType, xpstRoadPumpType,ignore);
			xpstRoadPumpTypes.add(xpstRoadPumpType);
		}
		return xpstRoadPumpTypes;
	}
	private List<th.co.aoe.imake.pst.xstream.PstRoadPump> getxPstRoadPumpObject(
			java.util.List<th.co.aoe.imake.pst.hibernate.bean.PstRoadPump> ntcCalendars) {
		List<th.co.aoe.imake.pst.xstream.PstRoadPump> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstRoadPump>(
				ntcCalendars.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstRoadPump pstRoadPump : ntcCalendars) {
			th.co.aoe.imake.pst.xstream.PstRoadPump xpstRoadPump =new th.co.aoe.imake.pst.xstream.PstRoadPump ();
			BeanUtils.copyProperties(pstRoadPump, xpstRoadPump,ignore);
			if(pstRoadPump.getPstRoadPumpStatus()!=null && pstRoadPump.getPstRoadPumpStatus().getPrpsId()!=null && pstRoadPump.getPstRoadPumpStatus().getPrpsId().intValue()!=0)
			{
				th.co.aoe.imake.pst.xstream.PstRoadPumpStatus pstRoadPumpStatus = new th.co.aoe.imake.pst.xstream.PstRoadPumpStatus(); 
				BeanUtils.copyProperties(pstRoadPump.getPstRoadPumpStatus(),pstRoadPumpStatus); 	
				xpstRoadPump.setPstRoadPumpStatus(pstRoadPumpStatus);
			}
			if(pstRoadPump.getPstRoadPumpType()!=null && pstRoadPump.getPstRoadPumpType().getPrptId()!=null && pstRoadPump.getPstRoadPumpType().getPrptId().intValue()!=0)
			{
				th.co.aoe.imake.pst.xstream.PstRoadPumpType pstRoadPumpType = new th.co.aoe.imake.pst.xstream.PstRoadPumpType(); 
				BeanUtils.copyProperties(pstRoadPump.getPstRoadPumpType(),pstRoadPumpType); 	
				xpstRoadPump.setPstRoadPumpType(pstRoadPumpType);
			}
			if(pstRoadPump.getPstBrandRoad()!=null && pstRoadPump.getPstBrandRoad().getPbId()!=null && pstRoadPump.getPstBrandRoad().getPbId().intValue()!=0)
			{
				th.co.aoe.imake.pst.xstream.PstBrand pstBrandRoad = new th.co.aoe.imake.pst.xstream.PstBrand(); 
				BeanUtils.copyProperties(pstRoadPump.getPstBrandRoad(),pstBrandRoad); 	
				xpstRoadPump.setPstBrandRoad(pstBrandRoad);
			}
			if(pstRoadPump.getPstBrandPump()!=null && pstRoadPump.getPstBrandPump().getPbId()!=null && pstRoadPump.getPstBrandPump().getPbId().intValue()!=0)
			{
				th.co.aoe.imake.pst.xstream.PstBrand pstBrandPump = new th.co.aoe.imake.pst.xstream.PstBrand(); 
				BeanUtils.copyProperties(pstRoadPump.getPstBrandPump(),pstBrandPump); 	
				xpstRoadPump.setPstBrandPump(pstBrandPump);
			}
			if(pstRoadPump.getPstModelRoad()!=null && pstRoadPump.getPstModelRoad().getPmId()!=null && pstRoadPump.getPstModelRoad().getPmId().intValue()!=0)
			{
				th.co.aoe.imake.pst.xstream.PstModel pstModelRoad = new th.co.aoe.imake.pst.xstream.PstModel(); 
				BeanUtils.copyProperties(pstRoadPump.getPstModelRoad(),pstModelRoad); 	
				xpstRoadPump.setPstModelRoad(pstModelRoad);
			}
			if(pstRoadPump.getPstModelPump()!=null && pstRoadPump.getPstModelPump().getPmId()!=null && pstRoadPump.getPstModelPump().getPmId().intValue()!=0)
			{
				th.co.aoe.imake.pst.xstream.PstModel pstModelPump = new th.co.aoe.imake.pst.xstream.PstModel(); 
				BeanUtils.copyProperties(pstRoadPump.getPstModelPump(),pstModelPump); 	
				xpstRoadPump.setPstModelPump(pstModelPump);
			}
			xpstRoadPump.setPagging(null);
			xntcCalendars.add(xpstRoadPump);
		}
		return xntcCalendars;
	} 
//	@Get("json")
	@Override
	protected Representation get(Variant variant) throws ResourceException {
		// TODO Auto-generated method stub
	 
		  return null;
	} 
	


	

	public PstRoadPumpService getPstRoadPumpService() {
		return pstRoadPumpService;
	}

	public void setPstRoadPumpService(PstRoadPumpService pstRoadPumpService) {
		this.pstRoadPumpService = pstRoadPumpService;
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
