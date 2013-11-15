package th.co.imake.syndome.bpm.rest.resource;

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

import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.managers.RoleTypeService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

public class RoleTypeResource extends BaseResource {
	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private RoleTypeService roleTypeService;
	private com.thoughtworks.xstream.XStream xstream;
	private static 	final String[] ignore_id=new String[]{"missAccount","missSery"};
	 
	public RoleTypeResource() {
		super();
		logger.debug("into constructor RoleTypeResource");
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
		logger.debug("into Post RoleTypeResource 2");
		InputStream in = null;
		try {
			in = entity.getStream();
			xstream.processAnnotations(th.co.imake.syndome.bpm.xstream.RoleType.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.imake.syndome.bpm.xstream.RoleType xbpsTerm = new th.co.imake.syndome.bpm.xstream.RoleType();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.imake.syndome.bpm.xstream.RoleType) ntcCalendarObj;
				if (xbpsTerm != null) {
				
					 
					th.co.imake.syndome.bpm.hibernate.bean.RoleType bpsTerm = new th.co.imake.syndome.bpm.hibernate.bean.RoleType();
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
						if(serviceName.equals(ServiceConstant.ROLE_TYPE_FIND_BY_ID)){
							th.co.imake.syndome.bpm.hibernate.bean.RoleType ntcCalendarReturn = roleTypeService.findRoleTypeById(bpsTerm.getRtId());
						logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(ntcCalendarReturn!=null){
								List<th.co.imake.syndome.bpm.xstream.RoleType> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.RoleType>(1);
								th.co.imake.syndome.bpm.xstream.RoleType xntcCalendarReturn = new th.co.imake.syndome.bpm.xstream.RoleType();
								BeanUtils.copyProperties(ntcCalendarReturn,xntcCalendarReturn,ignore_id);	
								xntcCalendarReturn.setPagging(null);
								/*if(ntcCalendarReturn.getMissSery()!=null && ntcCalendarReturn.getMissSery().getMsId()!=null && ntcCalendarReturn.getMissSery().getMsId().intValue()!=0){
									th.co.aoe.makedev.missconsult.xstream.MissSery missSery=new th.co.aoe.makedev.missconsult.xstream.MissSery();
									BeanUtils.copyProperties(ntcCalendarReturn.getMissSery(), missSery);
									missSery.setPagging(null);
									xntcCalendarReturn.setMissSery(missSery);
								}*/
								xntcCalendars.add(xntcCalendarReturn);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						} 
						if(serviceName.equals(ServiceConstant.ROLE_TYPE_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long rtId=0l;
							
							rtId=(roleTypeService.saveRoleType(bpsTerm));
							xbpsTerm.setRtId(rtId);
						
							return returnUpdateRecord(entity,xbpsTerm,rtId.intValue());
						}
						else if(serviceName.equals(ServiceConstant.ROLE_TYPE_UPDATE)){
						//	java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=roleTypeService.updateRoleType(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						/*else if(serviceName.equals(ServiceConstant.ROLE_TYPE_ITEMS_DELETE)){
						 
							String[] mcaIds=xbpsTerm.getMmIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <mcaIds.length; i++) {
								th.co.aoe.makedev.missconsult.hibernate.bean.RoleType item = new th.co.aoe.makedev.missconsult.hibernate.bean.RoleType();
								item.setMmId(Long.parseLong(mcaIds[i]));
								updateRecord=roleTypeService.deleteRoleType(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}*/
						else if(serviceName.equals(ServiceConstant.ROLE_TYPE_DELETE)){
							int updateRecord=roleTypeService.deleteRoleType(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.ROLE_TYPE_LIST_BY_RC_ID)){
							@SuppressWarnings("unchecked")
							List<th.co.imake.syndome.bpm.xstream.RoleType> xntcCalendars = roleTypeService.listRoleTypeByRcId(xbpsTerm.getRcId());
								
								VResultMessage vresultMessage = new VResultMessage();
								vresultMessage.setResultListObj(xntcCalendars);
								return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.ROLE_TYPE_LIST)){
							@SuppressWarnings("unchecked")
							List<th.co.imake.syndome.bpm.xstream.RoleType> xntcCalendars = roleTypeService.listRoleTypes(xbpsTerm.getMaId());
							
							VResultMessage vresultMessage = new VResultMessage();
							vresultMessage.setResultListObj(xntcCalendars);
							return getRepresentation(entity, vresultMessage, xstream);
						}
						else if(serviceName.equals(ServiceConstant.ROLE_TYPE_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings({ "rawtypes" })
							List result = (List) roleTypeService.searchRoleType(bpsTerm,page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.RoleType> ntcCalendars = (java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.RoleType>) result
										.get(0);
								String faqs_size = (String) result.get(1);
//								 
								VResultMessage vresultMessage = new VResultMessage();

								List<th.co.imake.syndome.bpm.xstream.RoleType> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.RoleType>();
								if (faqs_size != null && !faqs_size.equals(""))
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxRoleTypeObject(ntcCalendars);
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
		logger.debug("into GET RoleTypeResource");
		Pagging page =new Pagging(); 
		th.co.imake.syndome.bpm.hibernate.bean.RoleType bpsTerm = new th.co.imake.syndome.bpm.hibernate.bean.RoleType();
		//bpsTerm.setMegName("Aoe");
		@SuppressWarnings({ "rawtypes" })
		List result = (List) roleTypeService.searchRoleType(bpsTerm,page);
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.RoleType> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.RoleType>();
		if (result != null && result.size() == 2) {
			@SuppressWarnings("unchecked")
			java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.RoleType> ntcCalendars = (java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.RoleType>) result
					.get(0);
			String faqs_size = (String) result.get(1);
//			 
		

		
			if (faqs_size != null && !faqs_size.equals(""))
				vresultMessage.setMaxRow(faqs_size);
			if (ntcCalendars != null && ntcCalendars.size() > 0) {
				xntcCalendars = getxRoleTypeObject(ntcCalendars);
			}
		}
			vresultMessage.setResultListObj(xntcCalendars);
			return getRepresentation(null, vresultMessage, xstream);
	}
	private List<th.co.imake.syndome.bpm.xstream.RoleType> getxRoleTypeObject(
			java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.RoleType> ntcCalendars) {
		List<th.co.imake.syndome.bpm.xstream.RoleType> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.RoleType>(
				ntcCalendars.size());
		for (th.co.imake.syndome.bpm.hibernate.bean.RoleType roleType : ntcCalendars) {
			th.co.imake.syndome.bpm.xstream.RoleType xroleType =new th.co.imake.syndome.bpm.xstream.RoleType ();
			BeanUtils.copyProperties(roleType, xroleType,ignore_id);
			xroleType.setPagging(null);
			/*if(roleType.getMissSery()!=null && roleType.getMissSery().getMsId()!=null && roleType.getMissSery().getMsId().intValue()!=0){
				th.co.aoe.makedev.missconsult.xstream.MissSery missSery=new th.co.aoe.makedev.missconsult.xstream.MissSery();
				BeanUtils.copyProperties(roleType.getMissSery(), missSery);
				missSery.setPagging(null);
				xroleType.setMissSery(missSery);
			}
		*/
			
			xntcCalendars.add(xroleType);
		}
		return xntcCalendars;
	} 
	private Representation returnUpdateRecord(Representation entity,th.co.imake.syndome.bpm.xstream.RoleType xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.RoleType> xbpsTerms = new ArrayList<th.co.imake.syndome.bpm.xstream.RoleType>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
 
	public RoleTypeService getRoleTypeService() {
		return roleTypeService;
	}

	public void setRoleTypeService(RoleTypeService roleTypeService) {
		this.roleTypeService = roleTypeService;
	}
	public com.thoughtworks.xstream.XStream getXstream() {
		return xstream;
	}

	public void setXstream(com.thoughtworks.xstream.XStream xstream) {
		this.xstream = xstream;
	}


}
