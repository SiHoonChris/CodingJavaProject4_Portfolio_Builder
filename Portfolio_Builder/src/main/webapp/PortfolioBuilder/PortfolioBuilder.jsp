<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="AccessDB.DataServlet" %>
<%@ page import="java.util.ArrayList" %>
<%
DataServlet srv = new DataServlet(); 
ArrayList<String> listOfAssets = srv.ShowAll();
int range = srv.range;
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width" initial-scale="1.0">
		<title>Build your Portfolio!</title>
		<link rel="stylesheet" type='text/css' href='PortfolioBuilder.css'>
	</head>
	<body>
		<div class="container">
<!-- TL 파트 -->
			<div id="stock" class="TL">
				<div class="select" align="center">
					<div class="type">		
						<p>
							<input type="text" placeholder="종목명 검색"/>
							<span title="전체 종목 수">&nbsp;<%=listOfAssets.get(0) %></span>
						</p>
					</div>
					<div class="scroll">
						<table>
							<%=listOfAssets.get(1) %>
						</table>
					</div>
				</div>
				<div class="selected" align="center">
					<div class="type">
						<p>
							<input type="text" placeholder="종목명 검색"/>
							<span id="number_selec" title="선택한 종목 수">&nbsp;(0)</span>
						</p>
					</div>
					<div class="scroll">
						<table id="selected">
						</table>
					</div>				
				</div>
				<div class="display">
					<h3 id="full-name">종목명 상세</h3>
				</div>
				<div class="button">
					<div id="add">
						<button type="button" onclick="add_assets()">추가</button>
					</div>
					<div id="remove">
						<button type="button" onclick="remove_assets()">제거</button>
					</div>
					<div id="reset">
						<button type="button" onclick="reset_assets()">초기화</button>
					</div>
				</div>
			</div>
<!-- TL 파트 -->
<!-- TR 파트 -->
  			<div class="TR">
  				<div id="table">표 : No. Ticker/Code 종목명 수익률 비중</div>
  				<span class="date">(업데이트 : 2022.12)</span>
  				<span class="time">(X.XXXXsec.)</span>
  			</div>
<!-- TR 파트 -->
<!-- BL 파트 -->
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
<!-- BL 파트 -->
<!-- BR 파트 -->
 			<div id="chart" class="BR">
  				도넛모양 차트
  			</div>
  		</div>
<!-- BR 파트 -->
	</body>
	
	<script>
// TL 파트 스크립트
	// 별도의 확인 버튼 없이, 입력된 문자열을 포함하는 내용을 자동으로 <table>형태로 표시. 만약 없으면 찾는 결과가 없다("None")고 출력 (AJAX ?)
	// 미국주식의 경우, 대소문자 구분 없이 검색 가능하게 코드 작성

	// 1) 종목명 보여주기
		for(var i=1 ; i < <%=range+1 %> ; i++){
			let id="list-no"+i;
			let asset = document.getElementById(id);
			asset.addEventListener("mouseover", assetMouseOver);
			asset.addEventListener("mouseout", assetMouseOut);
		}

		function assetMouseOver(){ // 종목 코드/티커에 마우스 올리면 풀네임 보여줌
			document.getElementById("full-name").innerHTML
			= document.getElementById(event.srcElement.id).getAttribute("name");
		}
		function assetMouseOut(){ // 마우스가 나가면 기본 문자열 보여줌
			document.getElementById("full-name").innerHTML="종목명 상세";
		}
			
	// 2~5) 종목 선택 관련 작업 (버튼 실행)
		let checkedValue = [];  // checkedValue 배열에 담아서 selectedAssets 배열로 옮김
		let selectedAssets=[];  // 종목 선택에 대한 종합적인 결과를 출력하는 배열
		const map = new Map();  // 4-1)에서 사용 : key는 종목명, value는 그 종목의 위치(배열 안)
		let assetName="";	
		
	// 2) 버튼 공통 적용
		function aft_buttonClicked() {
			// 포트폴리오 안에 담긴 종목 수 표시
			document.getElementById("number_selec").innerHTML = "&nbsp;("+selectedAssets.length+")";
			// 버튼 실행 후 전체 체크박스에 체크 해제
			const checkedBox = document.getElementsByName("TL_checkbox");
			for(var i=0; i<checkedBox.length; i++){
				if(checkedBox[i].checked==true) checkedBox[i].checked=false;
			}
		}	
	// 3-1) 추가 : 체크된 항목들을 checkedValue배열에 담기
		function getCheckboxValue(event) {
			let name='';
						
			if(event.target.checked==true) {
				name = event.target.id;
				checkedValue.push(name);
			}
			else if(event.target.checked==false) {
				let index = checkedValue.indexOf(event.target.id);
				checkedValue.splice(index, 1);
			}
		}
	// 3-2) 추가 : 선택된 종목들 포트폴리오에 추가()
		function add_assets() {
			selectedAssets = selectedAssets.concat(checkedValue);
			selectedAssets = [...new Set(selectedAssets)];
			checkedValue=[];
			
			assetName="<tbody>";
			for(var i=0; i<selectedAssets.length; i++){
				assetName += '<tr><td>';
				assetName += '<input type="checkbox" name="'+selectedAssets[i]+'" ';
				assetName += 'onclick="remove_in_array(event)" /> ';
				assetName += selectedAssets[i];
				assetName += '</td></tr>';
			}
			assetName += "</tbody>";
			document.getElementById("selected").innerHTML = assetName;
			
			aft_buttonClicked();
		}
	// 4-1) 제거 : selectedAssets 배열에서 선택된 항목 제거
		function remove_in_array(event) {
			if(event.target.checked==true) {
				let name = event.target.name;
				let index = selectedAssets.indexOf(name);
				map.set(name, index);
				selectedAssets.splice(index, 1, "blank");
			}
			else if(event.target.checked==false) {
				let name = event.target.name;
				let index = map.get(name);
				selectedAssets.splice(index, 1, name);
			}
		}
	// 4-2) 제거 : 포트폴리오 내의 선택된 종목만 제거
		function remove_assets() {
			selectedAssets = [...new Set(selectedAssets)];
			let index = selectedAssets.indexOf("blank");
			selectedAssets.splice(index, 1);
		
			assetName="<tbody>";
			for(var i=0; i<selectedAssets.length; i++){
				assetName += '<tr><td>';
				assetName += '<input type="checkbox" name="'+selectedAssets[i]+'" ';
				assetName += 'onclick="remove_in_array(event)" /> ';
				assetName += selectedAssets[i];
				assetName += '</td></tr>';
			}
			assetName += "</tbody>";
			document.getElementById("selected").innerHTML = assetName;
			
			aft_buttonClicked();
		}
	// 5) 초기화 : 포트폴리오 안에 추가된 전체 종목 삭제
		function reset_assets() {
			if(confirm("선택된 종목 전체가 삭제됩니다.")) {
				selectedAssets=[];
				
				assetName = "<tbody></tbody>";
				document.getElementById("selected").innerHTML = assetName;
				
				aft_buttonClicked();
			}
		}		
// TL 파트 스크립트

	</script>
</html>