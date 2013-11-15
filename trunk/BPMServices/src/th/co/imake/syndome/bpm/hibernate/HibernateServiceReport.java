package th.co.imake.syndome.bpm.hibernate;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.joda.time.DateTime;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import th.co.imake.syndome.bpm.managers.ServiceReportService;
import th.co.imake.syndome.bpm.xstream.ServiceReport;

@Repository
@Transactional
public class HibernateServiceReport extends HibernateCommon implements ServiceReportService {

	//private static final Logger logger = Logger.getLogger(ServiceConstant.LOG_APPENDER);
	private static SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
	private static SimpleDateFormat format2 = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
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
	//private List<String[]> getResult(Session session,StringBuffer sb){
	private List<List<String>> getResult(Session session,StringBuffer sb){
		Query query =session.createSQLQuery(sb.toString());
		@SuppressWarnings("unchecked")
		
		List<Object[]> list=query.list();
		//List<String[]> results=new ArrayList<String[]>(list.size()); 
		List<List<String>> results=new ArrayList<List<String>>(list.size());
		//List<String> results =new ArrayList<String>(list.size());
		for (Object[] objects : list) {
			//String[] strings =new String[objects.length] ;
			List<String> strings =new ArrayList<String>(objects.length);
			for (int i = 0; i < objects.length; i++) {
			//System.out.println(objects[i].getClass().toString());
			  if(objects[i]==null)
					 strings.add(null);
			  else	if(objects[i] instanceof java.lang.String){
				//strings[i]=(String)objects[i];
			//	System.out.println("value="+((String)objects[i]));
				strings.add((String)objects[i]);
			 } else if(objects[i] instanceof java.lang.Integer){ 
					strings.add((java.lang.Integer)objects[i]+"");
			}else if(objects[i] instanceof java.math.BigInteger){
					//strings[i]=(java.math.BigInteger)objects[i]+"";
				//	System.out.println("value="+((java.math.BigInteger)objects[i]+""));
					strings.add((java.math.BigInteger)objects[i]+"");
			} else if(objects[i] instanceof java.math.BigDecimal){
			//	System.out.println("value="+((java.math.BigDecimal)objects[i]+""));
				strings.add(((java.math.BigDecimal)objects[i]+""));
			}else if(objects[i] instanceof java.sql.Timestamp){
				strings.add(format2.format((java.sql.Timestamp)objects[i])); 
			}
				
			}
			results.add(strings);
		}
		return results;
	}
	private List<String> getResult(Session session,StringBuffer sb,int index){
		Query query =session.createSQLQuery(sb.toString());
		@SuppressWarnings("unchecked")
		List<Object[]> list=query.list();
		List<String> results =new ArrayList<String>(list.size());
		for (Object[] objects : list) {
			results.add((String)objects[index]);
		}
		return results;
	}
	private String getResultWithWeek(Session session,StringBuffer sb,int index){
		Query query =session.createSQLQuery(sb.toString()); 
		Object obj=query.uniqueResult();
		if(obj!=null){
			Object[] obj_values=(Object[])obj;
			return format2.format((java.sql.Timestamp)obj_values[index]);
		}
		return ""; 
	}
	@Transactional(readOnly=true)
	public ServiceReport findServiceReport(String mode,String month,String year)
			throws DataAccessException {
		// TODO Auto-generated method stub
		ServiceReport serviceReport =new ServiceReport();;
		Session session=sessionAnnotationFactory.getCurrentSession();
		try{
	//	Query query=session.createQuery(" select ProductReport from ProductReport ProductReport where ProductReport.mmId=:mmId");
		//Query query=session.createQuery(" select ProductReport from ProductReport ProductReport where ProductReport.missSery.msId=:msId");
			StringBuffer sb =new StringBuffer();
		if(mode.equals("1")){
			// get b
			sb.setLength(0); 
			//sb.append("SELECT truncate(((count(_group.meg_id)*100)/2)+0.006,2) AS PERCENT ,_group.meg_name " +
			sb.append("SELECT truncate(((count(_group.meg_id)*100)/( select count(*)" +
					" FROM "+schema+".MISS_REACTIVE_LOG log))+0.006,2) AS PERCENT ,_group.meg_name " +
			 
					" FROM "+schema+".MISS_REACTIVE_LOG log left join " +
					" "+schema+".MISS_SERIES sery on  log.MS_ID=sery.MS_ID left join " +
					" "+schema+".MISS_SERIES_MAP map on sery.ms_id=map.ms_id left join" +
					" "+schema+".MISS_EXAM exam on  map.me_id=exam.me_id left join " +
					" "+schema+".MISS_EXAM_GROUP _group on exam.meg_id=_group.meg_id" +
					" group by _group.meg_id order by  COUNT(_group.meg_id) DESC " ); 
			//System.out.println("dsss");
			serviceReport.setSeryPercentReactive(getResult(session,sb));
			
			// get c.
			sb.setLength(0);
			sb.append(" SELECT count(account.MA_ID),account.MA_NAME " +
					" FROM "+schema+".MISS_REACTIVE_LOG reactive left join" +
					" "+schema+".MISS_CANDIDATE candidate ON reactive.MCA_ID=candidate.MCA_ID" +
					"  left join   "+schema+".MISS_ACCOUNT account on candidate.MA_ID=account.MA_ID" +
					"  group by account.MA_ID " ); 
			serviceReport.setSeryCountReactive(getResult(session,sb));
			
			// get d.
			sb.setLength(0);
			sb.append("SELECT COUNT(MSYSTEM_BROWSER_BAND),MSYSTEM_BROWSER_BAND " +
					" FROM "+schema+".MISS_SYSTEM_USE group by MSYSTEM_BROWSER_BAND " +
					" ORDER BY  COUNT(MSYSTEM_BROWSER_BAND) DESC ");
			 
			serviceReport.setBrowsers(getResult(session,sb,1));
			
			// get e
			sb.setLength(0);
			sb.append("SELECT count(sery.MS_ID),sery.MS_SERIES_NAME FROM "+schema+".MISS_SERY_PROBLEM problem left join " +
					" "+schema+".MISS_SERIES sery on  problem.MS_ID=sery.MS_ID group by sery.MS_ID " +
					" ORDER BY  COUNT(sery.MS_ID) DESC ");
			 
			serviceReport.setSeryProblem(getResult(session,sb,1));
		}
		
		 DateTime datetime=new DateTime(format1.parse("1/"+month+"/"+year+""));
		 //System.out.println("year="+year);
		 //System.out.println("month="+month);
		 //System.out.println("weekOfWeekyear berore="+datetime.weekOfWeekyear().get());
		 int startWeek=datetime.weekOfWeekyear().get();
		 if(month.equals("1"))
			startWeek=1;
		 
		 datetime=datetime.dayOfMonth().setCopy(datetime.dayOfMonth().getMaximumValue());
		// System.out.println(datetime.weekOfWeekyear().get());
		// System.out.println("weekOfWeekyear affter="+datetime.weekOfWeekyear().get());
		 int endWeek=datetime.weekOfWeekyear().get();
		 if(month.equals("12"))
			 endWeek=datetime.weekOfWeekyear().getMaximumValue();//startWeek+4;
		//System.out.println("getMaximumValue="+datetime.dayOfMonth().getMaximumValue());
		 List<List<String>> serySystemUsed=new ArrayList<List<String>>((endWeek-startWeek)+1);
		 // get a
		 for (int i = startWeek; i <= endWeek; i++) {
			 List<String> strings =new ArrayList<String>(3);
			 strings.add(i+"");
			 sb.setLength(0);
			 sb.append("SELECT count(MSYSTEM_WEEK), MSYSTEM_DATE_TIME_LOGIN" +
			 		" FROM "+schema+".MISS_SYSTEM_USE" +
			 		" where   msystem_week="+i +" and YEAR(MSYSTEM_DATE_TIME_LOGIN)="+year+
			 		"  group by YEAR(MSYSTEM_DATE_TIME_LOGIN) ,MONTH(MSYSTEM_DATE_TIME_LOGIN)" +
			 		" ,DAY(MSYSTEM_DATE_TIME_LOGIN), HOUR(MSYSTEM_DATE_TIME_LOGIN)" +
			 		" order by count(MSYSTEM_WEEK) desc limit 1 ");
			 strings.add(getResultWithWeek(session, sb, 1));	
			 sb.setLength(0);
			 sb.append("SELECT count(MSYSTEM_WEEK), MSYSTEM_DATE_TIME_LOGIN" +
			 		" FROM "+schema+".MISS_SYSTEM_USE" +
			 		" where   msystem_week="+i +" and YEAR(MSYSTEM_DATE_TIME_LOGIN)="+year+
			 		"  group by YEAR(MSYSTEM_DATE_TIME_LOGIN) ,MONTH(MSYSTEM_DATE_TIME_LOGIN)" +
			 		" ,DAY(MSYSTEM_DATE_TIME_LOGIN), HOUR(MSYSTEM_DATE_TIME_LOGIN)" +
			 		" order by count(MSYSTEM_WEEK) asc limit 1 ");
			 strings.add(getResultWithWeek(session, sb, 1));	
			 serySystemUsed.add(strings);
		}
		 serviceReport.setSerySystemUsed(serySystemUsed);

		// get a
		/*List<String> seryMaxUses =new ArrayList<String>(12);
		   for(int i=1;i<=12;i++){
			   sb.setLength(0);
				sb.append(" SELECT count(MSYSTEM_WEEK),
-- ,HOUR(MSYSTEM_DATE_TIME_LOGIN) ,
MSYSTEM_DATE_TIME_LOGIN   
FROM "+schema+".MISS_SYSTEM_USE  
where   msystem_week=38
 group by YEAR(MSYSTEM_DATE_TIME_LOGIN) ,MONTH(MSYSTEM_DATE_TIME_LOGIN)
 ,DAY(MSYSTEM_DATE_TIME_LOGIN), HOUR(MSYSTEM_DATE_TIME_LOGIN) 
order by count(MSYSTEM_WEEK) desc limit 1
");
				seryMaxUses.add(getResultWithYear(session,sb,2));
		   }  */
		   //productReport.setSeryMaxUses(seryMaxUses);
		   //System.out.println("seryMaxUses="+seryMaxUses);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
				if (session != null) {
					session = null;
				} 
		}
	  return serviceReport;
	}


}
