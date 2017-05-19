package com.athena.ckx.module.xuqjs.service;

import java.util.ArrayList;

import com.athena.ckx.entity.xuqjs.Gongcy;
import com.athena.ckx.entity.xuqjs.GongysRouxbl;
import com.athena.ckx.util.DBUtil;
import com.athena.ckx.util.DateTimeUtil;
import com.athena.ckx.util.GetMessageByKey;
import com.athena.component.service.BaseService;
import com.athena.db.ConstantDbCode;
import com.athena.util.exception.ServiceException;
import com.toft.core3.container.annotation.Component;
import com.toft.core3.transaction.annotation.Transactional;

/**
 * 供应商-柔性比例Service
 * @author qizhongtao
 * @date 2012-4-09
 */
@Component
public class GongysRouxblService extends BaseService<GongysRouxbl>{
	/**
	 * 获取命名空间
	 * */
	@Override
	protected String getNamespace() {
		return "ts_ckx";
	}
	
	/**
	 * 批量数据保存
	 * @author qizhongtao
	 * @date 2012-4-09
	 * @param insert,edit,delete,userName
	 * @return String
	 * */
	@Transactional
	public String save(ArrayList<GongysRouxbl> insert,ArrayList<GongysRouxbl> edit,ArrayList<GongysRouxbl> delete,String userName)throws ServiceException{
		if(0 == insert.size()&&0 == edit.size()&&0 == delete.size()){
			return "null";
		}else{
			inserts(insert,userName);
			edits(edit,userName);
			deletes(delete,userName);
		}
		return "success";
	}
	/**
	 * 批量insert
	 * @author qizhongtao
	 * @date 2012-4-09
	 * @param insert,userName
	 * @return ""
	 * */
	@Transactional
	public String inserts(ArrayList<GongysRouxbl> insert,String userName)throws ServiceException{
		for (GongysRouxbl bean : insert) {
			
			//供应商编号是否存在
//			String sql = "select count(*) from "+DBUtilRemove.getdbSchemal()+"ckx_gongys where usercenter = '"+bean.getUsercenter()+"' and gcbh = '"+bean.getGongysbh()+"' and leix in( '1', '2') and biaos = '1'";
//			DBUtilRemove.checkBH(sql,GetMessageByKey.getMessage("gongyisbh")+bean.getGongysbh()+GetMessageByKey.getMessage("notexist"));
			Gongcy gongcy = new Gongcy();
			gongcy.setUsercenter(bean.getUsercenter());
			gongcy.setGcbh(bean.getGongysbh());
			gongcy.setLeix("3");
			gongcy.setBiaos("1");
			DBUtil.checkCount(baseDao, "ts_ckx.getCountGongys", gongcy, GetMessageByKey.getMessage("gongyisbh")+bean.getGongysbh()+GetMessageByKey.getMessage("notexist"));
			bean.setCreator(userName);
			bean.setCreate_time(DateTimeUtil.getAllCurrTime());
			bean.setEditor(userName);
			bean.setEdit_time(DateTimeUtil.getAllCurrTime());
			baseDao.getSdcDataSource(ConstantDbCode.DATASOURCE_CKX).execute("ts_ckx.insertGongysRouxbl", bean);
		}
		return "";
	}
	/**
	 * 批量edit
	 * @author qizhongtao
	 * @date 2012-4-09
	 * @param edit,userName
	 * @return ""
	 * */
	@Transactional
	public String edits(ArrayList<GongysRouxbl> edit,String userName)throws ServiceException{
		for (GongysRouxbl bean : edit) {
			bean.setEditor(userName);
			bean.setEdit_time(DateTimeUtil.getAllCurrTime());
			baseDao.getSdcDataSource(ConstantDbCode.DATASOURCE_CKX).execute("ts_ckx.updateGongysRouxbl", bean);
		}
		return "";
	}
	/**
	 * 批量delete
	 * @author qizhongtao
	 * @date 2012-4-09
	 * @param delete,userName
	 * @return ""
	 * */
	@Transactional
	public String deletes(ArrayList<GongysRouxbl> delete,String userName)throws ServiceException{
		for (GongysRouxbl bean : delete) {
			bean.setEditor(userName);
			bean.setEdit_time(DateTimeUtil.getAllCurrTime());
			baseDao.getSdcDataSource(ConstantDbCode.DATASOURCE_CKX).execute("ts_ckx.deleteGongysRouxbl", bean);
		}
		return "";
	}
}