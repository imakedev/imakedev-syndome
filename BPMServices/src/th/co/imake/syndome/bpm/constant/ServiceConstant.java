package th.co.imake.syndome.bpm.constant;

import java.util.ResourceBundle;

public class ServiceConstant {
	public static final String hostReference = "http://10.2.0.76:10000/BPSService/RestletServlet/";
	
	public static final String LOG_APPENDER = "BPMConsultLog";
	
	public static final String INTERFACE_RETURN_TYPE = "java.util.List";
	public static final String VOID_RETURN_TYPE = "void";
	public static final ResourceBundle bundle;
	public static String SCHEMA="";
	public static String LOG_LEVEL="dev";
	static{
		bundle =  ResourceBundle.getBundle( "jdbc" );	
		SCHEMA=bundle.getString("schema");
		LOG_LEVEL=bundle.getString("LOG_LEVEL");
	}

	public static final String BPM_CALL_CENTER_OPEN_JOB = "openJob";
	public static final String BPM_CALL_CENTER_GET_JOB_STATUS = "getJobStatus";
	
	// role_contact
		public static final String ROLE_CONTACT_SAVE = "saveRoleContact";
		public static final String ROLE_CONTACT_UPDATE = "updateRoleContact";
		public static final String ROLE_CONTACT_DELETE = "deleteRoleContact";
		public static final String ROLE_CONTACT_SEARCH = "searchRoleContact";
		public static final String ROLE_CONTACT_FIND_BY_ID = "findRoleContactById"; 
		public static final String ROLE_CONTACT_ITEMS_DELETE ="deleteRoleContactItems";
		public static final String ROLE_CONTACT_LIST_BY_MA_ID ="listRoleContactByMaId";
		
		
		// role_mapping
		public static final String ROLE_MAPPING_SAVE = "saveRoleMapping";
		public static final String ROLE_MAPPING_UPDATE = "updateRoleMapping";
		public static final String ROLE_MAPPING_DELETE = "deleteRoleMapping";
		public static final String ROLE_MAPPING_SEARCH = "searchRoleMapping";
		public static final String ROLE_MAPPING_FIND_BY_ID = "findRoleMappingById"; 
		public static final String ROLE_MAPPING_ITEMS_DELETE ="deleteRoleMappingItems";
		public static final String ROLE_MAPPING_LIST_BY_RC_ID ="listRoleMappingByRcId";
		
		// role_type
		public static final String ROLE_TYPE_SAVE = "saveRoleType";
		public static final String ROLE_TYPE_UPDATE = "updateRoleType";
		public static final String ROLE_TYPE_DELETE = "deleteRoleType";
		public static final String ROLE_TYPE_SEARCH = "searchRoleType";
		public static final String ROLE_TYPE_FIND_BY_ID = "findRoleTypeById"; 
		public static final String ROLE_TYPE_ITEMS_DELETE ="deleteRoleTypeItems";
		public static final String ROLE_TYPE_LIST_BY_RC_ID ="listRoleTypeByRcId";
		public static final String ROLE_TYPE_LIST ="listRoleTypes";
		
		// PST_CONCRETE
		public static final String PST_CONCRETE_SAVE = "savePstConcrete";
		public static final String PST_CONCRETE_UPDATE = "updatePstConcrete";
		public static final String PST_CONCRETE_DELETE = "deletePstConcrete";
		public static final String PST_CONCRETE_ITEMS_DELETE ="deletePstConcreteItems";
		public static final String PST_CONCRETE_SEARCH = "searchPstConcrete";
		public static final String PST_CONCRETE_FIND_BY_ID = "findPstConcreteById";
		public static final String PST_CONCRETE_LIST = "listPstConcrete";
		

		// PST_DEPARTMENT
		public static final String PST_DEPARTMENT_SAVE = "savePstDepartment";
		public static final String PST_DEPARTMENT_UPDATE = "updatePstDepartment";
		public static final String PST_DEPARTMENT_DELETE = "deletePstDepartment";
		public static final String PST_DEPARTMENT_ITEMS_DELETE ="deletePstDepartmentItems";
		public static final String PST_DEPARTMENT_SEARCH = "searchPstDepartment";
		public static final String PST_DEPARTMENT_FIND_BY_ID = "findPstDepartmentById";
		public static final String PST_DEPARTMENT_LIST = "listPstDepartment";
		
		// PST_DEPARTMENT
		public static final String PST_WORK_TYPE_SAVE = "savePstWorkType";
		public static final String PST_WORK_TYPE_UPDATE = "updatePstWorkType";
		public static final String PST_WORK_TYPE_DELETE = "deletePstWorkType";
		public static final String PST_WORK_TYPE_ITEMS_DELETE ="deletePstWorkTypeItems";
		public static final String PST_WORK_TYPE_SEARCH = "searchPstWorkType";
		public static final String PST_WORK_TYPE_FIND_BY_ID = "findPstWorkTypeById";
		
		// PST_JOB
		public static final String PST_JOB_SAVE = "savePstJob";
		public static final String PST_JOB_UPDATE = "updatePstJob";
		public static final String PST_JOB_DELETE = "deletePstJob";
		public static final String PST_JOB_ITEMS_DELETE ="deletePstJobItems";
		public static final String PST_JOB_SEARCH = "searchPstJob";
		public static final String PST_JOB_FIND_BY_ID = "findPstJobById";
		public static final String PST_JOB_LIST_MASTER = "listMasterPstJob";
		
		//PST_JOB_PAY_EXT
		public static final String PST_JOB_PAY_EXT_SAVE = "savePstJobPayExt"; 
		public static final String PST_JOB_PAY_EXT_DELETE = "deletePstJobPayExt";
		public static final String PST_JOB_PAY_EXT_SEARCH = "searchPstJobPayExt";
		
		//PST_JOB_PAY
		public static final String PST_JOB_PAY_SAVE = "savePstJobPay"; 
		public static final String PST_JOB_PAY_DELETE = "deletePstJobPay";
		public static final String PST_JOB_PAY_SEARCH = "searchPstJobPay";
		
		//PST_JOB_EMPLOYEE
		public static final String PST_JOB_EMPLOYEE_SAVE = "savePstJobEmployee"; 
		public static final String PST_JOB_EMPLOYEE_DELETE = "deletePstJobEmployee";
		public static final String PST_JOB_EMPLOYEE_SEARCH = "searchPstJobEmployee";
		
		//PST_JOB_WORK
		public static final String PST_JOB_WORK_SAVE = "savePstJobWork"; 
		public static final String PST_JOB_WORK_DELETE = "deletePstJobWork";
		public static final String PST_JOB_WORK_SEARCH = "searchPstJobWork";
		
		// USER
		public static final String USER_SAVE = "saveUser";
		public static final String USER_UPDATE = "updateUser";
		public static final String USER_DELETE = "deleteUser";
		public static final String USER_SEARCH = "searchUser";
		public static final String USER_FIND_BY_ID = "findUserById";
		 
		
		public static final String PST_OBJECT_SEARCH = "searchObject";
		public static final String PST_OBJECT_EXECUTE = "executeQuery";
		public static final String PST_OBJECT_EXECUTE_WITH_VALUES = "executeQueryWithValues";
		public static final String PST_OBJECT_UPDATE = "executeQueryUpdate";
		public static final String PST_OBJECT_DELETE = "executeQueryDelete";
		public static final String PST_OBJECT_EXECUTE_MAINTENANCE = "executeMaintenanceQuery";
		public static final String PST_OBJECT_SEARCH_SERVICE = "searchServiceObject"; 
		public static final String PST_OBJECT_SEARCH_TO_DO_LIST = "searchTodoListObject";
		public static final String PST_OBJECT_SEARCH_SERVICES_REPORT = "searchServicesReportObject"; 
		public static final String PST_OBJECT_SEARCH_REPORT_SO = "searchReportSOObject";
		public static final String PST_OBJECT_SEARCH_REPORT_DEPT_STATUS="searchReportDepStatusObject";
		public static final String PST_OBJECT_SEARCH_REPORT_PMMA="searchReportPMMAObject";
		
		public static final String PST_OBJECT_GEN_PMMA = "genPMMAObject"; 
	
}
