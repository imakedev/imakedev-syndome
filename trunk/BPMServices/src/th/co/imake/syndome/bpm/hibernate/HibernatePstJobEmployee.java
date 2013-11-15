package th.co.imake.syndome.bpm.hibernate;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.managers.PstJobEmployeeService;

@Repository
@Transactional
public class HibernatePstJobEmployee  extends HibernateCommon implements PstJobEmployeeService {

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
	public List listPstJobEmployees(Long pjId, Long peId,Long prpId){
		// TODO Auto-generated method stub
		Session session = sessionAnnotationFactory.getCurrentSession();
		try {
			Query query = null;
			StringBuffer sb =new StringBuffer(" select pstJobEmployee from PstJobEmployee pstJobEmployee ");
			boolean iscriteria = false;
			if(pjId!=null && pjId.intValue()!=0){
				sb.append(iscriteria?(" and pstJobEmployee.id.pjId="+pjId.intValue()+""):(" where pstJobEmployee.id.pjId="+pjId.intValue()+""));
				iscriteria=true;
			}
			if(peId!=null && peId.intValue()!=0){
				sb.append(iscriteria?(" and pstJobEmployee.id.peId="+peId.intValue()+""):(" where pstJobEmployee.id.peId="+peId.intValue()+""));
				iscriteria=true;
			}
			if(prpId!=null && prpId.intValue()!=0){
				sb.append(iscriteria?(" and pstJobEmployee.id.prpId="+prpId.intValue()+""):(" where pstJobEmployee.id.prpId="+prpId.intValue()+""));
				iscriteria=true;
			}
			
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
/*boolean iscriteria = false;

if(pcUid !=null && pcUid.trim().length()> 0){  
	//criteria.add(Expression.eq("megId", megId));	
	sb.append(iscriteria?(" and lcase(pstEmployeeStatus.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"):(" where lcase(pstEmployeeStatus.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"));
	  iscriteria = true;
}
if(pcName !=null && pcName.trim().length() > 0){  
	//criteria.add(Expression.eq("megId", megId));	
	sb.append(iscriteria?(" and lcase(pstEmployeeStatus.pcName) like '%"+pcName.trim().toLowerCase()+"%'"):(" where lcase(pstEmployeeStatus.pcName) like '%"+pcName.trim().toLowerCase()+"%'"));
	  iscriteria = true;
}*/
