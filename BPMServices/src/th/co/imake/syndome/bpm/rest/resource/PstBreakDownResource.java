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
import th.co.imake.syndome.bpm.managers.PstBreakDownService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

public class PstBreakDownResource  extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstBreakDownService pstBreakDownService; 
	private com.thoughtworks.xstream.XStream xstream; 
	public PstBreakDownResource() {
		super();
		logger.debug("into constructor PstBreakDownResource");
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
			xstream.processAnnotations(th.co.imake.syndome.bpm.xstream.PstBreakDown.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.imake.syndome.bpm.xstream.PstBreakDown xbpsTerm = new th.co.imake.syndome.bpm.xstream.PstBreakDown();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				//String className=ntcCalendarObj.getClass().toString();
				/*if("th.co.aoe.imake.pst.xstream.ProductReport".equals(className)){
					
				}else if(){
					
				}*/
				xbpsTerm = (th.co.imake.syndome.bpm.xstream.PstBreakDown) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown bpsTerm = new th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm); 
						if(serviceName.equals(ServiceConstant.PST_BREAK_DOWN_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPbdId());
							if(obj!=null){
								th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown pstBreakDown = (th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown)obj;
								BeanUtils.copyProperties(pstBreakDown, xbpsTerm) ;
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.imake.syndome.bpm.xstream.PstBreakDown> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstBreakDown>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_BREAK_DOWN_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long pbdId=0l;
							pbdId=(Long) (pstCommonService.save(bpsTerm));
							xbpsTerm.setPbdId(pbdId);
							return returnUpdateRecord(entity,xbpsTerm,pbdId.intValue());
						} else if(serviceName.equals(ServiceConstant.PST_BREAK_DOWN_UPDATE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_BREAK_DOWN_ITEMS_DELETE)){
							/*int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
							
							String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown item = new th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown();
								item.setPbdId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.PST_BREAK_DOWN_DELETE)){
							//	java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_BREAK_DOWN_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings("rawtypes")
							List result = (List) pstBreakDownService.searchPstBreakDown(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown> ntcCalendars = (java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.imake.syndome.bpm.xstream.PstBreakDown> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstBreakDown>();
								if (faqs_size != null && !faqs_size.equals(""))
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstBreakDownObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.imake.syndome.bpm.xstream.PstBreakDown xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.PstBreakDown> xbpsTerms = new ArrayList<th.co.imake.syndome.bpm.xstream.PstBreakDown>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.imake.syndome.bpm.xstream.PstBreakDown> getxPstBreakDownObject(
			java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown> ntcCalendars) {
		List<th.co.imake.syndome.bpm.xstream.PstBreakDown> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstBreakDown>(
				ntcCalendars.size());
		for (th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown missManual : ntcCalendars) {
			th.co.imake.syndome.bpm.xstream.PstBreakDown xmissManual =new th.co.imake.syndome.bpm.xstream.PstBreakDown ();
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
		th.co.imake.syndome.bpm.xstream.PstBreakDown  xbpsTerm =new th.co.imake.syndome.bpm.xstream.PstBreakDown();
		th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown pstBreakDown =new  th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown();
		xbpsTerm.setPbdId(1l);
		Object obj= pstCommonService.findById(pstBreakDown.getClass(), xbpsTerm.getPbdId());
		if(obj!=null){
			 pstBreakDown = (th.co.imake.syndome.bpm.hibernate.bean.PstBreakDown)obj;
			BeanUtils.copyProperties(pstBreakDown, xbpsTerm) ;
		}
	//logger.debug(" object return ="+ntcCalendarReturn);
	VResultMessage vresultMessage = new VResultMessage();
		if(xbpsTerm!=null){
			List<th.co.imake.syndome.bpm.xstream.PstBreakDown> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstBreakDown>(1);
			xbpsTerm.setPagging(null);							 
			xntcCalendars.add(xbpsTerm);
			vresultMessage.setResultListObj(xntcCalendars);
		}
		//save
		//Long pbdId=(Long) (pstCommonService.save(pstBreakDown));
		
		//update
		/*pstBreakDown.setPbdUid("updated");
		pstCommonService.update(pstBreakDown);*/
		
		// delete
		//pstCommonService.delete(pstBreakDown);
		return getRepresentation(null, vresultMessage, xstream);
		// return null;
	} 
	


	public PstBreakDownService getPstBreakDownService() {
		return pstBreakDownService;
	}

	public void setPstBreakDownService(PstBreakDownService pstBreakDownService) {
		this.pstBreakDownService = pstBreakDownService;
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