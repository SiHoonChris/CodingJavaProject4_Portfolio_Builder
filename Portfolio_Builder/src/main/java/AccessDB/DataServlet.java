package AccessDB;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//@WebServlet("/tester")
public class DataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public int range=0;
	
	public ArrayList<String> ShowAll() {
		DataDAO dao = new DataDAO();
		ArrayList<String> AllAssets = dao.ListEmAll();
		range = dao.listSize;
		System.out.println("[전체 종목 수 : "+range+"]");
		
		return AllAssets;
	} // END - public String ShowAll()
	
	
	public void init() throws ServletException {
	} // END - public void init() throws ServletException{}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {doHandle(request, response);}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {doHandle(request, response);}

	// 버튼 클릭에 따른 실행 상황 정의(SQL 관련 작업)
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	} // END - protected void doHandle(request, response) throws Exceptions
	
	
} //END - public class DataServlet{}