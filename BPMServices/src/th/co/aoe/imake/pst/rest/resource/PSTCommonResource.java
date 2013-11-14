package th.co.aoe.imake.pst.rest.resource;

import org.apache.log4j.Logger;
import org.restlet.representation.Representation;
import org.restlet.representation.Variant;
import org.restlet.resource.ResourceException;

import th.co.aoe.imake.pst.constant.ServiceConstant;

public class PSTCommonResource  extends BaseResource {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);  
	//private ProductReportService productReportService;
	private com.thoughtworks.xstream.XStream xstream; 
	public PSTCommonResource() {
		super();
		logger.debug("into constructor PSTCommonResource");
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
		/*logger.debug("into Post PSTCommonResource 2");
		InputStream in = null;
		try {
			in = entity.getStream();
			xstream.processAnnotations(th.co.aoe.imake.pst.xstream.ProductReport.class);// or xstream.autodetectAnnotations(true); (Auto-detect  Annotations)
			th.co.aoe.imake.pst.xstream.ProductReport xbpsTerm = new th.co.aoe.imake.pst.xstream.ProductReport();
			Object ntcCalendarObj = xstream.fromXML(in);
			if (ntcCalendarObj != null) {
				String className=ntcCalendarObj.getClass().toString();
				
				xbpsTerm = (th.co.aoe.imake.pst.xstream.ProductReport) ntcCalendarObj;
				if (xbpsTerm != null) { 
					if (xbpsTerm.getServiceName() != null
							&& xbpsTerm.getServiceName().length()!=0) {
						logger.debug(" BPS servicename = "
								+ xbpsTerm.getServiceName());
						String serviceName = xbpsTerm.getServiceName();
						if(serviceName.equals(ServiceConstant.PRODUCT_REPORT_FIND)){
							xbpsTerm = productReportService.findProductReport(xbpsTerm.getMode(),xbpsTerm.getYear());
						//logger.debug(" object return ="+ntcCalendarReturn);
						VResultMessage vresultMessage = new VResultMessage();
							if(xbpsTerm!=null){
								List<th.co.aoe.imake.pst.xstream.ProductReport> xntcCalendars = new ArrayList<th.co.aoe.imake.pst.xstream.ProductReport>(1);
								xbpsTerm.setPagging(null);							 
								xntcCalendars.add(xbpsTerm);
								vresultMessage.setResultListObj(xntcCalendars);
							}
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
		}*/
		return null;
	
	}

	
	@Override
	protected Representation get(Variant variant) throws ResourceException {
		// TODO Auto-generated method stub
		 return null;
	} 
	/*public ProductReportService getProductReportService() {
		return productReportService;
	}

	public void setProductReportService(ProductReportService productReportService) {
		this.productReportService = productReportService;
	}*/

	public com.thoughtworks.xstream.XStream getXstream() {
		return xstream;
	}

	public void setXstream(com.thoughtworks.xstream.XStream xstream) {
		this.xstream = xstream;
	}



}
