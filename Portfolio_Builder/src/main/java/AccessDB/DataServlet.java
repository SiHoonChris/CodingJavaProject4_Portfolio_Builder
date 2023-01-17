package AccessDB;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/portfolio")
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
	
	public String Tester() {
		DataDAO dao = new DataDAO();
		String html = dao.EqualWeightIndex();
		return html;
	} // END - public String Tester()

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {doHandle(request, response);}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {doHandle(request, response);}

	// 선택된 종목들(n개)과 선택된 포트폴리오 가중방법(1개)을 가지고 출력할 결과물을 생성
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String weighing_method = request.getParameter("Method");
		
		if(weighing_method.equals("ewi")) {
			System.out.println(weighing_method);
			
			DataDAO dao = new DataDAO();
			String html_txt = dao.EqualWeightIndex();
			request.setAttribute("html_txt", html_txt);
			
			RequestDispatcher dispatcher
			= request.getRequestDispatcher("/PortfolioBuilder/PortfolioBuilder.jsp");
			dispatcher.forward(request, response);
		}
		
		else if(weighing_method.equals("cwi")) {
			System.out.println(weighing_method);
		}
		else if(weighing_method.equals("shcwi")) {
			System.out.println(weighing_method);
		}
		
	} // END - protected void doHandle(request, response) throws Exceptions
	
	
	
	
	
	
	
	
	
	
	
} //END - public class DataServlet{}