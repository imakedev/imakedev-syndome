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
import th.co.imake.syndome.bpm.managers.PstConcreteService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

public class PstConcreteResource extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstConcreteService pstConcreteService; 
	private com.thoughtworks.xstream.XStream xstream; 
	public PstConcreteResource() {
		super();
		logger.debug("into constructor PstConcreteResource");
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
			xstream.processAnnotations(th.co.imake.syndome.bpm.xstream.PstConcrete.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.imake.syndome.bpm.xstream.PstConcrete xbpsTerm = new th.co.imake.syndome.bpm.xstream.PstConcrete();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.imake.syndome.bpm.xstream.PstConcrete) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.imake.syndome.bpm.hibernate.bean.PstConcrete bpsTerm = new th.co.imake.syndome.bpm.hibernate.bean.PstConcrete();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm); 
						if(serviceName.equals(ServiceConstant.PST_CONCRETE_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPconcreteId());
							if(obj!=null){
								th.co.imake.syndome.bpm.hibernate.bean.PstConcrete pstConcrete = (th.co.imake.syndome.bpm.hibernate.bean.PstConcrete)obj;
								BeanUtils.copyProperties(pstConcrete, xbpsTerm) ;
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.imake.syndome.bpm.xstream.PstConcrete> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstConcrete>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_CONCRETE_SAVE)){
							Long pconcreteId=0l;
							pconcreteId=(Long) (pstCommonService.save(bpsTerm));
							xbpsTerm.setPconcreteId(pconcreteId);
							return returnUpdateRecord(entity,xbpsTerm,pconcreteId.intValue());
						} else if(serviceName.equals(ServiceConstant.PST_CONCRETE_UPDATE)){
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_CONCRETE_ITEMS_DELETE)){
							 
							
						/*	String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.aoe.imake.pst.hibernate.bean.PstConcrete item = new th.co.aoe.imake.pst.hibernate.bean.PstConcrete();
								item.setPtId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
						}
						else if(serviceName.equals(ServiceConstant.PST_CONCRETE_DELETE)){
							int updateRecord=pstCommonService.delete(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_CONCRETE_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							//@SuppressWarnings({ "rawtypes" })
							List result = (List) pstConcreteService.searchPstConcrete(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstConcrete> ntcCalendars = (java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstConcrete>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.imake.syndome.bpm.xstream.PstConcrete> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstConcrete>();
								if (faqs_size != null && faqs_size.length()!=0)
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstConcreteObject(ntcCalendars);
								}
								vresultMessage.setResultListObj(xntcCalendars);
								return getRepresentation(entity, vresultMessage, xstream);
							}
						}else if(serviceName.equals(ServiceConstant.PST_CONCRETE_LIST)){
							@SuppressWarnings("rawtypes")
							List result = pstConcreteService.listPstConcretes();
							@SuppressWarnings("unchecked")
							java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstConcrete> ntcCalendars = (java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstConcrete>) result;
									
							VResultMessage vresultMessage = new VResultMessage();
							List<th.co.imake.syndome.bpm.xstream.PstConcrete> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstConcrete>();
							if (ntcCalendars != null && ntcCalendars.size() > 0) {
								xntcCalendars = getxPstConcreteObject(ntcCalendars);
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
	@SuppressWarnings("unused")
	private Representation returnUpdateRecord(Representation entity,th.co.imake.syndome.bpm.xstream.PstConcrete xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.PstConcrete> xbpsTerms = new ArrayList<th.co.imake.syndome.bpm.xstream.PstConcrete>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.imake.syndome.bpm.xstream.PstConcrete> getxPstConcreteObject(
			java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstConcrete> ntcCalendars) {
		List<th.co.imake.syndome.bpm.xstream.PstConcrete> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstConcrete>(
				ntcCalendars.size());
		for (th.co.imake.syndome.bpm.hibernate.bean.PstConcrete missManual : ntcCalendars) {
			th.co.imake.syndome.bpm.xstream.PstConcrete xmissManual =new th.co.imake.syndome.bpm.xstream.PstConcrete ();
			BeanUtils.copyProperties(missManual, xmissManual);
			xmissManual.setPagging(null);
			xntcCalendars.add(xmissManual);
		}
		return xntcCalendars;
	} 
	@Override
	protected Representation get(Variant variant) throws ResourceException {
		// TODO Auto-generated method stub
		/*System.out.println("sss");
		th.co.aoe.imake.pst.xstream.PstConcrete  xbpsTerm =new th.co.aoe.imake.pst.xstream.PstConcrete();
		th.co.aoe.imake.pst.hibernate.bean.PstConcrete pstConcrete =new  th.co.aoe.imake.pst.hibernate.bean.PstConcrete();
		xbpsTerm.setPtId(1l);
		Object obj= pstCommonService.findById(pstConcrete.getClass(), xbpsTerm.getPtId());
		if(obj!=null){
			 pstConcrete = (th.co.aoe.imake.pst.hibernate.bean.PstConcrete)obj;
			BeanUtils.copyProperties(pstConcrete, xbpsTerm) ;
		}
	//logger.debug(" object return ="+ntcCalendarReturn);
	VResultMessage vresultMessage = new VResultMessage();
		if(xbpsTerm!=null){
			List<th.co.aoe.imake.pst.xstream.PstConcrete> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstConcrete>(1);
			xbpsTerm.setPagging(null);							 
			xntcCalendars.add(xbpsTerm);
			vresultMessage.setResultListObj(xntcCalendars);
		}*/
		//save
		//Long ptId=(Long) (pstCommonService.save(pstConcrete));
		
		//update
		/*pstConcrete.setPbdUid("updated");
		pstCommonService.update(pstConcrete);*/
		
		// delete
		//pstCommonService.delete(pstConcrete);
		//return getRepresentation(null, vresultMessage, xstream);
		 return null;
	} 
	


	

	public PstConcreteService getPstConcreteService() {
		return pstConcreteService;
	}

	public void setPstConcreteService(PstConcreteService pstConcreteService) {
		this.pstConcreteService = pstConcreteService;
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
