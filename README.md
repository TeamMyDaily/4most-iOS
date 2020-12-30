> *기록은 더 쉽게 <br/>
회고는 더 깊게 <br/>
**어제보다 나은 하루의 시작, 마이데일리***

<br/>

## 👩🏻‍💻 TeamMyDaily - iOS Developer

| 이유진          | 신윤아    | 장혜령 |
|---------------|---------|-----|
| | | |
|[lee-yujinn](https://github.com/lee-yujinn)|[YoonAh-dev](https://github.com/YoonAh-dev) |[hryeong66](https://github.com/hryeong66)|

<br/>
<br/>

## ⚙️ Dailys Code Convention Rule
#### 네이밍

* 함수
  ```swift
    func setMyDaily() {
    } 
    lowerCamelCase 사용하고 동사로 시작
  ``` 
* 변수
  ```swift
    var myDailyMembers = 13
    lowerCamelCase 사용
  ```
* 상수
  ```swift
    let myDailyiOSDevelopers: [String] = ["유진", "윤아", "혜령"]
    lowerCamelCase 사용
  ```
* 클래스
  ```swift
    class MyDaily{
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

## 🍎 Dailys Team Rule
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
  MyDaily_iOS
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
