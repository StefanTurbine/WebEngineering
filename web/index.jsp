<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MeinVerein</title>
    <%--<jsp:include page="css/style.css"/>--%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
</head>
<body>
<header>
    <img src="${pageContext.request.contextPath}/img/logo.jpg" id="logo" height="100"/>
    <h2>Evil Corp e.V.</h2>
</header>
<div class="clearfix"></div>
<hr/>
<!-- CONTENT -->
<div id="navbar">
    <ul>
        <li><a class="active" href="index" active="true">Nachrichten</a></li>
        <li><a href="vorstand.html">Vorstand</a></li>
        <li><a href="kontakt">Kontakt</a></li>
    </ul>
</div>
<div class="container">
    <h3>Unsere Nachrichten</h3>
    <table width="100%">
        <thead>
        <tr>
            <th>Thema</th>
            <th>Datum</th>
        </tr>
        </thead>
        <tbody>
        <jsp:useBean id="messages" class="model.MessageHolder" scope="request"/>
        <c:forEach var="item" items="${messages.items}" varStatus="i">
            <tr align="right">
                <td>
                    <a href="detail/${i.index}">
                            ${item.subject}
                    </a>
                </td>
                <td>
                        ${item.date}
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <hr/>
    <div id="shoutbox">

    </div>
    <form class="form" action="submitFeedback" controller="administration">
        <label for="text">
            <h3>Enter your Feedback</h3>
        </label>
        <textarea required="true" name="text" id="text"></textarea>
        <h6 id="count_message"></h6>
        <button type="button" id="submit_btn" name="Submit" onclick="alert('TODO')">Absenden</button>
    </form>
</div>
<script>
    var text_max = 64;
    $('#count_message').html(text_max + ' Zeichen übrig');
    $('#text').keyup(function () {
        var text_length = $('#text').val().length;
        var text_remaining = text_max - text_length;
        $('#count_message').html(text_remaining + ' Zeichen übrig');
        $('#submit_btn').prop("disabled", (text_length > text_max));
        if(text_remaining <= 0){
            $('#text').val($('#text').val().substr(0, text_max - 1));
            alert('Ok. Ist gut jetzt...')
        }
    });
</script>
<!-- CONTENT -->
</div>
<hr/>
<footer>
    <h4>Disclaimer</h4>
    <p><cite>Ich hafte nicht für meine Inhalte</cite></p>
    <p>
        <small>ST 2017</small>
    </p>
</footer>
</body>
</html>