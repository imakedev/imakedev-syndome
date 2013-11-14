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
import th.co.aoe.imake.pst.managers.RoleContactService;
import th.co.aoe.imake.pst.xstream.common.Pagging;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

public class RoleContactResource extends BaseResource {
	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private RoleContactService roleContactService;
	private com.thoughtworks.xstream.XStream xstream;
	private static 	final String[] ignore_id=new String[]{"missAccount","missSery"};
	 
	public RoleContactResource() {
		super();
		logger.debug("into constructor RoleContactResource");
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
		logger.debug("into Post RoleContactResource 2");
		InputStream in = null;
		try {
			in = entity.getStream();
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.RoleContact.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.RoleContact xbpsTerm = new th.co.aoe.imake.pst.xstream.RoleContact();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.aoe.imake.pst.xstream.RoleContact) ntcCalendarObj;
				if (xbpsTerm != null) {
				
					 
					th.co.aoe.imake.pst.hibernate.bean.RoleContact bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.RoleContact();
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
						if(serviceName.equals(ServiceConstant.ROLE_CONTACT_FIND_BY_ID)){
							th.co.aoe.imake.pst.hibernate.bean.RoleContact ntcCalendarReturn = roleContactService.findRoleContactById(bpsTerm.getRcId());
						logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(ntcCalendarReturn!=null){
								List<th.co.aoe.imake.pst.xstream.RoleContact> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.RoleContact>(1);
								th.co.aoe.imake.pst.xstream.RoleContact xntcCalendarReturn = new th.co.aoe.imake.pst.xstream.RoleContact();
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
						if(serviceName.equals(ServiceConstant.ROLE_CONTACT_SAVE)){
						//	java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long rcId=0l;
							
							rcId=(roleContactService.saveRoleContact(bpsTerm));
							xbpsTerm.setRcId(rcId);
						
							return returnUpdateRecord(entity,xbpsTerm,rcId.intValue());
						}
						else if(serviceName.equals(ServiceConstant.ROLE_CONTACT_UPDATE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=roleContactService.updateRoleContact(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						/*else if(serviceName.equals(ServiceConstant.ROLE_CONTACT_ITEMS_DELETE)){
						 
							String[] mcaIds=xbpsTerm.getMmIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <mcaIds.length; i++) {
								th.co.aoe.makedev.missconsult.hibernate.bean.RoleContact item = new th.co.aoe.makedev.missconsult.hibernate.bean.RoleContact();
								item.setMmId(Long.parseLong(mcaIds[i]));
								updateRecord=roleContactService.deleteRoleContact(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}*/
						else if(serviceName.equals(ServiceConstant.ROLE_CONTACT_LIST_BY_MA_ID)){
							@SuppressWarnings("unchecked")
							List<th.co.aoe.imake.pst.xstream.RoleContact> xntcCalendars = roleContactService.listRoleContactBymaId(xbpsTerm.getMaId());
							
							VResultMessage vresultMessage = new VResultMessage();
							vresultMessage.setResultListObj(xntcCalendars);
							return getRepresentation(entity, vresultMessage, xstream);
						}
						
						else if(serviceName.equals(ServiceConstant.ROLE_CONTACT_DELETE)){
							int updateRecord=roleContactService.deleteRoleContact(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.ROLE_CONTACT_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings({ "rawtypes" })
							List result = (List) roleContactService.searchRoleContact(bpsTerm,page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.RoleContact> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.RoleContact>) result
										.get(0);
								String faqs_size = (String) result.get(1);
//								 
								VResultMessage vresultMessage = new VResultMessage();

								List<th.co.aoe.imake.pst.xstream.RoleContact> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.RoleContact>();
								if (faqs_size != null && !faqs_size.equals(""))
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxRoleContactObject(ntcCalendars);
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
		logger.debug("into GET RoleContactResource");
		Pagging page =new Pagging(); 
		th.co.aoe.imake.pst.hibernate.bean.RoleContact bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.RoleContact();
		//bpsTerm.setMegName("Aoe");
		@SuppressWarnings({ "rawtypes" })
		List result = (List) roleContactService.searchRoleContact(bpsTerm,page);
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.RoleContact> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.RoleContact>();
		if (result != null && result.size() == 2) {
			@SuppressWarnings("unchecked")
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.RoleContact> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.RoleContact>) result
					.get(0);
			String faqs_size = (String) result.get(1);
//			 
		

		
			if (faqs_size != null && !faqs_size.equals(""))
				vresultMessage.setMaxRow(faqs_size);
			if (ntcCalendars != null && ntcCalendars.size() > 0) {
				xntcCalendars = getxRoleContactObject(ntcCalendars);
			}
		}
			vresultMessage.setResultListObj(xntcCalendars);
			return getRepresentation(null, vresultMessage, xstream);
	}
	private List<th.co.aoe.imake.pst.xstream.RoleContact> getxRoleContactObject(
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.RoleContact> ntcCalendars) {
		List<th.co.aoe.imake.pst.xstream.RoleContact> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.RoleContact>(
				ntcCalendars.size());
		for (th.co.aoe.imake.pst.hibernate.bean.RoleContact missManual : ntcCalendars) {
			th.co.aoe.imake.pst.xstream.RoleContact xmissManual =new th.co.aoe.imake.pst.xstream.RoleContact ();
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
	private Representation returnUpdateRecord(Representation entity,th.co.aoe.imake.pst.xstream.RoleContact xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.RoleContact> xbpsTerms = new ArrayList<th.co.aoe.imake.pst.xstream.RoleContact>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
 
	public RoleContactService getRoleContactService() {
		return roleContactService;
	}

	public void setRoleContactService(RoleContactService roleContactService) {
		this.roleContactService = roleContactService;
	}
	public com.thoughtworks.xstream.XStream getXstream() {
		return xstream;
	}

	public void setXstream(com.thoughtworks.xstream.XStream xstream) {
		this.xstream = xstream;
	}


}
