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
import th.co.aoe.imake.pst.managers.PstBrandService;
import th.co.aoe.imake.pst.xstream.common.Pagging;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

public class PstBrandResource  extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstBrandService pstBrandService; 
	private com.thoughtworks.xstream.XStream xstream; 
	public PstBrandResource() {
		super();
		logger.debug("into constructor PstBrandResource");
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
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.PstBrand.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.PstBrand xbpsTerm = new th.co.aoe.imake.pst.xstream.PstBrand();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.aoe.imake.pst.xstream.PstBrand) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.aoe.imake.pst.hibernate.bean.PstBrand bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.PstBrand();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm); 
						if(serviceName.equals(ServiceConstant.PST_BRAND_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPbId());
							if(obj!=null){
								th.co.aoe.imake.pst.hibernate.bean.PstBrand pstBrand = (th.co.aoe.imake.pst.hibernate.bean.PstBrand)obj;
								BeanUtils.copyProperties(pstBrand, xbpsTerm) ;
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.aoe.imake.pst.xstream.PstBrand> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstBrand>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_BRAND_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long pbId=0l;
							pbId=(Long) (pstCommonService.save(bpsTerm));
							xbpsTerm.setPbId(pbId);
							return returnUpdateRecord(entity,xbpsTerm,pbId.intValue());
						} else if(serviceName.equals(ServiceConstant.PST_BRAND_UPDATE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_BRAND_ITEMS_DELETE)){
							/*int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
							
							String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.aoe.imake.pst.hibernate.bean.PstBrand item = new th.co.aoe.imake.pst.hibernate.bean.PstBrand();
								item.setPbId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.PST_BRAND_DELETE)){
								//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_BRAND_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings({ "rawtypes" })
							List result = (List) pstBrandService.searchPstBrand(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstBrand> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstBrand>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.aoe.imake.pst.xstream.PstBrand> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstBrand>();
								if (faqs_size != null && faqs_size.length()!=0)
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstBrandObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.aoe.imake.pst.xstream.PstBrand xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.PstBrand> xbpsTerms = new ArrayList<th.co.aoe.imake.pst.xstream.PstBrand>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.aoe.imake.pst.xstream.PstBrand> getxPstBrandObject(
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstBrand> ntcCalendars) {
		List<th.co.aoe.imake.pst.xstream.PstBrand> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstBrand>(
				ntcCalendars.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstBrand missManual : ntcCalendars) {
			th.co.aoe.imake.pst.xstream.PstBrand xmissManual =new th.co.aoe.imake.pst.xstream.PstBrand ();
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
		th.co.aoe.imake.pst.xstream.PstBrand  xbpsTerm =new th.co.aoe.imake.pst.xstream.PstBrand();
		th.co.aoe.imake.pst.hibernate.bean.PstBrand pstBrand =new  th.co.aoe.imake.pst.hibernate.bean.PstBrand();
		xbpsTerm.setPbId(1l);
		Object obj= pstCommonService.findById(pstBrand.getClass(), xbpsTerm.getPbId());
		if(obj!=null){
			 pstBrand = (th.co.aoe.imake.pst.hibernate.bean.PstBrand)obj;
			BeanUtils.copyProperties(pstBrand, xbpsTerm) ;
		}
	//logger.debug(" object return ="+ntcCalendarReturn);
	VResultMessage vresultMessage = new VResultMessage();
		if(xbpsTerm!=null){
			List<th.co.aoe.imake.pst.xstream.PstBrand> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstBrand>(1);
			xbpsTerm.setPagging(null);							 
			xntcCalendars.add(xbpsTerm);
			vresultMessage.setResultListObj(xntcCalendars);
		}
		//save
		//Long pbId=(Long) (pstCommonService.save(pstBrand));
		
		//update
		/*pstBrand.setPbdUid("updated");
		pstCommonService.update(pstBrand);*/
		
		// delete
		//pstCommonService.delete(pstBrand);
		return getRepresentation(null, vresultMessage, xstream);
		// return null;
	} 
	


	

	public PstBrandService getPstBrandService() {
		return pstBrandService;
	}

	public void setPstBrandService(PstBrandService pstBrandService) {
		this.pstBrandService = pstBrandService;
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
