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
import th.co.aoe.imake.pst.managers.PstPositionService;
import th.co.aoe.imake.pst.xstream.common.Pagging;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

public class PstPositionResource  extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstPositionService pstPositionService; 
	private com.thoughtworks.xstream.XStream xstream; 
	public PstPositionResource() {
		super();
		logger.debug("into constructor PstPositionResource");
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
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.PstPosition.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.PstPosition xbpsTerm = new th.co.aoe.imake.pst.xstream.PstPosition();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.aoe.imake.pst.xstream.PstPosition) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.aoe.imake.pst.hibernate.bean.PstPosition bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.PstPosition();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm); 
						if(serviceName.equals(ServiceConstant.PST_POSITION_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPpId());
							if(obj!=null){
								th.co.aoe.imake.pst.hibernate.bean.PstPosition pstPosition = (th.co.aoe.imake.pst.hibernate.bean.PstPosition)obj;
								BeanUtils.copyProperties(pstPosition, xbpsTerm) ;
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.aoe.imake.pst.xstream.PstPosition> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstPosition>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_POSITION_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long ppId=0l;
							ppId=(Long) (pstCommonService.save(bpsTerm));
							xbpsTerm.setPpId(ppId);
							return returnUpdateRecord(entity,xbpsTerm,ppId.intValue());
						} else if(serviceName.equals(ServiceConstant.PST_POSITION_UPDATE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_POSITION_ITEMS_DELETE)){
							/*int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
							
							String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.aoe.imake.pst.hibernate.bean.PstPosition item = new th.co.aoe.imake.pst.hibernate.bean.PstPosition();
								item.setPpId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.PST_POSITION_DELETE)){
								//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_POSITION_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings({ "rawtypes" })
							List result = (List) pstPositionService.searchPstPosition(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstPosition> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstPosition>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.aoe.imake.pst.xstream.PstPosition> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstPosition>();
								if (faqs_size != null && faqs_size.length()!=0)
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstPositionObject(ntcCalendars);
								}
								vresultMessage.setResultListObj(xntcCalendars);
								return getRepresentation(entity, vresultMessage, xstream);
							}
						}else if(serviceName.equals(ServiceConstant.PST_POSITION_LIST)){
							@SuppressWarnings({ "rawtypes" })
							List result = pstPositionService.listPstPosition();
							@SuppressWarnings("unchecked")
							java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstPosition> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstPosition>) result;
									
							VResultMessage vresultMessage = new VResultMessage();
							List<th.co.aoe.imake.pst.xstream.PstPosition> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstPosition>();
							if (ntcCalendars != null && ntcCalendars.size() > 0) {
								xntcCalendars = getxPstPositionObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.aoe.imake.pst.xstream.PstPosition xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.PstPosition> xbpsTerms = new ArrayList<th.co.aoe.imake.pst.xstream.PstPosition>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.aoe.imake.pst.xstream.PstPosition> getxPstPositionObject(
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstPosition> ntcCalendars) {
		List<th.co.aoe.imake.pst.xstream.PstPosition> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstPosition>(
				ntcCalendars.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstPosition missManual : ntcCalendars) {
			th.co.aoe.imake.pst.xstream.PstPosition xmissManual =new th.co.aoe.imake.pst.xstream.PstPosition ();
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
		th.co.aoe.imake.pst.xstream.PstPosition  xbpsTerm =new th.co.aoe.imake.pst.xstream.PstPosition();
		th.co.aoe.imake.pst.hibernate.bean.PstPosition pstPosition =new  th.co.aoe.imake.pst.hibernate.bean.PstPosition();
		xbpsTerm.setPpId(1l);
		Object obj= pstCommonService.findById(pstPosition.getClass(), xbpsTerm.getPpId());
		if(obj!=null){
			 pstPosition = (th.co.aoe.imake.pst.hibernate.bean.PstPosition)obj;
			BeanUtils.copyProperties(pstPosition, xbpsTerm) ;
		}
	//logger.debug(" object return ="+ntcCalendarReturn);
	VResultMessage vresultMessage = new VResultMessage();
		if(xbpsTerm!=null){
			List<th.co.aoe.imake.pst.xstream.PstPosition> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstPosition>(1);
			xbpsTerm.setPagging(null);							 
			xntcCalendars.add(xbpsTerm);
			vresultMessage.setResultListObj(xntcCalendars);
		}
		//save
		//Long ppId=(Long) (pstCommonService.save(pstPosition));
		
		//update
		/*pstPosition.setPbdUid("updated");
		pstCommonService.update(pstPosition);*/
		
		// delete
		//pstCommonService.delete(pstPosition);
		return getRepresentation(null, vresultMessage, xstream);
		// return null;
	} 
	


	

	public PstPositionService getPstPositionService() {
		return pstPositionService;
	}

	public void setPstPositionService(PstPositionService pstPositionService) {
		this.pstPositionService = pstPositionService;
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
