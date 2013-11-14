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
import th.co.aoe.imake.pst.managers.PstCustomerContactService;
import th.co.aoe.imake.pst.xstream.common.Pagging;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

public class PstCustomerContactResource extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstCustomerContactService pstCustomerContactService; 
	private com.thoughtworks.xstream.XStream xstream; 
	private String[] ignored_customer={"pstCustomer"};
	private String[] ignored_division={"pstCustomerDivision"};
	public PstCustomerContactResource() {
		super();
		logger.debug("into constructor PstCustomerContactResource");
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
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.PstCustomerContact.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.PstCustomerContact xbpsTerm = new th.co.aoe.imake.pst.xstream.PstCustomerContact();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.aoe.imake.pst.xstream.PstCustomerContact) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.aoe.imake.pst.hibernate.bean.PstCustomerContact bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.PstCustomerContact();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm,ignored_division);  
						if(xbpsTerm.getPstCustomerDivision()!=null){
							th.co.aoe.imake.pst.hibernate.bean.PstCustomerDivision divison = new th.co.aoe.imake.pst.hibernate.bean.PstCustomerDivision();
							BeanUtils.copyProperties(xbpsTerm.getPstCustomerDivision(),divison,ignored_customer); 
							if(xbpsTerm.getPstCustomerDivision().getPstCustomer()!=null){
								th.co.aoe.imake.pst.hibernate.bean.PstCustomer customer = new th.co.aoe.imake.pst.hibernate.bean.PstCustomer();
								BeanUtils.copyProperties(xbpsTerm.getPstCustomerDivision().getPstCustomer(),customer); 
								divison.setPstCustomer(customer);
							}
							bpsTerm.setPstCustomerDivision(divison);
						}
						
						
						if(serviceName.equals(ServiceConstant.PST_CUSTOMER_CONTACT_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPccId());
							if(obj!=null){
								th.co.aoe.imake.pst.hibernate.bean.PstCustomerContact pstCustomerContact = (th.co.aoe.imake.pst.hibernate.bean.PstCustomerContact)obj;
								BeanUtils.copyProperties(pstCustomerContact, xbpsTerm,ignored_division) ;
								if(pstCustomerContact.getPstCustomerDivision()!=null){
									th.co.aoe.imake.pst.xstream.PstCustomerDivision divison = new th.co.aoe.imake.pst.xstream.PstCustomerDivision();
									BeanUtils.copyProperties(pstCustomerContact.getPstCustomerDivision(),divison,ignored_customer);
									if(pstCustomerContact.getPstCustomerDivision().getPstCustomer()!=null){
										th.co.aoe.imake.pst.xstream.PstCustomer customer = new th.co.aoe.imake.pst.xstream.PstCustomer();
										BeanUtils.copyProperties(pstCustomerContact.getPstCustomerDivision().getPstCustomer(),customer); 
										customer.setPagging(null);
										divison.setPstCustomer(customer);
									}
									divison.setPagging(null);
									xbpsTerm.setPstCustomerDivision(divison);
								}
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.aoe.imake.pst.xstream.PstCustomerContact> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstCustomerContact>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_CUSTOMER_CONTACT_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long pccId=0l;
							pccId=(Long) (pstCommonService.save(bpsTerm));
							xbpsTerm.setPccId(pccId);
							return returnUpdateRecord(entity,xbpsTerm,pccId.intValue());
						} else if(serviceName.equals(ServiceConstant.PST_CUSTOMER_CONTACT_UPDATE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							//System.out.println("bpsTerm.getPccId()->"+bpsTerm.getPccId());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_CUSTOMER_CONTACT_ITEMS_DELETE)){
							/*int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
							
							String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.aoe.imake.pst.hibernate.bean.PstCustomerContact item = new th.co.aoe.imake.pst.hibernate.bean.PstCustomerContact();
								item.setPccId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.PST_CUSTOMER_CONTACT_DELETE)){
								//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());  
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_CUSTOMER_CONTACT_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings({ "rawtypes" })
							List result = (List) pstCustomerContactService.searchPstCustomerContact(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstCustomerContact> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstCustomerContact>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.aoe.imake.pst.xstream.PstCustomerContact> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstCustomerContact>();
								if (faqs_size != null && faqs_size.length()!=0)
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstCustomerContactObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.aoe.imake.pst.xstream.PstCustomerContact xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.PstCustomerContact> xbpsTerms = new ArrayList<th.co.aoe.imake.pst.xstream.PstCustomerContact>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.aoe.imake.pst.xstream.PstCustomerContact> getxPstCustomerContactObject(
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstCustomerContact> ntcCalendars) {
		List<th.co.aoe.imake.pst.xstream.PstCustomerContact> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstCustomerContact>(
				ntcCalendars.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstCustomerContact missManual : ntcCalendars) {
			th.co.aoe.imake.pst.xstream.PstCustomerContact xmissManual =new th.co.aoe.imake.pst.xstream.PstCustomerContact ();
			BeanUtils.copyProperties(missManual, xmissManual,ignored_division);
			 
			if(missManual.getPstCustomerDivision()!=null){
				th.co.aoe.imake.pst.xstream.PstCustomerDivision divison = new th.co.aoe.imake.pst.xstream.PstCustomerDivision();
				BeanUtils.copyProperties(missManual.getPstCustomerDivision(),divison,ignored_customer); 
				if(missManual.getPstCustomerDivision().getPstCustomer()!=null){
					th.co.aoe.imake.pst.xstream.PstCustomer customer = new th.co.aoe.imake.pst.xstream.PstCustomer();
					BeanUtils.copyProperties(missManual.getPstCustomerDivision().getPstCustomer(),customer); 
					customer.setPagging(null);
					divison.setPstCustomer(customer);
				}
				divison.setPagging(null);
				xmissManual.setPstCustomerDivision(divison);
			}
			
			xmissManual.setPagging(null);
			xntcCalendars.add(xmissManual);
		}
		return xntcCalendars;
	} 
	
	public PstCustomerContactService getPstCustomerContactService() {
		return pstCustomerContactService;
	}

	public void setPstCustomerContactService(PstCustomerContactService pstCustomerContactService) {
		this.pstCustomerContactService = pstCustomerContactService;
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
