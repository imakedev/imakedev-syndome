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
import th.co.aoe.imake.pst.hibernate.bean.PstEmployee;
import th.co.aoe.imake.pst.managers.PstEmployeeService;
import th.co.aoe.imake.pst.xstream.common.Pagging;
@Repository
@Transactional
public class HibernatePstEmployee  extends HibernateCommon implements PstEmployeeService {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	private int getSize(Session session, PstEmployee instance) throws Exception{
		try {
			String peUid=instance.getPeUid();
			String peFirstName=instance.getPeFirstName();
			String peLastName=instance.getPeLastName();
			Long ppId=(instance.getPstPosition()!=null && instance.getPstPosition().getPpId()!=null && 
					instance.getPstPosition().getPpId().intValue()!=-1)?instance.getPstPosition().getPpId():null;
			Query query=null;
			
			StringBuffer sb =new StringBuffer(" select count(pstEmployee) from PstEmployee pstEmployee ");
			boolean iscriteria = false;

			if(ppId !=null){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and pstEmployee.pstPosition.ppId="+ppId.intValue()+""):(" where pstEmployee.pstPosition.ppId="+ppId.intValue()+""));
				  iscriteria = true;
			}
			if(peUid !=null && peUid.trim().length()> 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and lcase(pstEmployee.peUid) like '%"+peUid.trim().toLowerCase()+"%'"):(" where lcase(pstEmployee.peUid) like '%"+peUid.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			if(peFirstName !=null && peFirstName.trim().length() > 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and lcase(pstEmployee.peFirstName) like '%"+peFirstName.trim().toLowerCase()+"%'"):(" where lcase(pstEmployee.peFirstName) like '%"+peFirstName.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			if(peLastName !=null && peLastName.trim().length() > 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and lcase(pstEmployee.peLastName) like '%"+peLastName.trim().toLowerCase()+"%'"):(" where lcase(pstEmployee.peLastName) like '%"+peLastName.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			
			
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
	 public List searchPstEmployee(PstEmployee instance,Pagging pagging) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			Session session = sessionAnnotationFactory.getCurrentSession();
			try {
				String peUid=instance.getPeUid();
				String peFirstName=instance.getPeFirstName();
				String peLastName=instance.getPeLastName();
				Long ppId=(instance.getPstPosition()!=null && instance.getPstPosition().getPpId()!=null && 
						instance.getPstPosition().getPpId().intValue()!=-1)?instance.getPstPosition().getPpId():null;
				Query query = null;
			
				StringBuffer sb =new StringBuffer(" select pstEmployee from PstEmployee pstEmployee ");
				
				boolean iscriteria = false;

				if(ppId !=null){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and pstEmployee.pstPosition.ppId="+ppId.intValue()+""):(" where pstEmployee.pstPosition.ppId="+ppId.intValue()+""));
					  iscriteria = true;
				}
				if(peUid !=null && peUid.trim().length()> 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstEmployee.peUid) like '%"+peUid.trim().toLowerCase()+"%'"):(" where lcase(pstEmployee.peUid) like '%"+peUid.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(peFirstName !=null && peFirstName.trim().length() > 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstEmployee.peFirstName) like '%"+peFirstName.trim().toLowerCase()+"%'"):(" where lcase(pstEmployee.peFirstName) like '%"+peFirstName.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(peLastName !=null && peLastName.trim().length() > 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstEmployee.peLastName) like '%"+peLastName.trim().toLowerCase()+"%'"):(" where lcase(pstEmployee.peLastName) like '%"+peLastName.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(pagging.getSortBy()!=null && pagging.getSortBy().length()>0){
						sb.append( " order by pstEmployee."+pagging.getOrderBy()+" "+pagging.getSortBy().toLowerCase());
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

	
}
