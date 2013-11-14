package th.co.aoe.imake.pst.hibernate;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.managers.PstJobWorkService;

@Repository
@Transactional
public class HibernatePstJobWork extends HibernateCommon implements PstJobWorkService {

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
	public List listPstJobWorks(Long pjId, Long prpId) {
		// TODO Auto-generated method stub
		Session session = sessionAnnotationFactory.getCurrentSession();
		try {
			Query query = null;
			StringBuffer sb =new StringBuffer(" select pstJobWork from PstJobWork pstJobWork ");
		boolean iscriteria = false;
		if(pjId!=null && pjId.intValue()!=0){
			sb.append(iscriteria?(" and pstJobWork.id.pjId="+pjId.intValue()+""):(" where pstJobWork.id.pjId="+pjId.intValue()+""));
			iscriteria=true;
		}
		if(prpId!=null && prpId.intValue()!=0){
			sb.append(iscriteria?(" and pstJobWork.id..prpId="+prpId.intValue()+""):(" where pstJobWork.id.prpId="+prpId.intValue()+""));
			iscriteria=true;
		} query =session.createQuery(sb.toString());
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
