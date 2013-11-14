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
import th.co.aoe.imake.pst.managers.PstEmployeeService;
import th.co.aoe.imake.pst.xstream.common.Pagging;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;

public class PstEmployeeResource  extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	private PSTCommonService pstCommonService;
	private PstEmployeeService pstEmployeeService; 
	private com.thoughtworks.xstream.XStream xstream;  
	private static final String[] ignore=	 {"pstPosition","pstTitle","pstRoadPump"};
	public PstEmployeeResource() {
		super();
		logger.debug("into constructor PstEmployeeResource");
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
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.PstEmployee.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.PstEmployee xbpsTerm = new th.co.aoe.imake.pst.xstream.PstEmployee();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				xbpsTerm = (th.co.aoe.imake.pst.xstream.PstEmployee) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						th.co.aoe.imake.pst.hibernate.bean.PstEmployee bpsTerm = new th.co.aoe.imake.pst.hibernate.bean.PstEmployee();
						BeanUtils.copyProperties(xbpsTerm,bpsTerm,ignore); 
						if(xbpsTerm.getPstPosition()!=null && xbpsTerm.getPstPosition().getPpId()!=null && xbpsTerm.getPstPosition().getPpId().intValue()!=0)
						{
							th.co.aoe.imake.pst.hibernate.bean.PstPosition pstPosition = new th.co.aoe.imake.pst.hibernate.bean.PstPosition(); 
							BeanUtils.copyProperties(xbpsTerm.getPstPosition(),pstPosition); 	
							bpsTerm.setPstPosition(pstPosition);
						}
						
						if(xbpsTerm.getPstRoadPump()!=null && xbpsTerm.getPstRoadPump().getPrpId()!=null && xbpsTerm.getPstRoadPump().getPrpId().intValue()!=0)
						{
							th.co.aoe.imake.pst.hibernate.bean.PstRoadPump pstRoadPump = new th.co.aoe.imake.pst.hibernate.bean.PstRoadPump(); 
							pstRoadPump.setPrpId(xbpsTerm.getPstRoadPump().getPrpId());
							//BeanUtils.copyProperties(xbpsTerm.getPstRoadPump(),pstRoadPump); 	
							bpsTerm.setPstRoadPump(pstRoadPump);
						}
						//System.out.println("bpsTerm.getPstRoadPump()->"+bpsTerm.getPstRoadPump());
						if(xbpsTerm.getPstTitle()!=null && xbpsTerm.getPstTitle().getPtId()!=null && xbpsTerm.getPstTitle().getPtId().intValue()!=0)
						{
							th.co.aoe.imake.pst.hibernate.bean.PstTitle pstTitle = new th.co.aoe.imake.pst.hibernate.bean.PstTitle(); 
							BeanUtils.copyProperties(xbpsTerm.getPstTitle(),pstTitle); 	
							bpsTerm.setPstTitle(pstTitle);
						}
						if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_FIND_BY_ID)){
							Object obj= pstCommonService.findById(bpsTerm.getClass(), xbpsTerm.getPeId());
							if(obj!=null){
								th.co.aoe.imake.pst.hibernate.bean.PstEmployee pstEmployee = (th.co.aoe.imake.pst.hibernate.bean.PstEmployee)obj;
								BeanUtils.copyProperties(pstEmployee, xbpsTerm,ignore) ;
								if(pstEmployee.getPstPosition()!=null && pstEmployee.getPstPosition().getPpId()!=null && pstEmployee.getPstPosition().getPpId().intValue()!=0)
								{
									th.co.aoe.imake.pst.xstream.PstPosition pstPosition = new th.co.aoe.imake.pst.xstream.PstPosition(); 
									BeanUtils.copyProperties(pstEmployee.getPstPosition(),pstPosition); 	
									xbpsTerm.setPstPosition(pstPosition);
								}
								if(pstEmployee.getPstTitle()!=null && pstEmployee.getPstTitle().getPtId()!=null && pstEmployee.getPstTitle().getPtId().intValue()!=0)
								{
									th.co.aoe.imake.pst.xstream.PstTitle pstTitle = new th.co.aoe.imake.pst.xstream.PstTitle(); 
									BeanUtils.copyProperties(pstEmployee.getPstTitle(),pstTitle); 	
									xbpsTerm.setPstTitle(pstTitle);
								}
								if(pstEmployee.getPstRoadPump()!=null && pstEmployee.getPstRoadPump().getPrpId()!=null && pstEmployee.getPstRoadPump().getPrpId().intValue()!=0)
								{
									th.co.aoe.imake.pst.xstream.PstRoadPump pstRoadPump = new th.co.aoe.imake.pst.xstream.PstRoadPump(); 
									//BeanUtils.copyProperties(pstEmployee.getPstRoadPump(),pstRoadPump); 	
									pstRoadPump.setPrpId(pstEmployee.getPstRoadPump().getPrpId());
									pstRoadPump.setPrpNo(pstEmployee.getPstRoadPump().getPrpNo());
									xbpsTerm.setPstRoadPump(pstRoadPump);
								}
							}
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.aoe.imake.pst.xstream.PstEmployee> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstEmployee>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_SAVE)){
							//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							Long peId=0l;
							peId=(Long) (pstCommonService.save(bpsTerm));
							xbpsTerm.setPeId(peId);
							return returnUpdateRecord(entity,xbpsTerm,peId.intValue());
						} else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_UPDATE)){
						//	java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
							if(!(bpsTerm.getPstPosition()!=null && bpsTerm.getPstPosition().getPpId()!=null && bpsTerm.getPstPosition().getPpId().intValue()!=0))
								bpsTerm.setPstPosition(null);
							if(!(bpsTerm.getPstTitle()!=null && bpsTerm.getPstTitle().getPtId()!=null && bpsTerm.getPstTitle().getPtId().intValue()!=0))
								bpsTerm.setPstTitle(null);
							if(!(bpsTerm.getPstRoadPump()!=null && bpsTerm.getPstRoadPump().getPrpId()!=null && bpsTerm.getPstRoadPump().getPrpId().intValue()!=0))
								bpsTerm.setPstRoadPump(null);
							//System.out.println(bpsTerm.getPstPosition());
							int updateRecord=pstCommonService.update(bpsTerm);
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
							
						}
						else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_ITEMS_DELETE)){
							/*int updateRecord=missAccountService.deleteMissAccount(bpsTerm);
							returnUpdateRecord(entity,xbpsTerm,updateRecord);*/
							
							String[] ids=xbpsTerm.getIds().split(",");
							//logger.debug("xbpsTerm.getMsIds()="+xbpsTerm.getMsIds());
							int updateRecord=0;
							for (int i = 0; i <ids.length; i++) {
								th.co.aoe.imake.pst.hibernate.bean.PstEmployee item = new th.co.aoe.imake.pst.hibernate.bean.PstEmployee();
								item.setPeId(Long.parseLong(ids[i]));
								updateRecord=pstCommonService.delete(item);
							}
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}
						else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_DELETE)){
								//java.sql.Timestamp timeStampStartDate = new java.sql.Timestamp(new Date().getTime());
								int updateRecord=pstCommonService.delete(bpsTerm);
								return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_EMPLOYEE_SEARCH)){
							Pagging page = xbpsTerm.getPagging(); 
							@SuppressWarnings("rawtypes")
							List result = (List) pstEmployeeService.searchPstEmployee(bpsTerm, page);
							if (result != null && result.size() == 2) {
								@SuppressWarnings("unchecked")
								java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstEmployee> ntcCalendars = (java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstEmployee>) result
										.get(0);
								String faqs_size = (String) result.get(1);
								VResultMessage vresultMessage = new VResultMessage();
								List<th.co.aoe.imake.pst.xstream.PstEmployee> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstEmployee>();
								if (faqs_size != null && faqs_size.length()!=0)
									vresultMessage.setMaxRow(faqs_size);
								if (ntcCalendars != null && ntcCalendars.size() > 0) {
									xntcCalendars = getxPstEmployeeObject(ntcCalendars);
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
	private Representation returnUpdateRecord(Representation entity,th.co.aoe.imake.pst.xstream.PstEmployee xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.aoe.imake.pst.xstream.PstEmployee> xbpsTerms = new ArrayList<th.co.aoe.imake.pst.xstream.PstEmployee>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	}
	private List<th.co.aoe.imake.pst.xstream.PstEmployee> getxPstEmployeeObject(
			java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstEmployee> ntcCalendars) {
		List<th.co.aoe.imake.pst.xstream.PstEmployee> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstEmployee>(
				ntcCalendars.size());
		for (th.co.aoe.imake.pst.hibernate.bean.PstEmployee missManual : ntcCalendars) {
			th.co.aoe.imake.pst.xstream.PstEmployee xmissManual =new th.co.aoe.imake.pst.xstream.PstEmployee ();
			BeanUtils.copyProperties(missManual, xmissManual,ignore);
			if(missManual.getPstPosition()!=null && missManual.getPstPosition().getPpId()!=null && missManual.getPstPosition().getPpId().intValue()!=0)
			{
				th.co.aoe.imake.pst.xstream.PstPosition pstPosition = new th.co.aoe.imake.pst.xstream.PstPosition(); 
				BeanUtils.copyProperties(missManual.getPstPosition(),pstPosition); 	
				xmissManual.setPstPosition(pstPosition);
			}
			if(missManual.getPstTitle()!=null && missManual.getPstTitle().getPtId()!=null && missManual.getPstTitle().getPtId().intValue()!=0)
			{
				th.co.aoe.imake.pst.xstream.PstTitle pstTitle = new th.co.aoe.imake.pst.xstream.PstTitle(); 
				BeanUtils.copyProperties(missManual.getPstTitle(),pstTitle); 	
				xmissManual.setPstTitle(pstTitle);
			}
			if(missManual.getPstRoadPump()!=null && missManual.getPstRoadPump().getPrpId()!=null && missManual.getPstRoadPump().getPrpId().intValue()!=0)
			{
				th.co.aoe.imake.pst.xstream.PstRoadPump pstRoadPump = new th.co.aoe.imake.pst.xstream.PstRoadPump(); 
				pstRoadPump.setPrpId(missManual.getPstRoadPump().getPrpId());
				//BeanUtils.copyProperties(missManual.getPstRoadPump(),pstRoadPump); 	
				xmissManual.setPstRoadPump(pstRoadPump);
			}
			xmissManual.setPagging(null);
			xntcCalendars.add(xmissManual);
		}
		return xntcCalendars;
	} 
	@Override
	protected Representation get(Variant variant) throws ResourceException {
		// TODO Auto-generated method stub
		//System.out.println("sss");
		th.co.aoe.imake.pst.xstream.PstEmployee  xbpsTerm =new th.co.aoe.imake.pst.xstream.PstEmployee();
		th.co.aoe.imake.pst.hibernate.bean.PstEmployee pstEmployee =new  th.co.aoe.imake.pst.hibernate.bean.PstEmployee();
		xbpsTerm.setPeId(1l);
		Object obj= pstCommonService.findById(pstEmployee.getClass(), xbpsTerm.getPeId());
		if(obj!=null){
			 pstEmployee = (th.co.aoe.imake.pst.hibernate.bean.PstEmployee)obj;
			BeanUtils.copyProperties(pstEmployee, xbpsTerm) ;
		}
	//logger.debug(" object return ="+ntcCalendarReturn);
	VResultMessage vresultMessage = new VResultMessage();
		if(xbpsTerm!=null){
			List<th.co.aoe.imake.pst.xstream.PstEmployee> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.PstEmployee>(1);
			xbpsTerm.setPagging(null);							 
			xntcCalendars.add(xbpsTerm);
			vresultMessage.setResultListObj(xntcCalendars);
		}
		//save
		//Long peId=(Long) (pstCommonService.save(pstEmployee));
		
		//update
		/*pstEmployee.setPbdUid("updated");
		pstCommonService.update(pstEmployee);*/
		
		// delete
		//pstCommonService.delete(pstEmployee);
		return getRepresentation(null, vresultMessage, xstream);
		// return null;
	} 
	


	

	public PstEmployeeService getPstEmployeeService() {
		return pstEmployeeService;
	}

	public void setPstEmployeeService(PstEmployeeService pstEmployeeService) {
		this.pstEmployeeService = pstEmployeeService;
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
