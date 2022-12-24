# CodingJavaProject4 - Portfolio Builder (22.12.16 ~ )  

<div align="left">
<img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white">
<img src="https://img.shields.io/badge/html-E34F26?style=for-the-badge&logo=html5&logoColor=white">
<img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white">
<img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black">
<img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
</div><br>
<br>  
<br>  

<div align="center">
(웹 페이지 - 실행 화면)  
</div><br>  
<br>
<br>

<div align="right">제작 기간 : 22.12.16 ~ 진행 중</div>

### 목차  
&nbsp; &nbsp; 개발 동기 - 설계 - 후기 - 개선 사항 - 참고  
<hr>  

## 개발 동기  
- 그 동안 배운 내용들(Java, MySQL, HTML&CSS, JavaScript, JSP 등)을 활용해보고 싶었음  
- 기존에 작업 중이던 CodingJavaProject3의 내용을 웹 상에서 구현하면 재밌는 결과물이 만들어질 것 같다는 생각이 듦  
- 그래서 CodingJavaProject3는 중단하고, 기존 CodingJavaProject3의 작업 내용을 포함하는 이번 프로젝트를 구상하게 됨  

## 설계  
- 웹 페이지 구성  
&nbsp; ![web_page_design](https://user-images.githubusercontent.com/109140000/209435289-16ae2482-c167-445e-9d6b-e63344679e8b.png)  
- 중점 사항  
(해당 내용은 사전에 작성된 내용으로, 프로그램 작업 간 수정/추가/삭제 될 수 있음)<br>  
&nbsp; 1. 최대한 HTML/CSS을 사용한다.  
&nbsp; &nbsp; - Bootstrap 같은 프레임워크 사용 자제  
&nbsp; &nbsp; - 차트 위에 마우스를 올리면 강조 효과(분리 후 확대) 구현  
&nbsp; &nbsp; - 종목 정보는 티커 또는 코드로만 기입할 예정. 마우스 올리면 해당 종목 정보(종목명) 디스플레이(HTML의 title 태그 활용)  
&nbsp; &nbsp;  - [ ? ] 버튼에 마우스 올리면, 최대로 추가할 수 있는 종목 수 전시  
&nbsp; 2. Java Script를 사용한다. (jQuery 대신)    
&nbsp; &nbsp; - Java Script 이용하여 차트 제작  
&nbsp; &nbsp; - 차트 내 종목 클릭 시 해당 종목 정보 사이트로 이동(SEC 또는 investing.com)  
&nbsp; &nbsp; - 경고창 생성 : 모든 초기화 버튼에 대해서, 클릭 시 경고창 생성하고 재확인  
&nbsp; &nbsp; - 경고창 생성 : 선택해야할 조건을 충족하지 않고 실행 버튼 누를 시 경고창 생성  
&nbsp; 3. 표 구성  
&nbsp; &nbsp; - | No. | Ticker/Code | 종목명 | 연평균 수익률 | 보유 비중 |  
&nbsp; 4. SQL 데이터는 적어도 10년치 이상의 자료 구성  
&nbsp; 5. Java 프로그램(파일) 작성 간 DB에 직접적인 수정이 이뤄지지 않도록 주의  
&nbsp; 6. 포트폴리오 구성 방식은 '동일 가중방식'을 사용  
&nbsp; &nbsp; - 웹 페이지 구성과 Script 구현 완료 될 때까지는 가장 단순한 포트폴리오 구성 방식인 동일 가중방식 사용  
&nbsp; &nbsp; - 이후, SQL 자료 수정(필요 시) 및 포트폴리오 구성 방식 추가 예정  
&nbsp; &nbsp; - 그 때까지 CodingJavaProject3에서 구상해낸 가중방식 사용은 잠시 보류  

## 후기  
(프로젝트 종료 후 작성 예정)  

## 개선 사항 
- Portfolio Builder  
(프로젝트 종료 후 작성 예정)  

- SiHoonChris  
(프로젝트 종료 후 작성 예정)  

## 참고
- 현재 Repository에서의 기록  
12-16-2022 / 현 Repository 생성  
12-22-2022 / 웹 페이지 구성(HTML, CSS 활용, 각 요소들 위치 잡기)  
12-24-2022 / 웹 페이지 구성(버튼, 입력창 생성)  
  
- 이전 Repository :  
&nbsp; CodingJAvaProject3_EasyRiskParityPortfolio에서 현 repo로 흡수  
( https://github.com/SiHoonChris/CodingJavaProject3_EasyRiskParityPortfolio )  
