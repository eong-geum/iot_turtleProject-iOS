# 주제

거북목 방지 IoT 프로젝트 '엉금엉금'

## 요약
의자에 앉아 업무를 보는 사람들을 위한 거북목 방지 알림 시스템


## 프로젝트 목표
- 라즈베이파이를 이용한 IoT 프로젝트로, 카메라를 이용해 사용자의 자세를 실시간으로 촬영하여 거북목 포착 시 이를 알려주는 서비스를 개발하고자 합니다. 이를 통해 사용자가 무의식적으로 일에 열중하며 자세가 안 좋아지는 것을 방지하고, 보다 건강하게 일에 열중할 수 있도록 하는 것이 이 프로젝트의 목표입니다.

## 프로젝트 개발환경
Hardware - Raspberry PI, Camera Module
Library - Python-openCV
Web - React.js
iOS - Swift
Backend – Spring, Flask (python-opencv)

## 프로젝트 구조
<img width="800" alt="스크린샷 2021-06-22 오후 4 31 01" src="https://user-images.githubusercontent.com/29617557/152790524-58916b0b-48f7-42e7-bf88-b5eb7e19912b.png">

## 스크린샷
- 알림 화면
<img width="500" alt="스크린샷 2021-06-22 오후 4 31 01" src="https://user-images.githubusercontent.com/29617557/152790532-816fe995-2bde-4ebd-8ade-712dee2907df.png">
<img width="500" alt="그림1" src="https://user-images.githubusercontent.com/29617557/166117950-de54cc7f-8fae-4ddf-a67b-d90399c5acda.png">

- 알림 클릭시 타이머 실행
<img width="500" alt="스크린샷 2021-06-22 오후 4 31 44" src="https://user-images.githubusercontent.com/29617557/152790551-09813be7-ca65-4af1-8f34-fa349cba641a.png">
- 메인 화면
<img width="500" alt="스크린샷 2021-06-22 오후 4 32 19" src="https://user-images.githubusercontent.com/29617557/152790562-205c6c69-85c8-4045-bd23-377fe5bc70a4.png">
- 월간 거북목 측정 횟수를 보여주는 캘린더
<img width="500" alt="스크린샷 2021-06-22 오후 4 32 55" src="https://user-images.githubusercontent.com/29617557/152790577-d0a22dd5-8903-41b7-bbc6-e88d4b9c4aa9.png">

## 구현 기능

- iOS는 기본적으로 Firebase Realtime Database에 저장된 데이터베이스를 불러와 정보를 뷰에 띄워주는 역할을 수행합니다.

- 일별로 저장된 데이터를 달력을 통해 한 눈에 볼 수 있도록 Modal을 달았습니다. 데이터 캐싱을 위해 Realm을 사용하였습니다.

- Firebase의 Cloud Messaging 기능을 이용하여 스프링 서버로부터 push notification을 받고, 누르면 즉시 스트레칭을 할 수 있도록 타이머 기능을 제공합니다.

## 사용 라이브러리

Firebase(Realtime Database, Authentication, Cloud Messaging)

Realm

SRCountdownTimer

FSCalendar


