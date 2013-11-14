package th.co.aoe.imake.pst.hibernate;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import th.co.aoe.imake.pst.hibernate.bean.PstMaintenance;
import th.co.aoe.imake.pst.hibernate.bean.PstMaintenanceTran;
import th.co.aoe.imake.pst.hibernate.bean.PstMaintenanceTranPK;
import th.co.aoe.imake.pst.hibernate.bean.PstRoadPump;
import th.co.aoe.imake.pst.managers.PstObjectService;
@Repository
@Transactional
public class HibernatePstObject extends HibernateCommon implements PstObjectService {

//	private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER); HH:mm:ss
	 private static SimpleDateFormat format1 = new SimpleDateFormat("yyyy_MM_dd_HH_mm_ss");
	 private static SimpleDateFormat format2 = new SimpleDateFormat("dd/MM/yyyy");
	private SessionFactory sessionAnnotationFactory;
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}
	public void setSessionAnnotationFactory(SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List searchObject(String query) throws DataAccessException {
		// TODO Auto-generated method stub
		try{ 
		    List result= this.sessionAnnotationFactory
				.getCurrentSession()
				.createSQLQuery(query).list();
		    if(result!=null && result.size()>0){ 
		    	return result;
		    	//	Object obj[] =(Object[])result.get(i); 
		    }
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} 
		return null;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	@Override
	public int executeQuery(String[] str) throws DataAccessException {
		// TODO Auto-generated method stub
		Session session=sessionAnnotationFactory.getCurrentSession();
		int returnId=0;
		Query	query=null;
		try{ 
			for (int i = 0; i < str.length; i++) {
				query= session.createSQLQuery(str[i]);
				 returnId=returnId+query.executeUpdate();
			} 
				 
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if (session != null) {
				session = null;
			} 
		}
				return returnId;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	@Override
	public int executeQueryUpdate(String[] queryDelete,String[] queryUpdate) throws DataAccessException {
		// TODO Auto-generated method stub
	/*	Session session=sessionAnnotationFactory.getCurrentSession();
		StringBuffer sb =new StringBuffer();
		Query  queryHQL=null;*/
		int returnRecord=execute(queryDelete, "delete");
		 returnRecord=returnRecord+execute(queryUpdate, "update");
		/*for (int i = 0; i < queryDelete.length; i++) {
			String [] queryArray=queryDelete[i].split("_"); 
			sb.setLength(0);
			sb.append(" select count(pstCheckingMapping) from PstCheckingMapping pstCheckingMapping " +
					" where  pstCheckingMapping.id.pcmType='"+queryArray[0]+"' and pstCheckingMapping.id.pcmRefTypeNo="+queryArray[1]+
					" and pstCheckingMapping.id.pdId="+queryArray[2]+" and  pstCheckingMapping.id.pwtId="+queryArray[3]); 
			
			queryHQL=session.createQuery(sb.toString());
			 if(((Long)queryHQL.uniqueResult()).intValue()==0){
				 //save
				 th.co.aoe.imake.pst.hibernate.bean.PstCheckingMapping mapping= new th.co.aoe.imake.pst.hibernate.bean.PstCheckingMapping();
				 th.co.aoe.imake.pst.hibernate.bean.PstCheckingMappingPK pk=new th.co.aoe.imake.pst.hibernate.bean.PstCheckingMappingPK();
				 pk.setPcmType(queryArray[0]);
				 pk.setPcmRefTypeNo(Long.valueOf(queryArray[1]));
				 pk.setPdId(Long.valueOf(queryArray[2]));
				 pk.setPwtId(Long.valueOf(queryArray[3]));
				 mapping.setId(pk);
				 session.save(mapping);
			 }
		}
		*/
		return returnRecord;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	private int execute(String[] query,String mode) throws DataAccessException {
		// TODO Auto-generated method stub
		Session session=sessionAnnotationFactory.getCurrentSession();
		StringBuffer sb =new StringBuffer();
		Query  queryHQL=null;
		int returnRecord=0;
		for (int i = 0; i < query.length; i++) {
			String [] queryArray=query[i].split("_"); 
			sb.setLength(0);
			sb.append(" select count(pstCheckingMapping) from PstCheckingMapping pstCheckingMapping " +
					" where  pstCheckingMapping.id.pcmType='"+queryArray[0]+"' and pstCheckingMapping.id.pcmRefTypeNo="+queryArray[1]+
					" and pstCheckingMapping.id.pdId="+queryArray[2]+" and  pstCheckingMapping.id.pwtId="+queryArray[3]); 
			queryHQL=session.createQuery(sb.toString());
			 if(mode.equals("update")){
				 if(((Long)queryHQL.uniqueResult()).intValue()==0){
					 //save
					 th.co.aoe.imake.pst.hibernate.bean.PstCheckingMapping mapping= new th.co.aoe.imake.pst.hibernate.bean.PstCheckingMapping();
					 th.co.aoe.imake.pst.hibernate.bean.PstCheckingMappingPK pk=new th.co.aoe.imake.pst.hibernate.bean.PstCheckingMappingPK();
					 pk.setPcmType(queryArray[0]);
					 pk.setPcmRefTypeNo(Long.valueOf(queryArray[1]));
					 pk.setPdId(Long.valueOf(queryArray[2]));
					 pk.setPwtId(Long.valueOf(queryArray[3]));
					 mapping.setId(pk);
						 session.save(mapping);
					 returnRecord++;
				 }
			 }else{ //delete
				 if(((Long)queryHQL.uniqueResult()).intValue()>0){
					 //save
					 th.co.aoe.imake.pst.hibernate.bean.PstCheckingMapping mapping= new th.co.aoe.imake.pst.hibernate.bean.PstCheckingMapping();
					 th.co.aoe.imake.pst.hibernate.bean.PstCheckingMappingPK pk=new th.co.aoe.imake.pst.hibernate.bean.PstCheckingMappingPK();
					 pk.setPcmType(queryArray[0]);
					 pk.setPcmRefTypeNo(Long.valueOf(queryArray[1]));
					 pk.setPdId(Long.valueOf(queryArray[2]));
					 pk.setPwtId(Long.valueOf(queryArray[3]));
					 mapping.setId(pk);
						 session.delete(mapping);
						 returnRecord++;
				 }
			 }
			 /*if(((Long)queryHQL.uniqueResult()).intValue()==0){
				 //save
				 th.co.aoe.imake.pst.hibernate.bean.PstCheckingMapping mapping= new th.co.aoe.imake.pst.hibernate.bean.PstCheckingMapping();
				 th.co.aoe.imake.pst.hibernate.bean.PstCheckingMappingPK pk=new th.co.aoe.imake.pst.hibernate.bean.PstCheckingMappingPK();
				 pk.setPcmType(queryArray[0]);
				 pk.setPcmRefTypeNo(Long.valueOf(queryArray[1]));
				 pk.setPdId(Long.valueOf(queryArray[2]));
				 pk.setPwtId(Long.valueOf(queryArray[3]));
				 mapping.setId(pk);
				 if(mode.equals("update"))
					 session.save(mapping);
				 else
					 session.delete(mapping);
				 returnRecord++;
			 }*/
		}
		
		return returnRecord;
	}
 
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	@Override
	public int executeMaintenance(PstMaintenance[] pstMaintenanceArray,
			PstMaintenanceTran pstMaintenanceTran, String mode,String pmaintenanceCheckTimeStr,String pmaintenanceCheckTimeOldStr) {
		java.sql.Timestamp now = new java.sql.Timestamp(new Date().getTime());
		//java.sql.Timestamp dateOldTime = null;
		String nowStr=format1.format(now);
		
		String[] seconds=nowStr.split("_");
		
		Date date=null;
		if(pmaintenanceCheckTimeStr!=null && pmaintenanceCheckTimeStr.length()>0){		
			try {
				date=format2.parse(pmaintenanceCheckTimeStr);
				String dateStr=format1.format(date);
				String[] nowArray=dateStr.split("_");
				date=format1.parse(nowArray[0]+"_"+nowArray[1]+"_"+nowArray[2]+"_"+seconds[3]+"_"+seconds[4]+"_"+seconds[5]);
				now=new Timestamp(date.getTime());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		//Date dateOld=null;
		String pmaintenanceCheckTimeOldTimeStamp="";
		if(pmaintenanceCheckTimeOldStr!=null && pmaintenanceCheckTimeOldStr.length()>0){	
			String[] oldStrArray=pmaintenanceCheckTimeOldStr.split("_");
			//2013-06-09 19:13:36
			pmaintenanceCheckTimeOldTimeStamp=oldStrArray[0]+"-"+oldStrArray[1]+"-"+oldStrArray[2]+" "+oldStrArray[3]+":"+oldStrArray[4]+":"+oldStrArray[5];
			/*try {
				//dateOld=format1.parse(pmaintenanceCheckTimeOldStr);
//				String dateOldStr=format1.format(dateOld);
			//	dateOldTime=new Timestamp(dateOld.getTime());
			} catch (ParseException e) {
				// TODO Auto-generated catch block 
				e.printStackTrace();
			}*/
		} 
		  /*DateTime dt = new DateTime(new Date().getTime());
		  dt.hourOfDay().get()
		  dt.minuteOfHour().get();
		  dt.secondOfMinute().get();*/
		Session session=sessionAnnotationFactory.getCurrentSession();
		int returnValue=0;
		BigDecimal reset =new BigDecimal(0);
		PstRoadPump pstRoadPump=	(PstRoadPump)super.findById(sessionAnnotationFactory.getCurrentSession(), PstRoadPump.class, pstMaintenanceTran.getId().getPrpId());
     
		if(mode.equals("add")){ //add
		if(pstMaintenanceArray!=null && pstMaintenanceArray.length>0){		 
			
			int size=pstMaintenanceArray.length; 
			for (int i = 0; i < size; i++) { 
			    	pstMaintenanceArray[i].getId().setPmaintenanceCheckTime(now);			    	
			    	session.save(pstMaintenanceArray[i]);
			    } 
			
		}  
		pstMaintenanceTran.setPmaintenanceCubicAmountOld(pstRoadPump.getPrpCubicAmount());
		pstMaintenanceTran.setPmaintenanceDaysOfWorkOld(pstRoadPump.getPrpDaysOfWork());
		pstMaintenanceTran.setPmaintenanceHoursOfWorkOld(pstRoadPump.getPrpHoursOfWork());
		pstMaintenanceTran.setPmaintenanceMileOld(pstRoadPump.getPrpMile()); 
		
		pstMaintenanceTran.getId().setPmaintenanceCheckTime(now);
		PstMaintenanceTranPK pk=(PstMaintenanceTranPK)session.save(pstMaintenanceTran); 
		returnValue=pk.getPrpId().intValue();
		 
		pstRoadPump.setPrpCubicAmount(reset);
		pstRoadPump.setPrpDaysOfWork(reset);
		pstRoadPump.setPrpHoursOfWork(pstMaintenanceTran.getPmaintenanceHoursOfWorkOld());
		pstRoadPump.setPrpMile(pstMaintenanceTran.getPmaintenanceMile());
		session.update(pstRoadPump);
		
	}else{// update 	 
			if(pstMaintenanceArray!=null && pstMaintenanceArray.length>0){		 
				int size=pstMaintenanceArray.length; 
				for (int i = 0; i < size; i++) { 
				    	//pstMaintenanceArray[i].getId().setPmaintenanceCheckTime(dateOldTime);
				    /*	PstMaintenance pstMaintenanceDomain=(PstMaintenance)super.findById(sessionAnnotationFactory.getCurrentSession(), PstMaintenance.class, pstMaintenanceArray[i].getId());
				    	pstMaintenanceDomain.setPmaintenanceStatus(pstMaintenanceArray[i].getPmaintenanceStatus());
				    	pstMaintenanceDomain.setPmaintenanceDetail(pstMaintenanceArray[i].getPmaintenanceDetail());*/
				    	//pstMaintenanceDomain.getId().setPmaintenanceCheckTime(dateOldTime);
				    	Query query= session.createQuery("update PstMaintenance  pstMaintenance set pstMaintenance.pmaintenanceDetail=:pmaintenanceDetail ," +
				    			"pstMaintenance.pmaintenanceStatus=:pmaintenanceStatus ," +
				    			" pstMaintenance.id.pmaintenanceCheckTime='"+pmaintenanceCheckTimeOldTimeStamp+"'" +
				    			" where " +
				    			"pstMaintenance.id.prpId=:prpId and pstMaintenance.id.pdId=:pdId " +
				    			"and pstMaintenance.id.pwtId=:pwtId and pstMaintenance.id.pmaintenanceCheckTime='"+pmaintenanceCheckTimeOldTimeStamp+"'");
				    	query.setParameter("pmaintenanceDetail", pstMaintenanceArray[i].getPmaintenanceDetail());
				    	query.setParameter("pmaintenanceStatus", pstMaintenanceArray[i].getPmaintenanceStatus());
				    	query.setParameter("prpId", pstMaintenanceArray[i].getId().getPrpId());
				    	query.setParameter("pdId", pstMaintenanceArray[i].getId().getPdId());
				    	query.setParameter("pwtId", pstMaintenanceArray[i].getId().getPwtId());
				    	returnValue=returnValue+query.executeUpdate();
				    	//session.update(pstMaintenanceDomain);
				    }
			} 
		//	pstMaintenanceTran.getId().setPmaintenanceCheckTime(dateOldTime); 
		//	PstMaintenanceTran pstMaintenanceTranDomain=	(PstMaintenanceTran)super.findById(sessionAnnotationFactory.getCurrentSession(), PstMaintenanceTran.class, pstMaintenanceTran.getId());
		//	pstMaintenanceTranDomain.setPmaintenanceMile(pstMaintenanceTran.getPmaintenanceMile());
		//	pstMaintenanceTranDomain.setPmaintenanceHoursOfWork(pstMaintenanceTran.getPmaintenanceHoursOfWork());
			Query query= session.createQuery("update PstMaintenanceTran  pstMaintenanceTran set pstMaintenanceTran.pmaintenanceMile=:pmaintenanceMile ," +
	    			"pstMaintenanceTran.pmaintenanceHoursOfWork=:pmaintenanceHoursOfWork ,  " +
	    			" pstMaintenanceTran.id.pmaintenanceCheckTime='"+pmaintenanceCheckTimeOldTimeStamp+"'" +
	    			" where " +
	    			"pstMaintenanceTran.id.prpId=:prpId and pstMaintenanceTran.id.pmaintenanceDocNo=:pmaintenanceDocNo " +
	    			"  and pstMaintenanceTran.id.pmaintenanceCheckTime='"+pmaintenanceCheckTimeOldTimeStamp+"'");
	    	query.setParameter("pmaintenanceMile", pstMaintenanceTran.getPmaintenanceMile());
	    	query.setParameter("pmaintenanceHoursOfWork", pstMaintenanceTran.getPmaintenanceHoursOfWork());
	    	query.setParameter("prpId", pstMaintenanceTran.getId().getPrpId());
	    	query.setParameter("pmaintenanceDocNo", pstMaintenanceTran.getId().getPmaintenanceDocNo()); 
	    	returnValue=returnValue+query.executeUpdate();
		//	session.update(pstMaintenanceTranDomain);
	}  
		return returnValue;
	}
	 

}
