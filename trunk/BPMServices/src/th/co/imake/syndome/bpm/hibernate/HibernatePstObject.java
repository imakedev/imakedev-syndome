package th.co.imake.syndome.bpm.hibernate;

import java.text.SimpleDateFormat;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import th.co.imake.syndome.bpm.managers.PstObjectService;
@Repository
@Transactional
public class HibernatePstObject extends HibernateCommon implements PstObjectService {

//	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER); HH:mm:ss
	 private static SimpleDateFormat format1 = new SimpleDateFormat("yyyy_MM_dd_HH_mm_ss");
	 private static SimpleDateFormat format2 = new SimpleDateFormat("dd/MM/yyyy");
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List searchObject(String query) throws DataAccessException {
		// TODO Auto-generated method stub
		try{ 
			//System.out.println("query->"+query);
		    List result= this.sessionAnnotationFactory
				.getCurrentSession()
				.createSQLQuery(query).list();
		    if(result!=null && result.size()>0){ 
		    	return result;
		    	//	Object obj[] =(Object[])result.get(i); 
		    }
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} 
		return null;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	@Override
	public int executeQuery(String[] str) throws DataAccessException {
		// TODO Auto-generated method stub
		Session session=sessionAnnotationFactory.getCurrentSession();
		int returnId=0;
		Query	query=null;
		try{ 
			for (int i = 0; i < str.length; i++) {
				//System.out.println("str==>"+str[i]);
				query= session.createSQLQuery(str[i]);
				 returnId=returnId+query.executeUpdate();
			} 
				 
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if (session != null) {
				session = null;
			} 
		}
				return returnId;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	@Override
	public int executeQueryWithValues(String[] str,List<String[]> values) throws DataAccessException {
		// TODO Auto-generated method stub
		Session session=sessionAnnotationFactory.getCurrentSession();
		int returnId=0;
		Query	query=null;
		try{ 
			for (int i = 0; i < str.length; i++) {
				//System.out.println("str2==>"+str[i]);
				query= session.createSQLQuery(str[i]);
				int j=0;
				//System.out.println(values.size());
				String[] strings=(String[])values.get(i);
				for (int k = 0; k < strings.length; k++) {
					query.setParameter(k,strings[k]);
				}
				/*for (String[] strings : values) {
					query.setParameter(j++,strings);
				}*/
				 returnId=returnId+query.executeUpdate();
			} 
				 
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if (session != null) {
				session = null;
			} 
		}
				return returnId;
	}
}
