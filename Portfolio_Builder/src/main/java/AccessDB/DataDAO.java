package AccessDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DataDAO {
	private DataSource        dataFactory;
	private Connection        conn;
	private PreparedStatement pstmt;
	private ResultSet         rs;
	
	private List<DataDTO> wholeAssets = new ArrayList<DataDTO>();
	int listSize;
	
	
	// ----------------------------------------
	// 0. DB와의 연결통로 생성
	// ----------------------------------------
	public DataDAO() {
		try {
			Context ctx = new InitialContext();
			Context env = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) env.lookup("jdbc/mysql");
		} catch(Exception e) {
			e.printStackTrace();
		}
	} // public DataDAO()

	// ----------------------------------------
	// 1. 선택 가능한 종목 전체 가져오기
	// ----------------------------------------
	public ArrayList<String> ListEmAll() {
		
		ArrayList<String> info = new ArrayList<String>();
		String list="";
		String numberOfAssets="";
		
		try {
			conn = dataFactory.getConnection();

			String query = "SELECT * FROM assets ";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				DataDTO dto = new DataDTO();
				dto.setCountry(rs.getString("country"));
				dto.setName(rs.getString("name"));
				dto.setCode_ticker(rs.getString("code_ticker"));
				wholeAssets.add(dto);
			}
			
			list="<tbody>";
			listSize=wholeAssets.size();
			for(int i=0; i<listSize; i++) {
				list += "<tr><td>";
				list += "<input type=\"checkbox\" name=\"TL_checkbox\" ";
				list += "id=\""+wholeAssets.get(i).code_ticker+"\" onclick=\"getCheckboxValue(event)\" /> ";
				list += "<span id=\"list-no"+(i+1)+"\" name=\""+wholeAssets.get(i).name+"\"> ";
				list += wholeAssets.get(i).code_ticker+"</span>";
				list += "</td></tr>";
			}
			list+="</tbody>";
			numberOfAssets=Integer.toString(listSize);
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		info.add(numberOfAssets);
		info.add(list);

		return info;

	} // public void ListEmAll()
	
	// ----------------------------------------
	// 2. 동일 가중방식 구현
	// ----------------------------------------	
	public String EqualWeightIndex(String forQuery) {
		List<DataDTO> statsForTable = new ArrayList<DataDTO>();
		String tableComponent="";
		
		try {
			conn = dataFactory.getConnection();
			
			String query
			= "SELECT stats.code_ticker , "
			+ "       assets.name , "
			+ "		  stats.Annual_AVG , "
			+ "       ( 1/(SELECT COUNT(code_ticker) FROM stats WHERE code_ticker IN ("+forQuery+")) ) AS proportion "
			+ "FROM stats, assets "
			+ "WHERE stats.code_ticker=assets.code_ticker "
			+ "      AND stats.code_ticker IN ("+forQuery+");";
			
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				DataDTO dto = new DataDTO();
				dto.setCode_ticker(rs.getString("code_ticker"));
				dto.setName(rs.getString("name"));
				dto.setAvg_yield(rs.getFloat("Annual_AVG"));
				dto.setProportion(rs.getFloat("proportion"));
				statsForTable.add(dto);
			}
			
			for(int i=0; i<statsForTable.size(); i++) {
				tableComponent += "<tr>";
				tableComponent += "<td id='No'>"+(i+1)+"</td>";
				tableComponent += "<td id='CodeTicker'>"+statsForTable.get(i).code_ticker+"</td>";
				tableComponent += "<td id='NameOfStock'>"+statsForTable.get(i).name+"</td>";
				tableComponent += "<td id='YieldRate'>"+statsForTable.get(i).avg_yield+"%</td>";
				tableComponent += "<td id='Porportion'>"+statsForTable.get(i).proportion+"%</td>";
				tableComponent += "</tr>";
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return tableComponent;
	} // public String EqualWeightIndex()
	
	// ----------------------------------------
	// 3. 시가총액 가중방식 구현
	// ----------------------------------------	
	public String CapitalizationWeightIndex(String forQuery) {
		List<DataDTO> statsForTable = new ArrayList<DataDTO>();
		String tableComponent="";
		
		try {
			conn = dataFactory.getConnection();
			
			String query 
			= "SELECT stats.code_ticker, "
			+ "       assets.name, "
			+ "       stats.Annual_AVG, "
			+ "       (Market_Cap/(SELECT SUM(Market_Cap) FROM stats WHERE stats.code_ticker IN ("+forQuery+"))) AS proportion "
			+ "FROM stats, assets "
			+ "WHERE stats.code_ticker=assets.code_ticker "
			+ "      AND stats.code_ticker "
			+ "      IN ("+forQuery+"); ";
			
			pstmt=conn.prepareStatement(query);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				DataDTO dto = new DataDTO();
				dto.setCode_ticker(rs.getString("code_ticker"));
				dto.setName(rs.getString("name"));
				dto.setAvg_yield(rs.getFloat("Annual_AVG"));
				dto.setProportion(rs.getFloat("proportion"));
				statsForTable.add(dto);
			}
			
			for(int i=0; i<statsForTable.size(); i++) {
				tableComponent += "<tr>";
				tableComponent += "<td id='No'>"+(i+1)+"</td>";
				tableComponent += "<td id='CodeTicker'>"+statsForTable.get(i).code_ticker+"</td>";
				tableComponent += "<td id='NameOfStock'>"+statsForTable.get(i).name+"</td>";
				tableComponent += "<td id='YieldRate'>"+statsForTable.get(i).avg_yield+"%</td>";
				tableComponent += "<td id='Porportion'>"+statsForTable.get(i).proportion+"%</td>";
				tableComponent += "</tr>";
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return tableComponent;
	} // public String CapitalizationWeightIndex()
	
	// ----------------------------------------
	// 4. SiHoonChris 가중방식 구현  *TSLA처럼 투자비중이 음수이면 어떻게 처리하지??
	// ----------------------------------------	
	public String SihoonChrisWeightIndex(String forQuery) {
		List<DataDTO> statsForTable = new ArrayList<DataDTO>();
		String tableComponent="";
		
		try {
			conn = dataFactory.getConnection();
			
			String query 
			= "SELECT stats.code_ticker, assets.name, stats.Adj_Annual_AVG, "
			+ "       IFNULL( "
			+ "	      ( "
			+ "		    ( "
			+ "		      ( (SELECT AVG(STDEV) FROM stats WHERE stats.code_ticker IN ("+forQuery+") AND STDEV < 2*(SELECT AVG(STDEV) FROM stats)) "
			+ "			     + ( (SELECT AVG(STDEV) FROM stats WHERE stats.code_ticker IN ("+forQuery+") AND STDEV < 2*(SELECT AVG(STDEV) FROM stats)) "
			+ "                    - (SELECT STDEV FROM stats WHERE stats.code_ticker=assets.code_ticker AND STDEV < 2*(SELECT AVG(STDEV) FROM stats)) "
			+ "				   ) "
			+ "	  	      ) / ( SELECT AVG(STDEV) FROM stats WHERE stats.code_ticker IN ("+forQuery+") AND STDEV < 2*(SELECT AVG(STDEV) FROM stats) ) "
			+ "		    ) "
			+ "         * "
			+ "         ( 1 / "
			+ "           ( SELECT COUNT(code_ticker) FROM stats WHERE stats.code_ticker IN ("+forQuery+") AND STDEV < 2*(SELECT AVG(STDEV) FROM stats) ) "
			+ "		    ) "
			+ "       ), 0 ) AS proportion "
			+ "FROM stats, assets "
			+ "WHERE stats.code_ticker=assets.code_ticker "
			+ "AND stats.code_ticker "
			+ "IN ("+forQuery+"); ";
			
			pstmt=conn.prepareStatement(query);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				DataDTO dto = new DataDTO();
				dto.setCode_ticker(rs.getString("code_ticker"));
				dto.setName(rs.getString("name"));
				dto.setAvg_yield(rs.getFloat("Adj_Annual_AVG"));
				dto.setProportion(rs.getFloat("proportion"));
				statsForTable.add(dto);
			}
			
			for(int i=0; i<statsForTable.size(); i++) {
				tableComponent += "<tr>";
				tableComponent += "<td id='No'>"+(i+1)+"</td>";
				tableComponent += "<td id='CodeTicker'>"+statsForTable.get(i).code_ticker+"</td>";
				tableComponent += "<td id='NameOfStock'>"+statsForTable.get(i).name+"</td>";
				tableComponent += "<td id='YieldRate'>"+statsForTable.get(i).avg_yield+"%</td>";
				tableComponent += "<td id='Porportion'>"+statsForTable.get(i).proportion+"%</td>";
				tableComponent += "</tr>";
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return tableComponent;
	} // public String SihoonChrisWeightIndex()
	
	
} // END - public class DataDAO{}