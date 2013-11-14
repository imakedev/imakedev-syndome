package th.co.aoe.imake.pst.managers;

import java.util.List;

import org.springframework.dao.DataAccessException;

import th.co.aoe.imake.pst.hibernate.bean.PstBrand;
import th.co.aoe.imake.pst.xstream.common.Pagging;

public interface PstBrandService {
	@SuppressWarnings("rawtypes")
	public  List searchPstBrand(PstBrand persistentInstance,	Pagging pagging)throws DataAccessException  ;
}
