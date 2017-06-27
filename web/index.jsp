<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MeinVerein</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <c:set var="req" value="${pageContext.request}"/>
    <c:set var="baseURL" value="${req.scheme}://${req.serverName}:${req.serverPort}${req.contextPath}"/>
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
    <div id="shoutbox" style="overflow-y: scroll; height:200px;">
        No Messages!
    </div>
    <hr/>
    <form class="form" action="submitFeedback" controller="administration">
        <h3>Enter your Feedback</h3>
        <div>
            <label for="author">Name</label>
            <input type="text" id="author"/>
        </div>
        <div>
            <textarea required="true" name="text" id="text"></textarea>
        </div>
        <h6 id="count_message"></h6>
        <button type="button" id="submit_btn" name="Submit" onclick="sendToShoutbox()">
            Absenden
        </button>
    </form>
</div>
<script>
    var url = '${baseURL}/resources/shoutbox';
    function sendToShoutbox() {
        console.log("Sending PUT request");
        var text = document.getElementById("text").value;
        var author = document.getElementById("author").value;
        var params = ('?message=' + text);
        params += ('&author=' + author);

        clearForm();

        var request = new XMLHttpRequest();
        request.open("PUT", url + params);
        request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        request.onload = function () {
            var response = JSON.parse(request.responseText);
            if (response.success) {
                updateShoutbox();
            }
            console.log(response)
        };
        request.send(null);
    }

    function updateShoutbox() {
        var request = new XMLHttpRequest();
        request.open("GET", url);
        request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        request.onload = function () {
            var response = JSON.parse(request.responseText);
            fillShoutBox(response);
        };
        request.send('');
    }

    function fillShoutBox(messages) {
        var shoutBox = document.getElementById("shoutbox");
        shoutBox.innerHTML = "";
        for (var i = 0; i < messages.length; i++) {
            var message = messages[i];
            var messageDiv = document.createElement('div');
            messageDiv.innerHTML = message.author + " - " + message.message;
            shoutBox.appendChild(messageDiv);
        }
        shoutBox.scrollTop = shoutBox.scrollHeight;
    }

    function clearForm() {
        document.getElementById("text").value = '';
    }
    window.setInterval(function () {
        updateShoutbox('${baseURL}/resources/shoutbox')
    }, 10000);
    updateShoutbox()
</script>
<script>
    var text_max = 64;
    var message;
    var textArea;
    var submitButton;

    /**
     * instantiating global vars and adding a listener to the textarea
     */
    function init() {
        message = document.getElementById("count_message");
        textArea = document.getElementById("text");
        submitButton = document.getElementById("submit_btn");
        textArea.addEventListener("input", updateForm);
        message.innerHTML = text_max + ' Zeichen übrig';
    }

    /**
     *     updating character-counter and limiting textarea
     */
    function updateForm() {
        var text_length = textArea.value.length;
        var text_remaining = text_max - text_length;
        message.innerHTML = text_remaining + ' Zeichen übrig';

        // Should never be true, as value is limited via vode to max_length
        if (text_length > text_max) {
            submitButton.setAttribute("disabled", "true");
        } else {
            submitButton.removeAttribute("disabled");
        }

        // limit textArea length
        if (text_remaining < 0) {
            textArea.value = textArea.value.substr(0, text_max);
            alert('Ok. Ist gut jetzt...');
            updateForm();
        }
    }
    init();
    updateForm();
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