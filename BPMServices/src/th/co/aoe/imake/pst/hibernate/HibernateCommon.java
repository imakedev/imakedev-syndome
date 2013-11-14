package th.co.aoe.imake.pst.hibernate;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import th.co.aoe.imake.pst.xstream.common.Pagging;


/**
 * Hibernate Common implementation delete , save , update and findById Method.
 * 
 * <p>
 * Note that transactions are declared with annotations and that some methods
 * contain "readOnly = true" which is an optimization that is particularly
 * valuable when using Hibernate (to suppress unnecessary flush attempts for
 * read-only operations).
 * 
 * @author Chatchai Pimtun
 */
@SuppressWarnings("deprecation")
@Repository
@Transactional
public class HibernateCommon {
	@SuppressWarnings("rawtypes")
	private static Class[] NO_ARGS_CLASS = new Class[0];
	private static Object[] NO_ARGS_OBJECT = new Object[0];
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public int delete(Session session, Object persistentInstance) {
		//Session session = this.sessionFactory.getCurrentSession();
		/*SessionStatistics sessionStats = session.getStatistics();
		sessionStats.*/
		//Statistics stats = this.sessionFactory.getStatistics();

		int canUpdate = 0;
		try{
		session.delete(persistentInstance);
		canUpdate =1;
		}finally {
			if (session != null) {
				session = null;
			} 
		}
		return canUpdate;
	}
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public int update(Session session, Object persistentInstance) {
		int canUpdate = 0;
		try{
			session.update(persistentInstance);
			canUpdate =1;
			}catch (Exception e) {
				// TODO: handle exception
			} finally {
				if (session != null) {
					session = null;
				} 
			}
			return canUpdate;
	}
	
	@Transactional(propagation = Propagation.REQUIRES_NEW,rollbackFor={RuntimeException.class})
	public Object save(Session session, Object transientInstance)
			throws DataAccessException {
		Object obj  = null;
		try{
			 obj = session.save(transientInstance);
		
			/*if(obj!=null){
				returnId =(Long) obj;
			}*/
			} finally {
				if (session != null) {
					session = null;
				} 
			}
			return obj;
	}
	@Transactional(readOnly = true)
	public Object findById(Session session, @SuppressWarnings("rawtypes") Class classType, Serializable id) {
		Object obj = null;
		try {
			//session.createQuery(arg0);
			obj = session.get(classType, id);
			return obj;
		} catch (RuntimeException re) {
			throw re;
		} finally {
			if (session != null) {
				session = null;
			}
		}
	}
	@SuppressWarnings({ "rawtypes", "unused", "unchecked" })
	public Criteria getCommonCriteria(Session  session ,Object instance,Map likeExpression ,Map leExpression ,Map geExpression) throws DataAccessException {

		// TODO Auto-generated method stub
	 
		/*boolean iscriteria = false;
		boolean isSelectAll = false;*/
		//Pagging pagging = null;
		try {
			Class c = instance.getClass();
			Criteria criteria = (Criteria) session
					.createCriteria(c);
			//pagging =  (Pagging)c.getMethod("getPagging", NO_ARGS_CLASS).invoke(instance, NO_ARGS_OBJECT);	 
			Object idObj = c.getMethod("getFieldId", NO_ARGS_CLASS).invoke(instance, NO_ARGS_OBJECT);
			Method[] methods = c.getMethods();
			String fieldName = "";			
			for (int i = 0; i < methods.length; i++) {
				if (methods[i].getName().startsWith("get")) {
					if (!methods[i].getName().equals("getClass")) {
						Class cType	= methods[i].getReturnType();
						Object obj = null;
						try {
							obj = methods[i].invoke(instance, NO_ARGS_OBJECT);
								if(obj!=null){
									fieldName =	methods[i].getName().substring(3,methods[i].getName().length());
									fieldName = fieldName.substring(0,1).toLowerCase()+fieldName.substring(1,fieldName.length());
									if(cType == Long.class){
										Long valueLong = new Long(obj.toString());
										if (valueLong.intValue() != 0) {
											criteria.add(Expression.eq(fieldName, valueLong));
											//iscriteria = true;
										}
									}
									if(cType == String.class){
										if ( !"".equals(obj.toString())
												&& !" ".equals(obj.toString())) { 
											boolean haveExtExpression =false;
											//System.out.println("likeExpression==>"+likeExpression);
											if(likeExpression!=null){
												if(likeExpression.containsKey(fieldName)){
													criteria.add(Expression.like(fieldName, obj.toString(),MatchMode.ANYWHERE).ignoreCase());
													haveExtExpression = true;
												}
											}
											if(leExpression!=null){
												if(leExpression.containsKey(fieldName)){
													criteria.add(Expression.le(fieldName, obj.toString()));
													haveExtExpression = true;
												}
											}
											if(geExpression!=null){
												if(geExpression.containsKey(fieldName)){
													criteria.add(Expression.ge(fieldName, obj.toString()));
													haveExtExpression = true;
												}
											}
											if(!haveExtExpression){
												criteria.add(Expression.eq(fieldName, obj.toString()));
											}
											//iscriteria = true;
										}
									}
									if(cType.toString().indexOf("th.or.ntc.hibernate.bean.N")>1){/*
										try {
											Object sub = c.getMethod(methods[i].getName(), NO_ARGS_CLASS).invoke(instance, NO_ARGS_OBJECT);
											if(sub!=null){
												criteria.add(Expression.eq(fieldName, sub));
												iscriteria = true;
											}
										} catch (SecurityException e) {
											// TODO Auto-generated catch block
											e.printStackTrace();
										} catch (NoSuchMethodException e) {
											// TODO Auto-generated catch block
											e.printStackTrace();
										}
									*/} 
								}
						} catch (IllegalArgumentException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (IllegalAccessException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (InvocationTargetException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
			} 

			/*if(idObj!=null && !idObj.toString().equals("")
					&& !idObj.toString().equals(" "))
			criteria.addOrder(Order.asc(idObj.toString()));
			// set pagging.
			String size = String.valueOf(getSize(session, instance,likeExpression,leExpression,geExpression));
			criteria.setFirstResult(pagging.getStartIndex());
			int maxResults = pagging.getStartIndex()==0?pagging.getPageSize():((pagging.getStartIndex()+pagging.getPageSize())-1);
			 criteria.setMaxResults(maxResults);*/
			
			//List l = criteria.list();

			 

			return criteria;
		} catch (Exception re) {
			re.printStackTrace();
		}finally{
			//pagging=null;
		}
		return null;
	
	}
	@SuppressWarnings({  "rawtypes", "unchecked" })
	@Transactional(readOnly = true)
	public List search(Session  session ,Object instance,Map likeExpression ,Map leExpression ,Map geExpression,Map likeFirstExpression,Map likeEndExpression,Map neExpression) throws DataAccessException {
		// TODO Auto-generated method stub

		// TODO Auto-generated method stub
		 
		ArrayList transList = new ArrayList();
		/*boolean iscriteria = false;
		boolean isSelectAll = false;*/
		Pagging pagging = null;
		try {
			Class c = instance.getClass();
			Criteria criteria = (Criteria) session
					.createCriteria(c);
			pagging =  (Pagging)c.getMethod("getPagging", NO_ARGS_CLASS).invoke(instance, NO_ARGS_OBJECT);	 
			Object idObj = c.getMethod("getFieldId", NO_ARGS_CLASS).invoke(instance, NO_ARGS_OBJECT);
			Method[] methods = c.getMethods();
			String fieldName = "";			
			for (int i = 0; i < methods.length; i++) {
				if (methods[i].getName().startsWith("get")) {
					if (!methods[i].getName().equals("getClass")) {
						Class cType	= methods[i].getReturnType();
						Object obj = null;
						try {
							obj = methods[i].invoke(instance, NO_ARGS_OBJECT);
								if(obj!=null){
									fieldName =	methods[i].getName().substring(3,methods[i].getName().length());
									fieldName = fieldName.substring(0,1).toLowerCase()+fieldName.substring(1,fieldName.length());
									if(cType == Long.class){
										Long valueLong = new Long(obj.toString());
										if (valueLong.intValue() != 0) {
											criteria.add(Expression.eq(fieldName, valueLong));
											//iscriteria = true;
										}
									}
									if(cType == String.class){
										if ( !"".equals(obj.toString())
												&& !" ".equals(obj.toString())) { 
											boolean haveExtExpression =false;
											//System.out.println("likeExpression==>"+likeExpression);
											if(likeExpression!=null){
												if(likeExpression.containsKey(fieldName)){
													criteria.add(Expression.like(fieldName, obj.toString(),MatchMode.ANYWHERE).ignoreCase());
													haveExtExpression = true;
												}
											}
											if(leExpression!=null){
												if(leExpression.containsKey(fieldName)){
													criteria.add(Expression.le(fieldName, obj.toString()));
													haveExtExpression = true;
												}
											}
											if(geExpression!=null){
												if(geExpression.containsKey(fieldName)){
													criteria.add(Expression.ge(fieldName, obj.toString()));
													haveExtExpression = true;
												}
											}
											if(likeFirstExpression!=null){
												if(likeFirstExpression.containsKey(fieldName)){
													criteria.add(Expression.like(fieldName, obj.toString(),MatchMode.START).ignoreCase());
													haveExtExpression = true;
												}
											}
											if(likeEndExpression!=null){
												if(likeEndExpression.containsKey(fieldName)){
													criteria.add(Expression.like(fieldName, obj.toString(),MatchMode.END).ignoreCase());
													haveExtExpression = true;
												}
											}
											if(neExpression!=null){
												if(neExpression.containsKey(fieldName)){
													criteria.add(Expression.ne(fieldName, obj.toString()));
													haveExtExpression = true;
												}
											}
											
											if(!haveExtExpression){
												criteria.add(Expression.eq(fieldName, obj.toString()));
											}
											//iscriteria = true;
										}
									}
									if(cType.toString().indexOf("th.or.ntc.hibernate.bean.N")>1){
										try {
											Object sub = c.getMethod(methods[i].getName(), NO_ARGS_CLASS).invoke(instance, NO_ARGS_OBJECT);
											if(sub!=null){
												criteria.add(Expression.eq(fieldName, sub));
												//iscriteria = true;
											}
										} catch (SecurityException e) {
											// TODO Auto-generated catch block
											e.printStackTrace();
										} catch (NoSuchMethodException e) {
											// TODO Auto-generated catch block
											e.printStackTrace();
										}
									} 
								}
						} catch (IllegalArgumentException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (IllegalAccessException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (InvocationTargetException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
			} 

			if(idObj!=null && !idObj.toString().equals("")
					&& !idObj.toString().equals(" "))
			criteria.addOrder(Order.asc(idObj.toString()));
			// set pagging.
			String size = String.valueOf(getSize(session, instance,likeExpression,leExpression,geExpression,likeFirstExpression,likeEndExpression,neExpression));
			/*criteria.setFirstResult(pagging.getStartIndex());
		//	int maxResults = pagging.getStartIndex()==0?pagging.getPageSize():((pagging.getStartIndex()+pagging.getPageSize())-1);
			int maxResults = pagging.getStartIndex()==0?pagging.getPageSize():((pagging.getStartIndex()+pagging.getPageSize()));
			 criteria.setMaxResults(maxResults);*/
			 criteria.setFirstResult(pagging.getPageSize() * (pagging.getPageNo() - 1));
			 criteria.setMaxResults(pagging.getPageSize());
 		 // System.out.println(" getStartIndex ==> "+pagging.getStartIndex());
		//  System.out.println(" maxResults ==> "+maxResults);
			List l = criteria.list();

			transList.add(l);

			transList.add(size);

			return transList;
		} catch (Exception re) {
			re.printStackTrace();
		}finally{
			pagging=null;
		}
		return null;
	
	}
	@SuppressWarnings({ "rawtypes","unchecked" })
	private int getSize(Session session,
			Object instance,Map likeExpression ,Map leExpression ,Map geExpression,Map likeFirstExpression,Map likeEndExpression,Map neExpression) throws Exception {

	/*	boolean iscriteria = false;
		boolean isSelectAll = false;*/
		try {
			 
				Class c = instance.getClass();
				Criteria criteria = (Criteria) session
						.createCriteria(c);			 
				Method[] methods = c.getMethods();
				String fieldName = ""; 		
				for (int i = 0; i < methods.length; i++) {
					if (methods[i].getName().startsWith("get")) {
						if (!methods[i].getName().equals("getClass")) {
							Class cType	= methods[i].getReturnType();
							Object obj = null;
							try {
								obj = methods[i].invoke(instance, NO_ARGS_OBJECT);
									if(obj!=null){
										fieldName =	methods[i].getName().substring(3,methods[i].getName().length());
										fieldName = fieldName.substring(0,1).toLowerCase()+fieldName.substring(1,fieldName.length());
										if(cType == Long.class){
											Long valueLong = new Long(obj.toString());
											if (valueLong.intValue() != 0) {
												criteria.add(Expression.eq(fieldName, valueLong));
											//	iscriteria = true;
											}
										}
										if(cType == String.class){
											if ( !"".equals(obj.toString())
													&& !" ".equals(obj.toString())) {
												boolean haveExtExpression =false;
												if(likeExpression!=null){
													if(likeExpression.containsKey(fieldName)){
														criteria.add(Expression.like(fieldName, obj.toString(),MatchMode.ANYWHERE).ignoreCase());
														haveExtExpression = true;
													}
												}
												if(leExpression!=null){
													if(leExpression.containsKey(fieldName)){
														criteria.add(Expression.le(fieldName, obj.toString()));
														haveExtExpression = true;
													}
												}
												if(geExpression!=null){
													if(geExpression.containsKey(fieldName)){
														criteria.add(Expression.ge(fieldName, obj.toString()));
														haveExtExpression = true;
													}
												}
												if(likeFirstExpression!=null){
													if(likeFirstExpression.containsKey(fieldName)){
														criteria.add(Expression.like(fieldName, obj.toString(),MatchMode.START).ignoreCase());
														haveExtExpression = true;
													}
												}
												if(likeEndExpression!=null){
													if(likeEndExpression.containsKey(fieldName)){
														criteria.add(Expression.like(fieldName, obj.toString(),MatchMode.END).ignoreCase());
														haveExtExpression = true;
													}
												}
												if(neExpression!=null){
													if(neExpression.containsKey(fieldName)){
														criteria.add(Expression.ne(fieldName, obj.toString()));
														haveExtExpression = true;
													}
												}
												if(!haveExtExpression){
													criteria.add(Expression.eq(fieldName, obj.toString()));
												}
												//iscriteria = true;
											}
										}
										if(cType.toString().indexOf("th.or.ntc.hibernate.bean.N")>1){
											try {
												Object sub = c.getMethod(methods[i].getName(), NO_ARGS_CLASS).invoke(instance, NO_ARGS_OBJECT);
												if(sub!=null){
													criteria.add(Expression.eq(fieldName, sub));
													//iscriteria = true;
												}
											} catch (SecurityException e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											} catch (NoSuchMethodException e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											}
										} 
									}
							} catch (IllegalArgumentException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} catch (IllegalAccessException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							} catch (InvocationTargetException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
					}
				} 
			 
			criteria.setProjection(Projections.rowCount());
			return ((Integer) criteria.list().get(0)).intValue();

		} catch (HibernateException re) {
			throw re;
		} catch (Exception e) {
			throw e;
		}
	
	}
	@SuppressWarnings("rawtypes")
	@Transactional(readOnly = true)
	public List search(Session  session ,Object instance,Map likeExpression ,Map leExpression ,Map geExpression) throws DataAccessException {
		return search(session, instance, likeExpression, leExpression, geExpression,null,null,null);
	}
	
	@SuppressWarnings("rawtypes")
	@Transactional(readOnly = true)
	public List search(Session  session ,Object instance,Map likeExpression ,Map leExpression ,Map geExpression,Map likeFirstExpression,Map likeEndExpression) throws DataAccessException {
		return search(session, instance, likeExpression, leExpression, geExpression,likeFirstExpression,likeEndExpression,null);
	}	
}
