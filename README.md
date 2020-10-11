# RUNNERS HI - iOS
🏃🏻‍♂️🏃🏻‍♀️ 러너스하이 iOS Ver.릴리즈
- 진행기간 : 2020년 8월 24일 ~ 현재진행중<br>
[이전 리드미 보기](https://github.com/RunnersHi/RunnersHi_iOS)

<img width="800" src="https://user-images.githubusercontent.com/51286963/95125361-d4646880-078f-11eb-9ae1-f55cbc62b208.jpg">

## 러닝을 게임처럼, 러너스하이
> 우리는 '함께' 뛸 때 더 많은 시너지를 만들어냅니다. 요즘 세대들은 러닝 크루에 소속되어 러닝을 즐기곤 하지만, Offline 러닝크루는 고정된 시간과 장소라는 한계점을 가지고 있습니다.  우리는 같이 달리고 싶지만, 달릴 수 없는 순간들이 존재한다는 점에 집중하고자 합니다.  우리의 서비스를 통해 시공간의 제약없이 다양한 사람들과 함께 달림으로써 건강한 라이프 스타일을 만들어나가길 바랍니다. 

####  ⭐️ 기존 러닝 어플리케이션과의 확실한 차별화 요소를 적용했습니다.  
: 기존 러닝 어플리케이션과의 확실한 차별화 요소를 적용했습니다.  

#### ⭐️ *따로, 또 같이*  함께 하는 가치를 추구하고자 합니다.   
: 어떤 단체에 소속되지 않아도, 굳이 친구와 약속을 잡고 만나지 않아도, 사용자는 언제 어디서든 나와 함께 뛸 상대를 찾아 같이 러닝을 즐길 수 있습니다.

####  ⭐️ 트렌디한 디자인적 요소를 통해 시각적인 즐거움을 얻을 수 있습니다.    
: 특정 목표를 달성하면 개성있는 여러 가지 뱃지를 획득할 수 있음과 동시에 다양한 러너 랭킹을 통해 사용자의 즐거움을 도모하고자 합니다. 또, 누구나 사용하기 쉬운 UX 요소는 즐거움을 배로 향상시켜 줄거에요.

=> [발표영상 보기](https://youtu.be/BWE3SevkljM)

------------
### A. Setting
- [ Coding Convention ](./README/CodingConvention.md)<br>
- [ Foldering ](./README/Foldering.md)<br>

------------
### B-1. 개발 환경 및 라이브러리
![Xcode](https://img.shields.io/badge/Xcode-12.0.1-blue)
![swift](https://img.shields.io/badge/swift-5.0-green)
![iOS](https://img.shields.io/badge/iOS-13.5-yellow)
![Alamofire](https://img.shields.io/badge/Alamofire-4.8.2-orange)
![NMapsMape](https://img.shields.io/badge/NMapsMape-3.x-red)
  
------------
### B-2. WORKFLOW

![최종과제  RUNNER'S HI WORKFLOW_page-0001](https://user-images.githubusercontent.com/51286963/87786064-4c4b8280-c874-11ea-8b41-86404fccc6df.jpg)

------------

### B-3. 변경된 혹은 추가된 기능

|  화면 이름 | 기능 | 구현 |담당자|
|:--------:|--------:| --------:|--------:|
| 회원 가입|회원 가입 제거|🔵|김민희|
|스플래쉬화면|uuid로 계정 생성|🔵|김민희|
|매칭화면 |소켓 통신 제거 |🔵|김민희|
|매칭요청화면|http-post 방식으로 매칭 요청|🔵|김민희|
|매칭성공화면|http-get 방식으로 상대방 정보 받아오기|🔵|김민희|
|러닝화면|매칭된 사용자와 순위 비교||김민희|
|러닝화면|http-put 방식으로 순위 변경 알림||김민희|
|러닝기록상세보기화면|http방식으로 뛰었던 정보 받아오기||최영재|
|레코드탭|뱃지보기 제거|🔵|최영재|

------------

### C-1. 개발 설명

#### Tab Bar

: Tab Bar을 이용해 각 스토리보드를 이어주며 이동 가능


#### Splash 화면 

🥳 앱을 처음 구동할 때 뜨는 화면. UUID 체크인도 여기서 발생한다.<br>

<img width="200" alt="splashView" src="https://user-images.githubusercontent.com/51286963/95124979-44beba00-078f-11eb-8f1a-d6bf2843a816.png">

#### Running Tab(홈 화면)

🥳 Main 화면. 일러스트롤 포함하며, RUN NOW 버튼 클릭시 주요 기능은 매칭 서비스가 시작된다. 원하는 매칭 러너의 조건을 설정하고 매칭이 되면 상대방 프로필을 확인한 후, 러닝이 시작된다. <br>
<br>
<img width="200" alt="RunningTab" src="https://user-images.githubusercontent.com/51286963/87796596-891f7580-c884-11ea-8cf8-99b4282ce165.png"> <img width="200" alt="RunningTab-매칭" src="https://user-images.githubusercontent.com/51286963/87796611-8de42980-c884-11ea-9ef5-bf6b83d8c537.png"> <img width="200" alt="스크린샷 2020-07-17 오후 11 06 42" src="https://user-images.githubusercontent.com/51286963/87796615-8e7cc000-c884-11ea-9142-45a08d8d01f7.png"> <br><img width="200" alt="스크린샷 2020-07-17 오후 11 06 46" src="https://user-images.githubusercontent.com/51286963/87796620-8faded00-c884-11ea-8515-7d4529d50817.png"> <img width="200" alt="스크린샷 2020-07-17 오후 11 06 49" src="https://user-images.githubusercontent.com/51286963/87796623-90468380-c884-11ea-8def-714195e5e0c1.png">

🥳 매칭이 되면 상대방 프로필을 확인한 후, 러닝이 시작된다. 실시간으로 자신의 속도(km), 페이스(pace), 남은 시간이 표시되고 현재 자신이 뛰고있는 위치가 지도(네이버)를 통해 표시된다.<br>
🤓 함께 뛰는 러너와의 실시간 순위를 보여줘 러닝 욕구를 더욱 자극시킨다. 

<img width="180" alt="매칭된러너프로필" src="https://user-images.githubusercontent.com/51286963/87796841-e0254a80-c884-11ea-93cd-25f0d258638a.PNG"> <img width="180" alt="매칭_러닝중" src="https://user-images.githubusercontent.com/51286963/95125562-1f7e7b80-0790-11eb-8a1b-81284363d3bd.png"> <img width="180" alt="실시간러닝중" src="https://user-images.githubusercontent.com/51286963/87827334-ade01100-c8b5-11ea-8f5b-d069c660ac6e.gif">
<br><img width="180" alt="졌다" src="https://user-images.githubusercontent.com/51286963/87799758-90e11900-c888-11ea-8427-e297a727eb00.png"><img width="180" alt="이겼다" src="https://user-images.githubusercontent.com/51286963/87799763-92aadc80-c888-11ea-98fd-eb77e28c1044.png">


#### Record Tab

: 자신이 지금까지 쌓아온 러닝 기록을 확인할 수 있다.

<img width="200" alt="record" src="https://user-images.githubusercontent.com/51286963/95125767-67050780-0790-11eb-8c6c-c090acc50a5d.png">



#### Ranking Tab

: 현재 이 어플에서 '이달의 러너', '명예의 전당', '졌.잘.싸' 로 나눠진 3개의 랭킹 순위를 확인할 수 있다.

<img width="200" alt="RankingTab" src="https://user-images.githubusercontent.com/51286963/87797396-92f5a880-c885-11ea-999d-05bee8e66e71.png">

#### MyPage Tab

: 자신의 기본 정보(프로필 사진, 닉네임, 레벨, 전적)을 확인할 수 있고 모아둔 뱃지를 간략히 확인할 수 있다.

<img width="200" alt="MypageTab" src="https://user-images.githubusercontent.com/51286963/87797520-bf112980-c885-11ea-9010-2eca20b574c5.png">

------------

### C-2. 🌟새로 적용한 기능🌟
- UUID 체크인<br>
: UUID는 Universally Unique IDentifier의 약어로 범용 고유 식별자이다. uuid의 포맷은 총 36개의 문자를 8–4–4–4–12로 구분한 형태이다. 회원가입을 제거한 이유는 이 전에는 회원가입을 꼭 해야지만 기능을 누릴 수 있었는데 그렇게 된다면 많은 초기 사용자가 유입되지 못하는 이유가 될 수 있다. 이런 이유로 어플을 둘러볼 수 있게 하기 위해서 uuid를 사용해 회원가입 대신 사용하고 있다.

    ``` swift
    CheckInUUID(uuid: UIDevice.current.identifierForVendor?.uuidString ?? "")
    ```

    ``` swift
    struct UuidDetail: Codable {
    let accessToken, nickname: String
    let gender, image, level: Int
    let badge: String
    let win, lose: Int
    }
    ```
    : UIDevice.current.identifierForVendor?.uuidString을 통해 기기 고유의 uuid값을 추출해온다. 그리고 그 값을 서버에 넘기면 서버는 이 기기가 처음 어플에 들어온 사용자인지, 혹은 이미 방문했던 사용자인지 구분한다. 만약 처음 어플에 들어온 사용자라면 임시 계정을 발급해주고 두번째 이상 방문이라면 그 전에 발급받았던 임시 계정을 보내준다. 어플을 사용하면서 제일 필요한 토큰과 마이페이지에 필요한 정보들을 http통신을 통해 받는다. 

- CoreData <br>
: CoreData는 프레임 워크이다. 그 중 Persistence 기능은 관계형 데이터베이스인 SQLite을 통해 지원되기 때문에 이 기능을 이용해 디바이스에 permanent data(영구적인 데이터)를 저장할 수 있다.
    <img width="560" alt="CoreData" src="https://user-images.githubusercontent.com/51286963/95127024-4dfd5600-0792-11eb-8aed-3830bec840b6.png">
    ```swift
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Information> {
        return NSFetchRequest<Information>(entityName: "Information")
    }

    @NSManaged public var accessToken: String?
    @NSManaged public var badge: String?
    @NSManaged public var gender: Int64
    @NSManaged public var level: Int64
    @NSManaged public var image: Int64
    @NSManaged public var lose: Int64
    @NSManaged public var nickname: String?
    @NSManaged public var win: Int64
    ```
    : 위의 uuid 체크인에서 받아온 정보를 CoreData에 저장하고자 한다. 그 이유는 사용자의 정보는 매칭 할 때, 매칭 중, 매칭 후의 화면에서도 쓰이고 마이페이지 화면에서도 쓰이는 등 자주 사용되는 정보이고 특히 토큰값은 서버에 전달할 일이 많기 때문에 UserDefaults보다 CoreData를 사용해서 저장하는 것이 접근성이 더 좋다고 판단했다. 

    ``` swift
    func saveUser(accessToken: String, nickname: String, gender: Int64, level: Int64, image: Int64, badge: String, win: Int64, lose: Int64, onSuccess: @escaping ((Bool) -> Void)) {
        if let context = context,
            let entity: NSEntityDescription
            = NSEntityDescription.entity(forEntityName: infoModel, in: context) {
            if let user: Information = NSManagedObject(entity: entity, insertInto: context) as? Information {
                user.accessToken = accessToken
                user.nickname = nickname
                user.level = level
                user.gender = gender
                user.image = image
                user.badge = badge
                user.win = win
                user.lose = lose
                
                contextSave { success in
                    onSuccess(success)
                }
            }
        }
    }
    ```
    : 위에서 생성해준 Information 구조와 같게 값을 저장하는 함수를 만들어준다. 
    
    ``` swift
    fileprivate func saveUserInfo(_ accessToken: String, nickname: String, gender: Int64, level: Int64, image: Int64, badge: String, win: Int64, lose: Int64) {
        CoreDataManager.shared.saveUser(accessToken: accessToken, nickname: nickname, gender: gender, level: level, image: image, badge: badge, win: win, lose: lose) { onSuccess in
            print("saved = \(onSuccess)")
        }
    }
    ```
    : 서버에 연결해 값을 받아오는데 성공하면 이 값들을 사용자의 정보를 저장하는 CoreData 함수에 전달한다. 그리고 앱을 새로 접속할 때 마다 새로운 토큰으로 변경되기 때문에 앱을 새로 시작할 때는 information에 data가 저장되어 있는지 확인한 후, 있다면 삭제하고 새로 받아온 값을 저장해주는 것이 중요하다. 


------------
### D. 팀원 역할 및 소개
- 김민희 [ Repo ](https://www.notion.so/Kim-Min-Hee-b8c50856e43943ce9611baea5c14dd8b) : 러너스하이 iOS 리드개발자, MainTab 구현 및 러닝 구현 담당 <br>
- 최영재 [ Repo ](https://github.com/realwhyjay) : 러너스하이 iOS 서브개발자, RankTab / RecordTab / MyPabeTab / SignTab 담당 
------------
### F. 결과 / 성과 
: IT 창업 동아리 26th ‘SOPT’ APPJAM 대상 수상, 현재 앱스토어 출시 준비 중.

