package th.co.aoe.imake.pst.hibernate;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpType;
import th.co.aoe.imake.pst.managers.PstRoadPumpTypeService;
import th.co.aoe.imake.pst.xstream.common.Pagging;

@Repository
@Transactional
public class HibernatePstRoadPumpType  extends HibernateCommon implements PstRoadPumpTypeService {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	private int getSize(Session session, PstRoadPumpType instance) throws Exception{
		try { 
			Query query=null; 
			StringBuffer sb =new StringBuffer(" select count(pstRoadPumpType) from PstRoadPumpType pstRoadPumpType ");
			query =session.createQuery(sb.toString());
			return ((Long)query.uniqueResult()).intValue(); 
		} catch (HibernateException re) {
			logger.error("HibernateException",re);
			throw re;
		} catch (Exception e) {
			logger.error("Exception",e);
			throw e;
		}
	}
	 @SuppressWarnings({ "rawtypes", "unchecked" })
	 @Transactional(readOnly=true)
	 public List searchPstRoadPumpType(PstRoadPumpType instance,Pagging pagging) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			Session session = sessionAnnotationFactory.getCurrentSession();
			try {
				Query query = null;
				StringBuffer sb =new StringBuffer(" select pstRoadPumpType from PstRoadPumpType pstRoadPumpType ");
     			if(pagging.getSortBy()!=null && pagging.getSortBy().length()>0){
						sb.append( " order by pstRoadPumpType."+pagging.getOrderBy()+" "+pagging.getSortBy().toLowerCase());
				}			
				 query =session.createQuery(sb.toString());
				// set pagging.
				 String size = String.valueOf(getSize(session, instance)); 
				 logger.debug(" first Result="+(pagging.getPageSize()* (pagging.getPageNo() - 1))); 
				 
				 query.setFirstResult(pagging.getPageSize() * (pagging.getPageNo() - 1));
				 query.setMaxResults(pagging.getPageSize());
				 
				 List l = query.list();   
				 transList.add(l); 
			 	 transList.add(size); 
				return transList;
			} catch (Exception re) {
				//re.printStackTrace();
				logger.error("find by property name failed", re);
				 
			}
			return transList;
		}
	 @SuppressWarnings("rawtypes")
	@Override
	public List listPstRoadPumpType() throws DataAccessException {
		// TODO Auto-generated method stub
		//ArrayList  transList = new ArrayList ();
		Session session = sessionAnnotationFactory.getCurrentSession();
		try {
			Query query = null;
			StringBuffer sb =new StringBuffer(" select pstRoadPumpType from PstRoadPumpType pstRoadPumpType ");
			 query =session.createQuery(sb.toString());
			// set pagging.
			 
			 List l = query.list();   
			return l;
		} catch (Exception re) {
			//re.printStackTrace();
			logger.error("find by property name failed", re);
			 
		}
		return null;
	}
}
