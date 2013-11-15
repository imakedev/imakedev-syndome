package th.co.imake.syndome.bpm.hibernate;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.managers.PstJobPayExtService;

@Repository
@Transactional
public class HibernatePstJobPayExt  extends HibernateCommon implements PstJobPayExtService {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List listPstJobPayExts(Long pjId, Long pjpeNo) {
		// TODO Auto-generated method stub
		Session session = sessionAnnotationFactory.getCurrentSession();
		try {
			Query query = null;
			StringBuffer sb =new StringBuffer(" select pstJobPayExt from PstJobPayExt pstJobPayExt ");
		boolean iscriteria = false;
		if(pjId!=null && pjId.intValue()!=0){
			sb.append(iscriteria?(" and pstJobPayExt.id.pjId="+pjId.intValue()+""):(" where pstJobPayExt.id.pjId="+pjId.intValue()+""));
			iscriteria=true;
		}
		if(pjpeNo!=null && pjpeNo.intValue()!=0){
			sb.append(iscriteria?(" and pstJobPayExt.id.pjpeNo="+pjpeNo.intValue()+""):(" where pstJobPayExt.id.pjpeNo="+pjpeNo.intValue()+""));
			iscriteria=true;
		} query =session.createQuery(sb.toString());
		// set pagging.
		 
		 List l = query.list();   
		// System.out.println(l);
		return l;
	} catch (Exception re) {
		//re.printStackTrace();
		logger.error("find by property name failed", re);
		 
	}
	return null;
	
	}
	@Override
	public Long getNextPjpeNo(Long pjId) {
		// TODO Auto-generated method stub
		Session session = sessionAnnotationFactory.getCurrentSession();		
		Query query =session.createQuery( "select max(pstJobPayExt.id.pjpeNo)   from PstJobPayExt pstJobPayExt where pstJobPayExt.id.pjId="+pjId);
		Object obj=query.uniqueResult();
		if(obj!=null){
			return ((Long)obj)+1;
		}
		return 1l;
	}

}
