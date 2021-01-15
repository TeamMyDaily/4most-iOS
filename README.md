
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
| 로그인/회원가입<br/>기록<br/>목표 |회고<br/> 마이페이지 설정 |키워드 설정<br/> 마이페이지 키워드 |

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

|    주요기능     |         상세기능         | 우선순위 | 담당자 | 구현 |
| :-------------: | :----------------------: | :------: | :----: | :--: |
| 로그인/회원가입 |    회원가입 및 로그인    |   `P1`   | 이유진 |  ⭕️   |
|                 |        자동로그인        |   `P2`   | 이유진 |  ⭕️   |
|   키워드 설정   |       키워드 선택        |   `P1`   | 장혜령 |  ⭕️   |
|                 |   키워드 추가 및 삭제    |   `P1`   | 장혜령 |  ⭕️   |
|                 |   키워드 우선순위 지정   |   `P1`   | 장혜령 |  ⭕️   |
|                 |     키워드 정의 작성     |   `P1`   | 장혜령 |  ⭕️   |
|      기록       |     기록 날짜별 조회     |   `P1`   | 이유진 |  ⭕️   |
|                 |   키워드 별 기록 추가    |   `P1`   | 이유진 |  ⭕️   |
|                 |     기록 상세 페이지     |   `P1`   | 이유진 |  ⭕️   |
|                 |    기록 수정 및 삭제     |   `P1`   | 이유진 |  ⭕️   |
|                 |      기록 날짜 변경      |   `P1`   | 이유진 |  ⭕️   |
|      목표       |     목표 주차별 조회     |   `P2`   | 이유진 |  ⭕️   |
|                 |     목표 상세 페이지     |   `P2`   | 이유진 |  ⭕️   |
|                 |   키워드 별 목표 추가    |   `P2`   | 이유진 |  ⭕️   |
|                 |    목표 수정 및 삭제     |   `P2`   | 이유진 |  ⭕️   |
|                 |    목표 달성여부 체크    |   `P2`   | 이유진 |  ⭕️   |
|                 |      목표 주차 변경      |   `P2`   | 이유진 |  ⭕️   |
|      회고       |       리포트 조회        |   `P1`   | 신윤아 |  ⭕️   |
|                 |  키워드 별 리포트 조회   |   `P1`   | 신윤아 |  ⭕️   |
|                 |        회고 조회         |   `P1`   | 신윤아 |  ⭕️   |
|                 |        회고 작성         |   `P1`   | 신윤아 |  ⭕️   |
|                 |      회고 주차 변경      |   `P1`   | 신윤아 |  ⭕️   |
|   마이페이지    |   키워드 우선순위 변경   |   `P2`   | 장혜령 |  ⭕️   |
|                 |     키워드 정의 조회     |   `P2`   | 장혜령 |  ⭕️   |
|                 |   키워드 추가 및 삭제    |   `P2`   | 장혜령 |  ⭕️   |
|                 | 기록 키워드 등록 및 해제 |   `P2`   | 장혜령 |  ⭕️   |
|                 |     사용자 정보 조회     |   `P3`   | 신윤아 |  ⭕️   |
|                 |      비밀번호 변경       |   `P3`   | 신윤아 |  ⭕️   |
|                 |         회원탈퇴         |   `P3`   | 신윤아 |  ⭕️   |



<br/>

## ✅ 개발 설명
1. **핵심 기능 구현 방법**

    - 키워드 설정
         ```swift
          //KeywordSettingTVC - tableviewcell 안에 버튼 클릭 delegate
              protocol SelectKeywordDelegate {
                func addSelectedKeyword(_ cell: KeywordSettingTVC, selectedText: String) -> Bool

                func cancelSelectedKeyword(_ cell: KeywordSettingTVC, selectedText: String)
              }

              }

          ///KeywordSettingVC
              extension KeywordSettingVC: SelectKeywordDelegate{
                func addSelectedKeyword(_ cell: KeywordSettingTVC, selectedText: String) -> Bool{
                    if selectedKeywordCount >= 8{
                        alertKeyword()
                        return false
                    }else{
                        if attitudeOfWork.contains(selectedText){
                            selectedKeywordList[1].append(selectedText)
                        }else{
                            selectedKeywordList[0].append(selectedText)
                        }
                        selectedKeywordCount += 1
                        setButtonActive()
                        return true
                    }
                }

                func cancelSelectedKeyword(_ cell: KeywordSettingTVC, selectedText: String) {
                    var keywordIndex = -1

                    for i in 0...2{
                        keywordIndex = selectedKeywordList[i].firstIndex(of: selectedText) ?? -1
                        if keywordIndex != -1{
                            selectedKeywordList[i].remove(at: keywordIndex)
                            selectedKeywordCount -= 1
                            setButtonActive()
                        }
                    }
                }
            }

         ```
      tableview cell 안에 키워드 버튼들이 있습니다. 그 버튼을 눌렀을 때, 그 눌리 버튼의 이름이 무엇이었는지, 현재 눌린 버튼은 몇개인지를 알아야했다. 
      다른 계층의 뷰 사이의 정보를 처음에는 어떻게 주고 받을지 몰라 static 변수로 눌린 갯수를 +,- 했다. 그 static 변수가 8개가 되었는지 검사할 수 있는 방법이 없었다. 
      이 문제를 delegate를 이용하여 해결하였다. 하위 뷰에 cell에 delegate 함수를 사용하고 그 함수를 상위인 VC에서 구현하여 데이터를 주고 받았다.   
      
    - 기록
    
      ```swift
      @IBAction func btnMoreTapped(_ sender: Any) {
              if sender is UIButton {
                  isExpanded = !isExpanded
                  
                  sizingLabel.numberOfLines = isExpanded ? 0 : 1
                  labelBody.textColor = isExpanded ? UIColor.mainLightGray3 : UIColor.white
                  labelBody.font = .myRegularSystemFont(ofSize: 15)
                  sizingLabel.font = .myRegularSystemFont(ofSize: 15)
                  buttonMore.setImage(isExpanded ? UIImage(named: "btn_chevron_down"): UIImage(named: "btn_chevron_up"), for: .normal)
                  
                  delegate?.moreTapped(cell: self)
              }
          }
      
       func moreTapped(cell: DetailTVC) {
              tableView.beginUpdates()
              tableView.endUpdates()
          }
      ```
    
      기록의 개수에 맞게 드롭다운이 되며 정보가 보여져야 하는 부분에서 테이블뷰의 길이가 동적으로 변했어야 했다.        탭이 눌리면 tableview가 레이아웃을 다시 잡을 수 있게 동적인 길이를 갱신되어야 해서 테이블뷰의 길이는 estimatedRowHeight로 초기에 잡고 automaticDimension을 적용시켜주어 구현했다.
    
      
    
    - 회고
    
      ```swift
      func collectionView(_ collectionView: UICollectionView, heightForLabelAtIndexPath indexPath: IndexPath) -> CGFloat {
              let width = (collectionView.bounds.size.width - (collectionView.contentInset.left + collectionView.contentInset.right + 16 + 16 + 30)) / 2 - 30
              let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
              label.text = taskTitle[indexPath.item]
              label.preferredMaxLayoutWidth = width
              label.numberOfLines = 0
              label.lineBreakMode = NSLineBreakMode.byWordWrapping
              label.contentMode = .scaleToFill
              label.font = .myBoldSystemFont(ofSize: 16)
              label.sizeToFit()
              
              let calculateHeight = label.intrinsicContentSize.height + 120
              return calculateHeight
          }
      ```
    
      회고뷰에서 키워드별 리포트 상세 기록을 조회할 시 해당 행동 기록 text가 가지고 있는 Label 크기에 따라 셀의 height 크기가 각각 다른 UICollectionView를 생성해야 했습니다. 따라서 UICollectionViewLayout 파일을 따로 생성해 collectionView의 높이를 생성하는 collectionView 함수를 override하여 Label에 따라서 셀 크기를 다르게 생성하는 함수 collectionView를 만들었습니다. 해당 함수에서는 들어가는 Label의 높이를 계산해내어 각 셀마다 다른 높이를 가질 수 있도록 했습니다.
    
      
2. **Extension을 통해 작성한 메소드 설명**
    - Extension+Date
    
      ```swift
      extension Date {
          var startOfWeek: Date? {
              var gregorian = Calendar(identifier: .gregorian)
              gregorian.timeZone = TimeZone(secondsFromGMT: 0)!
              guard let monday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
              if Calendar.current.component(.weekday, from: monday) == 1{ //일요일일때
                  return gregorian.date(byAdding: .day, value: 1, to: monday)
              }else{
                  return gregorian.date(byAdding: .day, value: 2, to: monday)
              }
          }
          
          var endOfWeek: Date? {
              var gregorian = Calendar(identifier: .gregorian)
              gregorian.timeZone = TimeZone(secondsFromGMT: 0)!
              guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
              if Calendar.current.component(.weekday, from: self) == 1{ //일요일일때
                  return gregorian.date(byAdding: .day, value: 2, to: sunday)
              }else{
                  return gregorian.date(byAdding: .day, value: 7, to: sunday)
              }
          }
      }
      ```
    
      서버와의 통신에서 현재 시점 주차의 시작날짜와 마지막날짜를 유닉스타임으로 변환해서 보내기 위해 사용
    
      iOS에서 제공되는 Calendar는 매주 일요일을 주의 시작으로 계산하기 때문에 월요일부터 계산하는 포모스트에는 맞지 않아 일요일인 경우를 예외적으로 계산해서 현재 시점의 시작과 끝 날짜를 리턴!
    

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
  - delegate 지정, UI관련 설정 등등 모두 함수로
* 함수는 `extension`에 정의하고 정리
  - `extension`은 목적에 따라 분류
  

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
  4Most_iOS
    |── Source
    │   └── Scene
    │         ├── MyDaily.storyboard
    │         ├── View
    │         │     │── Cell
    │         │     └── VC
    │         └── Network
    │               └── Service
    │               └── Response
    │               └── Resquest
  	└── Resource 
        |── Assets.xcassets
        |── LaunchScreen.storyboard
        |── AppDelegate.swift
      |── SceneDelegate.swift
        └── Info.plist
  
  ```
