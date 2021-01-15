

<br/>
<img height="250" src="https://user-images.githubusercontent.com/55099365/103762567-d8887680-505b-11eb-9a76-83b8da83104c.jpeg"></img>

> **이상이 일상이 되는 회고, 4most***

<br/>

## 👩🏻‍💻 Team4Most - iOS Developer

| 이유진          | 신윤아    | 장혜령 |
|---------------|---------|-----|
| | | |
|[lee-yujinn](https://github.com/lee-yujinn)|[YoonAh-dev](https://github.com/YoonAh-dev) |[hryeong66](https://github.com/hryeong66)|

<br/>
<br/>

## ⚙️ 4Mosts Code Convention Rule
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
