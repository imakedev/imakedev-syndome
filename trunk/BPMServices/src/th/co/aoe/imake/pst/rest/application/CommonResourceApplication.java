package th.co.aoe.imake.pst.rest.application;

import org.restlet.Application;
import org.restlet.Restlet;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
/**
 * @author Chatchai Pimtun (Admin)
 *
 */
public class CommonResourceApplication extends Application {

	/*@Override
	public Restlet createInboundRoot() {
		// TODO Auto-generated method stub
		return super.createInboundRoot();
	}*/

    /**
     * Creates a root Restlet that will receive all incoming calls.
     */
	
    @Override
    public synchronized Restlet createInboundRoot(){
    //createRoot() {
        // Create a router Restlet that defines routes.
    	final   ApplicationContext springContext = new ClassPathXmlApplicationContext(
                 new String[] {
                		 "th/co/aoe/imake/pst/rest/config/applicationContext-common.xml",
                		 "th/co/aoe/imake/pst/rest/config/applicationContext-hibernate.xml",
                		 "th/co/aoe/imake/pst/rest/config/applicationContext-pst-resource.xml",
                		 "th/co/aoe/imake/pst/rest/config/applicationContext-root-router.xml"});    
        // Add a route for the MailRoot resource
    	org.restlet.ext.spring.SpringRouter router = (org.restlet.ext.spring.SpringRouter)springContext.getBean("root");
        return router;
    } 
     
}
