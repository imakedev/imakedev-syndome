package th.co.imake.syndome.bpm.hibernate;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.joda.time.DateTime;
import org.springframework.beans.BeanUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import th.co.imake.syndome.bpm.constant.ServiceConstant;
import th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping;
import th.co.imake.syndome.bpm.managers.PstEmployeeWorkMappingService;
import th.co.imake.syndome.bpm.xstream.common.Pagging;
@Repository
@Transactional
public class HibernatePstEmployeeWorkMapping  extends HibernateCommon implements PstEmployeeWorkMappingService {

	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private SessionFactory sessionAnnotationFactory;
	private static String[] emp_ignore={"pstPosition","pstTitle","pstRoadPump"}; 
	private static SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	private int getSize(Session session, PstEmployeeWorkMapping instance,boolean setPrpNo,String date) throws Exception{
		try {
			/*String pcUid=instance.getPcUid();
			String pcName=instance.getPcName();*/
			
			Query query=null;
			StringBuffer sb =new StringBuffer();
			if(setPrpNo)
				sb.append(" select count(pstEmployee) from PstEmployeeWorkMapping as pstEmployeeWorkMapping   right join pstEmployeeWorkMapping.pstEmployee as pstEmployee  where pstEmployeeWorkMapping.prpNo='"+instance.getPrpNo().trim()+"'" +
						" and pstEmployeeWorkMapping.id.pewmDateTime between '"+date+" 00:00:00' and '"+date+" 23:59:59'");
			else
				sb.append(" select count(pstEmployee) from  PstEmployee pstEmployee ");
			
			//StringBuffer sb =new StringBuffer(" select count(pstEmployee) from PstEmployeeWorkMapping as pstEmployeeWorkMapping   right join pstEmployeeWorkMapping.pstEmployee as pstEmployee ");
		//	select pstEmployee,pstEmployeeWorkMapping from  
			//boolean iscriteria = false;
			
		/*	if(pcUid !=null && pcUid.trim().length()> 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and lcase(pstEmployeeWorkMapping.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"):(" where lcase(pstEmployeeWorkMapping.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			if(pcName !=null && pcName.trim().length() > 0){  
				//criteria.add(Expression.eq("megId", megId));	
				sb.append(iscriteria?(" and lcase(pstEmployeeWorkMapping.pcName) like '%"+pcName.trim().toLowerCase()+"%'"):(" where lcase(pstEmployeeWorkMapping.pcName) like '%"+pcName.trim().toLowerCase()+"%'"));
				  iscriteria = true;
			}
			*/
			
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
	 public List searchPstEmployeeWorkMapping(PstEmployeeWorkMapping instance,Pagging pagging) throws DataAccessException {
			ArrayList  transList = new ArrayList ();
			Session session = sessionAnnotationFactory.getCurrentSession();
			try {
				/*String pcUid=instance.getPcUid();
				String pcName=instance.getPcName();*/
				Date pewmDateTime=instance.getId().getPewmDateTime();
				String prpNo=instance.getPrpNo();
				boolean setPrpNo=false;
				if(prpNo!=null && !prpNo.equals("-1")){
					setPrpNo=true;
				}
				
				Query query = null;
				String date=format1.format(pewmDateTime);
				DateTime dt = new DateTime(pewmDateTime.getTime()).dayOfMonth().setCopy(1);
				String date_start=format1.format(dt.toDate());
				dt = dt.dayOfMonth().setCopy(dt.dayOfMonth().getMaximumValue());
				String date_end=format1.format(dt.toDate());
			    dt= dt.dayOfMonth().setCopy(dt.dayOfMonth().getMaximumValue());
				//StringBuffer sb =new StringBuffer(" select pstEmployee,pstEmployeeWorkMapping from PstEmployeeWorkMapping as pstEmployeeWorkMapping   right join pstEmployeeWorkMapping.pstEmployee as pstEmployee ");
				StringBuffer sb =new StringBuffer();
				if(setPrpNo){ 
					sb.append(" select pstEmployee,pstEmployeeWorkMapping " +
							", ( select count(map) from PstEmployeeWorkMapping as map where map.id.pewmDateTime  between '"+date_start+" 00:00:00' and '"+date_end+" 23:59:59' " +
									 " and map.id.peId=pstEmployeeWorkMapping.id.peId and  map.pesId in(1,2) ) as xxxx "+
							" from PstEmployeeWorkMapping as pstEmployeeWorkMapping   right join pstEmployeeWorkMapping.pstEmployee as pstEmployee  where pstEmployeeWorkMapping.prpNo='"+prpNo.trim()+"'" +
							" and pstEmployeeWorkMapping.id.pewmDateTime between '"+date+" 00:00:00' and '"+date+" 23:59:59'");
				}else{
					sb.append(" select pstEmployee " +
							" , ( select count(map) from PstEmployeeWorkMapping as map where map.id.pewmDateTime  between '"+date_start+" 00:00:00' and '"+date_end+" 23:59:59' " +
							 " and map.id.peId=pstEmployee.peId and  map.pesId in(1,2) ) as xxxx "+
							" from  PstEmployee  pstEmployee ");
					   //  " , ( select count(map) from PstEmployeeWorkMapping as map where map.id.pewmDateTime  between '"+date_start+" 00:00:00' and '"+date_end+" 23:59:59' " +
					//	 " and map.id.peId=pstEmployeeWorkMapping.id.peId ) as xxxx "+
				}
				 // sb =new StringBuffer(" select pstEmployeeWorkMapping from PstEmployeeWorkMapping pstEmployeeWorkMapping ");
				
			//	boolean iscriteria = false;
				/*
				if(pcUid !=null && pcUid.trim().length()> 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstEmployeeWorkMapping.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"):(" where lcase(pstEmployeeWorkMapping.pcUid) like '%"+pcUid.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}
				if(pcName !=null && pcName.trim().length() > 0){  
					//criteria.add(Expression.eq("megId", megId));	
					sb.append(iscriteria?(" and lcase(pstEmployeeWorkMapping.pcName) like '%"+pcName.trim().toLowerCase()+"%'"):(" where lcase(pstEmployeeWorkMapping.pcName) like '%"+pcName.trim().toLowerCase()+"%'"));
					  iscriteria = true;
				}*/
				if(pagging.getSortBy()!=null && pagging.getSortBy().length()>0){
						sb.append( " order by "+pagging.getOrderBy()+" "+pagging.getSortBy().toLowerCase());
				}			
				 query =session.createQuery(sb.toString());
				// set pagging.
				 String size = String.valueOf(getSize(session, instance,setPrpNo,date)); 
				 logger.debug(" first Result="+(pagging.getPageSize()* (pagging.getPageNo() - 1))); 
				 
				 query.setFirstResult(pagging.getPageSize() * (pagging.getPageNo() - 1));
				 query.setMaxResults(pagging.getPageSize());
				/* d
					private PstPosition pstPosition;

					//bi-directional many-to-one association to PstTitle
					@ManyToOne
					@JoinColumn(name="PT_ID",nullable=true)
					private PstTitle pstTitle*/;
				// List<th.co.aoe.imake.pst.hibernate.bean.PstEmployee> l = query.list(); 
					 List l = query.list();
				 int sizeReturn=l.size();
				//Ljava.lang.Object;
				List returnList=new ArrayList(sizeReturn);
			if(setPrpNo)
				for (int i = 0; i < sizeReturn; i++) { 
					java.lang.Object[] l1= (java.lang.Object[])l.get(i);
					th.co.imake.syndome.bpm.hibernate.bean.PstEmployee employee=(th.co.imake.syndome.bpm.hibernate.bean.PstEmployee)l1[0];
					
					th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping pstEmployeeWorkMapping=(th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping)l1[1]; 
					
					th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping xmapping=new th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping();
					 th.co.imake.syndome.bpm.xstream.PstEmployee xemployee= new th.co.imake.syndome.bpm.xstream.PstEmployee();
					 
						if(pstEmployeeWorkMapping!=null && pstEmployeeWorkMapping.getId()!=null){
							th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMappingPK pk =pstEmployeeWorkMapping.getId();
							xmapping.setPeId(pk.getPeId());
							xmapping.setPesId(pstEmployeeWorkMapping.getPesId());
							xmapping.setPrpNo(pstEmployeeWorkMapping.getPrpNo());
							xmapping.setPewmDateTime(pk.getPewmDateTime());
							th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus pstEmployeeStatus=pstEmployeeWorkMapping.getPstEmployeeStatus();
							 if(pstEmployeeStatus!=null){
								 th.co.imake.syndome.bpm.xstream.PstEmployeeStatus xpstEmployeeStatus = new th.co.imake.syndome.bpm.xstream.PstEmployeeStatus();
								 BeanUtils.copyProperties(pstEmployeeStatus, xpstEmployeeStatus);
								 xmapping.setPstEmployeeStatus(xpstEmployeeStatus);
							 }
						}
						
					
						 
					 BeanUtils.copyProperties(employee, xemployee,emp_ignore);
					 if(employee.getPstPosition()!=null){
						 th.co.imake.syndome.bpm.xstream.PstPosition xpstPosition= new th.co.imake.syndome.bpm.xstream.PstPosition();
						 BeanUtils.copyProperties(employee.getPstPosition(), xpstPosition);
						 xemployee.setPstPosition(xpstPosition);
					 }
					 if(employee.getPstTitle()!=null){
						 th.co.imake.syndome.bpm.xstream.PstTitle xpstTitle= new th.co.imake.syndome.bpm.xstream.PstTitle();
						 BeanUtils.copyProperties(employee.getPstTitle(),xpstTitle);
						 xemployee.setPstTitle(xpstTitle);
					 }
					 if(employee.getPstRoadPump()!=null){
						 th.co.imake.syndome.bpm.xstream.PstRoadPump xpstRoadPump= new th.co.imake.syndome.bpm.xstream.PstRoadPump();
						 xpstRoadPump.setPrpId(employee.getPstRoadPump().getPrpId());
						 xpstRoadPump.setPrpNo(employee.getPstRoadPump().getPrpNo());
						// BeanUtils.copyProperties(employee.getPstRoadPump(),xpstRoadPump);
						 xemployee.setPstRoadPump(xpstRoadPump);
					 }
					 xmapping.setPstEmployee(xemployee);
					 xmapping.setWeekdayCollection(((java.lang.Long)l1[2]).intValue()+"");
					 returnList.add(xmapping); 
				}
			else
				for (int i = 0; i < sizeReturn; i++) { 
					java.lang.Object[] l1= (java.lang.Object[])l.get(i);
					th.co.imake.syndome.bpm.hibernate.bean.PstEmployee employee=(th.co.imake.syndome.bpm.hibernate.bean.PstEmployee)l1[0];
					//th.co.aoe.imake.pst.hibernate.bean.PstEmployee employee=(th.co.aoe.imake.pst.hibernate.bean.PstEmployee)l1[0];
					//th.co.aoe.imake.pst.hibernate.bean.PstEmployeeWorkMapping pstEmployeeWorkMapping=(th.co.aoe.imake.pst.hibernate.bean.PstEmployeeWorkMapping)l1[1]; 
					
					th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping xmapping=new th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping();
					 th.co.imake.syndome.bpm.xstream.PstEmployee xemployee= new th.co.imake.syndome.bpm.xstream.PstEmployee();
					 sb.setLength(0);
					 sb.append(" select pstEmployeeWorkMapping " +
					      //  " , ( select count(map) from PstEmployeeWorkMapping as map where map.id.pewmDateTime  between '"+date_start+" 00:00:00' and '"+date_end+" 23:59:59' " +
						//	 " and map.id.peId=pstEmployeeWorkMapping.id.peId ) as xxxx "+
					 		"  from PstEmployeeWorkMapping as pstEmployeeWorkMapping " +
							  " "+	 
							 " where pstEmployeeWorkMapping.id.pewmDateTime between '"+date+" 00:00:00' and '"+date+" 23:59:59' " +
								" and pstEmployeeWorkMapping.id.peId="+employee.getPeId());
					/* SELECT count(*) FROM PST_DB.PST_EMPLOYEE_WORK_MAPPING map 
					 where map.PEWM_DATE_TIME between '2013-01-01 00:00:00' 
					 and '2013-01-31 23:59:59'*/
					 query =session.createQuery(sb.toString());
					 Object obj=query.uniqueResult();
					 if(obj!=null){
						// java.lang.Object[] l1= (java.lang.Object[])obj;
							/*th.co.aoe.imake.pst.hibernate.bean.PstEmployee employee=(th.co.aoe.imake.pst.hibernate.bean.PstEmployee)l1[0];
							th.co.aoe.imake.pst.hibernate.bean.PstEmployeeWorkMapping pstEmployeeWorkMapping=(th.co.aoe.imake.pst.hibernate.bean.PstEmployeeWorkMapping)l1[1]; 
							*/
						 th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping mapping =(th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping)obj;
						 th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMappingPK pk =mapping.getId();
						 
							xmapping.setPeId(pk.getPeId());
							xmapping.setPesId(mapping.getPesId());
							xmapping.setPrpNo(mapping.getPrpNo());
							xmapping.setPewmDateTime(pk.getPewmDateTime());
							
							th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeStatus pstEmployeeStatus=mapping.getPstEmployeeStatus();
							 if(pstEmployeeStatus!=null){
								 th.co.imake.syndome.bpm.xstream.PstEmployeeStatus xpstEmployeeStatus = new th.co.imake.syndome.bpm.xstream.PstEmployeeStatus();
								 BeanUtils.copyProperties(pstEmployeeStatus, xpstEmployeeStatus);
								 xmapping.setPstEmployeeStatus(xpstEmployeeStatus);
							 }
					 }
						/*if(pstEmployeeWorkMapping!=null && pstEmployeeWorkMapping.getId()!=null){
							th.co.aoe.imake.pst.hibernate.bean.PstEmployeeWorkMappingPK pk =pstEmployeeWorkMapping.getId();
							xmapping.setPeId(pk.getPeId());
							xmapping.setPesId(pk.getPesId());
							xmapping.setPrpNo(pk.getPrpNo());
							xmapping.setPewmDateTime(pk.getPewmDateTime());
							th.co.aoe.imake.pst.hibernate.bean.PstEmployeeStatus pstEmployeeStatus=pstEmployeeWorkMapping.getPstEmployeeStatus();
							 if(pstEmployeeStatus!=null){
								 th.co.aoe.imake.pst.xstream.PstEmployeeStatus xpstEmployeeStatus = new th.co.aoe.imake.pst.xstream.PstEmployeeStatus();
								 BeanUtils.copyProperties(pstEmployeeStatus, xpstEmployeeStatus);
								 xmapping.setPstEmployeeStatus(xpstEmployeeStatus);
							 }
						}*/
						
					
						 
					 BeanUtils.copyProperties(employee, xemployee,emp_ignore);
					 if(employee.getPstPosition()!=null){
						 th.co.imake.syndome.bpm.xstream.PstPosition xpstPosition= new th.co.imake.syndome.bpm.xstream.PstPosition();
						 BeanUtils.copyProperties(employee.getPstPosition(), xpstPosition);
						 xemployee.setPstPosition(xpstPosition);
					 }
					 if(employee.getPstTitle()!=null){
						 th.co.imake.syndome.bpm.xstream.PstTitle xpstTitle= new th.co.imake.syndome.bpm.xstream.PstTitle();
						 BeanUtils.copyProperties(employee.getPstTitle(),xpstTitle);
						 xemployee.setPstTitle(xpstTitle);
					 }
					 if(employee.getPstRoadPump()!=null){
						 th.co.imake.syndome.bpm.xstream.PstRoadPump xpstRoadPump= new th.co.imake.syndome.bpm.xstream.PstRoadPump();
						 xpstRoadPump.setPrpId(employee.getPstRoadPump().getPrpId());
						 xpstRoadPump.setPrpNo(employee.getPstRoadPump().getPrpNo()); 
						 xemployee.setPstRoadPump(xpstRoadPump);
					 }
					 xmapping.setPstEmployee(xemployee);
					 xmapping.setWeekdayCollection(((java.lang.Long)l1[1]).intValue()+"");
					 returnList.add(xmapping); 
				}
			 
				 transList.add(returnList); 
			 	 transList.add(size); 
				return transList;
			} catch (Exception re) {
				//re.printStackTrace();
				logger.error("find by property name failed", re);
				 
			}
			return transList;
		}
	 
	@Override
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public int setPstEmployeeWorkMapping(Long[] peIds, Long[] pesIds,
			String[] prpNos, Date pewmDateTime) {
		try{
		if(peIds!=null && peIds.length>0){
			StringBuffer sb =new StringBuffer();
			String date=format1.format(pewmDateTime);
			Query query=null;
			for (int i = 0; i < prpNos.length; i++) {
				Session session = sessionAnnotationFactory.getCurrentSession();
				 sb.setLength(0);
				sb.append(" select count(pstEmployeeWorkMapping) from PstEmployeeWorkMapping as pstEmployeeWorkMapping " +
						" where pstEmployeeWorkMapping.id.pewmDateTime between '"+date+" 00:00:00' and '"+date+" 23:59:59' " +
						" and pstEmployeeWorkMapping.id.peId="+peIds[i]);
			 query =session.createQuery(sb.toString());
			 //Object obj=query.uniqueResult();
			 int obj=((Long)query.uniqueResult()).intValue();
			// th.co.aoe.imake.pst.hibernate.bean.PstEmployeeWorkMapping mapping=null;
			 if(obj==1){ // update
				// mapping=(th.co.aoe.imake.pst.hibernate.bean.PstEmployeeWorkMapping)obj;
				 if(pesIds[i]!=null && pesIds[i].intValue()!=-1){
					// mapping.setPesId(pesIds[i]);
				 }else
					 pesIds[i]=null;
					// mapping.setPesId(null);
				 if(prpNos[i]!=null && !prpNos[i].equals("-1")){
					// mapping.setPrpNo(prpNos[i]);
				 }else
					 prpNos[i]=null;
					// mapping.setPrpNo(null);
				// mapping.getId().setPewmDateTime(pewmDateTime);
				 sb.setLength(0); 
					sb.append(" update PstEmployeeWorkMapping as pstEmployeeWorkMapping  set pesId=:pesId " +
							" , prpNo=:prpNo , id.pewmDateTime=:pewmDateTime " +
							" where pstEmployeeWorkMapping.id.pewmDateTime between '"+date+" 00:00:00' and '"+date+" 23:59:59' " +
							" and pstEmployeeWorkMapping.id.peId="+peIds[i]);
				 query =session.createQuery(sb.toString());
				 query.setParameter("pesId", pesIds[i]);
				 query.setParameter("prpNo", prpNos[i]);
				 query.setParameter("pewmDateTime", pewmDateTime);
				  query.executeUpdate();
				 
				// session.update(mapping);
			 }else{ // save 
				 th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping   mapping= new th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping();
				 if(pesIds[i]!=null && pesIds[i].intValue()!=-1){
					 mapping.setPesId(pesIds[i]);
				 }else
					 mapping.setPesId(null);
				 if(prpNos[i]!=null && !prpNos[i].equals("-1")){
					 mapping.setPrpNo(prpNos[i]);
				 }else
					 mapping.setPrpNo(null);
				 th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMappingPK pk =
						 new th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMappingPK(peIds[i],pewmDateTime);
				 mapping.setId(pk);
				 session.save(mapping);
			 }
			// Object obj=query.uniqueResult();
				
			}
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		return 0;
	}
	@SuppressWarnings("unused")
	private List<th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping> getxPstEmployeeWorkMappingObject(
			java.util.ArrayList<th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping> ntcCalendars) {
		List<th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping> xntcCalendars = new ArrayList<th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping>(
				ntcCalendars.size());
		for (th.co.imake.syndome.bpm.hibernate.bean.PstEmployeeWorkMapping missManual : ntcCalendars) {
			th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping xmissManual =new th.co.imake.syndome.bpm.xstream.PstEmployeeWorkMapping ();
			BeanUtils.copyProperties(missManual, xmissManual);
			xmissManual.setPagging(null);
			xntcCalendars.add(xmissManual);
		}
		return xntcCalendars;
	} 

}
