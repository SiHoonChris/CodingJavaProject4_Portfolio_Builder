<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="AccessDB.DataServlet" %>
<%
DataServlet srv = new DataServlet(); 
String listOfAssets = srv.ShowAll();
%>

<!DOCTYPE html>
<!-- https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout/Box_Alignment_in_CSS_Grid_Layout -->
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width" initial-scale="1.0">
		<title>Build your Portfolio!</title>
		<link rel="stylesheet" type='text/css' href='PortfolioBuilder.css'>
		
		<script> // 테스트용 - 수정 예정
			function add_assets() { // 선택 종목 포트폴리오에 추가
				document.getElementById("selected").innerHTML='<tr><td><input type="checkbox"/> AAPL</td></tr>';
			}
			
			let asset = document.getElementById("eliminate");
			asset.addEventListener("mouseover", assetMouseOver);
			asset.addEventListener("mouseout", assetMouseOut);
			function assetMouseOver(){ // 마우스를 올리면 종목 코드/티커에 마우스 올리면 풀네임 보여줌
				document.getElementById("fullname").innerHTML="fullname";
			}
			function assetMouseOut(){ // 마우스가 나가면 기본 문자열 보여줌
				document.getElementById("fullname").innerHTML="종목명 상세";
			}	
		</script>
	</head>
	
	<body>
		<div class="container">
			<div id="stock" class="TL">
				<div class="select" align="center">
					<div class="type">		
						<input type="text" placeholder="티커 또는 종목코드 검색"/>
					</div>
					<!-- 따로 확인 버튼 없이, 입력된 결과에 해당하는 내용만 박스에 남김. 만약 없으면 찾는 결과가 없다고 출력 -->
					<!-- 데이터에 보유중인 종목 수 표시 -->
					<div class="scroll">
						<table>
							<%=listOfAssets %>
						</table>
					</div>
				</div>
				<!-- 선택한 종목 수 표시 -->
				<div class="selected" align="center">
					<div class="type">		
						<input type="text" placeholder="티커 또는 종목코드 검색"/>
					</div>
					<div class="scroll">
						<table id="selected">
						</table>
					</div>				
				</div>
				<div class="display">
					<h3 id="fullname">종목명 상세</h3>
					<!-- div(class="select") 내의 종목명에 마우스 올리면 div(class="display")에 종목 풀네임 출력 -->
					<!-- Full-name이 길어서 칸 밖으로 나가면 애니메이션 효과 적용, 전광판처럼 우에서 좌로 이동 -->
				</div>
				<div class="button">
					<div id="add">
						<button type="button" onclick="add_assets()">추가</button>
					</div>
					<div id="remove">
						<button id="eliminate">제거</button>
					</div>
					<div id="reset">
						<button>초기화</button>
						<!-- 초기화 버튼 클릭 시 alert 창 띄우기 : 재확인 -->
					</div>
				</div>
			</div>
			
  			<div class="TR">
  				<div id="table">표 : No. Ticker/Code 종목명 수익률 비중</div>
  				<span class="date">(업데이트 : 2022.12)</span>
  				<span class="time">(X.XXXXsec.)</span>
  			</div>
  			<div id="method" class="BL">
  				<div class="select">
  					<div class="title">포트폴리오 구성방식 선택</div>
  					<div class="scroll">
  						<table>
  							<tr>
  								<td>
  									<input type="radio"/>동일 가중평균
  								<td>
  								<td>
  									<input type="radio"/>시가총액 가중평균
  								<td>
  							</tr>
  							<tr>
  								<td>
  									<input type="radio"/>자체제작 방식
  								<td>
  								<td>
  									<input type="radio"/>뭐시기 가중평균
  								<td>
  							</tr>
  							<tr>
  								<td>
  									<input type="radio"/>동일 가중평균
  								<td>
  								<td>
  									<input type="radio"/>시가총액 가중평균
  								<td>
  							</tr>
  							<tr>
  								<td>
  									<input type="radio"/>자체제작 방식
  								<td>
  								<td>
  									<input type="radio"/>뭐시기 가중평균
  								<td>
  							</tr>
  							<tr>
  								<td>
  									<input type="radio"/>동일 가중평균
  								<td>
  								<td>
  									<input type="radio"/>시가총액 가중평균
  								<td>
  							</tr>
  							<tr>
  								<td>
  									<input type="radio"/>자체제작 방식
  								<td>
  								<td>
  									<input type="radio"/>뭐시기 가중평균
  								<td>
  							</tr>
  						</table>
  					</div>
  				</div>
  				<!-- 라디오버튼 적용 -->
  				<div class="selected">
  					<div>동일 가중평균</div>
  					<br/>
  					<div>포트폴리오 내의 모든 종목에 대해 같은 비율로 투자하는 것을 의미함</div>
  				</div>
  				<div class="button">
  					<button>실행</button>
  				</div>
  			</div>
  			<div id="chart" class="BR">
  				도넛모양 차트
  			</div>
  		</div>
	</body>
</html>