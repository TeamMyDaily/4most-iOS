
<img src="https://user-images.githubusercontent.com/55099365/104696578-d7d59b80-5751-11eb-9f32-2b19cb80a7df.png"></img>
<br/>
## 🧭  4Most
<img height="250" src="https://user-images.githubusercontent.com/55099365/103762567-d8887680-505b-11eb-9a76-83b8da83104c.jpeg"></img>


> **_이상이 일상이 되는 회고, 4most_** <br/><br/>
> **개발기간: 2020.12.27 ~ 2021.01.16**


<br/>

## 👩🏻‍💻 Team4Most - iOS Developer

| 이유진          | 신윤아    | 장혜령 |
|:---------------:|:---------:|:-----:|
|<img height="250" src="https://user-images.githubusercontent.com/55099365/104681972-f37f7880-5736-11eb-824f-578699215822.jpg"></img> | <img height="250" src="https://user-images.githubusercontent.com/55099365/104682215-84565400-5737-11eb-9d97-56c233364d58.jpeg"></img> |<img height="250" src="https://user-images.githubusercontent.com/55099365/104682117-4ce7a780-5737-11eb-9a64-cfd77bea477c.png"></img> |
|[lee-yujinn](https://github.com/lee-yujinn)|[YoonAh-dev](https://github.com/YoonAh-dev) |[hryeong66](https://github.com/hryeong66)|
| 로그인<br/> 회원가입<br/> 나의 기록<br/> 목표 설정 |평가 및 회고<br/> 마이페이지 설정 |키워드 설정<br/> 마이페이지 키워드 |


<br/>
<br/>

## ⚙️ 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.0-orange)]()
[![xcode](https://img.shields.io/badge/Xcode-12.3-blue)]()
[![iOS](https://img.shields.io/badge/iOS-14.3-silver)]()
[![Moya](https://img.shields.io/badge/Moya-14.0.0-red)]()
[![Alamofire](https://img.shields.io/badge/Alamofire-5.4.1-lightgrey)]()
[![lottie-ios](https://img.shields.io/badge/lottie--ios-3.1.9-yellowgreen)]()

<br/>

## 🖼 서비스 Workflow
[![flow](https://user-images.githubusercontent.com/55099365/104683302-fcbe1480-5739-11eb-83f2-c202cc0b4cc8.png)]()


## 📱 기능 명세서

| 우선순위       | 기능    | 상세기능 | 담당자 | 구현 여부 |
|:------------:|---------|-----|---------|:-----:|
| `P3`| 스플래시 | 스플래시 | |  |
|`P2` | 로그인 | 로그인 | 이유진 | ⭕️ |
|`P2`| 회원가입 | 회원가입 | 이유진 | ⭕️|
| `P1` | 키워드 | 키워드 선택 | 장혜령 | ⭕️|
|`P1` |  | 키워드 추가 | 장혜령 |⭕️ |
|`P1` |  | 키워드 삭제 | 장혜령 |⭕️ | 
| `P1`|  | 키워드 우선순위 지정  | 장혜령 |⭕️ |
|`P1` | | 키워드 정의 작성 | 장혜령 |⭕️ |
|`P1` | 나의 기록 | 기록 조회| 이유진 | ⭕️|
|`P1` |  | 기록 작성 | 이유진 |⭕️ |
|`P1` |  | 날짜 변경 | 이유진 |⭕️ |
| `P2`| 목표설정 | 목표 작성 | 이유진 |⭕️ |
| `P2`|  | 목표 조회 | 이유진 |⭕️ |
|`P2` |  | 주차 변경 | 이유진 | ⭕️|
|`P1` | 평가 및 회고 | 리포트 조회 | 신윤아 |⭕️ |
|`P1` |  | 키워드별 리포트 조회 | 신윤아 |⭕️ |
|`P1`|  | 회고 조회 | 신윤아 |⭕️ |
|`P1` |  | 회고 작성 | 신윤아 | ⭕️|
|`P1` |  | 주차 변경 | 신윤아 |⭕️ |
|`P2`| 마이페이지 | 키워드 우선순위 변경 | 장혜령 | ⭕️|
|`P2` |  | 키워드 정의 조회| 장혜령 | ⭕️|
|`P2` |  | 키워드 추가| 장혜령 | ⭕️|
| `P2`|  | 키워드 삭제| 장혜령 | ⭕️|
|`P3` | 설정 | 회원 탈퇴| 신윤아 |⭕️ |
|`P3` |  | 비밀번호 변경| 신윤아 | ⭕️|

<br/>

## ✅ 개발 설명
1. **핵심 기능 구현 방법**

    - 나의 기록
    - 키워드 설정
    - 회고 조회
    <br/>
2. **Extension을 통해 작성한 메소드 설명**
    - Extension+Date
    
<br/>

## 🤝 4Mosts Code Convention Rule
#### 네이밍

* 함수
  ```swift
    func set4Most() {
    } 
    lowerCamelCase 사용하고 동사로 시작
  ``` 
* 변수
  ```swift
    var fourMostMembers = 13
    lowerCamelCase 사용
  ```
* 상수
  ```swift
    let fourMostiOSDevelopers: [String] = ["유진", "윤아", "혜령"]
    lowerCamelCase 사용
  ```
* 클래스
  ```swift
    class fourMost{
    }
    UpperCamelCase 사용
  ```
* 파일명

  |          | 약어   |
  |-------------|--------|
  |ViewController| `VC` | 
  |TableViewCell| `TVC` | 
  |CollectionViewCell| `CVC` | 
  
* 메서드
  - **설정 관련 메서드**는 `set`으로 시작
    ```swift
      func setNavigationBar() {
      }
    ```
#### 기타규칙
* `self`는 최대한 사용을 **지양**

* `viewDidLoad()`에서는 **함수호출만**
  - delegate 지정, UI관련 설정 등등 모두 함수로 빼도록 합시다.
* 함수는 `extension`에 정의하고 정리
  - `extension`은 목적에 따라 분류하면 좋겠어요.
  
<br/>

## 🍎 4Mosts Team Rule
### git
🔀 **git branch**
* master : 제품으로 출시될 수 있는 브랜치
* develop : 다음 출시 버전을 개발하는 브랜치
* feature : 기능을 개발하는 브랜치
* release : 이번 출시 버전을 준비하는 브랜치
<br/>

✌️ **git commit message**
* [Feat] : 기능추가
* [Fix] : 버그수정
* [Chore] : 간단한 수정
* [Docs] : 문서 및 리드미 작성
* [Merge] : 머지
<br/>

### project foldering
* Resourse : asset, info.plist, AppDelegate 관리
* Source : Scene(flow 별로 폴더링) -> Storyboard, VC, Network(API), Model 등 관리
  ```
  fourMost_iOS
    |── Source
    │   └── Scene
    │         ├── MyDaily.storyboard
    │         ├── View
    │         │     │── Cell
    │         │     └── VC
    │         └── Network
    │               └── Model
    └── Resource 
        |── Assets.xcassets
        |── LaunchScreen.storyboard
        |── AppDelegate.swift
        |── SceneDelegate.swift
        └── Info.plist

  ```
