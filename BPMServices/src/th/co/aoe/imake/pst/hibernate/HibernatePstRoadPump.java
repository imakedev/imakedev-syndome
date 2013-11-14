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
import th.co.aoe.imake.pst.hibernate.bean.PstRoadPump;
import th.co.aoe.imake.pst.managers.PstRoadPumpService;
import th.co.aoe.imake.pst.xstream.common.Pagging;
@Repository
@Transactional
public class HibernatePstRoadPump  extends HibernateCommon implements PstRoadPumpService {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	private int getSize(Session session, PstRoadPump instance) throws Exception{
		try {
			String prpNo=instance.getPrpNo();
			String prpRegister=instance.getPrpRegister();
			th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpStatus pstRoadPumpStatus=instance.getPstRoadPumpStatus();
			Long prpsId=null;
			if(pstRoadPumpStatus!=null)
				prpsId=pstRoadPumpStatus.getPrpsId();
			Query query=null;
			
			StringBuffer sb =new StringBuffer(" select count(pstRoadPump) from PstRoadPump pstRoadPump ");
			
			boolean iscriteria = false;
			if(prpsId !=null && prpsId.intValue()!= 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and pstRoadPump.pstRoadPumpStatus.prpsId="+prpsId+" "):(" where pstRoadPump.pstRoadPumpStatus.prpsId="+prpsId+" "));
				  iscriteria = true;
			}
			if(prpNo !=null && prpNo.trim().length()> 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and lcase(pstRoadPump.prpNo) like '%"+prpNo.trim().toLowerCase()+"%'"):(" where lcase(pstRoadPump.prpNo) like '%"+prpNo.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			if(prpRegister !=null && prpRegister.trim().length() > 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and lcase(pstRoadPump.prpRegister) like '%"+prpRegister.trim().toLowerCase()+"%'"):(" where lcase(pstRoadPump.prpRegister) like '%"+prpRegister.trim().toLowerCase()+"%'"));
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
	 public List searchPstRoadPump(PstRoadPump instance,Pagging pagging) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			Session session = sessionAnnotationFactory.getCurrentSession();
			try {
				String prpNo=instance.getPrpNo();
				String prpRegister=instance.getPrpRegister();
				th.co.aoe.imake.pst.hibernate.bean.PstRoadPumpStatus pstRoadPumpStatus=instance.getPstRoadPumpStatus();
				Long prpsId=null;
				if(pstRoadPumpStatus!=null)
					prpsId=pstRoadPumpStatus.getPrpsId();
				Query query = null;
			
				StringBuffer sb =new StringBuffer(" select pstRoadPump from PstRoadPump pstRoadPump ");
				
				boolean iscriteria = false;
				if(prpsId !=null && prpsId.intValue()!= 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and pstRoadPump.pstRoadPumpStatus.prpsId="+prpsId+" "):(" where pstRoadPump.pstRoadPumpStatus.prpsId="+prpsId+" "));
					  iscriteria = true;
				}
				if(prpNo !=null && prpNo.trim().length()> 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstRoadPump.prpNo) like '%"+prpNo.trim().toLowerCase()+"%'"):(" where lcase(pstRoadPump.prpNo) like '%"+prpNo.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(prpRegister !=null && prpRegister.trim().length() > 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstRoadPump.prpRegister) like '%"+prpRegister.trim().toLowerCase()+"%'"):(" where lcase(pstRoadPump.prpRegister) like '%"+prpRegister.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(pagging.getSortBy()!=null && pagging.getSortBy().length()>0){
						sb.append( " order by pstRoadPump."+pagging.getOrderBy()+" "+pagging.getSortBy().toLowerCase());
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
	public List listPstRoadPumpNo() {
		// TODO Auto-generated method stub
		Session session = sessionAnnotationFactory.getCurrentSession();
		try {
			Query query = null;
			StringBuffer sb =new StringBuffer(" select pstRoadPump from PstRoadPump pstRoadPump order by pstRoadPump.prpNo asc ");
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
