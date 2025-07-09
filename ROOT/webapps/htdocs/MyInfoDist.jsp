<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="cycle.Cycle" %>
<%@ page import="cycle.CycleDAO" %>


<head>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
    <style>
        #snow {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            opacity: 0.9;
        }

        #free55 {
            background-color: #fff;

        }

        div#wrap {
            background: #fff;
        }

        header#header {
            background: #fff;
            text-align: center;
            justify-content: center;
            align-items: center;
        }

        nav#nav {
            background: linear-gradient(to left, #1488cc, #2b32b2);
            color: white;
            margin-left: auto;
            margin-right: auto;
            width: 100%;
        }


        @media (min-width: 1800px) {
            nav#nav {
                width: 60%;
            }
        }

        div#warp, header#header {
            padding: 10px;
        }

        nav#nav ul {
            margin: 0 auto;
            padding: 0;
            list-style: none;
            text-align: center;
        }

        nav#nav ul li {
            padding: 10px;
            display: inline-block;
        }

        nav#nav ul li:hover {
            display: inline-block;
            background: #a9a9f5;
        }

        #nav ul li a {
            color: white;
        }

        a {
            text-decoration: none;
        }

        .container {
            width: 1200px;
            margin: 10px auto;
            padding: 5px;
            display: flex;
            flex-wrap: wrap;
            align-items: flex-start;
            border: 1px solid #000;
            border-radius: 10px 10px 10px 10px;
            background-color: #fff;
        }

        .sideMenu {
            width: 280px;
            padding: 5px;
            border: 1px solid red;
        }

        .sideMenu ul {
            list-style: none;
            padding: 5px;
        }

        .sideMenu ul li a {
            text-decoration: none;
            display: block;
            color: #000;
            padding: 8px 15px 8px 15px;
            font-weight: bold;
        }

        .sideMenu ul li a:hover {
            background: rgb(100, 149, 237);
            color: white;
        }

        .infoContent {
            width: 880px;
            padding: 5px;
            border: 1px solid blue;
        }

        /*달력*/
        .rap {
            width: 100%;
            padding: 0 1.4rem;
            margin-top: .3rem;
        }

        .dateHead {
            margin-bottom: .4rem;
        }

        .dateHead div {
            background: #e31b20;
            color: #fff;
            text-align: center;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            grid-gap: 5px;
        }

        .grid div {
            padding: .6rem;
            font-size: .9rem;
            cursor: pointer;
        }

        .dateBoard div {
            color: #222;
            font-weight: bold;
            min-height: 6rem;
            padding: .6rem .8rem;
            border-radius: .6rem;
            border: 1px solid #eee;
        }

        .noColor {
            background: #eee;
        }

        .header {
            display: flex;
            justify-content: space-between;
            padding: 1rem 2rem;
        }

        .btn {
            display: block;
            width: 20px;
            height: 20px;
            border: 3px solid #000;
            border-width: 3px 3px 0 0;
            cursor: pointer;
        }

        .prevDay {
            transform: rotate(-135deg);
        }

        .nextDay {
            transform: rotate(45deg);
        }

        .dateBoard div p {
            font-weight: normal;
            margin-top: .2rem;
        }

        * {
            margin: 0;
            padding: 0;
        }
    </style>

</head>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Calendar cal = null;
    String[] datesArr = new String[7];
    int thisMonthLastDay = 0, thisMonth = 99;
    for (int i = 0; i < 7; i++) {
        cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -i);
        if (i == 0) {
            thisMonthLastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
            thisMonth = cal.get(Calendar.MONTH) + 1;
        }
        datesArr[i] = dateFormat.format(cal.getTime());
    }
    CycleDAO cycleDAO = new CycleDAO();
    String userId = (String) session.getAttribute("user_id");
    // String userId = "9999"; // Use this line instead if you want to use a fixed userId


    ArrayList<Cycle> list = cycleDAO.getCycleData(userId);
    List<Cycle> weekList = cycleDAO.getCycleDataForLastWeek(userId);
    List<Cycle> monthList = cycleDAO.getCycleDataForLastMonth(userId);

    String[] oneWeekDate = new String[7];
    String[] oneWeekDist = new String[7];
    String[] oneWeekSpeed = new String[7];
    ArrayList<String> monthDistanceList = new ArrayList<String>();
    ArrayList<String> monthSpeedList = new ArrayList<String>();
    ArrayList<String> monthDateList = new ArrayList<String>();

    for (Cycle cycle : weekList) {
        for (int j = 0; j < datesArr.length; j++) {
            if (dateFormat.format(cycle.getDate()).equals(datesArr[j])) {
                oneWeekDist[j] = Double.toString(cycle.getDistance());
                oneWeekSpeed[j] = Double.toString(cycle.getSpeed());
                oneWeekDate[j] = dateFormat.format(cycle.getDate());
                break;
            }
        }
    }

    for (Cycle cycle : monthList) {
        monthDistanceList.add(cycle.getDistance() + "km");
        monthSpeedList.add(cycle.getSpeed() + "km/s");
        monthDateList.add(dateFormat.format(cycle.getDate()));
    }

    for (int i = 0; i < oneWeekDate.length; i++) {
        if (oneWeekDate[i] == null) {
            oneWeekDist[i] = "0";
            oneWeekSpeed[i] = "0";
        }
    }
%>

<body>
<div id="wrap">
    <div id="snow"></div>
    <header id="header">
        <a href="test.jsp"> <img src="./logo.png" alt="Your Logo"/> </a>
    </header>
    <nav id="nav" style="border:1px solid black; border-radius: 10px 10px 10px 10px;">
        <ul>
            <li><a href="Untitled-5.jsp">공지사항</a></li>
            <li><a href="Untitled-4.jsp">사용 방법</a></li>
            <li><a href="Untitled-2.jsp">자유게시판</a></li>
            <li><a href="Untitled-3.jsp">문의 게시판</a></li>
            <li><a href="kit.jsp">키트구매처</a></li>
        </ul>
    </nav>
</div>
<div class="container">
    <div class="sideMenu">
        <h3 style="margin: 5px 10px 0 10px">내 정보</h3>
        <ul>
            <li><a href="MyInfoDist.jsp">달린 거리</a></li>
            <li><a href="MyInfoBoard.jsp">게시글 삭제</a></li>
            <li><a href="MyInfoReply.jsp">댓글 삭제</a></li>
            <li><a href="MyInfoChange.jsp">내 정보 변경</a></li>
        </ul>
    </div>
    <div class="infoContent">
        <canvas id="myChart"></canvas>
    </div>
    <div class='rap'>
        <div class="header">
            <div class="btn prevDay"></div>
            <h2 class='dateTitle'></h2>
            <div class="btn nextDay"></div>
        </div>

        <div class="grid dateHead">
            <div>일</div>
            <div>월</div>
            <div>화</div>
            <div>수</div>
            <div>목</div>
            <div>금</div>
            <div>토</div>
        </div>

        <div class="grid dateBoard"></div>
    </div>
</div>

<script type="text/javascript">
    var context = document
        .getElementById('myChart')
        .getContext('2d');
    var myChart = new Chart(context, {
        type: 'bar', // 차트의 형태 bar, line, pie ...
        data: { // 차트에 들어갈 데이터
            labels: [
                //x 축
                '6일전', '5일전', '4일전', '3일전', '2일전', '1일전', '오늘'
            ],
            datasets: [
                { //데이터
                    label: '1주일 동안 달린 거리', //차트 제목
                    fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                    data: [
                        <%
                        out.print(oneWeekDist[6]+", "+oneWeekDist[5]+", "+oneWeekDist[4]+", "+oneWeekDist[3]
                        +", "+oneWeekDist[2]+", "+oneWeekDist[1]+", "+oneWeekDist[0]);
                        %>
                        //21, 19, 25, 20, 23, 26, 25 //x축 label에 대응되는 데이터 값
                    ],
                    backgroundColor: [
                        //색상
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        //경계선 색상
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1 //경계선 굵기
                }
            ]
        },
        options: {
            scales: {
                yAxes: [
                    {
                        ticks: {
                            beginAtZero: true
                        }
                    }
                ]
            }
        }
    });
    // 임시 데이터
    const data = [
        <%
        for(int i = 0; i < monthDateList.size(); i++) {
            out.print("{date: '" +monthDateList.get(i) + "', content: '달린거리: " + monthDistanceList.get(i) + "'},");
            out.print("{date: '" +monthDateList.get(i) + "', content: '속도: " + monthSpeedList.get(i) + "'},");
        // {date: '2022-10-15', content: '테스트1'},
        }
        %>
    ];

    // 데이터 가공
    const calendarList = data.reduce(
        (acc, v) =>
            ({...acc, [v.date]: [...(acc[v.date] || []), v.content]})
        , {}
    );

    // pad method
    Number.prototype.pad = function () {
        return this > 9 ? this : '0' + this;
    }

    // 달력 생성
    const makeCalendar = (date) => {
        // 현재의 년도와 월 받아오기
        const currentYear = new Date(date).getFullYear();
        const currentMonth = new Date(date).getMonth() + 1;

        // 한달전의 마지막 요일
        const firstDay = new Date(date.setDate(1)).getDay();
        // 현재 월의 마지막 날 구하기
        const lastDay = new Date(currentYear, currentMonth, 0).getDate();

        // 남은 박스만큼 다음달 날짜 표시
        const limitDay = firstDay + lastDay;
        const nextDay = Math.ceil(limitDay / 7) * 7;

        let htmlDummy = '';

        // 한달전 날짜 표시하기
        for (let i = 0; i < firstDay; i++) {
            htmlDummy += '<div class="noColor"></div>';
        }
        // 이번달 날짜 표시하기
        for (let i = 1; i <= lastDay; i++) {
            const date = currentYear + '-' + currentMonth.pad() + '-' + i.pad();
            //const date = '${currentYear}-${currentMonth.pad()}-${i.pad()}';

            //htmlDummy += "<div><p>"+i+((calendarList[date] != null) ? calendarList[date].join('</p><p>') : "")+"</p></div>";
            htmlDummy += "<div>" + i + "<p>" + ((calendarList[date] != null) ? calendarList[date].join('</p><p>') : "") + "</p></div>";
        }

        // 다음달 날짜 표시하기
        for (let i = limitDay; i < nextDay; i++) {
            htmlDummy += "<div class='noColor'></div>";
        }
        document.querySelector('.dateBoard').innerHTML = htmlDummy;
        document.querySelector('.dateTitle').innerText = currentYear + "년 " + currentMonth + "월";
    }

    // const date = new Date('2022-10-10');
    const date = new Date();

    makeCalendar(date);

    // 이전달 이동
    document.querySelector('.prevDay').onclick = () => {
        makeCalendar(new Date(date.setMonth(date.getMonth() - 1)));
    }

    // 다음달 이동
    document.querySelector('.nextDay').onclick = () => {
        makeCalendar(new Date(date.setMonth(date.getMonth() + 1)));
    }
</script>
<script>
<%--    out.println("alert('" + aaa + "');"); --%>
<%--    console.log("<%=monthDateList.get(0)%>"); --%>
<%--    alert("<%=monthDateList%>"); --%>
</script>
</body>
