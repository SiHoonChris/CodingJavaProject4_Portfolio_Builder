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
	} // END - public DataDAO()

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
			
			// 출력 시 KR 제외한 부분만 출력
			
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

	} // END - public void ListEmAll()
	
	// ----------------------------------------
	// 2. 동일 가중방식 구현
	// ----------------------------------------	
	
	
} // END - public class DataDAO{}