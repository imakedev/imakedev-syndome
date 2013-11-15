// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/27/2012 12:14:40 AM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   MissExamServiceImpl.java

package th.co.imake.syndome.bpm.backoffice.service.impl;

import java.util.List;

import th.co.aoe.imake.pst.constant.ServiceConstant;
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
import th.co.aoe.imake.pst.xstream.PstObject;
import th.co.aoe.imake.pst.xstream.PstPosition;
import th.co.aoe.imake.pst.xstream.PstRoadPump;
import th.co.aoe.imake.pst.xstream.PstRoadPumpStatus;
import th.co.aoe.imake.pst.xstream.PstRoadPumpType;
import th.co.aoe.imake.pst.xstream.PstTitle;
import th.co.aoe.imake.pst.xstream.PstWorkType;
import th.co.aoe.imake.pst.xstream.User;
import th.co.aoe.imake.pst.xstream.common.VResultMessage;
import th.co.imake.syndome.bpm.backoffice.service.PSTService;

// Referenced classes of package th.co.aoe.imake.pst.exam.service.impl:
//            PostCommon

public class PSTServiceImpl extends PostCommon
    implements PSTService
{

    public PSTServiceImpl()
    {
    }
 
	@Override
	public VResultMessage searchPstBreakDown(PstBreakDown pstBreakDown) {
		// TODO Auto-generated method stub
		pstBreakDown.setServiceName(ServiceConstant.PST_BREAK_DOWN_SEARCH);
	    return postMessage(pstBreakDown, pstBreakDown.getClass().getName(), "pstBreakDown", true);
	}

	 public Long savePstBreakDown(PstBreakDown pstBreakDown)
	    {
		 pstBreakDown.setServiceName(ServiceConstant.PST_BREAK_DOWN_SAVE);
	        VResultMessage resultMessage = postMessage(pstBreakDown, pstBreakDown.getClass().getName(), "pstBreakDown", true);
	        pstBreakDown = (PstBreakDown)resultMessage.getResultListObj().get(0);
	        return pstBreakDown.getPbdId();
	    }

	    public int updatePstBreakDown(PstBreakDown pstBreakDown)
	    {
	    	pstBreakDown.setServiceName(ServiceConstant.PST_BREAK_DOWN_UPDATE);
	        VResultMessage resultMessage = postMessage(pstBreakDown, pstBreakDown.getClass().getName(), "pstBreakDown", true);
	        pstBreakDown = (PstBreakDown)resultMessage.getResultListObj().get(0);
	        return pstBreakDown.getUpdateRecord().intValue();
	    }

	    public int deletePstBreakDown(PstBreakDown pstBreakDown, String service)
	    {
	    	pstBreakDown.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstBreakDown, pstBreakDown.getClass().getName(), "pstBreakDown", true);
	        pstBreakDown = (PstBreakDown)resultMessage.getResultListObj().get(0);
	        return pstBreakDown.getUpdateRecord().intValue();
	    }

	    public PstBreakDown findPstBreakDownById(Long pbdId)
	    {
	    	PstBreakDown pstBreakDown = new PstBreakDown();
	    	pstBreakDown.setPbdId(pbdId);
	    	pstBreakDown.setServiceName(ServiceConstant.PST_BREAK_DOWN_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstBreakDown, pstBreakDown.getClass().getName(), "pstBreakDown", true);
	        return (PstBreakDown)resultMessage.getResultListObj().get(0);
	    }

		@Override
		public VResultMessage searchPstCost(PstCost pstCost) {
			// TODO Auto-generated method stub
			pstCost.setServiceName(ServiceConstant.PST_COST_SEARCH);
		    return postMessage(pstCost, pstCost.getClass().getName(), "pstCost", true);
		}

		@Override
		public Long savePstCost(PstCost pstCost) {
			// TODO Auto-generated method stub
			pstCost.setServiceName(ServiceConstant.PST_COST_SAVE);
		        VResultMessage resultMessage = postMessage(pstCost, pstCost.getClass().getName(), "pstCost", true);
		        pstCost = (PstCost)resultMessage.getResultListObj().get(0);
		        return pstCost.getPcId();
		}

		@Override
		public int updatePstCost(PstCost pstCost) {
			// TODO Auto-generated method stub
			pstCost.setServiceName(ServiceConstant.PST_COST_UPDATE);
	        VResultMessage resultMessage = postMessage(pstCost, pstCost.getClass().getName(), "pstCost", true);
	        pstCost = (PstCost)resultMessage.getResultListObj().get(0);
	        return pstCost.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstCost(PstCost pstCost, String service) {
			// TODO Auto-generated method stub
			pstCost.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstCost, pstCost.getClass().getName(), "pstCost", true);
	        pstCost = (PstCost)resultMessage.getResultListObj().get(0);
	        return pstCost.getUpdateRecord().intValue();
		}

		@Override
		public PstCost findPstCostById(Long long1) {
			// TODO Auto-generated method stub
			PstCost pstCost = new PstCost();
	    	pstCost.setPcId(long1);
	    	pstCost.setServiceName(ServiceConstant.PST_COST_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstCost, pstCost.getClass().getName(), "pstCost", true);
	        return (PstCost)resultMessage.getResultListObj().get(0);
		}

		@Override
		public VResultMessage searchPstRoadPump(PstRoadPump pstRoadPump) {
			// TODO Auto-generated method stub
			pstRoadPump.setServiceName(ServiceConstant.PST_ROAD_PUMP_SEARCH);
		    return postMessage(pstRoadPump, pstRoadPump.getClass().getName(), "pstRoadPump", true);
		}

		@Override
		public Long savePstRoadPump(PstRoadPump pstRoadPump) {
			// TODO Auto-generated method stub
			pstRoadPump.setServiceName(ServiceConstant.PST_ROAD_PUMP_SAVE);
		        VResultMessage resultMessage = postMessage(pstRoadPump, pstRoadPump.getClass().getName(), "pstRoadPump", true);
		        pstRoadPump = (PstRoadPump)resultMessage.getResultListObj().get(0);
		        return pstRoadPump.getPrpId();
		}

		@Override
		public int updatePstRoadPump(PstRoadPump pstRoadPump) {
			// TODO Auto-generated method stub
			pstRoadPump.setServiceName(ServiceConstant.PST_ROAD_PUMP_UPDATE);
	        VResultMessage resultMessage = postMessage(pstRoadPump, pstRoadPump.getClass().getName(), "pstRoadPump", true);
	        pstRoadPump = (PstRoadPump)resultMessage.getResultListObj().get(0);
	        return pstRoadPump.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstRoadPump(PstRoadPump pstRoadPump, String service) {
			// TODO Auto-generated method stub
			pstRoadPump.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstRoadPump, pstRoadPump.getClass().getName(), "pstRoadPump", true);
	        pstRoadPump = (PstRoadPump)resultMessage.getResultListObj().get(0);
	        return pstRoadPump.getUpdateRecord().intValue();
		}

		@Override
		public PstRoadPump findPstRoadPumpById(Long long1) {
			// TODO Auto-generated method stub
			PstRoadPump pstRoadPump = new PstRoadPump();
	    	pstRoadPump.setPrpId(long1);
	    	pstRoadPump.setServiceName(ServiceConstant.PST_ROAD_PUMP_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstRoadPump, pstRoadPump.getClass().getName(), "pstRoadPump", true);
	        return (PstRoadPump)resultMessage.getResultListObj().get(0);
		}
		@SuppressWarnings("rawtypes")
		@Override
		public List listPstRoadPumpStatuses() {
			// TODO Auto-generated method stub
			PstRoadPumpStatus pstRoadPumpStatus = new PstRoadPumpStatus();
			pstRoadPumpStatus.setServiceName(ServiceConstant.PST_ROAD_PUMP_STATUS_LIST);
		        VResultMessage resultMessage = postMessage(pstRoadPumpStatus, pstRoadPumpStatus.getClass().getName(), "pstRoadPumpStatus", true);
		        return resultMessage.getResultListObj();
		}

		@Override
		public PstRoadPump listPstRoadPumpMaster() {
			// TODO Auto-generated method stub
			PstRoadPump pstRoadPump = new PstRoadPump(); 
	    	pstRoadPump.setServiceName(ServiceConstant.PST_ROAD_PUMP_LIST_MASTER);
	        VResultMessage resultMessage = postMessage(pstRoadPump, pstRoadPump.getClass().getName(), "pstRoadPump", true);
	        return (PstRoadPump)resultMessage.getResultListObj().get(0);
		}

		@Override
		public VResultMessage searchPstEmployeeStatus(
				PstEmployeeStatus pstEmployeeStatus) {
			// TODO Auto-generated method stub
			pstEmployeeStatus.setServiceName(ServiceConstant.PST_EMPLOYEE_STATUS_SEARCH);
		    return postMessage(pstEmployeeStatus, pstEmployeeStatus.getClass().getName(), "pstEmployeeStatus", true);
		}

		@Override
		public Long savePstEmployeeStatus(PstEmployeeStatus pstEmployeeStatus) {
			// TODO Auto-generated method stub
			pstEmployeeStatus.setServiceName(ServiceConstant.PST_EMPLOYEE_STATUS_SAVE);
		        VResultMessage resultMessage = postMessage(pstEmployeeStatus, pstEmployeeStatus.getClass().getName(), "pstEmployeeStatus", true);
		        pstEmployeeStatus = (PstEmployeeStatus)resultMessage.getResultListObj().get(0);
		        return pstEmployeeStatus.getPesId();
		}

		@Override
		public int updatePstEmployeeStatus(PstEmployeeStatus pstEmployeeStatus) {
			// TODO Auto-generated method stub
			pstEmployeeStatus.setServiceName(ServiceConstant.PST_EMPLOYEE_STATUS_UPDATE);
	        VResultMessage resultMessage = postMessage(pstEmployeeStatus, pstEmployeeStatus.getClass().getName(), "pstEmployeeStatus", true);
	        pstEmployeeStatus = (PstEmployeeStatus)resultMessage.getResultListObj().get(0);
	        return pstEmployeeStatus.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstEmployeeStatus(PstEmployeeStatus pstEmployeeStatus,
				String service) {
			// TODO Auto-generated method stub
			pstEmployeeStatus.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstEmployeeStatus, pstEmployeeStatus.getClass().getName(), "pstEmployeeStatus", true);
	        pstEmployeeStatus = (PstEmployeeStatus)resultMessage.getResultListObj().get(0);
	        return pstEmployeeStatus.getUpdateRecord().intValue();
		}

		@Override
		public PstEmployeeStatus findPstEmployeeStatusById(Long long1) {
			// TODO Auto-generated method stub
			PstEmployeeStatus pstEmployeeStatus = new PstEmployeeStatus();
			pstEmployeeStatus.setPesId(long1);
			pstEmployeeStatus.setServiceName(ServiceConstant.PST_EMPLOYEE_STATUS_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstEmployeeStatus, pstEmployeeStatus.getClass().getName(), "pstEmployeeStatus", true);
	        return (PstEmployeeStatus)resultMessage.getResultListObj().get(0);
		}

		@Override
		public VResultMessage searchPstEmployee(PstEmployee pstEmployee) {
			// TODO Auto-generated method stub
			pstEmployee.setServiceName(ServiceConstant.PST_EMPLOYEE_SEARCH);
		    return postMessage(pstEmployee, pstEmployee.getClass().getName(), "pstEmployee", true);
		}

		@Override
		public Long savePstEmployee(PstEmployee pstEmployee) {
			// TODO Auto-generated method stub
			pstEmployee.setServiceName(ServiceConstant.PST_EMPLOYEE_SAVE);
	        VResultMessage resultMessage = postMessage(pstEmployee, pstEmployee.getClass().getName(), "pstEmployee", true);
	        pstEmployee = (PstEmployee)resultMessage.getResultListObj().get(0);
	        return pstEmployee.getPeId();
		}

		@Override
		public int updatePstEmployee(PstEmployee pstEmployee) {
			// TODO Auto-generated method stub
			pstEmployee.setServiceName(ServiceConstant.PST_EMPLOYEE_UPDATE);
	        VResultMessage resultMessage = postMessage(pstEmployee, pstEmployee.getClass().getName(), "pstEmployee", true);
	        pstEmployee = (PstEmployee)resultMessage.getResultListObj().get(0);
	        return pstEmployee.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstEmployee(PstEmployee pstEmployee, String service) {
			// TODO Auto-generated method stub
			pstEmployee.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstEmployee, pstEmployee.getClass().getName(), "pstEmployee", true);
	        pstEmployee = (PstEmployee)resultMessage.getResultListObj().get(0);
	        return pstEmployee.getUpdateRecord().intValue();
		}

		@Override
		public PstEmployee findPstEmployeeById(Long long1) {
			// TODO Auto-generated method stub
			PstEmployee pstEmployee = new PstEmployee();
			pstEmployee.setPeId(long1);
			pstEmployee.setServiceName(ServiceConstant.PST_EMPLOYEE_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstEmployee, pstEmployee.getClass().getName(), "pstEmployee", true);
	        return (PstEmployee)resultMessage.getResultListObj().get(0);
		}
		@SuppressWarnings("rawtypes")
		@Override
		public List listPstPositions() {
			// TODO Auto-generated method stub
			PstPosition pstPosition = new PstPosition();
			pstPosition.setServiceName(ServiceConstant.PST_POSITION_LIST);
		        VResultMessage resultMessage = postMessage(pstPosition, pstPosition.getClass().getName(), "pstPosition", true);
		        return resultMessage.getResultListObj();
		}
		@SuppressWarnings("rawtypes")
		@Override
		public List listPstTitles() {
			// TODO Auto-generated method stub
			PstTitle pstTitle = new PstTitle();
			pstTitle.setServiceName(ServiceConstant.PST_TITLE_LIST);
		        VResultMessage resultMessage = postMessage(pstTitle, pstTitle.getClass().getName(), "pstTitle", true);
		        return resultMessage.getResultListObj();
		}

		@Override
		public VResultMessage searchPstEmployeeWorkMapping(
				PstEmployeeWorkMapping pstEmployeeWorkMapping) {
			// TODO Auto-generated method stub
			pstEmployeeWorkMapping.setServiceName(ServiceConstant.PST_EMPLOYEE_WORK_MAPPING_SEARCH);
		    return postMessage(pstEmployeeWorkMapping, pstEmployeeWorkMapping.getClass().getName(), "pstEmployeeWorkMapping", true);
		}

		@Override
		public int setPstEmployeeWorkMapping(
				PstEmployeeWorkMapping pstEmployeeWorkMapping) {
			// TODO Auto-generated method stub
			pstEmployeeWorkMapping.setServiceName(ServiceConstant.PST_EMPLOYEE_WORK_MAPPING_SET);
	        VResultMessage resultMessage = postMessage(pstEmployeeWorkMapping, pstEmployeeWorkMapping.getClass().getName(), "pstEmployeeWorkMapping", true);
	        pstEmployeeWorkMapping = (PstEmployeeWorkMapping)resultMessage.getResultListObj().get(0);
	        return pstEmployeeWorkMapping.getUpdateRecord();
		}
		@SuppressWarnings("rawtypes")
		@Override
		public List listPstEmployeeStatuses() {
			// TODO Auto-generated method stub
			PstEmployeeStatus pstEmployeeStatus = new PstEmployeeStatus();
			pstEmployeeStatus.setServiceName(ServiceConstant.PST_EMPLOYEE_STATUS_LIST);
		        VResultMessage resultMessage = postMessage(pstEmployeeStatus, pstEmployeeStatus.getClass().getName(), "pstEmployeeStatus", true);
		        return resultMessage.getResultListObj();
		}
		@SuppressWarnings("rawtypes")
		@Override
		public List listPstRoadPumpNo() {
			// TODO Auto-generated method stub
			PstRoadPump pstRoadPump = new PstRoadPump();
			pstRoadPump.setServiceName(ServiceConstant.PST_ROAD_PUMP_NO_LIST);
		        VResultMessage resultMessage = postMessage(pstRoadPump, pstRoadPump.getClass().getName(), "pstRoadPump", true);
		        return resultMessage.getResultListObj();
		}
		@SuppressWarnings("rawtypes")
		@Override
		public List listPstConcretes() {
			// TODO Auto-generated method stub
			PstConcrete pstConcrete = new PstConcrete();
			pstConcrete.setServiceName(ServiceConstant.PST_CONCRETE_LIST);
		        VResultMessage resultMessage = postMessage(pstConcrete, pstConcrete.getClass().getName(), "pstConcrete", true);
		        return resultMessage.getResultListObj();
		}

		@Override
		public VResultMessage searchPstJob(PstJob pstJob) {
			// TODO Auto-generated method stub
			pstJob.setServiceName(ServiceConstant.PST_JOB_SEARCH);
		    return postMessage(pstJob, pstJob.getClass().getName(), "pstJob", true);
		}

		@Override
		public Long savePstJob(PstJob pstJob) {
			// TODO Auto-generated method stub
			pstJob.setServiceName(ServiceConstant.PST_JOB_SAVE);
	        VResultMessage resultMessage = postMessage(pstJob, pstJob.getClass().getName(), "pstJob", true);
	        pstJob = (PstJob)resultMessage.getResultListObj().get(0);
	        return pstJob.getPjId();
		}

		@Override
		public int updatePstJob(PstJob pstJob) {
			// TODO Auto-generated method stub
			pstJob.setServiceName(ServiceConstant.PST_JOB_UPDATE);
	        VResultMessage resultMessage = postMessage(pstJob, pstJob.getClass().getName(), "pstJob", true);
	        pstJob = (PstJob)resultMessage.getResultListObj().get(0);
	        return pstJob.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstJob(PstJob pstJob, String service) {
			// TODO Auto-generated method stub
			pstJob.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstJob, pstJob.getClass().getName(), "pstJob", true);
	        pstJob = (PstJob)resultMessage.getResultListObj().get(0);
	        return pstJob.getUpdateRecord().intValue();
		}

		@Override
		public PstJob findPstJobById(Long long1) {
			// TODO Auto-generated method stub
			PstJob pstJob = new PstJob();
			pstJob.setPjId(long1);
			pstJob.setServiceName(ServiceConstant.PST_JOB_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstJob, pstJob.getClass().getName(), "pstJob", true);
	        return (PstJob)resultMessage.getResultListObj().get(0);
		}

		@Override
		public PstJob listJobMaster() {
			// TODO Auto-generated method stub
			PstJob pstJob = new PstJob(); 
			pstJob.setServiceName(ServiceConstant.PST_JOB_LIST_MASTER);
	        VResultMessage resultMessage = postMessage(pstJob, pstJob.getClass().getName(), "pstJob", true);
	        return (PstJob)resultMessage.getResultListObj().get(0);
		}
		@Override
		public Long savePstJobWork(PstJobWork pstJobWork) {
			// TODO Auto-generated method stub
			 pstJobWork.setServiceName(ServiceConstant.PST_JOB_WORK_SAVE);
		        VResultMessage resultMessage = postMessage(pstJobWork, pstJobWork.getClass().getName(), "pstJobWork", true);
		        pstJobWork = (PstJobWork)resultMessage.getResultListObj().get(0);
		        return pstJobWork.getPbdId();
		}
		@Override
		public int deletePstJobWork(PstJobWork pstJobWork, String service) {
			// TODO Auto-generated method stub
			pstJobWork.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstJobWork, pstJobWork.getClass().getName(), "pstJobWork", true);
	        pstJobWork = (PstJobWork)resultMessage.getResultListObj().get(0);
	        return pstJobWork.getUpdateRecord().intValue();
		}
		@Override
		public Long savePstJobEmployee(PstJobEmployee pstJobEmployee) {
			// TODO Auto-generated method stub
			 pstJobEmployee.setServiceName(ServiceConstant.PST_JOB_EMPLOYEE_SAVE);
		        VResultMessage resultMessage = postMessage(pstJobEmployee, pstJobEmployee.getClass().getName(), "pstJobEmployee", true);
		        pstJobEmployee = (PstJobEmployee)resultMessage.getResultListObj().get(0);
		        return Long.valueOf(pstJobEmployee.getUpdateRecord());
		}
		@Override
		public int deletePstJobEmployee(PstJobEmployee pstJobEmployee,
				String service) {
			// TODO Auto-generated method stub
			pstJobEmployee.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstJobEmployee, pstJobEmployee.getClass().getName(), "pstJobEmployee", true);
	        pstJobEmployee = (PstJobEmployee)resultMessage.getResultListObj().get(0);
	        return pstJobEmployee.getUpdateRecord().intValue();
		}
		@Override
		public Long savePstJobPay(PstJobPay pstJobPay) {
			// TODO Auto-generated method stub
			 pstJobPay.setServiceName(ServiceConstant.PST_JOB_PAY_SAVE);
		        VResultMessage resultMessage = postMessage(pstJobPay, pstJobPay.getClass().getName(), "pstJobPay", true);
		        pstJobPay = (PstJobPay)resultMessage.getResultListObj().get(0);
		        return Long.valueOf(pstJobPay.getUpdateRecord());
		}
		@Override
		public int deletePstJobPay(PstJobPay pstJobPay, String service) {
			// TODO Auto-generated method stub
			pstJobPay.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstJobPay, pstJobPay.getClass().getName(), "pstJobPay", true);
	        pstJobPay = (PstJobPay)resultMessage.getResultListObj().get(0);
	        return pstJobPay.getUpdateRecord().intValue();
		}
		@Override
		public Long savePstJobPayExt(PstJobPayExt pstJobPayExt) {
			// TODO Auto-generated method stub
			 pstJobPayExt.setServiceName(ServiceConstant.PST_JOB_PAY_EXT_SAVE);
		        VResultMessage resultMessage = postMessage(pstJobPayExt, pstJobPayExt.getClass().getName(), "pstJobPayExt", true);
		        pstJobPayExt = (PstJobPayExt)resultMessage.getResultListObj().get(0);
		        return Long.valueOf(pstJobPayExt.getUpdateRecord());
		}
		@Override
		public int deletePstJobPayExt(PstJobPayExt pstJobPayExt, String service) {
			// TODO Auto-generated method stub
			pstJobPayExt.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstJobPayExt, pstJobPayExt.getClass().getName(), "pstJobPayExt", true);
	        pstJobPayExt = (PstJobPayExt)resultMessage.getResultListObj().get(0);
	        return pstJobPayExt.getUpdateRecord().intValue();
		}
		@SuppressWarnings("rawtypes")
		@Override
		public List listPstJobWorks(Long pjId, Long prpId) {
			// TODO Auto-generated method stub
			PstJobWork pstJobWork = new PstJobWork(pjId, prpId, null, null, null, null, 
					null, null, null, null, null); 
			pstJobWork.setServiceName(ServiceConstant.PST_JOB_WORK_SEARCH);
		        VResultMessage resultMessage = postMessage(pstJobWork, pstJobWork.getClass().getName(), "pstJobWork", true);
		        return resultMessage.getResultListObj(); 
		}
		@SuppressWarnings("rawtypes")
		@Override
		public List listPstJobEmployees(Long pjId, Long peId,Long prpId) {
			// TODO Auto-generated method stub
			PstJobEmployee pstJobEmployee = new PstJobEmployee(pjId, peId, 
					prpId,null, null, null, null, null); 
			pstJobEmployee.setServiceName(ServiceConstant.PST_JOB_EMPLOYEE_SEARCH);
		        VResultMessage resultMessage = postMessage(pstJobEmployee, pstJobEmployee.getClass().getName(), "pstJobEmployee", true);
		        return resultMessage.getResultListObj(); 
		}
		@SuppressWarnings("rawtypes")
		@Override
		public List listPstJobPays(Long pjId, Long pcId) {
			// TODO Auto-generated method stub
			PstJobPay pstJobPay = new PstJobPay(pjId, pcId, null, null, null); 
			pstJobPay.setServiceName(ServiceConstant.PST_JOB_PAY_SEARCH);
		        VResultMessage resultMessage = postMessage(pstJobPay, pstJobPay.getClass().getName(), "pstJobPay", true);
		        return resultMessage.getResultListObj(); 
		}
		@SuppressWarnings("rawtypes")
		@Override
		public List listPstJobPayExts(Long pjId, Long pjpeNo) {
			// TODO Auto-generated method stub
			PstJobPayExt pstJobPayExt = new PstJobPayExt(pjId, pjpeNo, null, null, null); 
			pstJobPayExt.setServiceName(ServiceConstant.PST_JOB_PAY_EXT_SEARCH);
		        VResultMessage resultMessage = postMessage(pstJobPayExt, pstJobPayExt.getClass().getName(), "pstJobPayExt", true);
		        return resultMessage.getResultListObj(); 
		}
		@SuppressWarnings("rawtypes")
		@Override
		public List searchObject(String query) {
			// TODO Auto-generated method stub 
			PstObject pstObject = new PstObject(new String[]{query}); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_SEARCH);
		        VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true);
		        return resultMessage.getResultListObj(); 
		 
		}
		 
		@Override
		public int executeQuery(String[] query) {
			// TODO Auto-generated method stub
			PstObject pstObject = new PstObject(query); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_EXECUTE);
		        VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
		        pstObject = (PstObject)resultMessage.getResultListObj().get(0);
		        return pstObject.getUpdateRecord().intValue(); 
		 
		}
		@Override
		public int executeQueryUpdate(String[] queryDelete,String[] queryUpdate) {
			// TODO Auto-generated method stub
			PstObject pstObject = new PstObject(); 
			pstObject.setQueryDelete(queryDelete);
			pstObject.setQueryUpdate(queryUpdate);
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_UPDATE);
		        VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
		        pstObject = (PstObject)resultMessage.getResultListObj().get(0);
		        return pstObject.getUpdateRecord().intValue(); 
		 
		}
		/*@Override
		public int executeQueryDelete(String[] query) {
			// TODO Auto-generated method stub
			PstObject pstObject = new PstObject(query); 
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_DELETE);
		        VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
		        pstObject = (PstObject)resultMessage.getResultListObj().get(0);
		        return pstObject.getUpdateRecord().intValue(); 
		}*/
		@Override
		public VResultMessage searchPstPosition(PstPosition pstPosition) {
			// TODO Auto-generated method stub
			pstPosition.setServiceName(ServiceConstant.PST_POSITION_SEARCH);
		    return postMessage(pstPosition, pstPosition.getClass().getName(), "pstPosition", true);
		}

		@Override
		public Long savePstPosition(PstPosition pstPosition) {
			// TODO Auto-generated method stub
			pstPosition.setServiceName(ServiceConstant.PST_POSITION_SAVE);
	        VResultMessage resultMessage = postMessage(pstPosition, pstPosition.getClass().getName(), "pstPosition", true);
	        pstPosition = (PstPosition)resultMessage.getResultListObj().get(0);
	        return pstPosition.getPpId();
		}

		@Override
		public int updatePstPosition(PstPosition pstPosition) {
			// TODO Auto-generated method stub
			pstPosition.setServiceName(ServiceConstant.PST_POSITION_UPDATE);
	        VResultMessage resultMessage = postMessage(pstPosition, pstPosition.getClass().getName(), "pstPosition", true);
	        pstPosition = (PstPosition)resultMessage.getResultListObj().get(0);
	        return pstPosition.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstPosition(PstPosition pstPosition, String service) {
			// TODO Auto-generated method stub
			pstPosition.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstPosition, pstPosition.getClass().getName(), "pstPosition", true);
	        pstPosition = (PstPosition)resultMessage.getResultListObj().get(0);
	        return pstPosition.getUpdateRecord().intValue();
		}

		@Override
		public PstPosition findPstPositionById(Long long1) {
			// TODO Auto-generated method stub
			PstPosition pstPosition = new PstPosition();
			pstPosition.setPpId(long1);
			pstPosition.setServiceName(ServiceConstant.PST_POSITION_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstPosition, pstPosition.getClass().getName(), "pstPosition", true);
	        return (PstPosition)resultMessage.getResultListObj().get(0);
		}
		
		@Override
		public VResultMessage searchPstConcrete(PstConcrete pstConcrete) {
			// TODO Auto-generated method stub
			pstConcrete.setServiceName(ServiceConstant.PST_CONCRETE_SEARCH);
		    return postMessage(pstConcrete, pstConcrete.getClass().getName(), "pstConcrete", true);
		}

		@Override
		public Long savePstConcrete(PstConcrete pstConcrete) {
			// TODO Auto-generated method stub
			pstConcrete.setServiceName(ServiceConstant.PST_CONCRETE_SAVE);
	        VResultMessage resultMessage = postMessage(pstConcrete, pstConcrete.getClass().getName(), "pstConcrete", true);
	        pstConcrete = (PstConcrete)resultMessage.getResultListObj().get(0);
	        return pstConcrete.getPconcreteId();
		}

		@Override
		public int updatePstConcrete(PstConcrete pstConcrete) {
			// TODO Auto-generated method stub
			pstConcrete.setServiceName(ServiceConstant.PST_CONCRETE_UPDATE);
	        VResultMessage resultMessage = postMessage(pstConcrete, pstConcrete.getClass().getName(), "pstConcrete", true);
	        pstConcrete = (PstConcrete)resultMessage.getResultListObj().get(0);
	        return pstConcrete.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstConcrete(PstConcrete pstConcrete, String service) {
			// TODO Auto-generated method stub
			pstConcrete.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstConcrete, pstConcrete.getClass().getName(), "pstConcrete", true);
	        pstConcrete = (PstConcrete)resultMessage.getResultListObj().get(0);
	        return pstConcrete.getUpdateRecord().intValue();
		}

		@Override
		public PstConcrete findPstConcreteById(Long long1) {
			// TODO Auto-generated method stub
			PstConcrete pstConcrete = new PstConcrete();
			pstConcrete.setPconcreteId(long1);
			pstConcrete.setServiceName(ServiceConstant.PST_CONCRETE_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstConcrete, pstConcrete.getClass().getName(), "pstConcrete", true);
	        return (PstConcrete)resultMessage.getResultListObj().get(0);
		}

		@Override
		public List listPstDepartments() {
			// TODO Auto-generated method stub
			PstDepartment pstDepartment = new PstDepartment();
			pstDepartment.setServiceName(ServiceConstant.PST_DEPARTMENT_LIST);
		        VResultMessage resultMessage = postMessage(pstDepartment, pstDepartment.getClass().getName(), "pstDepartment", true);
		        return resultMessage.getResultListObj();
		}

		@Override
		public VResultMessage searchPstDepartment(PstDepartment pstDepartment) {
			// TODO Auto-generated method stub
			pstDepartment.setServiceName(ServiceConstant.PST_DEPARTMENT_SEARCH);
		    return postMessage(pstDepartment, pstDepartment.getClass().getName(), "pstDepartment", true);
		}

		@Override
		public Long savePstDepartment(PstDepartment pstDepartment) {
			// TODO Auto-generated method stub
			pstDepartment.setServiceName(ServiceConstant.PST_DEPARTMENT_SAVE);
	        VResultMessage resultMessage = postMessage(pstDepartment, pstDepartment.getClass().getName(), "pstDepartment", true);
	        pstDepartment = (PstDepartment)resultMessage.getResultListObj().get(0);
	        return pstDepartment.getPdId();
		}

		@Override
		public int updatePstDepartment(PstDepartment pstDepartment) {
			// TODO Auto-generated method stub
			pstDepartment.setServiceName(ServiceConstant.PST_DEPARTMENT_UPDATE);
	        VResultMessage resultMessage = postMessage(pstDepartment, pstDepartment.getClass().getName(), "pstDepartment", true);
	        pstDepartment = (PstDepartment)resultMessage.getResultListObj().get(0);
	        return pstDepartment.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstDepartment(PstDepartment pstDepartment,
				String service) {
			// TODO Auto-generated method stub
			pstDepartment.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstDepartment, pstDepartment.getClass().getName(), "pstDepartment", true);
	        pstDepartment = (PstDepartment)resultMessage.getResultListObj().get(0);
	        return pstDepartment.getUpdateRecord().intValue();
		}

		@Override
		public PstDepartment findPstDepartmentById(Long long1) {
			// TODO Auto-generated method stub
			PstDepartment pstDepartment = new PstDepartment();
			pstDepartment.setPdId(long1);
			pstDepartment.setServiceName(ServiceConstant.PST_DEPARTMENT_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstDepartment, pstDepartment.getClass().getName(), "pstDepartment", true);
	        return (PstDepartment)resultMessage.getResultListObj().get(0);
		}

		@Override
		public VResultMessage searchPstWorkType(PstWorkType pstWorkType) {
			// TODO Auto-generated method stub
			pstWorkType.setServiceName(ServiceConstant.PST_WORK_TYPE_SEARCH);
		    return postMessage(pstWorkType, pstWorkType.getClass().getName(), "pstWorkType", true);
		}

		@Override
		public Long savePstWorkType(PstWorkType pstWorkType) {
			// TODO Auto-generated method stub
			pstWorkType.setServiceName(ServiceConstant.PST_WORK_TYPE_SAVE);
	        VResultMessage resultMessage = postMessage(pstWorkType, pstWorkType.getClass().getName(), "pstWorkType", true);
	        pstWorkType = (PstWorkType)resultMessage.getResultListObj().get(0);
	        return pstWorkType.getPwtId();
		}

		@Override
		public int updatePstWorkType(PstWorkType pstWorkType) {
			// TODO Auto-generated method stub
			pstWorkType.setServiceName(ServiceConstant.PST_WORK_TYPE_UPDATE);
	        VResultMessage resultMessage = postMessage(pstWorkType, pstWorkType.getClass().getName(), "pstWorkType", true);
	        pstWorkType = (PstWorkType)resultMessage.getResultListObj().get(0);
	        return pstWorkType.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstWorkType(PstWorkType pstWorkType, String service) {
			// TODO Auto-generated method stub
			pstWorkType.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstWorkType, pstWorkType.getClass().getName(), "pstWorkType", true);
	        pstWorkType = (PstWorkType)resultMessage.getResultListObj().get(0);
	        return pstWorkType.getUpdateRecord().intValue();
		}

		@Override
		public PstWorkType findPstWorkTypeById(Long long1) {
			// TODO Auto-generated method stub
			PstWorkType pstWorkType = new PstWorkType();
	    	pstWorkType.setPwtId(long1);
	    	pstWorkType.setServiceName(ServiceConstant.PST_WORK_TYPE_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstWorkType, pstWorkType.getClass().getName(), "pstWorkType", true);
	        return (PstWorkType)resultMessage.getResultListObj().get(0);
		}

		@Override
		public VResultMessage searchPstRoadPumpStatus(
				PstRoadPumpStatus pstRoadPumpStatus) {
			// TODO Auto-generated method stub
			pstRoadPumpStatus.setServiceName(ServiceConstant.PST_ROAD_PUMP_STATUS_SEARCH);
		    return postMessage(pstRoadPumpStatus, pstRoadPumpStatus.getClass().getName(), "pstRoadPumpStatus", true);
		}

		@Override
		public Long savePstRoadPumpStatus(PstRoadPumpStatus pstRoadPumpStatus) {
			// TODO Auto-generated method stub
			pstRoadPumpStatus.setServiceName(ServiceConstant.PST_ROAD_PUMP_STATUS_SAVE);
	        VResultMessage resultMessage = postMessage(pstRoadPumpStatus, pstRoadPumpStatus.getClass().getName(), "pstRoadPumpStatus", true);
	        pstRoadPumpStatus = (PstRoadPumpStatus)resultMessage.getResultListObj().get(0);
	        return pstRoadPumpStatus.getPrpsId();
		}

		@Override
		public int updatePstRoadPumpStatus(PstRoadPumpStatus pstRoadPumpStatus) {
			// TODO Auto-generated method stub
			pstRoadPumpStatus.setServiceName(ServiceConstant.PST_ROAD_PUMP_STATUS_UPDATE);
	        VResultMessage resultMessage = postMessage(pstRoadPumpStatus, pstRoadPumpStatus.getClass().getName(), "pstRoadPumpStatus", true);
	        pstRoadPumpStatus = (PstRoadPumpStatus)resultMessage.getResultListObj().get(0);
	        return pstRoadPumpStatus.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstRoadPumpStatus(PstRoadPumpStatus pstRoadPumpStatus,
				String service) {
			// TODO Auto-generated method stub
			pstRoadPumpStatus.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstRoadPumpStatus, pstRoadPumpStatus.getClass().getName(), "pstRoadPumpStatus", true);
	        pstRoadPumpStatus = (PstRoadPumpStatus)resultMessage.getResultListObj().get(0);
	        return pstRoadPumpStatus.getUpdateRecord().intValue();
		}

		@Override
		public PstRoadPumpStatus findPstRoadPumpStatusById(Long long1) {
			// TODO Auto-generated method stub
			PstRoadPumpStatus pstRoadPumpStatus = new PstRoadPumpStatus();
	    	pstRoadPumpStatus.setPrpsId(long1);
	    	pstRoadPumpStatus.setServiceName(ServiceConstant.PST_ROAD_PUMP_STATUS_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstRoadPumpStatus, pstRoadPumpStatus.getClass().getName(), "pstRoadPumpStatus", true);
	        return (PstRoadPumpStatus)resultMessage.getResultListObj().get(0);
		}

		@Override
		public VResultMessage searchPstModel(PstModel pstModel) {
			// TODO Auto-generated method stub
			pstModel.setServiceName(ServiceConstant.PST_MODEL_SEARCH);
		    return postMessage(pstModel, pstModel.getClass().getName(), "pstModel", true);
		}

		@Override
		public Long savePstModel(PstModel pstModel) {
			// TODO Auto-generated method stub
			pstModel.setServiceName(ServiceConstant.PST_MODEL_SAVE);
	        VResultMessage resultMessage = postMessage(pstModel, pstModel.getClass().getName(), "pstModel", true);
	        pstModel = (PstModel)resultMessage.getResultListObj().get(0);
	        return pstModel.getPmId();
		}

		@Override
		public int updatePstModel(PstModel pstModel) {
			// TODO Auto-generated method stub
			pstModel.setServiceName(ServiceConstant.PST_MODEL_UPDATE);
	        VResultMessage resultMessage = postMessage(pstModel, pstModel.getClass().getName(), "pstModel", true);
	        pstModel = (PstModel)resultMessage.getResultListObj().get(0);
	        return pstModel.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstModel(PstModel pstModel, String service) {
			// TODO Auto-generated method stub
			pstModel.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstModel, pstModel.getClass().getName(), "pstModel", true);
	        pstModel = (PstModel)resultMessage.getResultListObj().get(0);
	        return pstModel.getUpdateRecord().intValue();
		}

		@Override
		public PstModel findPstModelById(Long long1) {
			// TODO Auto-generated method stub
			PstModel pstModel = new PstModel();
	    	pstModel.setPmId(long1);
	    	pstModel.setServiceName(ServiceConstant.PST_MODEL_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstModel, pstModel.getClass().getName(), "pstModel", true);
	        return (PstModel)resultMessage.getResultListObj().get(0);
		}

		@Override
		public VResultMessage searchPstBrand(PstBrand pstBrand) {
			// TODO Auto-generated method stub
			pstBrand.setServiceName(ServiceConstant.PST_BRAND_SEARCH);
		    return postMessage(pstBrand, pstBrand.getClass().getName(), "pstBrand", true);
		}

		@Override
		public Long savePstBrand(PstBrand pstBrand) {
			// TODO Auto-generated method stub
			pstBrand.setServiceName(ServiceConstant.PST_BRAND_SAVE);
	        VResultMessage resultMessage = postMessage(pstBrand, pstBrand.getClass().getName(), "pstBrand", true);
	        pstBrand = (PstBrand)resultMessage.getResultListObj().get(0);
	        return pstBrand.getPbId();
		}

		@Override
		public int updatePstBrand(PstBrand pstBrand) {
			// TODO Auto-generated method stub
			pstBrand.setServiceName(ServiceConstant.PST_BRAND_UPDATE);
	        VResultMessage resultMessage = postMessage(pstBrand, pstBrand.getClass().getName(), "pstBrand", true);
	        pstBrand = (PstBrand)resultMessage.getResultListObj().get(0);
	        return pstBrand.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstBrand(PstBrand pstBrand, String service) {
			// TODO Auto-generated method stub
			pstBrand.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstBrand, pstBrand.getClass().getName(), "pstBrand", true);
	        pstBrand = (PstBrand)resultMessage.getResultListObj().get(0);
	        return pstBrand.getUpdateRecord().intValue();
		}

		@Override
		public PstBrand findPstBrandById(Long long1) {
			// TODO Auto-generated method stub
			PstBrand pstBrand = new PstBrand();
	    	pstBrand.setPbId(long1);
	    	pstBrand.setServiceName(ServiceConstant.PST_BRAND_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstBrand, pstBrand.getClass().getName(), "pstBrand", true);
	        return (PstBrand)resultMessage.getResultListObj().get(0);
		}

		@Override
		public VResultMessage searchUser(User user) {
			// TODO Auto-generated method stub
			user.setServiceName(ServiceConstant.USER_SEARCH);
		    return postMessage(user, user.getClass().getName(), "user", true);
		}

		@Override
		public Long saveUser(User user) {
			// TODO Auto-generated method stub
			user.setServiceName(ServiceConstant.USER_SAVE);
	        VResultMessage resultMessage = postMessage(user, user.getClass().getName(), "user", true);
	        user = (User)resultMessage.getResultListObj().get(0);
	        return user.getId();
		}

		@Override
		public int updateUser(User user) {
			// TODO Auto-generated method stub
			user.setServiceName(ServiceConstant.USER_UPDATE);
	        VResultMessage resultMessage = postMessage(user, user.getClass().getName(), "user", true);
	        user = (User)resultMessage.getResultListObj().get(0);
	        return user.getUpdateRecord().intValue();
		}

		@Override
		public int deleteUser(User user, String service) {
			// TODO Auto-generated method stub
			user.setServiceName(service);
	        VResultMessage resultMessage = postMessage(user, user.getClass().getName(), "user", true);
	        user = (User)resultMessage.getResultListObj().get(0);
	        return user.getUpdateRecord().intValue();
		}

		@Override
		public User findUserById(Long long1) {
			// TODO Auto-generated method stub
			User user = new User();
			user.setId(long1);
			user.setServiceName(ServiceConstant.USER_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(user, user.getClass().getName(), "user", true);
	        return (User)resultMessage.getResultListObj().get(0);
		}

		@Override
		public List listPstRoadPumpTypees() {
			// TODO Auto-generated method stub
			PstRoadPumpType pstRoadPumpType = new PstRoadPumpType();
			pstRoadPumpType.setServiceName(ServiceConstant.PST_ROAD_PUMP_TYPE_LIST);
		        VResultMessage resultMessage = postMessage(pstRoadPumpType, pstRoadPumpType.getClass().getName(), "pstRoadPumpType", true);
		        return resultMessage.getResultListObj();
		}

		@Override
		public VResultMessage searchPstRoadPumpType(
				PstRoadPumpType pstRoadPumpType) {
			// TODO Auto-generated method stub
			pstRoadPumpType.setServiceName(ServiceConstant.PST_ROAD_PUMP_TYPE_SEARCH);
		    return postMessage(pstRoadPumpType, pstRoadPumpType.getClass().getName(), "pstRoadPumpType", true);
		}

		@Override
		public Long savePstRoadPumpType(PstRoadPumpType pstRoadPumpType) {
			pstRoadPumpType.setServiceName(ServiceConstant.PST_ROAD_PUMP_TYPE_SAVE);
	        VResultMessage resultMessage = postMessage(pstRoadPumpType, pstRoadPumpType.getClass().getName(), "pstRoadPumpType", true);
	        pstRoadPumpType = (PstRoadPumpType)resultMessage.getResultListObj().get(0);
	        return pstRoadPumpType.getPrptId();
		}

		@Override
		public int updatePstRoadPumpType(PstRoadPumpType pstRoadPumpType) {
			// TODO Auto-generated method stub
			pstRoadPumpType.setServiceName(ServiceConstant.PST_ROAD_PUMP_TYPE_UPDATE);
	        VResultMessage resultMessage = postMessage(pstRoadPumpType, pstRoadPumpType.getClass().getName(), "pstRoadPumpType", true);
	        pstRoadPumpType = (PstRoadPumpType)resultMessage.getResultListObj().get(0);
	        return pstRoadPumpType.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstRoadPumpType(PstRoadPumpType pstRoadPumpType,
				String service) {
			// TODO Auto-generated method stub
			pstRoadPumpType.setServiceName(service);
			VResultMessage resultMessage = postMessage(pstRoadPumpType, pstRoadPumpType.getClass().getName(), "pstRoadPumpType", true);
			pstRoadPumpType = (PstRoadPumpType)resultMessage.getResultListObj().get(0);
			return pstRoadPumpType.getUpdateRecord().intValue();
		}

		@Override
		public PstRoadPumpType findPstRoadPumpTypeById(Long long1) {
			PstRoadPumpType pstRoadPumpType = new PstRoadPumpType();
	    	pstRoadPumpType.setPrptId(long1);
	    	pstRoadPumpType.setServiceName(ServiceConstant.PST_ROAD_PUMP_TYPE_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstRoadPumpType, pstRoadPumpType.getClass().getName(), "pstRoadPumpType", true);
	        return (PstRoadPumpType)resultMessage.getResultListObj().get(0);
		}

		@Override
		public int executeMaintenance(PstMaintenance[] pstMaintenanceArray,
				PstMaintenanceTran pstMaintenanceTran, String mode) {
			// TODO Auto-generated method stub
			PstObject pstObject = new PstObject(); 	
			pstObject.setPstMaintenanceArray(pstMaintenanceArray);
			pstObject.setPstMaintenanceTran(pstMaintenanceTran);
			pstObject.setMode(mode);
			pstObject.setServiceName(ServiceConstant.PST_OBJECT_EXECUTE_MAINTENANCE);
		        VResultMessage resultMessage = postMessage(pstObject, pstObject.getClass().getName(), "pstObject", true); 
		        pstObject = (PstObject)resultMessage.getResultListObj().get(0);
		        return pstObject.getUpdateRecord().intValue(); 
		}

		@Override
		public VResultMessage searchPstCustomer(PstCustomer pstCustomer) {
			// TODO Auto-generated method stub
			pstCustomer.setServiceName(ServiceConstant.PST_CUSTOMER_SEARCH);
		    return postMessage(pstCustomer, pstCustomer.getClass().getName(), "pstCustomer", true);
		}

		@Override
		public Long savePstCustomer(PstCustomer pstCustomer) {
			// TODO Auto-generated method stub
			pstCustomer.setServiceName(ServiceConstant.PST_CUSTOMER_SAVE);
	        VResultMessage resultMessage = postMessage(pstCustomer, pstCustomer.getClass().getName(), "pstCustomer", true);
	        pstCustomer = (PstCustomer)resultMessage.getResultListObj().get(0);
	        return pstCustomer.getPcId();
		}

		@Override
		public int updatePstCustomer(PstCustomer pstCustomer) {
			// TODO Auto-generated method stub
			pstCustomer.setServiceName(ServiceConstant.PST_CUSTOMER_UPDATE);
	        VResultMessage resultMessage = postMessage(pstCustomer, pstCustomer.getClass().getName(), "pstCustomer", true);
	        pstCustomer = (PstCustomer)resultMessage.getResultListObj().get(0);
	        return pstCustomer.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstCustomer(PstCustomer pstCustomer, String service) {
			// TODO Auto-generated method stub
			pstCustomer.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstCustomer, pstCustomer.getClass().getName(), "pstCustomer", true);
	        pstCustomer = (PstCustomer)resultMessage.getResultListObj().get(0);
	        return pstCustomer.getUpdateRecord().intValue();
		}

		@Override
		public PstCustomer findPstCustomerById(Long long1) {
			// TODO Auto-generated method stub
			 	PstCustomer pstCustomer = new PstCustomer();
			pstCustomer.setPcId(long1);
			pstCustomer.setServiceName(ServiceConstant.PST_CUSTOMER_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstCustomer, pstCustomer.getClass().getName(), "pstCustomer", true);
	        return (PstCustomer)resultMessage.getResultListObj().get(0);
		}

		@Override
		public VResultMessage searchPstCustomerDivision(
				PstCustomerDivision pstCustomerDivision) {
			// TODO Auto-generated method stub
			pstCustomerDivision.setServiceName(ServiceConstant.PST_CUSTOMER_DIVISION_SEARCH);
		    return postMessage(pstCustomerDivision, pstCustomerDivision.getClass().getName(), "pstCustomerDivision", true);
		}

		@Override
		public Long savePstCustomerDivision(
				PstCustomerDivision pstCustomerDivision) {
			// TODO Auto-generated method stub
			pstCustomerDivision.setServiceName(ServiceConstant.PST_CUSTOMER_DIVISION_SAVE);
	        VResultMessage resultMessage = postMessage(pstCustomerDivision, pstCustomerDivision.getClass().getName(), "pstCustomerDivision", true);
	        pstCustomerDivision = (PstCustomerDivision)resultMessage.getResultListObj().get(0);
	        return pstCustomerDivision.getPcdId();
		}

		@Override
		public int updatePstCustomerDivision(
				PstCustomerDivision pstCustomerDivision) {
			// TODO Auto-generated method stub
			pstCustomerDivision.setServiceName(ServiceConstant.PST_CUSTOMER_DIVISION_UPDATE);
	        VResultMessage resultMessage = postMessage(pstCustomerDivision, pstCustomerDivision.getClass().getName(), "pstCustomerDivision", true);
	        pstCustomerDivision = (PstCustomerDivision)resultMessage.getResultListObj().get(0);
	        return pstCustomerDivision.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstCustomerDivision(
				PstCustomerDivision pstCustomerDivision, String service) {
			// TODO Auto-generated method stub
			pstCustomerDivision.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstCustomerDivision, pstCustomerDivision.getClass().getName(), "pstCustomerDivision", true);
	        pstCustomerDivision = (PstCustomerDivision)resultMessage.getResultListObj().get(0);
	        return pstCustomerDivision.getUpdateRecord().intValue();
		}

		@Override
		public PstCustomerDivision findPstCustomerDivisionById(Long long1) {
			// TODO Auto-generated method stub
			PstCustomerDivision pstCustomerDivision = new PstCustomerDivision();
			pstCustomerDivision.setPcdId(long1);
			pstCustomerDivision.setServiceName(ServiceConstant.PST_CUSTOMER_DIVISION_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstCustomerDivision, pstCustomerDivision.getClass().getName(), "pstCustomerDivision", true);
	        return (PstCustomerDivision)resultMessage.getResultListObj().get(0);
		}

		@Override
		public VResultMessage searchPstCustomerContact(
				PstCustomerContact pstCustomerContact) {
			// TODO Auto-generated method stub
			pstCustomerContact.setServiceName(ServiceConstant.PST_CUSTOMER_CONTACT_SEARCH);
		    return postMessage(pstCustomerContact, pstCustomerContact.getClass().getName(), "pstCustomerContact", true);
		}

		@Override
		public Long savePstCustomerContact(PstCustomerContact pstCustomerContact) {
			// TODO Auto-generated method stub
			pstCustomerContact.setServiceName(ServiceConstant.PST_CUSTOMER_CONTACT_SAVE);
	        VResultMessage resultMessage = postMessage(pstCustomerContact, pstCustomerContact.getClass().getName(), "pstCustomerContact", true);
	        pstCustomerContact = (PstCustomerContact)resultMessage.getResultListObj().get(0);
	        return pstCustomerContact.getPccId();
		}

		@Override
		public int updatePstCustomerContact(
				PstCustomerContact pstCustomerContact) {
			// TODO Auto-generated method stub
			pstCustomerContact.setServiceName(ServiceConstant.PST_CUSTOMER_CONTACT_UPDATE);
	        VResultMessage resultMessage = postMessage(pstCustomerContact, pstCustomerContact.getClass().getName(), "pstCustomerContact", true);
	        pstCustomerContact = (PstCustomerContact)resultMessage.getResultListObj().get(0);
	        return pstCustomerContact.getUpdateRecord().intValue();
		}

		@Override
		public int deletePstCustomerContact(
				PstCustomerContact pstCustomerContact, String service) {
			// TODO Auto-generated method stub
			pstCustomerContact.setServiceName(service);
	        VResultMessage resultMessage = postMessage(pstCustomerContact, pstCustomerContact.getClass().getName(), "pstCustomerContact", true);
	        pstCustomerContact = (PstCustomerContact)resultMessage.getResultListObj().get(0);
	        return pstCustomerContact.getUpdateRecord().intValue();
		}

		@Override
		public PstCustomerContact findPstCustomerContactById(Long long1) {
			// TODO Auto-generated method stub
			PstCustomerContact pstCustomerContact = new PstCustomerContact();
			pstCustomerContact.setPccId(long1);
			pstCustomerContact.setServiceName(ServiceConstant.PST_CUSTOMER_CONTACT_FIND_BY_ID);
	        VResultMessage resultMessage = postMessage(pstCustomerContact, pstCustomerContact.getClass().getName(), "pstCustomerContact", true);
	        return (PstCustomerContact)resultMessage.getResultListObj().get(0);
		}
		
		 
}
