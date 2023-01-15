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
	
	// 웹페이지 실행시 DB 내에 저장된 종목들의 정보를 출력함
	public ArrayList<String> ShowAll() {
		DataDAO dao = new DataDAO();
		ArrayList<String> AllAssets = dao.ListEmAll();
		range = dao.listSize;
		System.out.println("[전체 종목 수 : "+range+"]");
		
		return AllAssets;
	} // END - public String ShowAll()
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {doHandle(request, response);}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {doHandle(request, response);}

	// 선택된 종목들(n개)과 선택된 포트폴리오 가중방법(1개)을 가지고 출력할 결과물을 생성
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	} // END - protected void doHandle(request, response) throws Exceptions
	
	
} //END - public class DataServlet{}