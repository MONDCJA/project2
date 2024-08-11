
<!DOCTYPE html>
<html lang="kor" dir="ltr">
  <head>
    <title>SELECTO COFFEE</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="Keywords" content="카페 창업, 반값창업 행사중, 인테리어 비용 할인혜택, 입맛에 따라 즐기는 5가지 아메리카노"/>
    <meta name="Description" content="카페 창업, 반값창업 행사중, 인테리어 비용 할인혜택, 입맛에 따라 즐기는 5가지 아메리카노"/>
    <link rel="canonical" href="https://www.selecto.co.kr/index.asp">
        
    <meta property="og:type" content="website">
    <meta property="og:title" content="셀렉토커피" />
    <meta property="og:description" content="커피전문점,카페창업,아메리카노 전문점,브런치 카페,입맛에 따라 골라먹는 커피전문점등" />
    <meta property="og:url" content="https://www.selecto.co.kr" />
    <meta property="og:image" content="https://www.selecto.co.kr/assets/images/main/logo.png">
    <meta name="facebook-domain-verification" content="r6fwsds1v190yg0a91f01zrcswvrud" />
    <!-- 공통 css -->
    <link rel="stylesheet" href="../assets/css/reset.css?ver=20240709_01" type="text/css" />
    <link rel="stylesheet" href="../assets/css/header.css?ver=20240709_01" />
    <link rel="stylesheet" href="../assets/css/common.css?ver=20240709_01" />
    <link rel="stylesheet" href="../assets/css/footer.css?ver=20240709_01" />
    <link rel="shortcut icon" href="https://www.selecto.co.kr/assets/images/icon/newlogo_f2.ico" type="image/x-icon">
    <!-- 공통 JS -->
    <script src="../assets/js/plugin/jquery-3.5.1.min.js"></script>
    <script src="../assets/js/common.util.js?ver=20240709_01" charset="utf-8"></script>
    <!-- 플러그인 css,JS -->
    <link rel="stylesheet" href="../assets/css/plugin/swiper-bundle.min.css" />
    <script src="../assets/js/plugin/swiper-bundle.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="../assets/css/whatsnew-main.css" />
    <script type="text/javascript">
      $(document).ready(function() {
        getNewIngList();
        getNewCloseList('1');

        $(document).on("click", ".ingDetail", function() {
            var _$this = $(this);
            var _idx = _$this.attr("data-idx");
            var _slideInx = _$this.attr("data-slideInx");
            document.location.href = "whatsnew_detail.asp?boardIdx="+_idx+"&slideInx="+_slideInx;
        });
        $(document).on("click", ".closeDetail", function() {
            var _$this = $(this);
            var _idx = _$this.attr("data-idx");
            var _page = _$this.attr("data-page");
            document.location.href = "whatsnew_detail.asp?boardIdx="+_idx+"&page="+_page;
        });
      });
      function getNewIngList(){
        let pageSize = 100;
        let totalPages = 0;
        let strHtml = "";
        let ingIdx,ingSubject,ingImage,ingStartDate,ingEndDate;

        $.ajax({
          type: 'post'
          , async: true
          , url: "ajaxBrand.asp"
          , data: {"cmd":"getBoardList","board":"new","part":"ing","pageSize":pageSize,"page":"1"}
          , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
          , dataType: "json"
          , success: function(data) {
              // set data. 
              //console.log(data);
              if(typeof(data) != "object") {
                alert('error');
                return;
              }else{
                if(data.result == "Y"){
                  var cnt = data.dataList.length;
                  var totalPageCnt = data.totalPage;

                  $("#ingList").empty();     //리스트 초기화

                  if(totalPageCnt > 0){

                    for(i=0; i<cnt; i++)
                    {
                      
                      ingIdx        = data.dataList[i]['idx'];
                      ingSubject    = data.dataList[i]['subject'];
                      ingImage      = data.dataList[i]['pImage'];
                      ingStartDate  = data.dataList[i]['startDate'];
                      ingEndDate    = data.dataList[i]['endDate'];

                      strHtml += "<li class=\"whats-news-whats-new ingDetail cursor\" data-idx='"+ingIdx+"' data-slideInx='"+i+"'>";
                      strHtml += "  <div class=\"whats-new-img\"><img src=\""+ingImage+"\"></div>";
                      strHtml += "  <div class=\"whats-new-info\">";
                      strHtml += "    <span>"+ingSubject+"</span>";
                      strHtml += "    <span>"+ingStartDate+" ~ "+ingEndDate+"</span>";
                      strHtml += "  </div>";
                      strHtml += "</li>";
                    }
                    $("#ingList").append(strHtml);
                  }else{
                    $("#ingEmpty").removeClass("l-hidden");
                  }
                }else{
                  alert(data.msg);
                  return;
                }
              }
            }
          , error: function(data, status, err) {
              alert('error');
              return;
            }
        });
      }
      function getNewCloseList(curPage){
        let pageSize = 8;
        let totalPages = 0;
        let strHtml = "";
        let pagingHtml = "";
        let closeIdx,closeSubject,closeImage,closeStartDate,closeEndDate;

        $.ajax({
          type: 'post'
          , async: true
          , url: "ajaxBrand.asp"
          , data: {"cmd":"getBoardList","board":"new","part":"close","pageSize":pageSize,"page":curPage}
          , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
          , dataType: "json"
          , beforeSend: function() {
             $('.loading').show().fadeIn('fast'); 
             $(".loading").delay(100).fadeIn();
            }
          , success: function(data) {
              // set data. 
              //console.log(data);
              if(typeof(data) != "object") {
                alert('error');
                return;
              }else{
                if(data.result == "Y"){
                  var cnt = data.dataList.length;
                  var totalPageCnt = data.totalPage;

                  $("#closeList").empty();     //리스트 초기화
                  $("#div_paginate").empty();           //페이징 초기화
                  if(totalPageCnt > 0){
                    totalPages = Math.ceil(totalPageCnt / pageSize);
                    pagingHtml = pageLink(curPage, totalPages, "getNewCloseList");
                    for(i=0; i<cnt; i++)
                    {
                      
                      closeIdx        = data.dataList[i]['idx'];
                      closeSubject    = data.dataList[i]['subject'];
                      closeImage      = data.dataList[i]['pImage'];
                      closeStartDate  = data.dataList[i]['startDate'];
                      closeEndDate    = data.dataList[i]['endDate'];

                      strHtml += "<li class=\"whats-news-whats-new closeDetail cursor\" data-idx='"+closeIdx+"' data-page='"+curPage+"'>";
                      strHtml += "  <div class=\"whats-new-img\">";
                      strHtml += "    <img class=\"end-mark\" src=\"../assets/images/whats-new/event-end.png\"/>";
                      strHtml += "    <img class=\"img-bkout\" src=\""+closeImage+"\"/>";
                      strHtml += "  </div>";
                      strHtml += "  <div class=\"whats-new-info\">";
                      strHtml += "    <span>"+closeSubject+"</span>";
                      strHtml += "    <span>"+closeStartDate+" ~ "+closeEndDate+"</span>";
                      strHtml += "  </div>";
                      strHtml += "</li>";
                    }
                    $("#closeList").append(strHtml);
                    $("#div_paginate").html(pagingHtml);
                  }else{
                    $("#closeEmpty").removeClass("l-hidden");
                  }
                }else{
                  alert(data.msg);
                  return;
                }
              }
            }
          , error: function(data, status, err) {
              alert('error');
              return;
            }
          , complete: function() { 
              $(".loading").delay(100).fadeOut();
            }
        });
      }
    </script>
	<!-- Google Tag Manager 20240723 송인문과장요청-->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-5RZG6QF9');</script>
<!-- End Google Tag Manager -->
  </head>
  <body>
        <!--마우스 커서 모양변경 시작-->
    <div id="cursor"></div>
    <script src="../assets/js/mouse.js"></script>
    <!--마우스 커서 모양변경 끝-->
    <div id="mobile__menu">
            <!--로딩바시작-->
      <main class="container">
          <article class="loading" >
              <div class="box">
                  <div class="loader1"></div>
              </div>
          </article>
      </main>
      <!--로딩바끝-->
      <div class="mobile-menu__open">
        <div class="mobile-menu__open-contents">
          <div class="mobile-menu-closeBtn"></div>
          <div>
            <div class="menus">
              <div class="category-for-active">
                <div class="hidden-menuList">
                  <div class="menus-menu">셀렉토커피</div>
                  <div class="menus-arrow"></div>
                </div>
                <div class="category-list">
                  <a class="menus-menu-category" href="/brand/story.asp">브랜드 스토리</a>
                  <a class="menus-menu-category" href="/brand/history.asp">HISTORY</a>
                  <a class="menus-menu-category" href="/brand/competitivity.asp">경쟁력</a>
                  <!--<a class="menus-menu-category" href="/brand/oneforone.asp">ONE FOR ONE</a>-->
                </div>
              </div>
              <div class="category-for-active">
                <div class="hidden-menuList">
                  <div class="menus-menu">메뉴</div>
                  <div class="menus-arrow"></div>
                </div>
                <div class="category-list">
                  <!--<a class="menus-menu-category">MENU SUMMARY</a>-->
                  <a class="menus-menu-category" href="/brand/menu_main.asp?page=1&kind=Signature">Signature</a>
                  <a class="menus-menu-category" href="/brand/menu_main.asp?page=1&kind=Cookies">Season</a>
				  <a class="menus-menu-category" href="/brand/menu_main.asp?page=1&kind=Coffee">Coffee</a>
                  <a class="menus-menu-category" href="/brand/menu_main.asp?page=1&kind=Beverage">Beverage</a>
                  <a class="menus-menu-category" href="/brand/menu_main.asp?page=1&kind=Deli">Deli&Dessert</a>
                  <a class="menus-menu-category" href="/brand/menu_main.asp?page=1&kind=MD">MD</a>
                </div>
              </div>
              <div class="category-for-active">
                <div class="hidden-menuList">
                  <div class="menus-menu" >매장안내</div>
                  <div class="menus-arrow"></div>
                </div>
                <div class="category-list">
                  <a class="menus-menu-category" href="/brand/store_search.asp">매장찾기</a>
                  <!--<a class="menus-menu-category" href="store_scheduled.asp">오픈 예정 매장</a>-->
                </div>
              </div>
              <div class="category-for-active"> 
                <div class="hidden-menuList">
                  <div class="menus-menu">WHAT'S NEW</div>
                  <div class="menus-arrow"></div>
                </div>
                <div class="category-list">
                  <a class="menus-menu-category" href="/brand/whatsnew_main.asp">새로운 소식</a>
                  <a class="menus-menu-category" href="/brand/whatsnew_report.asp">보도자료</a>
                </div>
              </div>
            </div>
            <div class="sns">
              <a href="https://blog.naver.com/maxone01" target="_blank"><img src="../assets/images/icon/h-link-naver.svg" alt=""/></a>
              <a href="https://www.youtube.com/channel/UCM8GQsYfu6I4MgYwjnCJXrg/featured" target="_blank"><img src="../assets/images/icon/h-link-youtube.svg" alt=""/></a>
              <a href="https://www.instagram.com/selecto_coffee/" target="_blank"><img src="../assets/images/icon/h-link-instagram.svg" alt=""/></a>
            </div>
            <button class="menuLink" onclick="document.location.href='/founded/main.asp'">창업안내</button>
          </div>
        </div>
      </div>
    </div>
    <!-- start of :: wrap -->
    <div id="wrap">
      <!-- start of :: header -->
      <header id="header">
        <header class="header">
  <div class="header__inner">
    <h1 class="logo">
      <a href="main.asp">
        <img src="../assets/images/main/new_logo.png" alt="logo" />
      </a>
    </h1>

    <ul class="menu">
      <li class="menulist" onclick="document.location.href='/brand/story.asp';">셀렉토커피</li>
      <li class="menulist" onclick="document.location.href='/brand/menu_main.asp?page=1&kind=Signature';">메뉴</li>
      <li class="menulist" onclick="document.location.href='/brand/store_search.asp';">매장안내</li>
      <li class="menulist" onclick="document.location.href='/brand/whatsnew_main.asp';">WHAT'S NEW</li>
    </ul>

    <div class="link">
      <button class="link__found" onclick="document.location.href='/founded/main.asp';">창업안내</button>
      <a href="https://blog.naver.com/maxone01" target="_blank"><img src="../assets/images/icon/h-link-naver.svg" alt=""/></a>
      <a href="https://www.youtube.com/channel/UCM8GQsYfu6I4MgYwjnCJXrg/featured" target="_blank"><img src="../assets/images/icon/h-link-youtube.svg" alt=""/></a>
      <a href="https://www.instagram.com/selecto_coffee/" target="_blank"><img src="../assets/images/icon/h-link-instagram.svg" alt=""/></a>
    </div>

    <div class="mobile-menu">
      <div class="menu-burger">
        <div class="burger__bar"></div>
        <div class="burger__bar"></div>
        <div class="burger__bar"></div>
      </div>
    </div>
  </div>

  <div class="header-hidden for-mouseOut">
    <div class="header-hidden__inner">
      <ul class="menu-hidden">
        <ul>
          <li class="menu-hidden-list">
            <a class="list-link" href="/brand/story.asp">브랜드 스토리</a>
          </li>
          <li class="menu-hidden-list">
            <a class="list-link" href="/brand/history.asp">HISTORY</a>
          </li>
          <li class="menu-hidden-list">
            <a class="list-link" href="/brand/competitivity.asp">경쟁력</a>
          </li>
          <!--<li class="menu-hidden-list">
            <a class="list-link" href="/brand/oneforone.asp">ONE FOR ONE</a> 
          </li>-->
        </ul>
        <ul>
          <!--<li class="menu-hidden-list">
            <a class="list-link" href="/brand/menu_main.asp">MENU SUMMARY</a>
          </li>-->
          <li class="menu-hidden-list">
            <a class="list-link" href="/brand/menu_main.asp?page=1&kind=Signature">Signature</a>
          </li>
		  <li class="menu-hidden-list">
            <a class="list-link" href="/brand/menu_main.asp?page=1&kind=Cookies">Season</a>
          </li>
          <li class="menu-hidden-list">
            <a class="list-link" href="/brand/menu_main.asp?page=1&kind=Coffee">Coffee</a>
          </li>
          <li class="menu-hidden-list">
            <a class="list-link" href="/brand/menu_main.asp?page=1&kind=Beverage">Beverage</a>
          </li>
          <li class="menu-hidden-list"><a class="list-link" href="/brand/menu_main.asp?page=1&kind=Deli">Deli&Dessert</a></li>
          <li class="menu-hidden-list"><a class="list-link" href="/brand/menu_main.asp?page=1&kind=MD">MD</a></li>
        </ul>
        <ul>
          <li class="menu-hidden-list">
            <a class="list-link" href="/brand/store_search.asp">매장찾기</a>
          </li>
          <!--<li class="menu-hidden-list">
            <a class="list-link" href="/brand/store_scheduled.asp">오픈 예정 매장</a>
          </li>-->
        </ul>
        <ul>
          <li class="menu-hidden-list">
            <a class="list-link" href="/brand/whatsnew_main.asp">새로운 소식</a>
          </li>
          <li class="menu-hidden-list">
            <a class="list-link" href="/brand/whatsnew_report.asp">보도자료</a>
          </li>
        </ul>
      </ul>
    </div>
  </div>
</header>
<script>
  // [공통사용 스크립트] 스크롤 방향 감지, 스크롤 방향 아래 = 헤더 사라짐 / 스크롤 방향 위 = 헤더 나타남
  var idheader = document.querySelector("#header");
  var header = document.querySelector(".header");

  var headerMoving = function (direction) {
    if (direction === "up") {
      idheader.className = "";
      header.className = "";
    } else if (direction === "down") {
      idheader.className = "scrollDown";
      header.className = "scrollDown";
    }
  };
  var prevScrollTop = 0;

  window.addEventListener("scroll", function () {
    var nextScrollTop = window.pageYOffset || 0;
    let value = this.scrollY;

    if (nextScrollTop > prevScrollTop && value > 0) {
      headerMoving("down");
    } else if (nextScrollTop < prevScrollTop || value <= 1) {
      headerMoving("up");
    }
    prevScrollTop = nextScrollTop;
  });

  // 221027 수정
  // 헤더 메뉴펼침 마우스무브 이벤트
  var Header = document.querySelector(".header");
  var Hidden_header = document.querySelector(".header-hidden");
  var menulist = document.querySelectorAll(".menulist");
  var foundlink = document.querySelector(".link__found");
  var mouseOut = document.querySelector(".for-mouseOut");
  var listLink = document.querySelectorAll(".list-link");

  for (let menu of menulist) {
    menu.addEventListener("mousemove", function () {
      Hidden_header.classList.add("active");
      foundlink.classList.add("active");
      Header.classList.add("active");
      menu.classList.add("active");

      Hidden_header.classList.add("active");
      foundlink.classList.add("active");
      Header.classList.add("active");
      menu.classList.add("active");
    });

    Header.addEventListener("mouseleave", function () {
      Hidden_header.classList.remove("active");
      foundlink.classList.remove("active");
      Header.classList.remove("active");
      menu.classList.remove("active");
    });

    for (let link of listLink) {
      link.addEventListener("click", function () {
        Hidden_header.classList.remove("active");
        foundlink.classList.remove("active");
        Header.classList.remove("active");
        menu.classList.remove("active");
      });
    }
  }

  // //221027 수정

  // [공통사용 스크립트] 모바일 버거 메뉴 클릭할 때 액티브
  let mobileburger = document.querySelector(".mobile-menu");
  let mobileburgerOpen = document.querySelector(".mobile-menu__open");
  let closeBtn = document.querySelector(".mobile-menu-closeBtn");
  let wrapBlur = document.querySelector("#wrap");

  mobileburger.addEventListener("click", function () {
    mobileburgerOpen.classList.toggle("active");
    wrapBlur.classList.toggle("blur");
  });

  closeBtn.addEventListener("click", function () {
    mobileburgerOpen.classList.remove("active");
    wrapBlur.classList.remove("blur");
  });

  // [공통사용 스크립트] 모바일 버거 메뉴 하위메뉴 드랍다운
  let hiddenMenuList = document.querySelectorAll(".hidden-menuList");

  for (let i = 0; i < hiddenMenuList.length; i++) {
    hiddenMenuList[i].addEventListener("click", function () {
      this.classList.toggle("active");
      this.nextElementSibling.classList.toggle("active");
    });
  }

  // [공통사용 스크립트] 마우스가 스크롤 밖으로 나가면 히든 메뉴 인액티브
  document.addEventListener("mouseleave", (event) => {
    if (
      event.clientY <= 0 ||
      event.clientX <= 0 ||
      event.clientX >= window.innerWidth ||
      event.clientY >= window.innerHeight
    ) {
      Hidden_header.classList.remove("active");
      foundlink.classList.remove("active");
    }
  });
</script>


      </header>
      <!-- end of :: header -->
      <!-- start of :: container -->
      <main class="container">
        <section class="whats-new__wrap">
          <div class="inner">
            <div class="whats-new-head">
              <span>WHAT'S NEW</span>
              <div class="whats-new-category-list">
                <div class="whats-new-category-w">
                  <a class="whats-new-category active" href="whatsnew_main.asp">WHAT'S NEW</a>
                  <a class="whats-new-category" href="whatsnew_report.asp">보도자료</a>
                </div>
              </div>
            </div>

            <div class="whats-news-wrap ing-wrap">
              <span class="event-head">진행중인 소식</span>
              <div class="there-is-nothing l-hidden" id="ingEmpty">
                <p class="txt">진행중인 소식이 없습니다.</p>
              </div>
              <ul class="whats-news-list" id="ingList">
                
              </ul>
            </div>
            <div class="whats-news-wrap event-end-wrap">
              <span class="event-head">지난 소식</span>
              <div class="there-is-nothing l-hidden" id="closeEmpty">
                <p class="txt">지난 소식이 없습니다.</p>
              </div>
              <ul class="whats-news-list" id="closeList">
                
              </ul>
            </div>
            <div class="brand_store_pagination" id="div_paginate"></div>
          </div>
        </section>
        <div id="privacyPopUp">
          <!-- 참고: 스크립트로 load 됩니다. include 폴더 privacy-pop_up.asp  -->
           <style type="text/css">
    .privacyInfoAgreeClose{width:135px;height:48px;border-radius: 24px;background:#ff4713;font-weight:700;font-size:17px;letter-spacing: -0.01em;color:#fff}
 </style>
 <script type="text/javascript">
  $(document).ready(function() {
    $( document ).on( "click", ".clicktxt", function(){ 
      var sid = $(this).attr("data-id");
      $("#"+sid).trigger("click");
      
    });
  });
 </script>
<!------------------------------------ 개인정보취급방침 팝업 창 --------------------------------->
<div class="pop_up_wrap privacyUseInfo l-hidden">
  <div class="footer_pop_up">
    <p class="footer_popup_close_btn privacyUseInfoClose"></p>
    <p class="footer_popup_title">개인정보취급방침</p>
    <p class="footer_popup_title-lead">
      셀렉토 커피는 이용자들의 개인정보를 소중히 다루고 있습니다.
    </p>
    <p class="privacy_txt">
      <span class="privacy_txt-head">수집하는 개인정보 항목</span>

      <span
        >회사는 SMS상담, 브로슈어신청, 온라인창업문의 신청 등을 위해 아래와 같은
        개인정보를 수집하고 있습니다.
      </span>
      <span>
        - 수집항목 : 이름 , 연락처 , 휴대전화번호,쿠키
        <br />
        - 개인정보 수집방법 : 홈페이지(상담신청란)
      </span>
      <span class="privacy_txt-head">개인정보의 수집 및 이용목적</span>
      <span>
        회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.<br>
        서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 정보제공,콘텐츠 제공 , 
        자매 브랜드(바나타이거) 마케팅 및 광고에 활용, 이벤트 등 
        광고성 정보전달, 불만처리 등 민원처리 , 고지사항 전달 마케팅 및 광고에 활용, 
        이벤트 등 광고성 정보 전달 , 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계
      </span>
      <span class="privacy_txt-head">개인정보의 보유 및 이용기간</span>
      <span>
        원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체
        없이 파기합니다. 단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우
        회사는 아래와 같이 관계법령에서 정한 일정한 기간 동안 회원정보를
        보관합니다.
      </span>
      <span>
        - 보존 항목 : 가맹계약에 필요한 계약정보<br />
        - 보존 근거 : 계약 또는 청약철회 등에 관한 기록<br />
        - 보존 기간 : 3년<br />
        - 계약 또는 청약철회 등에 관한 기록 : 5년 (전자상거래등에서의
        소비자보호에 관한 법률)<br />
        - 대금결제 및 재화 등의 공급에 관한 기록 : 5년 (전자상거래등에서의
        소비자보호에 관한 법률)<br />
        - 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년 (전자상거래등에서의
        소비자보호에 관한 법률)
      </span>

      <span class="privacy_txt-head">개인정보의 파기절차 및 방법 </span>
      회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를
      지체없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.
      <span>
        파기절차 회원님이 상담등을 위해 입력하신 정보는 목적이 달성된 후 별도의
        DB로 옮겨져(종이의 경우 별도의 서류함) <br />
        내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간
        참조) 일정 기간 저장된 후 파기되어집니다. 별도 DB로 옮겨진 개인정보는
        법률에 의한 경우가 아니고서는 보유되어지는 이외의 다른 목적으로 이용되지
        않습니다.
      </span>
      <span>
        파기방법 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는
        기술적 방법을 사용하여 삭제합니다.
      </span>

      <span class="privacy_txt-head">개인정보 제공 </span>
      <span>
        회사는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만,
        아래의 경우에는 예외로 합니다. <br />- 이용자들이 사전에 동의한 경우
        <br />
        법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라
        수사기관의 요구가 있는 경우
      </span>
      <span class="privacy_txt-head"
        >이용자 및 법정대리인의 권리와 그 행사방법
      </span>
      <span>
        이용자들의 개인정보 조회,수정을 위해서는 본인 확인 절차를 거치신 후 정정
        또는 탈퇴가 가능합니다. 혹은 개인정보관리책임자에게 서면, 전화 또는
        이메일로 연락하시면 지체없이 조치하겠습니다. <br />

        귀하가 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기
        전까지 당해 개인정보를 이용 또는 제공하지 않습니다. 또한 잘못된
        개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게
        지체없이 통지하여 정정이 이루어지도록 하겠습니다. <br />

        회사는 이용자의 요청에 의해 해지 또는 삭제된 개인정보는 "회사가 수집하는
        개인정보의 보유 및 이용기간"에 명시된 바에 따라 처리하고 그 외의 용도로
        열람 또는 이용할 수 없도록 처리하고 있습니다.
      </span>
      <span class="privacy_txt-head"
        >개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항
      </span>
      <span>
        회사는 귀하의 정보를 수시로 저장하고 찾아내는 ‘쿠키(cookie)’ 등을
        운용합니다. 쿠키란 oo의 웹사이트를 운영하는데 이용되는 서버가 귀하의
        브라우저에 보내는 아주 작은 텍스트 파일로서 귀하의 컴퓨터 하드디스크에
        저장됩니다. 회사은(는) 다음과 같은 목적을 위해 쿠키를 사용합니다.
      </span>
      <span>
        쿠키 등 사용 목적 - 회원과 비회원의 접속 빈도나 방문 시간 등을 분석,
        이용자의 취향과 관심분야를 파악 및 자취 추적, 각종 이벤트 참여 정도 및
        방문 회수 파악 등을 통한 타겟 마케팅 및 개인 맞춤 서비스 제공 귀하는
        쿠키 설치에 대한 선택권을 가지고 있습니다. <br />
        따라서, 귀하는 웹브라우저에서 옵션을 설정함으로써 모든 쿠키를
        허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의
        저장을 거부할 수도 있습니다.
      </span>
      <span>
        쿠키 설정 거부 방법 쿠키 설정을 거부하는 방법으로는 회원님이 사용하시는
        웹 브라우저의 옵션을 선택함으로써 모든 쿠키를 허용하거나 쿠키를 저장할
        때마다 확인을 거치거나, 모든 쿠키의 저장을 거부할 수 있습니다.
        <br />
        설정방법 예(인터넷 익스플로어의 경우) : 웹 브라우저 상단의 도구 > 인터넷
        옵션 > 개인정보 단, 귀하께서 쿠키 설치를 거부하였을 경우 서비스 제공에
        어려움이 있을 수 있습니다
      </span>

      <span class="privacy_txt-head">개인정보에 관한 민원서비스 </span>
      <span>
        회사는 고객의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기
        위하여 아래와 같이 관련 부서 및 개인정보관리책임자를 지정하고 있습니다.
      </span>
      <span>
        - 고객서비스담당 부서 : 마케팅팀<br />
        - 전화번호 : 1600-5649<br />
        - 이메일 : phe68@selecto.co.kr
      </span>

      <span>
        귀하께서는 회사의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련
        민원을 개인정보관리책임자 혹은 담당부서로 신고하실 수 있습니다. 회사는
        이용자들의 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다.
        <br />
        기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에
        문의하시기 바랍니다.
      </span>
      <span>
        - 개인분쟁조정위원회 (www.1336.or.kr/1336) <br />
        - 정보보호마크인증위원회 (www.eprivacy.or.kr/02-580-0533~4) <br />
        - 대검찰청 인터넷범죄수사센터 (http://icic.sppo.go.kr/02-3480-3600)
        <br />
        - 경찰청 사이버테러대응센터 (www.ctrc.go.kr/02-392-0330
      </span>
    </p>
  </div>
</div>

<div class="pop_up_wrap privacyInfoAgree l-hidden">
  <div class="footer_pop_up">
    <!--<p class="footer_popup_close_btn privacyInfoAgreeClose"></p>-->
    <p class="footer_popup_title">개인정보 수집 및 이용에 관한 사항(필수)</p>
    <p class="footer_popup_title-lead">
      셀렉토 커피는 이용자들의 개인정보를 소중히 다루고 있습니다.
    </p>
    <p class="privacy_txt">
      <span class="privacy_txt-head">수집하는 개인정보 항목</span>

      <span
        >회사는 SMS상담, 브로슈어신청, 온라인창업문의 신청 등을 위해 아래와 같은
        개인정보를 수집하고 있습니다.
      </span>
      <span>
        - 수집항목 : 이름 , 연락처 , 휴대전화번호,쿠키
        <br />
        - 개인정보 수집방법 : 홈페이지(상담신청란)
      </span>
      <span class="privacy_txt-head">개인정보의 수집 및 이용목적</span>
      <span>
        회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.<br>
        서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 정보제공,콘텐츠 제공 , 
        자매 브랜드(바나타이거) 마케팅 및 광고에 활용, 이벤트 등 
        광고성 정보전달, 불만처리 등 민원처리 , 고지사항 전달 마케팅 및 광고에 활용, 
        이벤트 등 광고성 정보 전달 , 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계
      </span>
      <span class="privacy_txt-head">개인정보의 보유 및 이용기간</span>
      <span>
        원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체
        없이 파기합니다. 단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우
        회사는 아래와 같이 관계법령에서 정한 일정한 기간 동안 회원정보를
        보관합니다.
      </span>
      <span>
        - 보존 항목 : 가맹계약에 필요한 계약정보<br />
        - 보존 근거 : 계약 또는 청약철회 등에 관한 기록<br />
        - 보존 기간 : 3년<br />
        - 계약 또는 청약철회 등에 관한 기록 : 5년 (전자상거래등에서의
        소비자보호에 관한 법률)<br />
        - 대금결제 및 재화 등의 공급에 관한 기록 : 5년 (전자상거래등에서의
        소비자보호에 관한 법률)<br />
        - 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년 (전자상거래등에서의
        소비자보호에 관한 법률)
      </span>
    </p>
    <p class="footer_popup_title-lead" style="text-align: left;margin-left: 30px;">
      <input type="checkbox" name="p_agree" id="p_agree" value="Y"> <span class="clicktxt" data-id="p_agree">개인정보 수집 및 이용에 동의합니다.(필수)</span>
    </p>
    <p class="footer_popup_title" style="padding-top:30px;">개인정보 제3자 제공 (선택)</p>
      <p class="privacy_txt" >
          <span class="privacy_txt-head">개인정보 제3자 제공</span>

          <span>회사는「개인정보 수집 및 이용에 관한 사항」에서 고지한 범위 내에서만 개인정보를 이용하며, 원칙적으로 이용자의 개인정보를 제3자에게 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.
          </span>
          <span>가. 이용자가 서비스 이용중 제3자 제공에 동의(수락)한 경우</span>
          <span class="privacy_txt-head">1. 개인정보 제3자 제공</span>
          <span>
              귀하께서는 개인정보의 제3자 제공에 대해, 동의하지 않을 수 있고 언제든지 제3자 제공 동의를 철회할 수 있습니다. 
          </span>
          <span class="privacy_txt-head">바나타이거</span>
          <span>
              - 제공받는자 : 바나타이거<br>
              - 제공목적 : 프랜차이즈 개설 정보 제공<br>
              - 제공하는 항목 : 이름 , 연락처 , 휴대전화번호<br>
              - 보유 및 이용기간 : 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체<br>
                없이 파기합니다. 단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는<br>
                아래와 같이 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다.
          </span>
          <span>
              - 보존 항목 : 가맹계약에 필요한 계약정보<br />
              - 보존 근거 : 계약 또는 청약철회 등에 관한 기록<br />
              - 보존 기간 : 3년<br />
              - 계약 또는 청약철회 등에 관한 기록 : 5년<br />&nbsp;&nbsp;&nbsp;&nbsp;(전자상거래등에서의소비자보호에 관한 법률)<br />
              - 대금결제 및 재화 등의 공급에 관한 기록 : 5년<br />&nbsp;&nbsp;&nbsp;&nbsp;(전자상거래등에서의소비자보호에 관한 법률)<br />
              - 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년<br />&nbsp;&nbsp;&nbsp;&nbsp;(전자상거래등에서의소비자보호에 관한 법률)
          </span>
      </p>
      <p class="footer_popup_title-lead" style="text-align: left;margin-left: 30px;"><input type="checkbox" name="p_third_agree" id="p_third_agree" value="Y"> <span class="clicktxt" data-id="p_third_agree">제3자 제공에 동의합니다.(선택)</span></p>
      <p class="footer_popup_title-lead" style="text-align: right;margin-right: 15px;">
          <button type="button" id="privacyInfoAgreeClose" class="privacyInfoAgreeClose f_right">완료</button>
      </p>
  </div>
</div>
        </div>
        <div class="footer__totop">
          <div class="totop__btn">
            <img class="totop__btn-circle" src="../assets/images/main/f-totop__circle.png" alt=""/>
            <img class="totop__btn-arrow" src="../assets/images/main/f-totop__arrow.png" alt=""/>
          </div>
          <span>TOP</span>
        </div>
      </main>
      <!-- end of :: container -->
      <!-- start of :: footer -->
      <footer id="footer" class="footer">
        <!-- 참고: 스크립트로 load 됩니다. include 폴더 footer.html  -->
        
<div class="inner">
  <a class="footer__logo"><img src="../assets/images/main/logo-white.svg" alt=""/></a>
  <div class="footer__link">
    <a href="https://blog.naver.com/maxone01" target="_blank"><img src="../assets/images/main/f-link-n.svg" alt="" /></a>
    <a href="https://www.youtube.com/channel/UCM8GQsYfu6I4MgYwjnCJXrg/featured" target="_blank"><img src="../assets/images/main/f-link-y.svg" alt=""/></a>
    <a href="https://www.instagram.com/selecto_coffee/" target="_blank"><img src="../assets/images/main/f-link-i.svg" alt=""/></a>
  </div>
  <ul class="footer__list">
    <!-- <li><a href="#none">회사소개</a></li>
    <li><a href="#none">인재채용</a></li>
    <li><a href="#none">오시는길</a></li> -->
    <li><a class="privacy-pop_up-button" href="#none">개인정보취급방침</a></li>
  </ul>
  <div class="footer__info">
    <div>
      <span
        >주소 : 서울시 구로구 구로3동 222-14 에이스하이엔드타워 2차 1402호</span
      >
      <div class="info-devide__bar dv-remove"></div>
      <span
        >도로명주소 : 서울시 구로구 디지털로26길 61 에이스하이엔드타워 2차
        1402호</span
      >
    </div>
    <div>
      <div>
        <span>대표이사 : 황규연</span>
        <div class="info-devide__bar"></div>
        <span>사업자등록번호 : 109-81-99153</span>
        <div class="info-devide__bar dv-remove"></div>
      </div>
      <div>
        <span><a href="tel:1600-5649" style="color: #FFF;">전화 : 1600-5649</a></span>
        <div class="info-devide__bar"></div>
        <span>팩스 : 02-6340-1701</span>
      </div>
    </div>
  </div>
  <div class="footer__copy">
    <span>COPYRIGHT ㈜맥스원이링크 ALL RIGHTS RESERVED.</span>
  </div>
  <!-- <div class="footer__totop">
    <div class="totop__btn">
      <img
        class="totop__btn-circle"
        src="../assets/images/main/f-totop__circle.png"
        alt=""
      />
      <img
        class="totop__btn-arrow"
        src="../assets/images/main/f-totop__arrow.png"
        alt=""
      />
    </div>
    <span>TOP</span>
  </div> -->
</div>

<script>
  document
    .querySelector(".footer__totop")
    .addEventListener("click", function () {
      window.scrollTo({
        top: 0,
        behavior: "smooth",
      });
    });

  let privacyBtn = document.querySelector(".privacy-pop_up-button");
  let popUpPage = document.querySelector(".pop_up_wrap");
  let popUpCloseBtn = document.querySelector(".footer_popup_close_btn");
  const Body = document.getElementsByClassName("body");

  privacyBtn.addEventListener("click", function () {
    popUpPage.classList.remove("l-hidden");
    $("body").css("overflow", "hidden");
  });

  popUpCloseBtn.addEventListener("click", function () {
    popUpPage.classList.add("l-hidden");
    $("body").css("overflow", "unset");
  });
</script>

      </footer>
      <!-- end of :: footer -->
    </div>
    <!-- end of :: wrap -->
    <!-- Google Tag Manager (noscript) 20240723 송인문과장요청-->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5RZG6QF9"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
  </body>
</html>
