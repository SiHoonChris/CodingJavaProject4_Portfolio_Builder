# CodingJavaProject4 - Portfolio Builder (22.12.16 ~ 23.01.29)  

<div align="left">
<img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white">
<img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
<img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
<img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white">
<img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black">
</div>
<br><br>

1  
![1mouseevent](https://user-images.githubusercontent.com/109140000/217211736-b1931e93-0ce1-4289-aa9d-f34443fcbdc3.gif)  
2  
![2autosearch](https://user-images.githubusercontent.com/109140000/217211743-094c3217-114e-4d74-b356-93ff0133078e.gif)  
3  
![3removeall](https://user-images.githubusercontent.com/109140000/217211744-cc2505be-1df6-485a-afc1-0078b0aba696.gif)  
4  
![4add](https://user-images.githubusercontent.com/109140000/217211750-2283da69-8e9e-45de-a700-d15720555361.gif)  
5  
![5delete](https://user-images.githubusercontent.com/109140000/217211755-9200fd2d-1bbf-4839-86e1-ee588ef1fb4d.gif)  
6  
![6execution](https://user-images.githubusercontent.com/109140000/217211758-3e4c8342-001e-4373-bd84-80fb857fefc7.gif)  
7  
![7chart](https://user-images.githubusercontent.com/109140000/217211763-d8b02893-c106-498d-84df-30bc3528d6ee.gif)  

<br>
<div align="center"><i>"&nbsp; &nbsp; JavaScript로 구현한 기능들 &nbsp; &nbsp;"</i></div>

<br><br>  

<div align="right">제작 기간 : 22.12.16 ~ 23.01.29</div>
<br><br>

### 목차  
&nbsp; &nbsp; 개발 동기 - 설계 - SiHoonChris 가중방식 - 후기 - 개선 사항 - 참고  
<hr>  

## 개발 동기  
- JSP를 배우면서, 그 동안 배운 내용들을 활용하여 무언가를 만들어 보고 싶었다.    
- 기존에 작업 중이었던 CodingJavaProject3의 내용을 웹페이지에서 구현해내면 괜찮은 결과물이 만들어질 것 같다는 생각이 들었다.  
- 그래서 CodingJavaProject3는 중단하고, 기존 CodingJavaProject3의 작업 내용을 포함하는 이번 프로젝트를 구상/진행하게 되었다.  
<br>

## 설계 (초기 계획과 결과물 비교) 
![web_page_design](https://user-images.githubusercontent.com/109140000/209435289-16ae2482-c167-445e-9d6b-e63344679e8b.png)  
![screenshotReadme](https://user-images.githubusercontent.com/109140000/216916861-0d25db07-3383-48cd-b436-0f87df81a9e0.png) 
<div align="center"><i>"&nbsp; &nbsp; 초기 계획과 결과물 &nbsp; &nbsp;"</i></div>  
<br><br>  

계획 1. &nbsp; 최대한 기본 HTML/CSS 기능만을 사용한다.  
&nbsp; - Bootstrap 같은 프레임워크 사용 자제  
&nbsp; - 차트 위에 마우스를 올리면 강조 효과(분리 후 확대) 구현  
&nbsp; - 종목 정보는 티커 또는 코드로만 기입할 예정. 마우스 올리면 해당 종목 정보(종목명) 디스플레이 ( HTML의 title 태그 활용 )    
&nbsp; - [ ? ] 버튼에 마우스 올리면, 최대로 추가할 수 있는 종목 수 전시  

> 1. 기본적인 HTML / CSS / JS 만을 사용했다.  
&nbsp; - Bootstrap을 포함한 다른 프레임워크들을 전혀 사용하지 않다.  
&nbsp; - 차트 위에 마우스를 올리면 강조(색깔 변화, 크기 조정, 내용 전환을 통한) 효과가 발생하도록 JavaScript를 이용하여 코드를 작성하였다.  
&nbsp; - 종목 정보는 미국주식의 경우 티커를 입력하였고 국내주식은 종목명을 입력했다. 마우스를 올리면 웹페이지 상에 별도로 구현해 놓은 공간에 종목명 전체가 전시될 수 있도록 제작했다.  
&nbsp; - 추가할 수 있는 최대 종목 수는 구현하지 않았다. 대신에 해당 공간에는 포트폴리오에 편입시킨 종목의 수를 표시할 수 있게 했다.  

계획 2. &nbsp;  Java Script를 사용한다 ( jQuery 대신 )  
&nbsp; - Java Script 이용하여 차트 제작  
&nbsp; - 차트 내 종목 클릭 시 해당 종목 정보 사이트로 이동(SEC 또는 investing.com)  
&nbsp; - 경고창 생성 : 모든 초기화 버튼에 대해서, 클릭 시 경고창 생성하고 재확인  
&nbsp; - 경고창 생성 : 선택해야할 조건을 충족하지 않고 실행 버튼 누를 시 경고창 생성  
> 2. JavaScript만을 사용했다.  
&nbsp; - JavaScript의 arc함수를 활용하여 차트 생성했다.    
&nbsp; - 종목 클릭에 따른 다른 웹페이지 이동은 구현하지 않았다  
&nbsp; - 경고창(alert) 생성 : 종목은 1종목 이상, 가중방식은 하나를 반드시 고르도록 제작했다  
&nbsp; - 경고창(alert) 생성 : 초기화 버튼 클릭시 해당 내용 재안내했다  

계획 3. &nbsp;  표 구성  
&nbsp; - No.  //  Ticker/Code  //  종목명  //  연평균 수익률  //  보유 비중  
> 3. Column명    
&nbsp; - No. &nbsp;|&nbsp;  코드/티커  &nbsp;|&nbsp;  종목명  &nbsp;|&nbsp;  수익률  &nbsp;|&nbsp;  비중  

계획 4. &nbsp; SQL 데이터는 적어도 10년치 이상의 자료 구성
> 4. 2012년부터 2023년까지의 연단위 자료를 통해 SQL DB구성    

계획 5. &nbsp; Java 프로그램(파일) 작성 간 DB에 직접적인 수정이 이뤄지지 않도록 주의  
> 5. Data Access Object 제작 간 아무 이상 없었음   

계획 6. &nbsp; 포트폴리오 구성 방식은 '동일 가중방식'을 사용  
&nbsp; - 웹 페이지 구성과 Script 구현 완료 될 때까지는 가장 단순한 포트폴리오 구성 방식인 동일 가중방식 사용
&nbsp; - 이후, SQL 자료 수정(필요 시) 및 포트폴리오 구성 방식 추가 예정  
&nbsp; - 그 때까지 CodingJavaProject3에서 구상해낸 가중방식 사용은 잠시 보류
> 6. 3가지 가중방식(동일, 시가총액, SiHoonChris) 모두 구현했다. 제작 순서를 철저하게 지키지는 않았다.    

>7. 기타  
&nbsp; - 종목 검색 기능을 구현할 때 따로 검색 버튼을 만들지 않고, 입력된 값에 대해 자동으로(바로) 인식하여 결과를 보여줄 수 있도록 제작했다(keyup 이벤트 사용)  
&nbsp; - 포트폴리오 전체 수익률 표시를 테이블 밑에 생성했다. 실행 소요시간은 작성하지 않았다.  
<br>

## SiHoonChris 가중방식  
1) SiHoonChris 가중방식은 Ray Dalio의 "All Weather Portfolio(Risk Parity)"에서 영감을 받아 직접 고안한 것이다. 포트폴리오 내 종목들이 차지하는 비중은 해당 종목이 가진 연수익률의 표준편차에 반비례하여 계산된다. 연평균 수익률은 (현재 진행 중인) 올해 수익률의 비중을 축소시켜 계산한다. (자세한 계산식은 Query.txt 참고)  
2) 이름은 뭐라고 붙여야 할지 모르겠어서 내 깃허브 프로필 이름을 붙였다.  
<br>

## 후기  
1) 배운 내용들을 한 번씩은 다 활용해보고 싶다는 욕심에 억지스러운 부분들이 있었던 것 같다.  
2) JavaScript로 할 수 있는 것들이 굉장히 많음을 이번에 제대로 깨닫게 되었고, 해당 언어와 분야에 흥미가 생겼다.  
3) 머리 속에서 생각해낸 계산식을 SQL로 구현해내는 것이 생각보다 더 어려웠다.  
4) 직접 페이지를 구성해보는 것이 이번이 처음이었기에 HTML/CSS 활용에 어려움을  겪었다.  
<br>

## 개선 사항 
- Portfolio Builder   
1. 학습적인 목적이 있었기에, 불필요한 Servlet 활용과 페이지 이동이 있었다. JavaScript에 더 큰 비중을 두고 제작한다면 지금보다 더 개선된 결과물이 만들어질 것 같다.  

- SiHoonChris  
1. JavaScript를 좀 더 깊게 공부하자.  
2. Java를 활용한 SQL 작업에 익숙해지자.  
<br>

## 참고  
- 현 repo에서의 작업 내용  
12-16-2022 &nbsp; / &nbsp; <strong>[프로젝트 시작]</strong> 현 Repository 생성  
12-22-2022 &nbsp; / &nbsp; (HTML/CSS) 웹 페이지 구성(각 요소 위치 지정)  
12-24-2022 &nbsp; / &nbsp; (HTML/CSS) 종목 추가/제거/초기화 버튼, 종목 검색 입력창 생성  
12-28-2022 &nbsp; / &nbsp; (HTML/CSS) 스크롤바 생성, (Java-XML) SQL연동 확인  
12-30-2022 &nbsp; / &nbsp; (JS) DB내 자료(종목 코드) 웹페이지 상 출력  
01-01-2023 &nbsp; / &nbsp; (JS) 종목명 상세 보기(마우스 이벤트) 구현, (Java-JSP) 종목별 태그 안의 속성 추가  
01-02-2023 &nbsp; / &nbsp; (JS) 선택된 종목에 대한 (추가)버튼 기능 구현  
01-03-2023 &nbsp; / &nbsp; (JS) '추가' 버튼 기능 구현 완료  
01-07-2023 &nbsp; / &nbsp; (JS) 버튼(추가, 제거, 초기화) 기능 구현 완료, 포트폴리오에 추가된 종목 수 표시, (JSP) DB내 종목 전체 수 표시 완료  
01-10-2023 &nbsp; / &nbsp; (JS) 라디오버튼 클릭시 포트폴리오 가중방식에 대한 설명 전시  
01-15-2023 &nbsp; / &nbsp; (JS) 버튼(추가/제거/초기화) 실행시 발생하는 에러들 해결    
01-16-2023 &nbsp; / &nbsp; (HTML) 포트폴리오 내용 테이블 생성    
01-17-2023 &nbsp; / &nbsp; (Java) 자료 전송, 페이지 이동  
01-18-2023 &nbsp; / &nbsp; (Java) 자료 전송, 페이지 이동, (SQL-Java) 동일 가중방식 구현  
01-19-2023 &nbsp; / &nbsp; (SQL-Java) 시가총액 가중방식 구현  
01-20-2023 &nbsp; / &nbsp; (SQL-Java) SiHoonChris 가중방식 구현   
01-21-2023 &nbsp; / &nbsp; (SQL-Java) SiHoonChris 가중방식 보완, (JS) 원형 차트 생성  
01-22-2023 &nbsp; / &nbsp; (SQL-Java) SiHoonChris 가중방식 DAO상 작성, (JS) "실행" 버튼 구현  
01-24-2023 &nbsp; / &nbsp; (JS) 원형 차트 동작 부여  
01-26-2023 &nbsp; / &nbsp; (JS) 원형 차트 강조 효과 추가, 테이블-차트 연동  
01-28-2023 &nbsp; / &nbsp; (JS) 종목 자동 검색 기능 구현  
01-29-2023 &nbsp; / &nbsp; (JS) 전체 수익률 출력 <strong>[프로젝트 종료]</strong>  

- 이전 Repository :  
&nbsp; CodingJAvaProject3_EasyRiskParityPortfolio에서 현 repo로 흡수  
( https://github.com/SiHoonChris/CodingJavaProject3_EasyRiskParityPortfolio )  
