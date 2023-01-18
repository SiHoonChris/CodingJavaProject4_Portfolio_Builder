/**
 * PortfolioBuilder JavaScript/jQuery
 */

// TL에서... 
// 별도의 확인 버튼 없이, 입력된 문자열을 포함하는 내용을 자동으로 <table>형태로 표시. 만약 없으면 찾는 결과가 없다("None")고 출력 (AJAX ?)
// 미국주식의 경우, 대소문자 구분 없이 검색 가능하게 코드 작성

// TL-1) 종목명 보여주기
let total_num = document.getElementById("Total").innerHTML;
total_num = total_num.substring(6);
		
for(var i=1 ; i < parseInt(total_num,10) ; i++){
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

// TL-2~5) 종목 선택 관련 작업 (버튼 실행)
let checkedValue_add = [];    // 선택한 종목들을 checkedValue_add에 담고, add_assets()가 실행되면 selectedAssets로 옮김
let checkedValue_remove = []; // 선택한 종목들을 checkedValue_remove에 담고, remove_assets()가 실행되면 selectedAssets로 옮김
let selectedAssets=[];  // 종목 선택에 대한 종합적인 결과를 출력하는 배열
const map = new Map();  // 4-1)에서 사용 : key는 종목명, value는 그 종목의 위치(배열 안)
let assetName="";
		
// TL-2) 버튼 공통 적용
function aft_buttonClicked() {
	// 포트폴리오 안에 담긴 종목 수 표시
	document.getElementById("number_selec").innerHTML = "&nbsp;("+selectedAssets.length+")";
	// 버튼 실행 후 전체 체크박스에 체크 해제
	const checkedBox = document.getElementsByName("TL_checkbox");
	for(var i=0; i<checkedBox.length; i++){
		if(checkedBox[i].checked==true) checkedBox[i].checked=false;
	}
	checkedValue_add=[];
	checkedValue_remove=[];
}
	
// TL-3-1) 추가 : 체크된 항목들을 checkedValue배열에 담기
function getCheckboxValue(event) {				
	if(event.target.checked==true) {
		let name = event.target.id;
		checkedValue_add.push(name);
		console.log(checkedValue_add);
	}
	else if(event.target.checked==false) {
		let index = checkedValue_add.indexOf(event.target.id);
		checkedValue_add.splice(index, 1);
		console.log(checkedValue_add);
	}
}
// TL-3-2) 추가 : 선택된 종목들 포트폴리오에 추가()
function add_assets() {
	selectedAssets = selectedAssets.concat(checkedValue_add);
	selectedAssets = [...new Set(selectedAssets)];
	checkedValue_add=[];
	
	assetName="<tbody>";
	for(var i=0; i<selectedAssets.length; i++){
		assetName += '<tr><td>';
		assetName += '<input type="checkbox" name="composition" value="'+selectedAssets[i]+'" ';
		assetName += 'onclick="remove_in_array(event)" /> ';
		assetName += selectedAssets[i];
		assetName += '</td></tr>';
	}
	assetName += "</tbody>";
	document.getElementById("selected").innerHTML = assetName;
	
	aft_buttonClicked();
}

// TL-4-1) 제거 : selectedAssets 배열에서 선택된 항목 제거
function remove_in_array(event) {
	if(event.target.checked==true) {
		let name = event.target.value;
		checkedValue_remove.push(name);
		console.log(checkedValue_remove);
	}
	else if(event.target.checked==false) {
		let index = checkedValue_remove.indexOf(event.target.value);
		checkedValue_remove.splice(index, 1);
		console.log(checkedValue_remove);
	}
}
// TL-4-2) 제거 : 포트폴리오 내의 선택된 종목만 제거
function remove_assets() {
	for(var i=0; i<checkedValue_remove.length; i++){
		for(var j=0; j<selectedAssets.length; j++){
			if(checkedValue_remove[i]==selectedAssets[j]){
				selectedAssets.splice(j, 1);
			}	
		}
	}
	checkedValue_remove=[];

	assetName="<tbody>";
	for(var i=0; i<selectedAssets.length; i++){
		assetName += '<tr><td>';
		assetName += '<input type="checkbox" name="composition" value="'+selectedAssets[i]+'" ';
		assetName += 'onclick="remove_in_array(event)" /> ';
		assetName += selectedAssets[i];
		assetName += '</td></tr>';
	}
	assetName += "</tbody>";
	document.getElementById("selected").innerHTML = assetName;
	
	aft_buttonClicked();
}

// TL-5) 초기화 : 포트폴리오 안에 추가된 전체 종목 삭제
function reset_assets() {
	if(confirm("선택된 종목 전체가 삭제됩니다.")) {
		selectedAssets=[];
		
		assetName = "<tbody></tbody>";
		document.getElementById("selected").innerHTML = assetName;
		
		aft_buttonClicked();
	}
}		


// BL-1) 포트폴리오 가중 방식에 대한 설명을 보여준다
let method = document.querySelector("#p_method");
let expl   = document.querySelector("#p_expl");
	
function select_method(event) {
	let title;
	let explanation;

	switch(event.target.id) {
	case 'ewi':
		title="동일 가중방식";
		explanation = "모든 구성 종목에 동일한 비중으로 투자한다. 중소형주의 주가변화가 상대적으로 높게 반영된다.";
		break;
	case 'cwi':
		title="시가총액 가중방식";
		explanation = "시가총액에 비례하여 구성 종목의 투자 비중을 설정한다. 대형주의 주가변화가 상대적으로 높게 반영된다.";
		break;
	case 'shcwi':
		title="SiHoonChris 가중방식";
		explanation = "SiHoonChris가 Ray Dalio의 Risk-Parity Portfolio 전략에서 파생시킨 가중방식으로, ";
		explanation +="특정 기간 동안의 연간 수익률이 가지는 표준편차를 기준으로 투자비중을 설정하는 방식이다. ";
		explanation +="표준편차가 낮을수록 높은 투자비중을 갖게 되며, 기대수익률은 기간 동안의 연평균 수익률에서 ";
		explanation +="표준편차의 크기에 비례하는 수익률을 감하여 계산한다.";
	}
	method.textContent = title;
	expl.textContent   = explanation;
}

// BL-2) 실행 버튼 구현
function fn_sendDatas(event){
	let html_string="";
	for(var i=0; i<selectedAssets.length; i++ ){
		if(i==selectedAssets.length-1) {html_string += "'"+selectedAssets[i]+"'";}
		else {html_string += "'"+selectedAssets[i]+"', "};
	}
	document.getElementById("nameOfAssets").value = html_string;

	let AssetsAndMethod = document.AssetsAndMethod;
	let Method = AssetsAndMethod.Method.value;
	let Assets = AssetsAndMethod.Assets.value;
	
	AssetsAndMethod.method="post";
	AssetsAndMethod.action="/result";
	AssetsAndMethod.submit();
}