# kbu_final_project(졸업작품)
한국성서대학교 4학년 1학기에 걸쳐 진행한 flutter 와 firebase를 이용한 졸업 작품 
## 여행 계획 앱(flutter)
여행지에 대한 정보(여행지 정보, 구글 맵,리뷰)와 계획 기능(to do list)을 이용한 간단한 앱
아직 지속적인 업데이트 중에 있으며 최종적으로는 구글 배포 까지 할 예정임
아직 ui적인 부분이나 전체적인 디자인에 부족함이 있으며 지속적 업데이트를 이 레포지토리 계속 푸쉬할 예정 
## 폴더 구조(lib)
|폴더(파일) 이름|내용|
|:---|:---:|
| data| db|
| main| 프로젝트를 이루는 주된 파일들(여행,즐겨찾기등 주 기능)|
| plan| 계획 기능|
| login.dart|로그인 기능|
| main.dart|앱 실행시키는 메인 실행 파일 및 푸시알림 기능|
| mainPage.dart|메인 페이지|
| signPage.dart|회원가입 기능|


### 폴더 구조(data)
|폴더(파일) 이름|내용|
|:---|:---:|
| disableInfo.dart| 장애인 정보|
| listData.dart| 관광타입,지역 정보 |
| Plandata.dart| 계획 정보|
| reviews.dart|리뷰 정보|
| tour.dart|구글 지도 |
| user.dart|사용자 정보|


### 폴더 구조(main)
|폴더(파일) 이름|내용|
|:---|:---:|
| favoritePage.dart| 즐겨찾기 기능|
| mapPage.dart| 메인 맵 페이지 기능 |
| settingPage.dart| 설정 기능 |
| tourDetailPage.dart| 구글 맵,장애인,리뷰기능|


### 폴더 구조(plan)
|폴더(파일) 이름|내용|
|:---|:---:|
| addPlan.dart| 계획 추가 기능|
| ClearList.dart| 계획 삭제 기능|
| planDetailPage.dart| 계획 상세 페이지|
| PlanPage.dart|계획 페이지|
| todo.dart|계획 정보 |