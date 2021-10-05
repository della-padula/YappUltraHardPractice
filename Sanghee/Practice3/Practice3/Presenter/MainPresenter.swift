//
//  MainPresenter.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/04.
//

import UIKit

protocol MainView: AnyObject {
    func setHeader()
}

protocol MainViewPresenter {
    func getMainUnits()
}

class MainPresenter: MainViewPresenter {
    var mainUnits: [MainUnit] = []
    var currentDateString: String = ""
    
    init() {
        getMainUnits()
        getDateString()
    }
    
    func getDateString() {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM월 dd일 "
        let dateString = formatter.string(from: Date())

        formatter.dateFormat = "e"
        let day = formatter.string(from: Date())
        var dayString = ""
        
        switch day {
        case "1": dayString = "일요일"
        case "2": dayString =  "월요일"
        case "3": dayString =  "화요일"
        case "4": dayString =  "수요일"
        case "5": dayString =  "목요일"
        case "6": dayString =  "금요일"
        case "7": dayString =  "토요일"
        default: dayString =  "일요일"
        }
        
        currentDateString = dateString + dayString
    }
    
    func getMainUnits() {
        mainUnits = [
            MainUnit(title: "iPad가 처음이라면",
                     subTitle: "고르고 골랐어요",
                     emoji: "📱",
                     backgroundColor: .systemPurple,
                     detailUnits: [
                        DetailUnit(title: "첫 iPad를 구입한 당신.", emoji: "👏", paragraph: """
창의성을 발휘할 준비가 되었나요? 마음껏 그리고, 편집하고, 작곡하고, 써내려가보세요. 업무에 활용할 계획인가요? 더 쉽게 일정을 관리하고 깔끔하게 문서와 프레젠테이션을 작성하세요.

App Store 에디터가 선정한 가장 강력한 iPad 앱들과 함께 시작해봅시다.
"""),
                        DetailUnit(title: "스케치와 디자인", emoji: "✍️", paragraph: """
iPad와 Apple Pencil, 그리고 이 앱들과 함께라면 표현하지 못할 선과 색은 없습니다. 마음이 시키는 대로, 거침 없이 그려보고 칠해보세요.
"""),
                        DetailUnit(title: "이미지 편집", emoji: "🌃", paragraph: """
RAW 포맷 지원과 초고해상도 이미지 편집도 거뜬히 해내는 것은 기본. 강력한 AI를 활용해 동영상과 사진 보정에 날개를 달아주는 앱들이 있습니다. 데스크탑 수준의 전문적인 작업을 경험해보세요.
"""),
                        DetailUnit(title: "문서 작업과 일정 관리", emoji: "🗒", paragraph: """
iPad와 Magic Keyboard가 만나면 그게 곧 모바일 사무실이죠. 집, 카페, 심지어 달리는 택시 안에서도 필요한 일을 처리할 수 있습니다. 꼼꼼하게 일정을 챙기고 멋진 발표 자료를 준비해보세요.
"""),
                        DetailUnit(title: "디제잉과 작곡", emoji: "🎶", paragraph: """
초보와 프로 모두가 십분 활용할 수 있는 앱과 함께라면 iPad가 음악 스튜디오로 변신합니다. 고퀄리티 샘플 팩으로 무장한 작곡 앱부터, 보컬과 비트를 정교하게 분리해주는 똑똑한 디제잉 앱까지 최고만 모았습니다.
"""),
                        DetailUnit(title: "내 손안의 극장", emoji: "🎥", paragraph: """
정확한 색재현율을 자랑하는 iPad의 커다란 스크린을 제대로 만끽해보세요. 영화, 드라마, 예능, 다큐멘터리, 각종 인터넷 방송 등 무궁무진한 볼거리를 아래 앱들에서 만날 수 있어요.
"""),
                        DetailUnit(title: "아이와 함께", emoji: "👶", paragraph: """
iPad는 아이에게 최고의 장난감이 되기도 합니다. 아이의 나이에 맞는 교육 콘텐츠와 즐길거리를 제공하면서, 부모도 안심하고 맡길 수 있는 어린이 앱들을 소개합니다.
"""),
                        DetailUnit(title: "Apple Pencil로 더 멋지게", emoji: "✏️", paragraph: """
iPad의 환상적인 동반자 Apple Pencil. 다양한 앱과 함께라면 Apple Pencil은 명화를 그리는 페인트 브러시가 되기도 하고, 강의의 핵심을 놓치지 않는 똑똑한 필기도구가 되기도 합니다. Apple Pencil과 최고의 궁합을 보여주는 아래 앱들을 확인해보세요.
""")
                     ]),
            MainUnit(title: "오늘의 앱",
                     subTitle: "미리보기",
                     emoji: "🔐",
                     backgroundColor: .systemGreen,
                     detailUnits: [
                        DetailUnit(title: "비밀번호 관리는 곧 불조심과도 같습니다.", emoji: "🔥", paragraph: """
아무리 강조해도 지나침이 없죠. 당신의 소중한 추억과 개인적인 정보가 소셜 미디어와 여러 웹사이트에 차곡히 쌓이는 동안, 해커들의 기술도 꾸준히, 그리고 더욱 정교하게 발달하고 있습니다.

복잡하고 강력한 암호를 만드는 것의 중요성이 점점 커지는 요즘. 어느새 계정마다 제각각인 비밀번호를 관리하는 게 여간 어려운 게 아니죠. 그렇다고 모든 계정을 비슷하거나 동일한 비밀번호로 통일하는 것도 위험하고요.
〈1Password〉가 당신의 스트레스와 걱정을 덜어줄 겁니다.
"""),
                        DetailUnit(title: "마스터 비밀번호로 개인정보를 안전하게 관리하세요.", emoji: "🔑", paragraph: """
〈1Password〉는 당신의 개인정보를 한데 모아 쉽게 관리하도록 도와줍니다. 다양한 소셜 미디어나 웹사이트의 로그인 정보나 비밀 메모를 적어둘 수 있는 노트장, 신용 카드, 신분증을 등록할 수 있죠. 각종 특수문자와 대소문자 구분을 이용해 더욱 안전한 비밀번호를 새롭게 만들어 주기도 합니다.
"""),
                        DetailUnit(title: "〈1Password〉는 모든 비밀번호와 중요 정보를 안전하게 저장하도록 도와줍니다.", emoji: "🔒︎", paragraph: """
그러니 당신은 아주 아주 강력한 마스터 비밀번호를 만들고, 그것 하나만 잘 기억하면 됩니다. 그 후로는 모든 수고를 〈1Password〉가 대신 맡아 주니까요.

이제 편안한 마음으로 온라인 세상을 누빌 일만 남았네요. 비밀번호를 관리하는 번거로움과는 영원히 안녕입니다!
""")
                     ]),
            MainUnit(title: "집중 모드 알차게 활용하는 법",
                     subTitle: "시작하기",
                     emoji: "🧐",
                     backgroundColor: .systemYellow,
                     detailUnits: [
                        DetailUnit(title: "업무나 게임에 온전히 집중하고 싶을 때가 있죠.", emoji: "", paragraph: """
iOS 15과 iPadOS 15의 ‘집중 모드’를 이용해보세요. 집중하는 동안에는 미리 지정해둔 앱과 게임의 알림만 뜨도록 설정할 수 있습니다.
"""),
                        DetailUnit(title: "집중 모드를 설정하세요.", emoji: "⚙️", paragraph: """
화면 우측 상단에서 아래로 쓸어내려 제어 센터를 열고 집중 모드를 누르세요. ‘개인 시간’, ‘업무’, ‘수면’ 집중 모드가 기본으로 보일 겁니다. 하단의 ‘+’ 버튼을 탭하면 피트니스, 운전, 마음 챙기기, 독서 등 더 많은 옵션이 나타나죠.

꼭 필요한 알림만 받도록 설정한 뒤 업무를 마무리하거나, 느긋하게 저녁 식사를 즐길 수 있죠. 오롯이 게임에 집중하며 역대 최고 점수에 도전할 수도 있습니다. 집중 모드마다 알림을 허용할 앱, 게임, 사람을 선택할 수 있습니다. 제어 센터에서 집중 모드 이름 옆에 있는 ‘...’을 탭한 뒤, ‘설정’을 탭하세요.
""")
                     ]),
            MainUnit(title: "모바일 속 오피스",
                     subTitle: "이렇게 하세요",
                     emoji: "🏢",
                     backgroundColor: .systemOrange,
                     detailUnits: [
                        DetailUnit(title: "멀리 떨어져 있어도, 바로 옆에 있는 것처럼 회의할 수 있다면.", emoji: "💻", paragraph: """
북적이는 지하철을 타고 사무실까지 출근하지 않아도 되겠죠. 다른 도시, 다른 나라에 있는 동료들과 자유롭게 아이디어를 나누며 협업하는 것도 가능하고요.

〈ALLO - 비주얼 캔버스〉는 많은 이들이 원격 근무를 할 수 있도록 도와줍니다. 언제 어디서든 iPhone, iPad, 그리고 데스크탑으로 같은 화면을 보며 동료들과 협업할 수 있으니까요.
"""),
                        DetailUnit(title: "캔버스에 모두 모여요", emoji: "📄", paragraph: """
가장 먼저 해야 할 일은 ‘캔버스’를 만드는 것입니다. 회의실의 화이트보드에 해당하죠. 그런 다음 공동 작업자를 모두 초대합니다. 세 동료는 이 캔버스에서 함께 자료를 모으고 아이디어를 나눕니다.
"""),
                        DetailUnit(title: "정리는 포스트잇으로", emoji: "📒", paragraph: """
포스트잇은 〈ALLO - 비주얼 캔버스〉에서 가장 기본적인 도구입니다. 여러 정보를 한눈에 들어오도록 정리하기에 좋습니다. 색과 양식이 다양하고, 캔버스 어디에든 가져다 붙일 수도 있으니까요.
"""),
                        DetailUnit(title: "파일 공유는 쉽고 자유롭게", emoji: "📁", paragraph: """
각자 가지고 있는 파일, 링크와 사진 등 참고 자료를 캔버스에 자유롭게 붙여 넣을 수 있습니다. 그저 파일을 드래그해 드롭하기만 하면 되죠.

파일을 쉽게 공유할 수 있으니, 이메일이나 클라우드 저장소를 통해 주고받아야 하는 번거로움도 없습니다.
"""),
                        DetailUnit(title: "화상 회의를 실시간으로", emoji: "💬", paragraph: """
이렇게 끌어모은 자료에 대해 의견을 남기고 싶다면? 자신이 원하는 위치에 코멘트를 남길 수 있어 편리합니다. 어떤 부분에 대한 피드백인지 몰라 헷갈릴 일도 없죠.

혹은 화상 회의를 열어도 좋습니다. 실시간으로 얼굴을 보며 대화를 나누니 의견을 매끄럽게 전달할 수 있습니다.
"""),
                        DetailUnit(title: "Apple Pencil로 그려요", emoji: "✏️", paragraph: """
〈ALLO - 비주얼 캔버스〉는 iPad에서 Apple Pencil과 함께 쓸 때 더욱더 빛을 발합니다. 캔버스에 공유된 자료와 이미지에 Apple Pencil로 자유롭게 글을 쓰거나 그림을 그릴 수 있으니까요.
""")
                     ]),
            MainUnit(title: "아날로그가 좋아! - 종이편",
                     subTitle: "컬렉션",
                     emoji: "📃",
                     backgroundColor: .brown,
                     detailUnits: [
                        DetailUnit(title: "App Store에도 레트로 열풍이 불고 있습니다.", emoji: "🕹", paragraph: """
필름 카메라를 연상케 하는 앱부터 문방구에서 사 읽던 두꺼운 만화 잡지를 모티프로 삼은 앱, 그리고 호주머니에 넣고 다니던 다마고치 게임기를 닮은 게임까지. 아날로그 시대의 산물을 영감으로 삼은 앱과 게임이 속속 출시되고 있습니다.

오늘은 그중에서 종이에 대한 향수를 불러일으키는 앱들을 소개합니다.
"""),
                        DetailUnit(title: "만화경", emoji: "🔭", paragraph: """
여느 웹툰 앱과는 조금 다릅니다. 어린 시절 즐겨 보던 종이 만화책에 더 가깝달까요?

〈만화경〉은 격주 수요일마다 새로운 만화 잡지 한 권을 발행합니다. 생김새도, 구성도 과거의 만화책을 똑 닮았죠.

다양한 작품의 따끈따끈한 에피소드는 물론 웹툰 작가 인터뷰까지 눌러 담았고, 디지털 애독자 엽서에 글을 또박또박 적어 보내던 추억이 되살아날 겁니다.
"""),
                        DetailUnit(title: "SLOWLY", emoji: "🐢", paragraph: """
기술이 발전한 지금, 우리는 지구 반대편에 있는 사람에게도 단 몇 초 만에 편지를 보낼 수 있습니다.

하지만 손 편지를 우체통에 넣고 설레는 마음으로 답장을 기다리던 시절이 그리울 때도 있습니다. 그럴 땐, 펜팔 앱 〈SLOWLY〉를 이용해보세요.

짧게는 2시간, 길게는 이틀. 펜팔이 사는 곳에 따라 배달 소요 시간이 달라집니다. 천천히, 그리고 여유롭게 전 세계 친구들과 의미 있는 편지를 주고받으세요.
"""),
                        DetailUnit(title: "백자 하루", emoji: "✒️", paragraph: """
빨간색 칸으로 빼곡히 메워진 추억의 원고지. 학창 시절, 이 원고지에 글을 쓰던 기억이 있나요? 그렇다면 〈백자 하루〉가 무척 반가울 겁니다.

한 글자, 한 글자 눌러쓰며 원고지를 채워가는 쾌감. 〈백자 하루〉에 나의 일상을 매일매일 기록하며 직접 경험해보세요. 꼭 100자를 써야 하는 건 아니니, 기호에 맞게 원고지 크기를 설정하세요.
"""),
                        DetailUnit(title: "Paper", emoji: "📃", paragraph: """
그림을 그리는 스케치북, 필기를 하는 공책, 혹은 일상을 기록하는 일기장. 〈Paper〉에 마련된 ‘저널’은 그 무엇이든 될 수 있습니다.

저널의 표지부터 종이 재질까지 취향에 맞춰 설정할 수 있죠. 묵직한 연필, 시원시원한 마커, 반듯한 줄자 등등 다양한 도구도 마련되어 있으니, 창의력을 마음껏 발휘해보세요.
""")
                     ]),
            MainUnit(title: "인생이라는 마라톤",
                     subTitle: "오늘의 게임",
                     emoji: "🏃‍♂️",
                     backgroundColor: .systemBlue,
                     detailUnits: [
                        DetailUnit(title: "내가 인생에서 후회하는 거?", emoji: "👦", paragraph: """
한두 가지가 아냐. 학생 때 적성을 못 찾았어. 갈팡질팡하다가 취직했지만 행복하지 않았지. 박하게 살다 보니 제대로 된 취미 하나 갖지 못했고. 돈도 많이 벌고 싶었는데 그것도 이루지 못했네.
"""),
                        DetailUnit(title: "주변 사람들은 내가 차갑다고 했어.", emoji: "👨", paragraph: """
당장 입에 풀칠하는 게 우선이다 보니 가족은 뒷전이었거든. 아이가 자라는 모습, 바쁘다는 핑계로 놓친 게 미안하고. 아내가 갑자기 쓰러져 잘해 줄 틈도 없이 보낸 게 두고두고 한이 돼.
"""),
                        DetailUnit(title: "하지만 누굴 탓하겠나.", emoji: "👴", paragraph: """
내 삶은 결국 내가 선택한 것들의 결과물인걸. 우린 모두 인생이란 게임을 달리고 있어. 그 과정에서 내가 무엇을 취하고 무엇을 버리느냐에 따라 나의 삶이 결정되는 거야.
"""),
                        DetailUnit(title: "인생이란 원래,", emoji: "🧎‍♂️", paragraph: """
계획대로 술술 풀리지 않는 법. 모든 걸 다 얻을 수는 없다는 것. 그러니까 돈을 많이 벌어도 행복하지 않을 수 있고, 주변에 친구가 없어도 행복하게 살 수 있다는 얘기야.
"""),
                        DetailUnit(title: "내 후회는 이렇게나 깊지만 아직 끝난건 아냐.", emoji: "🏃‍♂️", paragraph: """
우리에겐 아직 기회가 있어. 내 인생을 되돌아보고, 내 선택들을 곰곰이 생각해 보고, 다시 살아 볼 기회.

당신, 〈인생게임〉에서 달려 보지 않을래?
""")
                     ]),
            MainUnit(title: "우리 잠깐 걸을래요?",
                     subTitle: "건강한 삶",
                     emoji: "💪",
                     backgroundColor: .systemTeal,
                     detailUnits: [
                        DetailUnit(title: "요즘 걷기 좋은 날씨죠.", emoji: "🚪", paragraph: """
가벼운 운동화를 신고 바람막이 한 장 걸치고 문을 나서면 그만입니다. 러닝이나 인터벌 트레이닝에 비하면 단촐해 보일지라도, 운동 효과도 있으면서 부상 위험도 적죠. 언제 시작해도 좋은 운동인데, 지금 시작하기엔 정말 딱입니다.

쌀쌀하다고 움츠러들지 말고, 이 앱들과 함께 밖으로 나가봅시다.
"""),
                        DetailUnit(title: "만보기부터 챙겨볼까요", emoji: "🚶", paragraph: """
만보기 앱은 거창할 필요가 없습니다. 오늘 내가 얼마나 걸었고, 칼로리는 얼마나 소모했는지, 목표량을 채우려면 얼마나 더 움직여야 하는지 쉽게 확인할 수 있으면 되죠. 가독성 좋고 기본기에 충실한 〈StepsApp〉이 적절할 것 같군요.
"""),
                        DetailUnit(title: "멀리 가려면 함께 가라는 말이 있죠", emoji: "🏃‍♀️", paragraph: """
〈Pacer〉에는 국내 사용자들이 나만의 코스를 공유하고 있습니다. ‘루트’ 메뉴로 들어가면 공유된 코스를 볼 수 있죠. 걷거나 뛰는 걸 즐기는 사람들이 직접 발굴한 코스를 시도해보는 것도 재미있겠는데요?
"""),
                        DetailUnit(title: "활동량을 간편하게 체크하세요", emoji: "⌚️", paragraph: """
Apple Watch에 〈HealthFace〉를 받아두면 활동량 체크가 훨씬 간편해집니다. 걸음 수, 거리, 소모한 열량 등 핵심 정보를 Apple Watch 페이스에 띄울 수 있기 때문이죠.

별도의 앱을 열 필요도 없이 손목만 봐도, 오늘 앞으로 얼마나 더 움직여야 할지 파악할 수 있게 됩니다.
""")
                     ])
        ]
    }
}
