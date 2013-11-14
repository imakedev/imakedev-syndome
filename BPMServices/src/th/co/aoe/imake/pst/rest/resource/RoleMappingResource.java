package th.co.aoe.imake.pst.rest.resource;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.restlet.data.MediaType;
import org.restlet.representation.Representation;
import org.restlet.representation.Variant;
import org.restlet.resource.ResourceException;
import org.springframework.beans.BeanUtils;

import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.managers.RoleMappingService;
import th.co.aoe.imake.pst.xstream.common.Pagging;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

public class RoleMappingResource extends BaseResource {
	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private RoleMappingService roleMappingService;
	private com.thoughtworks.xstream.XStream xstream;
	private static 	final String[] ignore_id=new String[]{"missAccount","missSery"};
	 
	public RoleMappingResource() {
		super();
		logger.debug("into constructor RoleMappingResource");
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
		logger.debug("into Post RoleMappingResource 2");
		InputStream in = null;
		try {
			in = entity.getStream();
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.RoleMapping.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.RoleMapping xbpsTerm = new th.co.aoe.imake.pst.xstream.RoleMapping();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.aoe.imake.pst.xstream.RoleMapping) ntcCalendarObj;
				if (xbpsTerm != null) {
				
					 
					th.co.aoe.imake.pst.hibernate.bean.RoleMapping bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.RoleMapping();
					BeanUtils.copyProperties(xbpsTerm,bpsTerm,ignore_id); 
					/*if(xbpsTerm.getMissSery()!=null && xbpsTerm.getMissSery().getMsId()!=null && xbpsTerm.getMissSery().getMsId().intValue()!=0){
						th.co.aoe.makedev.missconsult.hibernate.bean.MissSery missSery=new th.co.aoe.makedev.missconsult.hibernate.bean.MissSery();
						missSery.setMsId(xbpsTerm.getMissSery().getMsId());
						bpsTerm.setMissSery(missSery);
					}*/
				
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						/*if(serviceName.equals(ServiceConstant.ROLE_MAPPING_FIND_BY_ID)){
							th.co.aoe.makedev.missconsult.hibernate.bean.RoleMapping ntcCalendarReturn = roleMappingService.findRoleMappingById(bpsTerm.getRcId());
						logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(ntcCalendarReturn!=null){
								List<th.co.aoe.makedev.missconsult.xstream.RoleMapping> xntcCalendars = new ArrayList<th.co.aoe.makedev.missconsult.xstream.RoleMapping>(1);
								th.co.aoe.makedev.missconsult.xstream.RoleMapping xntcCalendarReturn = new th.co.aoe.makedev.missconsult.xstream.RoleMapping();
								BeanUtils.copyProperties(ntcCalendarReturn,xntcCalendarReturn,ignore_id);	
								xntcCalendarReturn.setPagging(null);
								
								xntcCalendars.add(xntcCalendarReturn);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						} */
						if(serviceName.equals(ServiceConstant.ROLE_MAPPING_SAVE)){
						//	java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long rcId=0l;
							
							rcId=(roleMappingService.saveRoleMapping(bpsTerm));
							xbpsTerm.setRcId(rcId);
						
							return returnUpdateRecord(entity,xbpsTerm,rcId.intValue());
						}
						else if(serviceName.equals(ServiceConstant.ROLE_MAPPING_UPDATE)){
						//	java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=roleMappingService.updateRoleMapping(xbpsTerm.getRcId(),xbpsTerm.getRtIds());
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						/*else if(serviceName.equals(ServiceConstant.ROLE_MAPPING_ITEMS_DELETE)){
						 
							String[] mcaIds=xbpsTerm.getMmIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <mcaIds.length; i++) {
								th.co.aoe.makedev.missconsult.hibernate.bean.RoleMapping item = new th.co.aoe.makedev.missconsult.hibernate.bean.RoleMapping();
								item.setMmId(Long.parseLong(mcaIds[i]));
								updateRecord=roleMappingService.deleteRoleMapping(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}*/
						else if(serviceName.equals(ServiceConstant.ROLE_MAPPING_LIST_BY_RC_ID)){
							@SuppressWarnings("unchecked")
							List<th.co.aoe.imake.pst.xstream.RoleMapping> xntcCalendars = roleMappingService.listRoleMappingByrcId(xbpsTerm.getRcId());
							
							VResultMessage vresultMessage = new VResultMessage();
							vresultMessage.setResultListObj(xntcCalendars);
							return getRepresentation(entity, vresultMessage, xstream);
						}
						
						else if(serviceName.equals(ServiceConstant.ROLE_MAPPING_DELETE)){
							int updateRecord=roleMappingService.deleteRoleMapping(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.ROLE_MAPPING_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings({ "rawtypes" })
							List result = (List) roleMappingService.searchRoleMapping(bpsTerm,page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.RoleMapping> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.RoleMapping>) result
										.get(0);
								String faqs_size = (String) result.get(1);
//								 
								VResultMessage vresultMessage = new VResultMessage();

								List<th.co.aoe.imake.pst.xstream.RoleMapping> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.RoleMapping>();
								if (faqs_size != null && !faqs_size.equals(""))
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxRoleMappingObject(ntcCalendars);
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

	
	@Override
	protected Representation get(Variant variant) throws ResourceException {
		// TODO Auto-generated method stub
		logger.debug("test2"+variant.getMediaType()+","+MediaType.TEXT_PLAIN);
		logger.debug("into GET RoleMappingResource");
		Pagging page =new Pagging(); 
		th.co.aoe.imake.pst.hibernate.bean.RoleMapping bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.RoleMapping();
		//bpsTerm.setMegName("Aoe");
		@SuppressWarnings({ "rawtypes" })
		List result = (List) roleMappingService.searchRoleMapping(bpsTerm,page);
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.RoleMapping> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.RoleMapping>();
		if (result != null && result.size() == 2) {
			@SuppressWarnings("unchecked")
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.RoleMapping> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.RoleMapping>) result
					.get(0);
			String faqs_size = (String) result.get(1);
//			 
		

		
			if (faqs_size != null && !faqs_size.equals(""))
				vresultMessage.setMaxRow(faqs_size);
			if (ntcCalendars != null && ntcCalendars.size() > 0) {
				xntcCalendars = getxRoleMappingObject(ntcCalendars);
			}
		}
			vresultMessage.setResultListObj(xntcCalendars);
			return getRepresentation(null, vresultMessage, xstream);
	}
	private List<th.co.aoe.imake.pst.xstream.RoleMapping> getxRoleMappingObject(
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.RoleMapping> ntcCalendars) {
		List<th.co.aoe.imake.pst.xstream.RoleMapping> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.RoleMapping>(
				ntcCalendars.size());
		for (th.co.aoe.imake.pst.hibernate.bean.RoleMapping missManual : ntcCalendars) {
			th.co.aoe.imake.pst.xstream.RoleMapping xmissManual =new th.co.aoe.imake.pst.xstream.RoleMapping ();
			BeanUtils.copyProperties(missManual, xmissManual,ignore_id);
			xmissManual.setPagging(null);
			/*if(missManual.getMissSery()!=null && missManual.getMissSery().getMsId()!=null && missManual.getMissSery().getMsId().intValue()!=0){
				th.co.aoe.makedev.missconsult.xstream.MissSery missSery=new th.co.aoe.makedev.missconsult.xstream.MissSery();
				BeanUtils.copyProperties(missManual.getMissSery(), missSery);
				missSery.setPagging(null);
				xmissManual.setMissSery(missSery);
			}
		*/
			
			xntcCalendars.add(xmissManual);
		}
		return xntcCalendars;
	} 
	private Representation returnUpdateRecord(Representation entity,th.co.aoe.imake.pst.xstream.RoleMapping xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.RoleMapping> xbpsTerms = new ArrayList<th.co.aoe.imake.pst.xstream.RoleMapping>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
 
	public RoleMappingService getRoleMappingService() {
		return roleMappingService;
	}

	public void setRoleMappingService(RoleMappingService roleMappingService) {
		this.roleMappingService = roleMappingService;
	}
	public com.thoughtworks.xstream.XStream getXstream() {
		return xstream;
	}

	public void setXstream(com.thoughtworks.xstream.XStream xstream) {
		this.xstream = xstream;
	}


}
