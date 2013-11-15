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
import th.co.imake.syndome.bpm.managers.PstWorkTypeService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

public class PstWorkTypeResource extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstWorkTypeService pstWorkTypeService; 
	private com.thoughtworks.xstream.XStream xstream; 
	private static String[] ignored={"pstDepartment"};
	public PstWorkTypeResource() {
		super();
		logger.debug("into constructor PstWorkTypeResource");
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
			xstream.processAnnotations(th.co.imake.syndome.bpm.xstream.PstWorkType.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.imake.syndome.bpm.xstream.PstWorkType xbpsTerm = new th.co.imake.syndome.bpm.xstream.PstWorkType();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.imake.syndome.bpm.xstream.PstWorkType) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.imake.syndome.bpm.hibernate.bean.PstWorkType bpsTerm = new th.co.imake.syndome.bpm.hibernate.bean.PstWorkType();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm,ignored); 
						if(xbpsTerm.getPstDepartment()!=null && xbpsTerm.getPstDepartment().getPdId()!=null && xbpsTerm.getPstDepartment().getPdId().intValue()!=-1){
							th.co.imake.syndome.bpm.hibernate.bean.PstDepartment pstDepartment = new th.co.imake.syndome.bpm.hibernate.bean.PstDepartment();
							BeanUtils.copyProperties(xbpsTerm.getPstDepartment(),pstDepartment); 
							bpsTerm.setPstDepartment(pstDepartment);
						}
						if(serviceName.equals(ServiceConstant.PST_WORK_TYPE_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPwtId());
							if(obj!=null){
								th.co.imake.syndome.bpm.hibernate.bean.PstWorkType pstWorkType = (th.co.imake.syndome.bpm.hibernate.bean.PstWorkType)obj;
								BeanUtils.copyProperties(pstWorkType, xbpsTerm,ignored) ;
								if(pstWorkType.getPstDepartment()!=null){
									th.co.imake.syndome.bpm.xstream.PstDepartment xpstDepartment = new th.co.imake.syndome.bpm.xstream.PstDepartment();
									BeanUtils.copyProperties(pstWorkType.getPstDepartment(),xpstDepartment); 
									xpstDepartment.setPagging(null);
									xbpsTerm.setPstDepartment(xpstDepartment);
								}
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.imake.syndome.bpm.xstream.PstWorkType> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstWorkType>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_WORK_TYPE_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long ppId=0l;
							ppId=(Long) (pstCommonService.save(bpsTerm));
							xbpsTerm.setPwtId(ppId);
							return returnUpdateRecord(entity,xbpsTerm,ppId.intValue());
						} else if(serviceName.equals(ServiceConstant.PST_WORK_TYPE_UPDATE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_WORK_TYPE_ITEMS_DELETE)){
							/*int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
							
							String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.imake.syndome.bpm.hibernate.bean.PstWorkType item = new th.co.imake.syndome.bpm.hibernate.bean.PstWorkType();
								item.setPwtId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.PST_WORK_TYPE_DELETE)){
								//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_WORK_TYPE_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings({ "rawtypes" })
							List result = (List) pstWorkTypeService.searchPstWorkType(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstWorkType> ntcCalendars = (java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstWorkType>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.imake.syndome.bpm.xstream.PstWorkType> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstWorkType>();
								if (faqs_size != null && !faqs_size.equals(""))
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstWorkTypeObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.imake.syndome.bpm.xstream.PstWorkType xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.PstWorkType> xbpsTerms = new ArrayList<th.co.imake.syndome.bpm.xstream.PstWorkType>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.imake.syndome.bpm.xstream.PstWorkType> getxPstWorkTypeObject(
			java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstWorkType> ntcCalendars) {
		List<th.co.imake.syndome.bpm.xstream.PstWorkType> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstWorkType>(
				ntcCalendars.size());
		for (th.co.imake.syndome.bpm.hibernate.bean.PstWorkType missManual : ntcCalendars) {
			th.co.imake.syndome.bpm.xstream.PstWorkType xmissManual =new th.co.imake.syndome.bpm.xstream.PstWorkType ();
			BeanUtils.copyProperties(missManual, xmissManual,ignored);
			if(missManual.getPstDepartment()!=null){
				th.co.imake.syndome.bpm.xstream.PstDepartment xpstDepartment = new th.co.imake.syndome.bpm.xstream.PstDepartment();
				BeanUtils.copyProperties(missManual.getPstDepartment(),xpstDepartment); 
				xpstDepartment.setPagging(null);
				xmissManual.setPstDepartment(xpstDepartment);
			}
			xmissManual.setPagging(null);
			xntcCalendars.add(xmissManual);
		}
		return xntcCalendars;
	} 
	@Override
	protected Representation get(Variant variant) throws ResourceException {
		return null;
	} 
	


	

	public PstWorkTypeService getPstWorkTypeService() {
		return pstWorkTypeService;
	}

	public void setPstWorkTypeService(PstWorkTypeService pstWorkTypeService) {
		this.pstWorkTypeService = pstWorkTypeService;
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
	};
}
