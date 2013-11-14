package th.co.aoe.imake.pst.managers;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.xstream.ServiceReport;

public interface ServiceReportService {
	public ServiceReport findServiceReport(String mode,String month,String year) throws DataAccessException ;
}
