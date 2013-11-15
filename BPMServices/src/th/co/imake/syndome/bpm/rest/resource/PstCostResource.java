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
import th.co.imake.syndome.bpm.managers.PstCostService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

public class PstCostResource  extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstCostService pstCostService; 
	private com.thoughtworks.xstream.XStream xstream; 
	public PstCostResource() {
		super();
		logger.debug("into constructor PstCostResource");
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
			xstream.processAnnotations(th.co.imake.syndome.bpm.xstream.PstCost.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.imake.syndome.bpm.xstream.PstCost xbpsTerm = new th.co.imake.syndome.bpm.xstream.PstCost();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.imake.syndome.bpm.xstream.PstCost) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.imake.syndome.bpm.hibernate.bean.PstCost bpsTerm = new th.co.imake.syndome.bpm.hibernate.bean.PstCost();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm); 
						if(serviceName.equals(ServiceConstant.PST_COST_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPcId());
							if(obj!=null){
								th.co.imake.syndome.bpm.hibernate.bean.PstCost pstCost = (th.co.imake.syndome.bpm.hibernate.bean.PstCost)obj;
								BeanUtils.copyProperties(pstCost, xbpsTerm) ;
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.imake.syndome.bpm.xstream.PstCost> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstCost>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_COST_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long pcId=0l;
							pcId=(Long) (pstCommonService.save(bpsTerm));
							xbpsTerm.setPcId(pcId);
							return returnUpdateRecord(entity,xbpsTerm,pcId.intValue());
						} else if(serviceName.equals(ServiceConstant.PST_COST_UPDATE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_COST_ITEMS_DELETE)){
							/*int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
							
							String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.imake.syndome.bpm.hibernate.bean.PstCost item = new th.co.imake.syndome.bpm.hibernate.bean.PstCost();
								item.setPcId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.PST_COST_DELETE)){
							//	java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_COST_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							
							@SuppressWarnings({ "rawtypes" })
							List result = (List) pstCostService.searchPstCost(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings({ "unchecked"})
								java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstCost> ntcCalendars = (java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstCost>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.imake.syndome.bpm.xstream.PstCost> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstCost>();
								if (faqs_size != null && faqs_size.length()!=0)
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstCostObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.imake.syndome.bpm.xstream.PstCost xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.PstCost> xbpsTerms = new ArrayList<th.co.imake.syndome.bpm.xstream.PstCost>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.imake.syndome.bpm.xstream.PstCost> getxPstCostObject(
			java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstCost> ntcCalendars) {
		List<th.co.imake.syndome.bpm.xstream.PstCost> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstCost>(
				ntcCalendars.size());
		for (th.co.imake.syndome.bpm.hibernate.bean.PstCost missManual : ntcCalendars) {
			th.co.imake.syndome.bpm.xstream.PstCost xmissManual =new th.co.imake.syndome.bpm.xstream.PstCost ();
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
		th.co.imake.syndome.bpm.xstream.PstCost  xbpsTerm =new th.co.imake.syndome.bpm.xstream.PstCost();
		th.co.imake.syndome.bpm.hibernate.bean.PstCost pstCost =new  th.co.imake.syndome.bpm.hibernate.bean.PstCost();
		xbpsTerm.setPcId(1l);
		Object obj= pstCommonService.findById(pstCost.getClass(), xbpsTerm.getPcId());
		if(obj!=null){
			 pstCost = (th.co.imake.syndome.bpm.hibernate.bean.PstCost)obj;
			BeanUtils.copyProperties(pstCost, xbpsTerm) ;
		}
	//logger.debug(" object return ="+ntcCalendarReturn);
	VResultMessage vresultMessage = new VResultMessage();
		if(xbpsTerm!=null){
			List<th.co.imake.syndome.bpm.xstream.PstCost> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstCost>(1);
			xbpsTerm.setPagging(null);							 
			xntcCalendars.add(xbpsTerm);
			vresultMessage.setResultListObj(xntcCalendars);
		}
		//save
		//Long pcId=(Long) (pstCommonService.save(pstCost));
		
		//update
		/*pstCost.setPbdUid("updated");
		pstCommonService.update(pstCost);*/
		
		// delete
		//pstCommonService.delete(pstCost);
		return getRepresentation(null, vresultMessage, xstream);
		// return null;
	} 
	


	

	public PstCostService getPstCostService() {
		return pstCostService;
	}

	public void setPstCostService(PstCostService pstCostService) {
		this.pstCostService = pstCostService;
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
