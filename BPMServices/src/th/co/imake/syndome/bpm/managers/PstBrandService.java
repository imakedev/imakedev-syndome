package th.co.imake.syndome.bpm.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.imake.syndome.bpm.hibernate.bean.PstBrand;
import th.co.imake.syndome.bpm.xstream.common.Pagging;

public interface PstBrandService {
	@SuppressWarnings("rawtypes")
	public  List searchPstBrand(PstBrand persistentInstance,	Pagging pagging)throws DataAccessException  ;
}
