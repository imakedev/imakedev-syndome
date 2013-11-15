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
import th.co.imake.syndome.bpm.managers.PstCustomerDivisionService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

public class PstCustomerDivisionResource extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstCustomerDivisionService pstCustomerDivisionService; 
	private com.thoughtworks.xstream.XStream xstream; 
	private String[] ignored={"pstCustomer"};
	public PstCustomerDivisionResource() {
		super();
		logger.debug("into constructor PstCustomerDivisionResource");
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
			xstream.processAnnotations(th.co.imake.syndome.bpm.xstream.PstCustomerDivision.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.imake.syndome.bpm.xstream.PstCustomerDivision xbpsTerm = new th.co.imake.syndome.bpm.xstream.PstCustomerDivision();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.imake.syndome.bpm.xstream.PstCustomerDivision) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.imake.syndome.bpm.hibernate.bean.PstCustomerDivision bpsTerm = new th.co.imake.syndome.bpm.hibernate.bean.PstCustomerDivision();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm,ignored); 
						if(xbpsTerm.getPstCustomer()!=null){
							th.co.imake.syndome.bpm.hibernate.bean.PstCustomer customer = new th.co.imake.syndome.bpm.hibernate.bean.PstCustomer();
							BeanUtils.copyProperties(xbpsTerm.getPstCustomer(),customer); 
							bpsTerm.setPstCustomer(customer);
						}
						if(serviceName.equals(ServiceConstant.PST_CUSTOMER_DIVISION_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPcdId());
							if(obj!=null){
								th.co.imake.syndome.bpm.hibernate.bean.PstCustomerDivision pstCustomerDivision = (th.co.imake.syndome.bpm.hibernate.bean.PstCustomerDivision)obj;
								BeanUtils.copyProperties(pstCustomerDivision, xbpsTerm,ignored) ;
								if(pstCustomerDivision.getPstCustomer()!=null){
									th.co.imake.syndome.bpm.xstream.PstCustomer customer = new th.co.imake.syndome.bpm.xstream.PstCustomer();
									BeanUtils.copyProperties(pstCustomerDivision.getPstCustomer(),customer); 
									xbpsTerm.setPstCustomer(customer);
								}
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.imake.syndome.bpm.xstream.PstCustomerDivision> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstCustomerDivision>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_CUSTOMER_DIVISION_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long pcdId=0l;
							pcdId=(Long) (pstCommonService.save(bpsTerm));
							xbpsTerm.setPcdId(pcdId);
							return returnUpdateRecord(entity,xbpsTerm,pcdId.intValue());
						} else if(serviceName.equals(ServiceConstant.PST_CUSTOMER_DIVISION_UPDATE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_CUSTOMER_DIVISION_ITEMS_DELETE)){
							/*int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
							
							String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.imake.syndome.bpm.hibernate.bean.PstCustomerDivision item = new th.co.imake.syndome.bpm.hibernate.bean.PstCustomerDivision();
								item.setPcdId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.PST_CUSTOMER_DIVISION_DELETE)){
								//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_CUSTOMER_DIVISION_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings({ "rawtypes" })
							List result = (List) pstCustomerDivisionService.searchPstCustomerDivision(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstCustomerDivision> ntcCalendars = (java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstCustomerDivision>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.imake.syndome.bpm.xstream.PstCustomerDivision> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstCustomerDivision>();
								if (faqs_size != null && faqs_size.length()!=0)
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstCustomerDivisionObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.imake.syndome.bpm.xstream.PstCustomerDivision xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.PstCustomerDivision> xbpsTerms = new ArrayList<th.co.imake.syndome.bpm.xstream.PstCustomerDivision>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.imake.syndome.bpm.xstream.PstCustomerDivision> getxPstCustomerDivisionObject(
			java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstCustomerDivision> ntcCalendars) {
		List<th.co.imake.syndome.bpm.xstream.PstCustomerDivision> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstCustomerDivision>(
				ntcCalendars.size());
		for (th.co.imake.syndome.bpm.hibernate.bean.PstCustomerDivision missManual : ntcCalendars) {
			th.co.imake.syndome.bpm.xstream.PstCustomerDivision xmissManual =new th.co.imake.syndome.bpm.xstream.PstCustomerDivision ();
			BeanUtils.copyProperties(missManual, xmissManual,ignored);
			if(missManual.getPstCustomer()!=null){
				th.co.imake.syndome.bpm.xstream.PstCustomer customer = new th.co.imake.syndome.bpm.xstream.PstCustomer();
				BeanUtils.copyProperties(missManual.getPstCustomer(),customer); 
				customer.setPagging(null);
				xmissManual.setPstCustomer(customer);
			}
			xmissManual.setPagging(null);
			xntcCalendars.add(xmissManual);
		}
		return xntcCalendars;
	} 
	
	

	public PstCustomerDivisionService getPstCustomerDivisionService() {
		return pstCustomerDivisionService;
	}

	public void setPstCustomerDivisionService(PstCustomerDivisionService pstCustomerDivisionService) {
		this.pstCustomerDivisionService = pstCustomerDivisionService;
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
