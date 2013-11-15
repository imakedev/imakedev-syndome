package th.co.imake.syndome.bpm.rest.application;

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
    public synchronized Restlet createRoot() {
        // Create a router Restlet that defines routes.
		System.out.println("yyyyyyyyyyyy xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
		final   ApplicationContext springContext = new ClassPathXmlApplicationContext(
                 new String[] {
                		 "th/co/aoe/imake/pst/rest/config/applicationContext-common.xml",
                		 "th/co/aoe/imake/pst/rest/config/applicationContext-hibernate.xml",
                		 "th/co/aoe/imake/pst/rest/config/applicationContext-pst-resource.xml",
                		 "th/co/aoe/imake/pst/rest/config/applicationContext-root-router.xml"});   
        // Add a route for the MailRoot resource
    	org.restlet.ext.spring.SpringRouter router = (org.restlet.ext.spring.SpringRouter)springContext.getBean("root");
        return router;
    }*/

    /**
     * Creates a root Restlet that will receive all incoming calls.
     */
	
   @Override
    public synchronized Restlet createInboundRoot(){
    //createRoot() {
        // Create a router Restlet that defines routes.
    	//System.out.println("yyyyyyyyyyyy createInboundRoot xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    	final   ClassPathXmlApplicationContext springContext = new ClassPathXmlApplicationContext(
                 new String[] {
                		 "th/co/aoe/imake/pst/rest/config/applicationContext-common.xml",
                		 "th/co/aoe/imake/pst/rest/config/applicationContext-hibernate.xml",
                		 "th/co/aoe/imake/pst/rest/config/applicationContext-pst-resource.xml",
                		 "th/co/aoe/imake/pst/rest/config/applicationContext-root-router.xml"});    
        // Add a route for the MailRoot resource
    	org.restlet.ext.spring.SpringRouter router = (org.restlet.ext.spring.SpringRouter)springContext.getBean("root");
    	springContext.close();
        return router;
    } 
     
}
