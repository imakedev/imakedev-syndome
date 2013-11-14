package th.co.aoe.imake.pst.hibernate;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import th.co.aoe.imake.pst.constant.ServiceConstant;
import th.co.aoe.imake.pst.hibernate.bean.PstJob;
import th.co.aoe.imake.pst.managers.PstJobService;
import th.co.aoe.imake.pst.xstream.common.Pagging;

@Repository
@Transactional
public class HibernatePstJob extends HibernateCommon implements PstJobService {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private static SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
	private SessionFactory sessionAnnotationFactory;
	private static ResourceBundle bundle;
	private static String schema="";
	static{
		bundle =  ResourceBundle.getBundle( "jdbc" );	
		schema=bundle.getString("schema");
	}
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	private int getSize(Session session,String prpNo,String date, PstJob instance) throws Exception{
		try {
			
			String pjJobNo=instance.getPjJobNo();
			//Date pjCreatedTime=instance.getPjCreatedTime();
			String pjCustomerNo=instance.getPjCustomerNo();
			String pjCustomerName=instance.getPjCustomerName();
			String pjCustomerDepartment=instance.getPjCustomerDepartment();
			Long pconcreteId=(instance.getPstConcrete()!=null && instance.getPstConcrete().getPconcreteId()!=null &&
					instance.getPstConcrete().getPconcreteId().intValue()!=-1 && instance.getPstConcrete().getPconcreteId().intValue()!=0)?instance.getPstConcrete().getPconcreteId(): null;
			//instance.get
			
			
			Query query=null;
			
			//StringBuffer sb =new StringBuffer(" select count(pstJob) from PstJob pstJob ");
			StringBuffer sb =new StringBuffer(" select count(*)  from "+ServiceConstant.SCHEMA+".PST_JOB pstJob left join  "+ServiceConstant.SCHEMA+".PST_CONCRETE concrete on " +
			" pstJob.PCONCRETE_ID=concrete.PCONCRETE_ID " +
	" left join  "+ServiceConstant.SCHEMA+".PST_CUSTOMER customer on pstJob.PC_ID=customer.PC_ID"+
	" left join  "+ServiceConstant.SCHEMA+".PST_CUSTOMER_DIVISION division on pstJob.PCD_ID=division.PCD_ID"+
	" left join  "+ServiceConstant.SCHEMA+".PST_CUSTOMER_CONTACT contact on pstJob.PCC_ID=contact.PCC_ID" +
	" left join  "+ServiceConstant.SCHEMA+".PST_ROAD_PUMP r_pump on pstJob.PRP_ID=r_pump.PRP_ID" );
			
			
			boolean iscriteria = false;
			
			if(pjJobNo !=null && pjJobNo.trim().length()> 0){  
				//criteria.add(Expression.eq("megId", megId));	
				
				//sb.append(iscriteria?(" and lcase(pstJob.pjJobNo) like '%"+pjJobNo.trim().toLowerCase()+"%'"):(" where lcase(pstJob.pjJobNo) like '%"+pjJobNo.trim().toLowerCase()+"%'"));
				sb.append(iscriteria?(" and lower(pstJob.PJ_JOB_NO) like '%"+pjJobNo.trim().toLowerCase()+"%'"):(" where lower(pstJob.PJ_JOB_NO) like '%"+pjJobNo.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			if(pjCustomerNo !=null && pjCustomerNo.trim().length() > 0){  
				//criteria.add(Expression.eq("megId", megId));	
				
				//sb.append(iscriteria?(" and lcase(pstJob.pjCustomerNo) like '%"+pjCustomerNo.trim().toLowerCase()+"%'"):(" where lcase(pstJob.pjCustomerNo) like '%"+pjCustomerNo.trim().toLowerCase()+"%'"));
				sb.append(iscriteria?(" and lower(customer.PC_NO) like '%"+pjCustomerNo.trim().toLowerCase()+"%'"):(" where lower(customer.PC_NO) like '%"+pjCustomerNo.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			if(pjCustomerName !=null && pjCustomerName.trim().length() > 0){  
				//criteria.add(Expression.eq("megId", megId));	
				
				//sb.append(iscriteria?(" and lcase(pstJob.pjCustomerName) like '%"+pjCustomerName.trim().toLowerCase()+"%'"):(" where lcase(pstJob.pjCustomerName) like '%"+pjCustomerNo.trim().toLowerCase()+"%'"));
				sb.append(iscriteria?(" and lower(customer.PC_NAME) like '%"+pjCustomerName.trim().toLowerCase()+"%'"):(" where lower(customer.PC_NAME) like '%"+pjCustomerName.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			if(pjCustomerDepartment !=null && pjCustomerDepartment.trim().length() > 0){  
				//criteria.add(Expression.eq("megId", megId));	
				
				//sb.append(iscriteria?(" and lcase(pstJob.pjCustomerDepartment) like '%"+pjCustomerDepartment.trim().toLowerCase()+"%'"):(" where lcase(pstJob.pjCustomerDepartment) like '%"+pjCustomerNo.trim().toLowerCase()+"%'"));
				sb.append(iscriteria?(" and lower(division.PCD_NAME) like '%"+pjCustomerDepartment.trim().toLowerCase()+"%'"):(" where lower(division.PCD_NAME) like '%"+pjCustomerDepartment.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			if(pconcreteId !=null){  
				//criteria.add(Expression.eq("megId", megId));	
				
				//sb.append(iscriteria?(" and pstJob.pstConcrete.pconcreteId="+pconcreteId+""):(" where pstJob.pstConcrete.pconcreteId="+pconcreteId+""));
				sb.append(iscriteria?(" and pstJob.PCONCRETE_ID="+pconcreteId+""):(" where pstJob.PCONCRETE_ID="+pconcreteId+""));
				  iscriteria = true;
			}
			if(date!=null){  
				//criteria.add(Expression.eq("megId", megId));
				
				sb.append(iscriteria?(" and pstJob.PJ_CREATED_TIME  between '"+date+" 00:00:00' and '"+date+" 23:59:59'"):(" where pstJob.PJ_CREATED_TIME  between '"+date+" 00:00:00' and '"+date+" 23:59:59'"));
				  iscriteria = true;
			}
			//System.out.println("prpNo-->"+prpNo);
			if(prpNo!=null && prpNo.length()>0){  
				sb.append(iscriteria?(" and r_pump.PRP_NO='"+prpNo+"'"):(" where r_pump.PRP_NO='"+prpNo+"'"));
				  iscriteria = true;
			/*sb.append(iscriteria?(" and pstJob.pjId  in ( select  pstJobWork.id.pjId from PstJobWork as pstJobWork " +
					" ,  PstRoadPump as pstRoadPump where pstJobWork.id.prpId=pstRoadPump.prpId and " +
					" pstJobWork.id.pjId=pstJob.pjId and lcase(pstRoadPump.prpNo) like '%"+prpNo.trim().toLowerCase()+"%') "):
						(" where pstJob.pjId  in ( select  pstJobWork.id.pjId from PstJobWork as pstJobWork " +
					" ,  PstRoadPump as pstRoadPump where pstJobWork.id.prpId=pstRoadPump.prpId and " +
					" pstJobWork.id.pjId=pstJob.pjId and lcase(pstRoadPump.prpNo) like '%"+prpNo.trim().toLowerCase()+"%') "));*/
			}
			  query =session.createSQLQuery(sb.toString());
			 
				 return ((java.math.BigInteger)query.uniqueResult()).intValue(); 
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
	 public List searchPstJob(PstJob instance,String prpNo,Pagging pagging) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			Session session = sessionAnnotationFactory.getCurrentSession();
			try {
				String pjJobNo=instance.getPjJobNo();
				Date pjCreatedTime=instance.getPjCreatedTime();
				String pjCustomerNo=instance.getPjCustomerNo();
				String pjCustomerName=instance.getPjCustomerName();
				String pjCustomerDepartment=instance.getPjCustomerDepartment();
				Long pconcreteId=(instance.getPstConcrete()!=null && instance.getPstConcrete().getPconcreteId()!=null &&
						instance.getPstConcrete().getPconcreteId().intValue()!=-1 && instance.getPstConcrete().getPconcreteId().intValue()!=0)?instance.getPstConcrete().getPconcreteId(): null;
				//instance.get
				 
				//System.out.println("pjCustomerName->"+pjCustomerName);
				Query query = null;
			/*
			 * SELECT * FROM PST_DB.PST_JOB job where 
job.pj_id in( select job_work.pj_id from PST_DB.PST_JOB_WORK job_work left join 
 PST_DB.PST_ROAD_PUMP road_pump on job_work.prp_id=road_pump.prp_id 
where job_work.pj_id=job.pj_id and road_pump.prp_no='HP0')

			 */
				/*select 
				(select sum(jwork.PJW_CUBIC_AMOUNT) FROM PST_DB2.PST_JOB_WORK jwork 
				where jwork.PJ_ID=job.PJ_ID ) as amount , 
				(select sum(jpay.PJP_AMOUNT) FROM PST_DB2.PST_JOB_PAY jpay 
				where jpay.PJ_ID=job.PJ_ID ) as jpay_amount , 
				(select sum(jpay2.PJP_AMOUNT*costs.PC_AMOUNT) FROM PST_DB2.PST_JOB_PAY jpay2 inner join  PST_DB2.PST_COSTS costs
				on jpay2.PC_ID=costs.PC_ID 
				where jpay2.PJ_ID=job.PJ_ID ) as jpay_amount2 , 
				(select sum(jpay_ext.PJPE_AMOUNT) FROM PST_DB2.PST_JOB_PAY_EXT jpay_ext
				where jpay_ext.PJ_ID=job.PJ_ID ) as jpay_amount_ext , 
				 
				job.*
				 from PST_JOB job*/
				//StringBuffer sb =new StringBuffer(" select pstJob from PstJob pstJob ");				
				StringBuffer sb= new StringBuffer("select " +
						" (select sum(jwork.PJW_CUBIC_AMOUNT) FROM "+ServiceConstant.SCHEMA+".PST_JOB_WORK jwork " +
						" where jwork.PJ_ID=pstJob.PJ_ID ) as CUBIC_AMOUNT ,	" +
						/*" (select sum(jpay.PJP_AMOUNT) FROM "+ServiceConstant.SCHEMA+".PST_JOB_PAY jpay" +
						" where jpay.PJ_ID=pstJob.PJ_ID ) as PAY_AMOUNT ," +*/
						" (select sum(jpay2.PJP_AMOUNT*costs.PC_AMOUNT) " +
						" FROM "+ServiceConstant.SCHEMA+".PST_JOB_PAY jpay2 inner join  "+ServiceConstant.SCHEMA+".PST_COSTS costs on jpay2.PC_ID=costs.PC_ID" +						
						" where jpay2.PJ_ID=pstJob.PJ_ID ) as PAY_AMOUNT , " +
						" (select sum(jpay_ext.PJPE_AMOUNT)" +
						"  FROM "+ServiceConstant.SCHEMA+".PST_JOB_PAY_EXT jpay_ext where jpay_ext.PJ_ID=pstJob.PJ_ID ) as PAY_EXT_AMOUNT " +
						 
						", pstJob.PJ_ID " +
						", pstJob.PJ_CONTRACT_MOBILE_NO " +
						", pstJob.PJ_CONTRACT_NAME " +
						", pstJob.PJ_CREATED_TIME " +
						/*", pstJob.PJ_CUSTOMER_DEPARTMENT " +
						", pstJob.PJ_CUSTOMER_NAME " +
						", pstJob.PJ_CUSTOMER_NO " +*/
						", division.PCD_NAME " +
						", customer.PC_NAME " +
						", customer.PC_NO " + 
						", pstJob.PJ_JOB_NO " +
						", pstJob.PJ_REMARK " +
						", pstJob.PJ_UPDATED_TIME " +
						", pstJob.PJ_CUBIC_AMOUNT " +
						", pstJob.PCONCRETE_ID " +
						", concrete.PCONCRETE_NAME  " +
						", pstJob.PJ_FEEDBACK_SCORE " + 
						" from "+ServiceConstant.SCHEMA+".PST_JOB pstJob left join  "+ServiceConstant.SCHEMA+".PST_CONCRETE concrete on " +
								" pstJob.PCONCRETE_ID=concrete.PCONCRETE_ID " +
						" left join  "+ServiceConstant.SCHEMA+".PST_CUSTOMER customer on pstJob.PC_ID=customer.PC_ID"+
						" left join  "+ServiceConstant.SCHEMA+".PST_CUSTOMER_DIVISION division on pstJob.PCD_ID=division.PCD_ID"+
						" left join  "+ServiceConstant.SCHEMA+".PST_CUSTOMER_CONTACT contact on pstJob.PCC_ID=contact.PCC_ID" +
						" left join  "+ServiceConstant.SCHEMA+".PST_ROAD_PUMP r_pump on pstJob.PRP_ID=r_pump.PRP_ID" );
				
				boolean iscriteria = false;
				String date=null;
				if(pjCreatedTime!=null)
				date=format1.format(pjCreatedTime);
 
				if(pjJobNo !=null && pjJobNo.trim().length()> 0){  
					//criteria.add(Expression.eq("megId", megId));	
					
					//sb.append(iscriteria?(" and lcase(pstJob.pjJobNo) like '%"+pjJobNo.trim().toLowerCase()+"%'"):(" where lcase(pstJob.pjJobNo) like '%"+pjJobNo.trim().toLowerCase()+"%'"));
					sb.append(iscriteria?(" and lower(pstJob.PJ_JOB_NO) like '%"+pjJobNo.trim().toLowerCase()+"%'"):(" where lower(pstJob.PJ_JOB_NO) like '%"+pjJobNo.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(pjCustomerNo !=null && pjCustomerNo.trim().length() > 0){  
					//criteria.add(Expression.eq("megId", megId));	
					
					//sb.append(iscriteria?(" and lcase(pstJob.pjCustomerNo) like '%"+pjCustomerNo.trim().toLowerCase()+"%'"):(" where lcase(pstJob.pjCustomerNo) like '%"+pjCustomerNo.trim().toLowerCase()+"%'"));
					sb.append(iscriteria?(" and lower(customer.PC_NO) like '%"+pjCustomerNo.trim().toLowerCase()+"%'"):(" where lower(customer.PC_NO) like '%"+pjCustomerNo.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(pjCustomerName !=null && pjCustomerName.trim().length() > 0){  
					//criteria.add(Expression.eq("megId", megId));	
					
					//sb.append(iscriteria?(" and lcase(pstJob.pjCustomerName) like '%"+pjCustomerName.trim().toLowerCase()+"%'"):(" where lcase(pstJob.pjCustomerName) like '%"+pjCustomerNo.trim().toLowerCase()+"%'"));
					sb.append(iscriteria?(" and lower(customer.PC_NAME) like '%"+pjCustomerName.trim().toLowerCase()+"%'"):(" where lower(customer.PC_NAME) like '%"+pjCustomerName.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(pjCustomerDepartment !=null && pjCustomerDepartment.trim().length() > 0){  
					//criteria.add(Expression.eq("megId", megId));	
					
					//sb.append(iscriteria?(" and lcase(pstJob.pjCustomerDepartment) like '%"+pjCustomerDepartment.trim().toLowerCase()+"%'"):(" where lcase(pstJob.pjCustomerDepartment) like '%"+pjCustomerNo.trim().toLowerCase()+"%'"));
					sb.append(iscriteria?(" and lower(division.PCD_NAME) like '%"+pjCustomerDepartment.trim().toLowerCase()+"%'"):(" where lower(division.PCD_NAME) like '%"+pjCustomerDepartment.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(pconcreteId !=null){  
					//criteria.add(Expression.eq("megId", megId));	
					
					//sb.append(iscriteria?(" and pstJob.pstConcrete.pconcreteId="+pconcreteId+""):(" where pstJob.pstConcrete.pconcreteId="+pconcreteId+""));
					sb.append(iscriteria?(" and pstJob.PCONCRETE_ID="+pconcreteId+""):(" where pstJob.PCONCRETE_ID="+pconcreteId+""));
					  iscriteria = true;
				}
				if(date!=null){  
					//criteria.add(Expression.eq("megId", megId));
					
					sb.append(iscriteria?(" and pstJob.PJ_CREATED_TIME  between '"+date+" 00:00:00' and '"+date+" 23:59:59'"):(" where pstJob.PJ_CREATED_TIME  between '"+date+" 00:00:00' and '"+date+" 23:59:59'"));
					  iscriteria = true;
				}
				//System.out.println("prpNo-->"+prpNo);
				if(prpNo!=null && prpNo.length()>0){  
					sb.append(iscriteria?(" and r_pump.PRP_NO='"+prpNo+"'"):(" where r_pump.PRP_NO='"+prpNo+"'"));
					  iscriteria = true;
					/*sb.append(iscriteria?(" and pstJob.PJ_ID  in ( select  pstJobWork.PJ_ID from "+ServiceConstant.SCHEMA+".PST_JOB_WORK  pstJobWork " +
							" left join  "+ServiceConstant.SCHEMA+".PST_ROAD_PUMP  pstRoadPump on pstJobWork.PRP_ID=pstRoadPump.PRP_ID where " +
							" pstJobWork.PJ_ID=pstJob.PJ_ID and lower(pstRoadPump.PRP_NO) like '%"+prpNo.trim().toLowerCase()+"%') "):
								(" where pstJob.PJ_ID  in ( select  pstJobWork.PJ_ID from "+ServiceConstant.SCHEMA+".PST_JOB_WORK  pstJobWork " +
							" left join  "+ServiceConstant.SCHEMA+".PST_ROAD_PUMP  pstRoadPump on pstJobWork.PRP_ID=pstRoadPump.PRP_ID where " +
							" pstJobWork.PJ_ID=pstJob.PJ_ID and lower(pstRoadPump.PRP_NO) like '%"+prpNo.trim().toLowerCase()+"%') "));
					*/
					 
					//  iscriteria = true;
				}
				
				if(pagging.getSortBy()!=null && pagging.getSortBy().length()>0){
						sb.append( " order by pstJob."+pagging.getOrderBy()+" "+pagging.getSortBy().toLowerCase());
				}else{
					 
					//sb.append( " order by pstJob.pjCreatedTime desc , pstJob.pjJobNo asc");
					//sb.append( " order by pstJob.PJ_CREATED_TIME desc , pstJob.PJ_JOB_NO asc");
					sb.append( " order by   pstJob.PJ_JOB_NO desc");
				}
				 
				 //query =session.createsQuery(sb.toString());
				query =session.createSQLQuery(sb.toString());
				 
				// set pagging.
				 String size = String.valueOf(getSize(session,prpNo, date,instance)); 
				 logger.debug(" first Result="+(pagging.getPageSize()* (pagging.getPageNo() - 1))); 
				 
				 query.setFirstResult(pagging.getPageSize() * (pagging.getPageNo() - 1));
				 query.setMaxResults(pagging.getPageSize());
				 
				 List<java.lang.Object[]> l = query.list();   
				 //System.out.println("size-->"+l.size());
				 List<th.co.aoe.imake.pst.xstream.PstJob> xpstjobs = new ArrayList<th.co.aoe.imake.pst.xstream.PstJob>(l.size());
					 
				 for (Object[] objects : l) {
					 th.co.aoe.imake.pst.xstream.PstJob pstJob=new th.co.aoe.imake.pst.xstream.PstJob();
					 java.math.BigDecimal b1=objects[0]!=null?(java.math.BigDecimal)objects[0]:BigDecimal.valueOf(0);
					 java.math.BigDecimal b2=objects[1]!=null?(java.math.BigDecimal)objects[1]:BigDecimal.valueOf(0);
					 java.math.BigDecimal b3=objects[2]!=null?(java.math.BigDecimal)objects[2]:BigDecimal.valueOf(0);
					 pstJob.setCubicAmount(b1+"");
					 pstJob.setPayAmount(b2+"");
					 pstJob.setPayExtAmount(b3+"");
					 pstJob.setPayAll(BigDecimal.valueOf(b2.doubleValue()+b3.doubleValue())+"");
					
						/*", pstJob.PJ_ID " + 3
						", pstJob.PJ_CONTRACT_MOBILE_NO " + 4
						", pstJob.PJ_CONTRACT_NAME " + 5
						", pstJob.PJ_CREATED_TIME " + 6
						", pstJob.PJ_CUSTOMER_DEPARTMENT " + 7
						", pstJob.PJ_CUSTOMER_NAME " + 8
						", pstJob.PJ_CUSTOMER_NO " + 9
						", pstJob.PJ_JOB_NO " + 10
						", pstJob.PJ_REMARK " + 11
						", pstJob.PJ_UPDATED_TIME " + 12
						", pstJob.PJ_CUBIC_AMOUNT " + 13
						", pstJob.PCONCRETE_ID " + 14
						", concrete.PCONCRETE_NAME " + 15 */ 
						pstJob.setPjId(objects[3]!=null?Long.valueOf((Integer)objects[3]):null);
						pstJob.setPjContractMobileNo(objects[4]!=null?(String)objects[4]:null);
						pstJob.setPjContractName(objects[5]!=null?(String)objects[5]:null);
						pstJob.setPjCreatedTime(objects[6]!=null?(java.util.Date)objects[6]:null);
						pstJob.setPjCustomerDepartment(objects[7]!=null?(String)objects[7]:null);
						pstJob.setPjCustomerName(objects[8]!=null?(String)objects[8]:null);
						pstJob.setPjCustomerNo(objects[9]!=null?(String)objects[9]:null);
						pstJob.setPjJobNo(objects[10]!=null?(String)objects[10]:null);
						pstJob.setPjRemark(objects[11]!=null?(String)objects[11]:null);
						pstJob.setPjUpdatedTime(objects[12]!=null?(java.util.Date)objects[12]:null);
						pstJob.setPjCubicAmount(objects[13]!=null?(java.math.BigDecimal)objects[13]:null);
						
						 th.co.aoe.imake.pst.xstream.PstConcrete pstConcrete=new th.co.aoe.imake.pst.xstream.PstConcrete();
						pstConcrete.setPconcreteId(objects[14]!=null?Long.valueOf((Integer)objects[14]):null);
						pstConcrete.setPconcreteName(objects[15]!=null?(String)objects[15]:null);
						
						pstJob.setPjFeedBackScore(objects[16]!=null?(java.math.BigDecimal)objects[16]:null);
						pstJob.setPstConcrete(pstConcrete);
						xpstjobs.add(pstJob);
					 //System.out.println(pstJob.getCubicAmount());
					// pstJob.setPayAll(b1+b2);
					// System.out.println(objects[0].getClass());
				}
				 
				// java.util.ArrayList<th.co.aoe.imake.pst.hibernate.bean.PstJob>
				// System.out.println(l);
				 transList.add(xpstjobs);				 
			 	 transList.add(size); 
				return transList;
			} catch (Exception re) {
				//re.printStackTrace();
				logger.error("find by property name failed", re);
				 
			}
			return transList;
		}

}
