package com.athena.component.output;

import java.io.OutputStreamWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.athena.component.exchange.ParserException;
import com.athena.component.exchange.SpaceFinal;
import com.athena.component.exchange.config.DataParserConfig;
import com.athena.component.exchange.txt.TxtDataWriter;
import com.toft.core2.dao.database.DbUtils;

/**
 * 处理纠纷表 操作码为A25的结果集输出
 * 
 * @author chenlei
 * @vesion 1.0
 * @date 2012-4-19
 * lastModify  By 王冲, 2012-08-31 14:34  内容：注掉全部代码
 */
public class RkmxA25DataWriter extends TxtDataWriter {
	protected static Logger logger = Logger.getLogger(RkmxA25DataWriter.class);	//定义日志方法

	// 创建时间 格式为:yyyymmdd HH24:Mi:ss
	private String CJ_DATE;

	public RkmxA25DataWriter(DataParserConfig dataParserConfig) {
		super(dataParserConfig);
//
//		// 查找接口表的创建时间 将创建时间设置到变量中
//		CJ_DATE = get_CJ_DATE();
//
//		// 删除接口纠纷表表数据
//		deleteFxd();
//		// 将仓库中的纠纷表数据写入到接口对应表中
//		insertFxd();
	}

//	/**
//	 * 得到创建时间
//	 * 
//	 * @return
//	 */
//	private String get_CJ_DATE() {
//
//		String result = null;
//		try {
//			// 创建sql语句 查询
//			String sql = "select to_char(y.CREATE_TIME,'yyyymmdd HH24:Mi:ss') cj_date from "+SpaceFinal.spacename_ckx+".IN_CK_JIUFD y order by y.CREATE_TIME asc";
//			PreparedStatement st = interfaceConn.prepareStatement(sql);
//			ResultSet rs = st.executeQuery();
//
//			if (rs.next()) {
//				result = rs.getString("cj_date");
//			}
//
//		} catch (SQLException e) {
//			logger.error(e.getMessage());
//		}
//		return result;
//	}
//	
//	private List<Map<String,Object>> getBesinessDatas(){
//		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
//		
//		StringBuffer sb = new StringBuffer();	
//		sb.append("select USERCENTER, ");
//		sb.append("LIUSH, ");
//		sb.append("JIUFDH, ");
//		sb.append("UTH, ");
//		sb.append("BLH, ");
//		sb.append("ELH, ");
//		sb.append("PICH, ");
//		sb.append(" CANGKBH, ");
//		sb.append("ZICKBH, ");
//		sb.append("DANW, ");
//		sb.append("CHENGYSMC, ");
//		sb.append("JIUFSJ, ");
//		sb.append("CANGKGLYZ, ");
//		sb.append("SYSDATE, ");
//		sb.append("'0', ");
//		sb.append(" t.SHIJKCSL - t.lilkcsl, ");
//		sb.append("LINGJBH, ");
//		sb.append("GONGYSDM ");
//		sb.append("from "+SpaceFinal.spacename_ck+".CK_JIUFD t ");
//		sb.append("where t.SHIJKCSL - t.lilkcsl != 0 ");
//
//		// 添加条件 拿出 在最近一次创建时间和当前时间之间的数据
//		if (CJ_DATE == null) {
//			// 创建时间为空 则默认拿出当前之前的记录
//			sb.append(" and EDIT_TIME <= sysdate ");
//
//		} else {
//			// 不为空
//			sb.append("and EDIT_TIME >= to_date('" + CJ_DATE
//					+ "', 'yyyymmdd HH24:Mi:ss') ");
//			sb.append("and EDIT_TIME <= sysdate  ");
//		}
//
//		sb.append(" UNION (select USERCENTER, ");
//		sb.append(" LIUSH, ");
//		sb.append("JIUFDH, ");
//		sb.append(" UTH, ");
//		sb.append(" BLH, ");
//		sb.append(" ELH, ");
//		sb.append(" PICH, ");
//		sb.append(" CANGKBH, ");
//		sb.append(" ZICKBH, ");
//		sb.append(" DANW, ");
//		sb.append(" CHENGYSMC, ");
//		sb.append(" JIUFSJ, ");
//		sb.append("CANGKGLYZ, ");
//		sb.append(" SYSDATE, ");
//		sb.append(" '0', ");
//		sb.append(" SHIJLJSL, ");
//		sb.append(" SHIJLJBH, ");
//		sb.append(" SHIJGYSBH ");
//		sb.append("from "+SpaceFinal.spacename_ck+".CK_JIUFD t ");
//		sb.append("where t.SHIJLJBH IS NOT NULL ");
//
//		// 添加条件 拿出 在最近一次创建时间和当前时间之间的数据
//		if (CJ_DATE == null) {
//			// 创建时间为空 则默认拿出当前之前的记录
//			sb.append(" and EDIT_TIME <= sysdate )");
//
//		} else {
//			// 不为空
//			sb.append("and EDIT_TIME >= to_date('" + CJ_DATE
//					+ "', 'yyyymmdd HH24:Mi:ss') ");
//			sb.append("and EDIT_TIME <= sysdate )");
//		}
//		
//		try {
//			PreparedStatement st = businessConn.prepareStatement(sb.toString());
//			ResultSet rs = st.executeQuery();
//			
//			while(rs!=null&&rs.next()){
//				Map<String,Object> result = new HashMap<String,Object>();			
//				result.put("USERCENTER", rs.getObject(1));
//				result.put("LIUSH", rs.getObject(2));
//				result.put("JIUFDH", rs.getObject(3));
//				result.put("UTH", rs.getObject(4));
//				result.put("BLH", rs.getObject(5));				
//				result.put("ELH", rs.getObject(6));				
//				result.put("PICH", rs.getObject(7));				
//				result.put("CANGKBH", rs.getObject(8));				
//				result.put("ZICKBH", rs.getObject(9));				
//				result.put("DANW", rs.getObject(10));			
//				result.put("CHENGYSMC", rs.getObject(11));
//				result.put("JIUFSJ", rs.getObject(12));
//				result.put("CANGKGLYZ", rs.getObject(13));
//				result.put("SYSDATE", rs.getObject(14));				
//				result.put("CLBZ", rs.getObject(15));
//				result.put("SHIJK", rs.getObject(16));
//				result.put("LINGJBH", rs.getObject(17));
//				result.put("GONGYSDM", rs.getObject(18));
//				list.add(result);
//			}
//			
//		} catch (SQLException e) {
//			logger.error(e.getMessage());
//		}		
//		return list;
//	}
//
//	// 将仓库中的纠纷表数据写入到接口对应表中
//	private void insertFxd() {
//		try{
//			//创建sql语句 查询
//			StringBuffer sb = new StringBuffer();
//			
//			sb.append("insert into "+SpaceFinal.spacename_ckx+".IN_CK_JIUFD ");
//			sb.append("(USERCENTER, ");
//			sb.append("LIUSH, ");
//			sb.append(" JIUFDH, ");
//			sb.append(" UTH, ");
//			sb.append(" BLH, ");
//			sb.append(" ELH, ");
//			sb.append("PICH, ");
//			sb.append(" CANGKBH, ");
//			sb.append("ZICKBH, ");
//			sb.append("DANW, ");
//			sb.append("CHENGYSMC, ");
//			sb.append("JIUFSJ, ");
//			sb.append(" CANGKGLYZ, ");
//			sb.append(" CREATE_TIME, ");
//			sb.append("CLZT, ");
//			sb.append("KUCSL, ");
//			sb.append(" LINGJBH, ");
//			sb.append(" GONGYSDM) ");
//			sb.append(" values( ");
//			for(int i=0;i<18;i++){
//				if(i!=17){
//					sb.append(" ?, ");
//				}else{
//					sb.append(" ? )");
//				}
//			}
//			
//			List<Map<String, Object>> resyltList = getBesinessDatas();
//			
//			if(getBesinessDatas().size()>0){
//				PreparedStatement st = interfaceConn.prepareStatement(sb.toString());
//				
//				for(Map map: resyltList){									
//					st.setObject(1, map.get("USERCENTER"));
//					st.setObject(2, map.get("LIUSH"));
//					st.setObject(3, map.get("JIUFDH"));
//					st.setObject(4, map.get("UTH"));
//					st.setObject(5, map.get("BLH"));
//					st.setObject(6, map.get("ELH"));
//					st.setObject(7, map.get("PICH"));
//					st.setObject(8, map.get("CANGKBH"));					
//					st.setObject(9, map.get("ZICKBH"));
//					st.setObject(10, map.get("DANW"));					
//					st.setObject(11, map.get("CHENGYSMC"));
//					st.setObject(12, map.get("JIUFSJ"));
//					st.setObject(13, map.get("CANGKGLYZ"));
//					st.setObject(14, map.get("SYSDATE"));
//					st.setObject(15, map.get("CLBZ"));
//					st.setObject(16, map.get("SHIJK"));
//					st.setObject(17, map.get("LINGJBH"));
//					st.setObject(18, map.get("GONGYSDM"));					
//					st.execute();
//				}
//				
//			}
//			
//		}catch(SQLException e){
//			logger.error(e.getMessage());
//		}			
//	}
//
//	/**
//	 * 为后面改造--读取配置文件的sql
//	 * 
//	 * @return
//	 */
////	private String createSQL() {
////		StringBuffer sb = new StringBuffer();
////
////		sb.append("insert into "+SpaceFinal.spacename_ckx+".IN_CK_JIUFD ");
////		sb.append("(USERCENTER, ");
////		sb.append("LIUSH, ");
////		sb.append(" JIUFDH, ");
////		sb.append(" UTH, ");
////		sb.append(" BLH, ");
////		sb.append(" ELH, ");
////		sb.append("PICH, ");
////		sb.append(" CANGKBH, ");
////		sb.append("ZICKBH, ");
////		sb.append("DANW, ");
////		sb.append("CHENGYSMC, ");
////		sb.append("JIUFSJ, ");
////		sb.append(" CANGKGLYZ, ");
////		sb.append(" CREATE_TIME, ");
////		sb.append("CLZT, ");
////		sb.append("KUCSL, ");
////		sb.append(" LINGJBH, ");
////		sb.append(" GONGYSDM) ");
////		sb.append("select USERCENTER, ");
////		sb.append("LIUSH, ");
////		sb.append("JIUFDH, ");
////		sb.append("UTH, ");
////		sb.append("BLH, ");
////		sb.append("ELH, ");
////		sb.append("PICH, ");
////		sb.append("CANGKBH, ");
////		sb.append(" ZICKBH, ");
////		sb.append("DANW, ");
////		sb.append("CHENGYSMC, ");
////		sb.append("JIUFSJ, ");
////		sb.append("CANGKGLYZ, ");
////		sb.append("SYSDATE, ");
////		sb.append("'0', ");
////		sb.append(" t.SHIJKCSL - t.lilkcsl, ");
////		sb.append("LINGJBH, ");
////		sb.append("GONGYSDM ");
////		sb.append("from "+SpaceFinal.spacename_ck+".CK_JIUFD t ");
////		sb.append("where t.SHIJKCSL - t.lilkcsl != 0 ");
////
////		// 添加条件 拿出 在最近一次创建时间和当前时间之间的数据
////		if (CJ_DATE == null) {
////			// 创建时间为空 则默认拿出当前之前的记录
////			sb.append(" and EDIT_TIME <= sysdate ");
////
////		} else {
////			// 不为空
////			sb.append("and EDIT_TIME >= to_date('" + CJ_DATE
////					+ "', 'yyyymmdd HH24:Mi:ss') ");
////			sb.append("and EDIT_TIME <= sysdate  ");
////		}
////
////		sb.append(" UNION (select USERCENTER, ");
////		sb.append(" LIUSH, ");
////		sb.append("JIUFDH, ");
////		sb.append(" UTH, ");
////		sb.append(" BLH, ");
////		sb.append(" ELH, ");
////		sb.append(" PICH, ");
////		sb.append(" CANGKBH, ");
////		sb.append(" ZICKBH, ");
////		sb.append(" DANW, ");
////		sb.append(" CHENGYSMC, ");
////		sb.append(" JIUFSJ, ");
////		sb.append("CANGKGLYZ, ");
////		sb.append(" SYSDATE, ");
////		sb.append(" '0', ");
////		sb.append(" SHIJLJSL, ");
////		sb.append(" SHIJLJBH, ");
////		sb.append(" SHIJGYSBH ");
////		sb.append("from "+SpaceFinal.spacename_ck+".CK_JIUFD t ");
////		sb.append("where t.SHIJLJBH IS NOT NULL ");
////
////		// 添加条件 拿出 在最近一次创建时间和当前时间之间的数据
////		if (CJ_DATE == null) {
////			// 创建时间为空 则默认拿出当前之前的记录
////			sb.append(" and EDIT_TIME <= sysdate )");
////
////		} else {
////			// 不为空
////			sb.append("and EDIT_TIME >= to_date('" + CJ_DATE
////					+ "', 'yyyymmdd HH24:Mi:ss') ");
////			sb.append("and EDIT_TIME <= sysdate )");
////		}
////		return sb.toString();
////	}
//
//	// 删除接口纠纷表表数据
//	private void deleteFxd() {
//		try {
//			// 创建sql语句 查询
//			String sql = "delete from "+SpaceFinal.spacename_ckx+".IN_CK_JIUFD";
//			PreparedStatement st = interfaceConn.prepareStatement(sql);
//			st.execute(sql);
//		} catch (SQLException e) {
//			logger.error(e.getMessage());
//		}
//	}

	/**
	 * 调用A25S
	 */
	@Override
	public void fileAfter(OutputStreamWriter out) {
		//关闭连接
		if(interfaceConn!=null){
			DbUtils.freeConnection(interfaceConn);
		}
		
		if(businessConn!=null){
			DbUtils.freeConnection(businessConn);
		}
//		setTotal(getTotal()+dataEchange.total) ;
		// 处理A35
		dataEchange.doExchange("2460_CKLSZ_BH_A35", out, getTotal(),dataParserConfig.getWriterConfigs()[0].getUsercenter());
		
	}
}
