package th.co.imake.syndome.bpm.rest.application;

import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.LogManager;

import org.restlet.Application;
import org.restlet.Restlet;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import th.co.imake.syndome.bpm.constant.ServiceConstant;

/**
 * @author Chatchai Pimtun (Admin)
 * 
 */
public class CommonResourceApplication extends Application {

	/*
	 * @Override public synchronized Restlet createRoot() { // Create a router
	 * Restlet that defines routes.
	 * System.out.println("yyyyyyyyyyyy xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
	 * final ApplicationContext springContext = new
	 * ClassPathXmlApplicationContext( new String[] {
	 * "th/co/aoe/imake/pst/rest/config/applicationContext-common.xml",
	 * "th/co/aoe/imake/pst/rest/config/applicationContext-hibernate.xml",
	 * "th/co/aoe/imake/pst/rest/config/applicationContext-pst-resource.xml",
	 * "th/co/aoe/imake/pst/rest/config/applicationContext-root-router.xml"});
	 * // Add a route for the MailRoot resource
	 * org.restlet.ext.spring.SpringRouter router =
	 * (org.restlet.ext.spring.SpringRouter)springContext.getBean("root");
	 * return router; }
	 */

	/**
	 * Creates a root Restlet that will receive all incoming calls.
	 */

	@Override
	public synchronized Restlet createInboundRoot() {
		// createRoot() {
		// Create a router Restlet that defines routes.
		// System.out.println("yyyyyyyyyyyy createInboundRoot xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
		final ClassPathXmlApplicationContext springContext = new ClassPathXmlApplicationContext(
				new String[] {
						"th/co/imake/syndome/bpm/rest/config/applicationContext-common.xml",
						"th/co/imake/syndome/bpm/rest/config/applicationContext-hibernate.xml",
						"th/co/imake/syndome/bpm/rest/config/applicationContext-syndome-bpm-resource.xml",
						"th/co/imake/syndome/bpm/rest/config/applicationContext-root-router.xml" });
		// Add a route for the MailRoot resource
		org.restlet.ext.spring.SpringRouter router = (org.restlet.ext.spring.SpringRouter) springContext
				.getBean("root");
		springContext.close();
		// For Production
		if (ServiceConstant.LOG_LEVEL.equals("pro")) {
			LogManager logManager = LogManager.getLogManager();
			for (Enumeration e = logManager.getLoggerNames(); e
					.hasMoreElements();) {
				String logName = e.nextElement().toString();
				if (logName.startsWith("com.noelios")
						|| logName.startsWith("org.restlet")) {
					System.out.println("logName->" + logName);
					logManager.getLogger(logName).setLevel(Level.OFF);
				}
			}
		}
		/*
		 * java.util.logging.Logger rootLogger =
		 * LogManager.getLogManager().getLogger(""); Handler[] handlers =
		 * rootLogger.getHandlers(); rootLogger.removeHandler(handlers[0]);
		 * SLF4JBridgeHandler.install();
		 */
		return router;
	}
}
