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
import th.co.imake.syndome.bpm.managers.UserService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

public class UserResource  extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private UserService userService; 
	private com.thoughtworks.xstream.XStream xstream; 
	public UserResource() {
		super();
		logger.debug("into constructor UserResource");
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
			xstream.processAnnotations(th.co.imake.syndome.bpm.xstream.User.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.imake.syndome.bpm.xstream.User xbpsTerm = new th.co.imake.syndome.bpm.xstream.User();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.imake.syndome.bpm.xstream.User) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.imake.syndome.bpm.hibernate.bean.User bpsTerm = new th.co.imake.syndome.bpm.hibernate.bean.User();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm); 
						if(serviceName.equals(ServiceConstant.USER_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getId());
							if(obj!=null){
								th.co.imake.syndome.bpm.hibernate.bean.User user = (th.co.imake.syndome.bpm.hibernate.bean.User)obj;
								BeanUtils.copyProperties(user, xbpsTerm) ;
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.imake.syndome.bpm.xstream.User> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.User>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.USER_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long id=0l;
							id=(Long) (pstCommonService.save(bpsTerm));
							xbpsTerm.setId(id);
							return returnUpdateRecord(entity,xbpsTerm,id.intValue());
						} else if(serviceName.equals(ServiceConstant.USER_UPDATE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.USER_DELETE)){
								//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.USER_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings({ "rawtypes" })
							List result = (List) userService.searchUser(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.User> ntcCalendars = (java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.User>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.imake.syndome.bpm.xstream.User> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.User>();
								if (faqs_size != null && !faqs_size.equals(""))
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxUserObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.imake.syndome.bpm.xstream.User xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.User> xbpsTerms = new ArrayList<th.co.imake.syndome.bpm.xstream.User>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.imake.syndome.bpm.xstream.User> getxUserObject(
			java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.User> ntcCalendars) {
		List<th.co.imake.syndome.bpm.xstream.User> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.User>(
				ntcCalendars.size());
		for (th.co.imake.syndome.bpm.hibernate.bean.User missManual : ntcCalendars) {
			th.co.imake.syndome.bpm.xstream.User xmissManual =new th.co.imake.syndome.bpm.xstream.User ();
			BeanUtils.copyProperties(missManual, xmissManual);
			xmissManual.setPagging(null);
			xntcCalendars.add(xmissManual);
		}
		return xntcCalendars;
	} 
	


	

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
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
