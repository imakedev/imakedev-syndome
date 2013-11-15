package th.co.imake.syndome.bpm.managers;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.xstream.ServiceReport;

public interface ServiceReportService {
	public ServiceReport findServiceReport(String mode,String month,String year) throws DataAccessException ;
}
