package th.co.aoe.imake.pst.constant;

import java.util.ResourceBundle;

public class ServiceConstant {
	public static final String hostReference = "http://10.2.0.76:10000/BPSService/RestletServlet/";
	
	public static final String LOG_APPENDER = "PSTLog";
	
	public static final String INTERFACE_RETURN_TYPE = "java.util.List";
	public static final String VOID_RETURN_TYPE = "void";
	public static final ResourceBundle bundle;
	public static String SCHEMA="";
	static{
		bundle =  ResourceBundle.getBundle( "jdbc" );	
		SCHEMA=bundle.getString("schema");
	}

	// PST_BREAK_DOWN
	public static final String PST_BREAK_DOWN_SAVE = "savePstBreakDown";
	public static final String PST_BREAK_DOWN_UPDATE = "updatePstBreakDown";
	public static final String PST_BREAK_DOWN_DELETE = "deletePstBreakDown";
	public static final String PST_BREAK_DOWN_ITEMS_DELETE ="deletePstBreakDownItems";
	public static final String PST_BREAK_DOWN_SEARCH = "searchPstBreakDown";
	public static final String PST_BREAK_DOWN_FIND_BY_ID = "findPstBreakDownById";
	
	// PST_COSTS
	public static final String PST_COST_SAVE = "savePstCost";
	public static final String PST_COST_UPDATE = "updatePstCost";
	public static final String PST_COST_DELETE = "deletePstCost";
	public static final String PST_COST_ITEMS_DELETE ="deletePstCostItems";
	public static final String PST_COST_SEARCH = "searchPstCost";
	public static final String PST_COST_FIND_BY_ID = "findPstCostById";

	// PST_ROAD_PUMP
	public static final String PST_ROAD_PUMP_SAVE = "savePstRoadPump";
	public static final String PST_ROAD_PUMP_UPDATE = "updatePstRoadPump";
	public static final String PST_ROAD_PUMP_DELETE = "deletePstRoadPump";
	public static final String PST_ROAD_PUMP_ITEMS_DELETE ="deletePstRoadPumpItems";
	public static final String PST_ROAD_PUMP_SEARCH = "searchPstRoadPump";
	public static final String PST_ROAD_PUMP_FIND_BY_ID = "findPstRoadPumpById";
	public static final String PST_ROAD_PUMP_LIST_MASTER = "listMasterPstRoadPump";
	public static final String PST_ROAD_PUMP_NO_LIST = "listPstRoadPumpNo";
	
	
	// PST_ROAD_PUMP_STATUS
	public static final String PST_ROAD_PUMP_STATUS_SAVE = "savePstRoadPumpStatus";
	public static final String PST_ROAD_PUMP_STATUS_UPDATE = "updatePstRoadPumpStatus";
	public static final String PST_ROAD_PUMP_STATUS_DELETE = "deletePstRoadPumpStatus";
	public static final String PST_ROAD_PUMP_STATUS_ITEMS_DELETE ="deletePstRoadPumpStatusItems";
	public static final String PST_ROAD_PUMP_STATUS_SEARCH = "searchPstRoadPumpStatus";
	public static final String PST_ROAD_PUMP_STATUS_FIND_BY_ID = "findPstRoadPumpStatusById";
	public static final String PST_ROAD_PUMP_STATUS_LIST = "listPstRoadPumpStatus";
	
	// PST_ROAD_PUMP_STATUS
	public static final String PST_ROAD_PUMP_TYPE_SAVE = "savePstRoadPumpType";
	public static final String PST_ROAD_PUMP_TYPE_UPDATE = "updatePstRoadPumpType";
	public static final String PST_ROAD_PUMP_TYPE_DELETE = "deletePstRoadPumpType";
	public static final String PST_ROAD_PUMP_TYPE_ITEMS_DELETE ="deletePstRoadPumpTypeItems";
	public static final String PST_ROAD_PUMP_TYPE_SEARCH = "searchPstRoadPumpType";
	public static final String PST_ROAD_PUMP_TYPE_FIND_BY_ID = "findPstRoadPumpTypeById";
	public static final String PST_ROAD_PUMP_TYPE_LIST = "listPstRoadPumpType";
	
	// PST_ROAD_PUMP_DEACTIVE_MAPPING
	public static final String PST_ROAD_PUMP_DEACTIVE_MAPPING_SAVE = "savePstRoadPumpDeactiveMapping";
	public static final String PST_ROAD_PUMP_DEACTIVE_MAPPING_UPDATE = "updatePstRoadPumpDeactiveMapping";
	public static final String PST_ROAD_PUMP_DEACTIVE_MAPPING_DELETE = "deletePstRoadPumpDeactiveMapping";
	public static final String PST_ROAD_PUMP_DEACTIVE_MAPPING_ITEMS_DELETE ="deletePstRoadPumpDeactiveMappingItems";
	public static final String PST_ROAD_PUMP_DEACTIVE_MAPPING_SEARCH = "searchPstRoadPumpDeactiveMapping";
	public static final String PST_ROAD_PUMP_DEACTIVE_MAPPING_FIND_BY_ID = "findPstRoadPumpDeactiveMappingById";
	
	// PST_EMPLOYEE_STATUS
	public static final String PST_EMPLOYEE_STATUS_SAVE = "savePstEmployeeStatus";
	public static final String PST_EMPLOYEE_STATUS_UPDATE = "updatePstEmployeeStatus";
	public static final String PST_EMPLOYEE_STATUS_DELETE = "deletePstEmployeeStatus";
	public static final String PST_EMPLOYEE_STATUS_ITEMS_DELETE ="deletePstEmployeeStatusItems";
	public static final String PST_EMPLOYEE_STATUS_SEARCH = "searchPstEmployeeStatus";
	public static final String PST_EMPLOYEE_STATUS_FIND_BY_ID = "findPstEmployeeStatusById";
	public static final String PST_EMPLOYEE_STATUS_LIST = "listPstEmployeeStatus";
	
	
	// PST_EMPLOYEE
	public static final String PST_EMPLOYEE_SAVE = "savePstEmployee";
	public static final String PST_EMPLOYEE_UPDATE = "updatePstEmployee";
	public static final String PST_EMPLOYEE_DELETE = "deletePstEmployee";
	public static final String PST_EMPLOYEE_ITEMS_DELETE ="deletePstEmployeeItems";
	public static final String PST_EMPLOYEE_SEARCH = "searchPstEmployee";
	public static final String PST_EMPLOYEE_FIND_BY_ID = "findPstEmployeeById";
		
	// PST_EMPLOYEE_WORK_MAPPING
	public static final String PST_EMPLOYEE_WORK_MAPPING_SAVE = "savePstEmployeeWorkMapping";
	public static final String PST_EMPLOYEE_WORK_MAPPING_UPDATE = "updatePstEmployeeWorkMapping";
	public static final String PST_EMPLOYEE_WORK_MAPPING_DELETE = "deletePstEmployeeWorkMapping";
	public static final String PST_EMPLOYEE_WORK_MAPPING_ITEMS_DELETE ="deletePstEmployeeWorkMappingItems";
	public static final String PST_EMPLOYEE_WORK_MAPPING_SEARCH = "searchPstEmployeeWorkMapping";
	public static final String PST_EMPLOYEE_WORK_MAPPING_FIND_BY_ID = "findPstEmployeeWorkMappingById";
	public static final String PST_EMPLOYEE_WORK_MAPPING_SET = "setPstEmployeeWorkMapping";
	
	
	 
	// PST_POSITION
	public static final String PST_POSITION_SAVE = "savePstPosition";
	public static final String PST_POSITION_UPDATE = "updatePstPosition";
	public static final String PST_POSITION_DELETE = "deletePstPosition";
	public static final String PST_POSITION_ITEMS_DELETE ="deletePstPositionItems";
	public static final String PST_POSITION_SEARCH = "searchPstPosition";
	public static final String PST_POSITION_FIND_BY_ID = "findPstPositionById";
	public static final String PST_POSITION_LIST = "listPstPostion";
	
	// PST_CUSTOMER
	public static final String PST_CUSTOMER_SAVE = "savePstCustomer";
	public static final String PST_CUSTOMER_UPDATE = "updatePstCustomer";
	public static final String PST_CUSTOMER_DELETE = "deletePstCustomer";
	public static final String PST_CUSTOMER_ITEMS_DELETE ="deletePstCustomerItems";
	public static final String PST_CUSTOMER_SEARCH = "searchPstCustomer";
	public static final String PST_CUSTOMER_FIND_BY_ID = "findPstCustomerById";
		
	// PST_CUSTOMER_DIVISION
	public static final String PST_CUSTOMER_DIVISION_SAVE = "savePstCustomerContact";
	public static final String PST_CUSTOMER_DIVISION_UPDATE = "updatePstCustomerContact";
	public static final String PST_CUSTOMER_DIVISION_DELETE = "deletePstCustomerContact";
	public static final String PST_CUSTOMER_DIVISION_ITEMS_DELETE ="deletePstCustomerContactItems";
	public static final String PST_CUSTOMER_DIVISION_SEARCH = "searchPstCustomerContact";
	public static final String PST_CUSTOMER_DIVISION_FIND_BY_ID = "findPstCustomerContactById";
		
	// PST_CUSTOMER_CONTACT
	public static final String PST_CUSTOMER_CONTACT_SAVE = "savePstCustomerDivision";
	public static final String PST_CUSTOMER_CONTACT_UPDATE = "updatePstCustomerDivision";
	public static final String PST_CUSTOMER_CONTACT_DELETE = "deletePstCustomerDivision";
	public static final String PST_CUSTOMER_CONTACT_ITEMS_DELETE ="deletePstCustomerDivisionItems";
	public static final String PST_CUSTOMER_CONTACT_SEARCH = "searchPstCustomerDivision";
	public static final String PST_CUSTOMER_CONTACT_FIND_BY_ID = "findPstCustomerDivisionById";
	
	// PST_MODEL
	public static final String PST_MODEL_SAVE = "savePstModel";
	public static final String PST_MODEL_UPDATE = "updatePstModel";
	public static final String PST_MODEL_DELETE = "deletePstModel";
	public static final String PST_MODEL_ITEMS_DELETE ="deletePstModelItems";
	public static final String PST_MODEL_SEARCH = "searchPstModel";
	public static final String PST_MODEL_FIND_BY_ID = "findPstModelById";
	 	
		
	// PST_BRAND
	public static final String PST_BRAND_SAVE = "savePstBrand";
	public static final String PST_BRAND_UPDATE = "updatePstBrand";
	public static final String PST_BRAND_DELETE = "deletePstBrand";
	public static final String PST_BRAND_ITEMS_DELETE ="deletePstBrandItems";
	public static final String PST_BRAND_SEARCH = "searchPstBrand";
	public static final String PST_BRAND_FIND_BY_ID = "findPstBrandById";
	
	// PST_TITLE
	public static final String PST_TITLE_SAVE = "savePstTitle";
	public static final String PST_TITLE_UPDATE = "updatePstTitle";
	public static final String PST_TITLE_DELETE = "deletePstTitle";
	public static final String PST_TITLE_ITEMS_DELETE ="deletePstTitleItems";
	public static final String PST_TITLE_SEARCH = "searchPstTitle";
	public static final String PST_TITLE_FIND_BY_ID = "findPstTitleById";
	public static final String PST_TITLE_LIST = "listPstTitle";
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
		public static final String PST_OBJECT_UPDATE = "executeQueryUpdate";
		public static final String PST_OBJECT_DELETE = "executeQueryDelete";
		public static final String PST_OBJECT_EXECUTE_MAINTENANCE = "executeMaintenanceQuery";
		
		
		
	
}
