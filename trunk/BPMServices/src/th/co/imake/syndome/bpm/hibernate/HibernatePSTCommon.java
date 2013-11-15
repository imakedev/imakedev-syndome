package th.co.imake.syndome.bpm.hibernate;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import th.co.imake.syndome.bpm.managers.PSTCommonService;
@Repository
@Transactional
public class HibernatePSTCommon extends HibernateCommon implements PSTCommonService {
	//private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = RuntimeException.class)
	public int delete(Object persistentInstance) {
		// TODO Auto-generated method stub
		return super.delete(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = RuntimeException.class)
	public int update(Object persistentInstance) {
		// TODO Auto-generated method stub
		return super.update(sessionAnnotationFactory.getCurrentSession(), persistentInstance);
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = RuntimeException.class)
	public Object save( Object transientInstance)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return super.save(sessionAnnotationFactory.getCurrentSession(), transientInstance);
	}
	@Transactional(readOnly = true)
	public Object findById( @SuppressWarnings("rawtypes") Class classType, Serializable id) {
		// TODO Auto-generated method stub
		return super.findById(sessionAnnotationFactory.getCurrentSession(), classType, id);
	}
	@SuppressWarnings("rawtypes")
	@Transactional(readOnly = true)
	public List listObject(String queryStr) {
		// TODO Auto-generated method stub
		Session session =sessionAnnotationFactory.getCurrentSession(); 
		Query query =session.createQuery(queryStr);
		  return query.list();
	}
	
}
