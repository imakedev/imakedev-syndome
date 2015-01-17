package th.co.imake.syndome.bpm.managers;

import org.springframework.dao.DataAccessException;

public interface BpmCallCenterService {

	public th.co.imake.syndome.bpm.xstream.BpmCallCenter findBpmCallCenterById(String bccNo)throws DataAccessException  ;
	public String saveBpmCallCenter(th.co.imake.syndome.bpm.hibernate.bean.BpmCallCenter transientInstance) throws DataAccessException;
	/*@SuppressWarnings("rawtypes")
	public  List searchCoopMessage(th.co.imake.syndome.bpm.hibernate.bean.BpmCallCenter persistentInstance ,Pagging paging)throws DataAccessException  ;
	
	
	@SuppressWarnings("rawtypes")
	public  List listCoopMessage(th.co.imake.vcoop.hibernate.bean.CoopMessage persistentInstance ,Paging paging)throws DataAccessException  ;
	public th.co.imake.syndome.bpm.xstream.CoopMessage findCoopMessageById(String caCardId,String token,Long cmId)throws DataAccessException  ;
	
	public int updateCoopMessage(th.co.imake.vcoop.hibernate.bean.CoopMessage transientInstance,byte[] pictureContent,String pictureExtension) throws DataAccessException ;
	public int deleteCoopMessage(th.co.imake.vcoop.hibernate.bean.CoopMessage persistentInstance) throws DataAccessException ;*/	
	
}
