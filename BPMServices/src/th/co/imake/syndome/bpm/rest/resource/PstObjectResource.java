package th.co.imake.syndome.bpm.rest.resource;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.restlet.representation.Representation;
import org.restlet.representation.Variant;
import org.restlet.resource.ResourceException;

import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.managers.PstObjectService;
import th.co.imake.syndome.bpm.xstream.common.VResultMessage;

public class PstObjectResource extends BaseResource {
	private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
//	private PSTCommonService pstCommonService;
	private PstObjectService pstObjectService; 
	private com.thoughtworks.xstream.XStream xstream; 
	private static final String[] ignore=	 {"id","pstDepartment","pstRoadPump","pstWorkType"};
	private static final String[] ignore2=	 {"pstRoadPump"};
 
	public PstObjectResource() {
		super();
		logger.debug("into constructor stObject");
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
		logger.debug("into Post PstObjectResource 2");
		InputStream in = null;
		try {
			in = entity.getStream();
			xstream.processAnnotations(th.co.imake.syndome.bpm.xstream.PstObject.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.imake.syndome.bpm.xstream.PstObject xbpsTerm = new th.co.imake.syndome.bpm.xstream.PstObject();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				 
				xbpsTerm = (th.co.imake.syndome.bpm.xstream.PstObject) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();  
						if(serviceName.equals(ServiceConstant.PST_OBJECT_SEARCH)){
							@SuppressWarnings({ "rawtypes" })
							List list= pstObjectService.searchObject(xbpsTerm.getQuery()[0]);
							VResultMessage vresultMessage = new VResultMessage();
							vresultMessage.setResultListObj(list); 
							return getRepresentation(entity, vresultMessage, xstream);
						}else if(serviceName.equals(ServiceConstant.PST_OBJECT_EXECUTE)){
							int updateRecord=pstObjectService.executeQuery(xbpsTerm.getQuery()); 
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
						}else if(serviceName.equals(ServiceConstant.PST_OBJECT_EXECUTE_WITH_VALUES)){
							 int updateRecord=pstObjectService.executeQueryWithValues(xbpsTerm.getQuery(),xbpsTerm.getValues()); 
							return returnUpdateRecord(entity,xbpsTerm,updateRecord);
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
	private Representation returnUpdateRecord(Representation entity,th.co.imake.syndome.bpm.xstream.PstObject xbpsTerm,int updateRecord){
		VResultMessage vresultMessage = new VResultMessage();
		List<th.co.imake.syndome.bpm.xstream.PstObject> xbpsTerms = new ArrayList<th.co.imake.syndome.bpm.xstream.PstObject>(1);
		xbpsTerm.setUpdateRecord(updateRecord);
		xbpsTerms.add(xbpsTerm);
		vresultMessage.setResultListObj(xbpsTerms);
		//export(entity, vresultMessage, xstream);	
		return getRepresentation(entity, vresultMessage, xstream);
	} 

	public PstObjectService getPstObjectService() {
		return pstObjectService;
	}

	public void setPstObjectService(PstObjectService pstObjectService) {
		this.pstObjectService = pstObjectService;
	}

	/*public PSTCommonService getPstCommonService() {
		return pstCommonService;
	}

	public void setPstCommonService(PSTCommonService pstCommonService) {
		this.pstCommonService = pstCommonService;
	}
*/
	public com.thoughtworks.xstream.XStream getXstream() {
		return xstream;
	}

	public void setXstream(com.thoughtworks.xstream.XStream xstream) {
		this.xstream = xstream;
	}

}
