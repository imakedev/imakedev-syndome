package th.co.imake.syndome.bpm.hibernate;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.managers.PstJobPayService;

@Repository
@Transactional
public class HibernatePstJobPay  extends HibernateCommon implements PstJobPayService {

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
	public List listPstJobPays(Long pjId, Long pcId) {
		// TODO Auto-generated method stub
		Session session = sessionAnnotationFactory.getCurrentSession();
		try {
			Query query = null;
			StringBuffer sb =new StringBuffer(" select pstJobPay from PstJobPay pstJobPay ");
		boolean iscriteria = false;
		if(pjId!=null && pjId.intValue()!=0){
			sb.append(iscriteria?(" and pstJobPay.id.pjId="+pjId.intValue()+""):(" where pstJobPay.id.pjId="+pjId.intValue()+""));
			iscriteria=true;
		}
		if(pcId!=null && pcId.intValue()!=0){
			sb.append(iscriteria?(" and pstJobPay.id.pcId="+pcId.intValue()+""):(" where pstJobPay.id.pcId="+pcId.intValue()+""));
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
