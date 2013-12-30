// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/27/2012 12:14:17 AM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   MissExamService.java

package th.co.imake.syndome.bpm.backoffice.service;

import java.util.List;

import th.co.imake.syndome.bpm.xstream.common.VResultMessage;


public interface SynDomeBPMService {
	// PstBreakDown
	@SuppressWarnings("rawtypes")
	public List searchObject(String query);
	public int executeQuery(String[] query);
	public int executeQuery(String[] query,List<String[]> values);
	public int executeQueryUpdate(String[] queryDelete,String[] queryUpdate);
		 
	//public int executeQueryDelete(String[] query);
	
	
	// User
	public abstract VResultMessage searchUser(
			th.co.imake.syndome.bpm.xstream.User user);
	public abstract String saveUser(th.co.imake.syndome.bpm.xstream.User user);

	public abstract int updateUser(th.co.imake.syndome.bpm.xstream.User user);

	public abstract int deleteUser(th.co.imake.syndome.bpm.xstream.User user, String service);

	public abstract th.co.imake.syndome.bpm.xstream.User findUserById(String long1);
	
	//public String getRunningNo(String module);
	public abstract String getRunningNo(String module,String format_year_month_day,String digit,String local);
	
}
