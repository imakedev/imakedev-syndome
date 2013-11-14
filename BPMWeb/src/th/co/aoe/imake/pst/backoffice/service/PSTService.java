// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/27/2012 12:14:17 AM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   MissExamService.java

package th.co.aoe.imake.pst.backoffice.service;

import java.util.List;

import th.co.aoe.imake.pst.xstream.PstBrand;
import th.co.aoe.imake.pst.xstream.PstBreakDown;
import th.co.aoe.imake.pst.xstream.PstConcrete;
import th.co.aoe.imake.pst.xstream.PstCost;
import th.co.aoe.imake.pst.xstream.PstCustomer;
import th.co.aoe.imake.pst.xstream.PstCustomerContact;
import th.co.aoe.imake.pst.xstream.PstCustomerDivision;
import th.co.aoe.imake.pst.xstream.PstDepartment;
import th.co.aoe.imake.pst.xstream.PstEmployee;
import th.co.aoe.imake.pst.xstream.PstEmployeeStatus;
import th.co.aoe.imake.pst.xstream.PstEmployeeWorkMapping;
import th.co.aoe.imake.pst.xstream.PstJob;
import th.co.aoe.imake.pst.xstream.PstJobEmployee;
import th.co.aoe.imake.pst.xstream.PstJobPay;
import th.co.aoe.imake.pst.xstream.PstJobPayExt;
import th.co.aoe.imake.pst.xstream.PstJobWork;
import th.co.aoe.imake.pst.xstream.PstMaintenance;
import th.co.aoe.imake.pst.xstream.PstMaintenanceTran;
import th.co.aoe.imake.pst.xstream.PstModel;
import th.co.aoe.imake.pst.xstream.PstPosition;
import th.co.aoe.imake.pst.xstream.PstRoadPump;
import th.co.aoe.imake.pst.xstream.PstRoadPumpStatus;
import th.co.aoe.imake.pst.xstream.PstRoadPumpType;
import th.co.aoe.imake.pst.xstream.PstWorkType;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;


public interface PSTService {
	// public findByUsername;
	// PstBreakDown
	public abstract VResultMessage searchPstBreakDown(
			PstBreakDown pstBreakDown);
	public abstract Long savePstBreakDown(PstBreakDown pstBreakDown);

	public abstract int updatePstBreakDown(PstBreakDown pstBreakDown);

	public abstract int deletePstBreakDown(PstBreakDown pstBreakDown, String service);

	public abstract PstBreakDown findPstBreakDownById(Long long1);
	
	// PstCost
	public abstract VResultMessage searchPstCost(
			PstCost pstCost);
	public abstract Long savePstCost(PstCost pstCost);

	public abstract int updatePstCost(PstCost pstCost);

	public abstract int deletePstCost(PstCost pstCost, String service);

	public abstract PstCost findPstCostById(Long long1);
	
	// PstRoadPump
	public abstract VResultMessage searchPstRoadPump(
				PstRoadPump pstRoadPump);
	public abstract Long savePstRoadPump(PstRoadPump pstRoadPump);

	public abstract int updatePstRoadPump(PstRoadPump pstRoadPump);

	public abstract int deletePstRoadPump(PstRoadPump pstRoadPump, String service);

	public abstract PstRoadPump findPstRoadPumpById(Long long1);
	@SuppressWarnings("rawtypes")
	public abstract List listPstRoadPumpStatuses();
	public abstract PstRoadPump listPstRoadPumpMaster();
	
	// PstEmployeeStatus
	public abstract VResultMessage searchPstEmployeeStatus(
					PstEmployeeStatus pstEmployeeStatus);
	public abstract Long savePstEmployeeStatus(PstEmployeeStatus pstEmployeeStatus);

	public abstract int updatePstEmployeeStatus(PstEmployeeStatus pstEmployeeStatus);

	public abstract int deletePstEmployeeStatus(PstEmployeeStatus pstEmployeeStatus, String service);

	public abstract PstEmployeeStatus findPstEmployeeStatusById(Long long1);
	
	
	// PstEmployee
	public abstract VResultMessage searchPstEmployee(
					PstEmployee pstEmployee);
	public abstract Long savePstEmployee(PstEmployee pstEmployee);

	public abstract int updatePstEmployee(PstEmployee pstEmployee);

	public abstract int deletePstEmployee(PstEmployee pstEmployee, String service);

	public abstract PstEmployee findPstEmployeeById(Long long1); 
	@SuppressWarnings("rawtypes")
	public abstract List listPstPositions();
	@SuppressWarnings("rawtypes")
	public abstract List listPstTitles();
	
	// PstEmployeeWorkMapping
	public abstract VResultMessage searchPstEmployeeWorkMapping(
			PstEmployeeWorkMapping pstEmployeeWorkMapping);
	public abstract int setPstEmployeeWorkMapping(PstEmployeeWorkMapping pstEmployeeWorkMapping);
	@SuppressWarnings("rawtypes")
	public abstract List listPstEmployeeStatuses();
	@SuppressWarnings("rawtypes")
	public abstract List listPstRoadPumpNo();
	@SuppressWarnings("rawtypes")
	public abstract List listPstConcretes();
	public abstract VResultMessage searchPstJob(
			PstJob pstJob);
	public abstract Long savePstJob(PstJob pstJob);

	public abstract int updatePstJob(PstJob pstJob);

	public abstract int deletePstJob(PstJob pstJob, String service);

	public abstract PstJob findPstJobById(Long long1);
	public abstract PstJob listJobMaster(); 
	@SuppressWarnings("rawtypes")
	public abstract List listPstJobWorks(Long pjId,Long prpId);
	public abstract Long savePstJobWork(PstJobWork pstJobWork); 
	public abstract int deletePstJobWork(PstJobWork pstJobWork, String service);
	@SuppressWarnings("rawtypes")
	public abstract List listPstJobEmployees( Long pjId, Long peId, Long prpId);
	public abstract Long savePstJobEmployee(PstJobEmployee pstJobEmployee); 
	public abstract int deletePstJobEmployee(PstJobEmployee pstJobEmployee, String service);
	@SuppressWarnings("rawtypes")
	public abstract List listPstJobPays(Long pjId,Long pcId);
	public abstract Long savePstJobPay(PstJobPay pstJobPay); 
	public abstract int deletePstJobPay(PstJobPay pstJobPay, String service);
	@SuppressWarnings("rawtypes")
	public abstract List listPstJobPayExts( Long pjId,Long pjpeNo);
	public abstract Long savePstJobPayExt(PstJobPayExt pstJobPayExt); 
	public abstract int deletePstJobPayExt(PstJobPayExt pstJobPayExt, String service);
	@SuppressWarnings("rawtypes")
	public List searchObject(String query);
	public int executeQuery(String[] query);
	public int executeQueryUpdate(String[] queryDelete,String[] queryUpdate);
	public int executeMaintenance(PstMaintenance[] pstMaintenance,PstMaintenanceTran pstMaintenanceTran,String mode);
		 
	//public int executeQueryDelete(String[] query);
	
	// PstPosition
	public abstract VResultMessage searchPstPosition(
			PstPosition pstPosition);
	public abstract Long savePstPosition(PstPosition pstPosition);

	public abstract int updatePstPosition(PstPosition pstPosition);

	public abstract int deletePstPosition(PstPosition pstPosition, String service);

	public abstract PstPosition findPstPositionById(Long long1);
	
	// PstCustomer
	public abstract VResultMessage searchPstCustomer(
				PstCustomer pstCustomer);
	public abstract Long savePstCustomer(PstCustomer pstCustomer);

	public abstract int updatePstCustomer(PstCustomer pstCustomer);

	public abstract int deletePstCustomer(PstCustomer pstCustomer, String service);

	public abstract PstCustomer findPstCustomerById(Long long1);
		
		
	// PstCustomerDivision
	public abstract VResultMessage searchPstCustomerDivision(
				PstCustomerDivision pstCustomerDivision);
	public abstract Long savePstCustomerDivision(PstCustomerDivision pstCustomerDivision);

	public abstract int updatePstCustomerDivision(PstCustomerDivision pstCustomerDivision);

	public abstract int deletePstCustomerDivision(PstCustomerDivision pstCustomerDivision, String service);

	public abstract PstCustomerDivision findPstCustomerDivisionById(Long long1);
		
	// PstCustomerContact
	public abstract VResultMessage searchPstCustomerContact(
				PstCustomerContact pstCustomerContact);
	public abstract Long savePstCustomerContact(PstCustomerContact pstCustomerContact);

	public abstract int updatePstCustomerContact(PstCustomerContact pstCustomerContact);

	public abstract int deletePstCustomerContact(PstCustomerContact pstCustomerContact, String service);

	public abstract PstCustomerContact findPstCustomerContactById(Long long1);
	
	// User
	public abstract VResultMessage searchUser(
			th.co.aoe.imake.pst.xstream.User user);
	public abstract Long saveUser(th.co.aoe.imake.pst.xstream.User user);

	public abstract int updateUser(th.co.aoe.imake.pst.xstream.User user);

	public abstract int deleteUser(th.co.aoe.imake.pst.xstream.User user, String service);

	public abstract th.co.aoe.imake.pst.xstream.User findUserById(Long long1);
	
	
	// PstModel
	public abstract VResultMessage searchPstModel(
				PstModel pstModel);
	public abstract Long savePstModel(PstModel pstModel);

	public abstract int updatePstModel(PstModel pstModel);

	public abstract int deletePstModel(PstModel pstModel, String service);

	public abstract PstModel findPstModelById(Long long1);
		
	// PstBrand
	public abstract VResultMessage searchPstBrand(
				PstBrand pstBrand);
	public abstract Long savePstBrand(PstBrand pstBrand);

	public abstract int updatePstBrand(PstBrand pstBrand);

	public abstract int deletePstBrand(PstBrand pstBrand, String service);

	public abstract PstBrand findPstBrandById(Long long1);
	
	// PstConcrete
	public abstract VResultMessage searchPstConcrete(
				PstConcrete pstConcrete);
	public abstract Long savePstConcrete(PstConcrete pstConcrete);

	public abstract int updatePstConcrete(PstConcrete pstConcrete);

	public abstract int deletePstConcrete(PstConcrete pstConcrete, String service);

	public abstract PstConcrete findPstConcreteById(Long long1);
	
	// PstConcrete
	@SuppressWarnings("rawtypes")
	public abstract List listPstDepartments();
	
	public abstract VResultMessage searchPstDepartment(
					PstDepartment pstConcrete);
	public abstract Long savePstDepartment(PstDepartment pstDepartment);

	public abstract int updatePstDepartment(PstDepartment pstDepartment);

	public abstract int deletePstDepartment(PstDepartment pstDepartment, String service);

	public abstract PstDepartment findPstDepartmentById(Long long1);
		
	// PstConcrete
		
	public abstract VResultMessage searchPstWorkType(
						PstWorkType pstConcrete);
	public abstract Long savePstWorkType(PstWorkType pstWorkType);

	public abstract int updatePstWorkType(PstWorkType pstWorkType);

	public abstract int deletePstWorkType(PstWorkType pstWorkType, String service);

	public abstract PstWorkType findPstWorkTypeById(Long long1);
	
	// PstRoadPumpStatus
	public abstract VResultMessage searchPstRoadPumpStatus(
				PstRoadPumpStatus pstRoadPumpStatus);
	public abstract Long savePstRoadPumpStatus(PstRoadPumpStatus pstRoadPumpStatus);

	public abstract int updatePstRoadPumpStatus(PstRoadPumpStatus pstRoadPumpStatus);

	public abstract int deletePstRoadPumpStatus(PstRoadPumpStatus pstRoadPumpStatus, String service);

	public abstract PstRoadPumpStatus findPstRoadPumpStatusById(Long long1);
	
	@SuppressWarnings("rawtypes")
	public abstract List listPstRoadPumpTypees();
	// PstRoadPumpType
	public abstract VResultMessage searchPstRoadPumpType(
					PstRoadPumpType pstRoadPumpType);
	public abstract Long savePstRoadPumpType(PstRoadPumpType pstRoadPumpType);

	public abstract int updatePstRoadPumpType(PstRoadPumpType pstRoadPumpType);

	public abstract int deletePstRoadPumpType(PstRoadPumpType pstRoadPumpType, String service);

	public abstract PstRoadPumpType findPstRoadPumpTypeById(Long long1);
		
}
