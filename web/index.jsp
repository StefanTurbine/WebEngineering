<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
    <meta charset="UTF-8">
    <title>MeinVerein</title>
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
          integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modified_style.css">
    <c:set var="req" value="${pageContext.request}"/>
    <c:set var="baseURL" value="${req.scheme}://${req.serverName}:${req.serverPort}${req.contextPath}"/>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-sm-3 pull-right">
            <img src="${pageContext.request.contextPath}/img/logo.jpg" id="logo" height="100"/>
        </div>
        <div class="col-sm-9">
            <h2 >Evil Corp e.V.</h2>
        </div>
        <div class="clearfix"></div>
        <hr/>
    </div>
    <div class="row">
        <div class="col-md-2 col-sm-3">
            <!-- CONTENT -->
            <div>
                <ul class="nav nav-pills nav-stacked" id="navlist">
                    <li><a href="index">Nachrichten</a></li>
                    <li><a href="vorstand.html">Vorstand</a></li>
                    <li><a href="kontakt">Kontakt</a></li>
                </ul>
            </div>
        </div>
        <div class="col-md-10 col-sm-9" id="main-content">
            <h3>Unsere Nachrichten</h3>
            <table class="table">
                <thead>
                <tr>
                    <th>Thema</th>
                    <th>Datum</th>
                </tr>
                </thead>
                <tbody>
                <jsp:useBean id="messages" class="model.MessageHolder" scope="request"/>
                <c:forEach var="item" items="${messages.items}" varStatus="i">
                    <tr>
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
            <h3>Unsere Shoutbox</h3>
            <div id="shoutbox" style="overflow-y: scroll; height:200px;">
                No Messages!
            </div>
            <hr/>
            <form class="form form-horizontal" action="submitFeedback">
                <h3>Sag auch was!</h3>
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="author">Name</label>
                    <div class="col-sm-10">
                        <input class="form-control" type="text" id="author"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="text">Nachricht</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" required="true" name="text" id="text"></textarea>
                    </div>
                </div>
                <div class="col-sm-12">
                    <label id="count_message"></label>
                    <button class="btn btn-primary pull-right" type="button" id="submit_btn" name="Submit"
                            onclick="sendToShoutbox()">
                        Absenden
                    </button>
                </div>
            </form>
        </div>
        <script>
            var url = '${baseURL}/resources/shoutbox';
            function sendToShoutbox() {
                console.log("Sending PUT request");
                var text = document.getElementById("text").value;
                var author = document.getElementById("author").value;
                if (author === null || author === "") {
                    author = "anonymous"
                }
                var params = ('?message=' + text);
                params += ('&author=' + author);

                clearForm();
                $.ajax(
                    {
                        type: "PUT",
                        url: url + params,
                        data: null,
                        success: function (response) {
                            response = JSON.parse(response);
                            if (response.success) {
                                addShoutBoxEntry(author, text); // adding new entry to shoutbox list
                                updateForm(); // updating form to remove red borders
                            }
                            console.log(response)   // remove me
                        }
                    }
                );
            }

            function updateShoutbox() {
                $.ajax(
                    {
                        type: "GET",
                        url: url,
                        data: null,
                        success: function (response) {
                            response = JSON.parse(response);
                            fillShoutBox(response);
                        }
                    }
                )
            }

            function fillShoutBox(messages) {
                var shoutBox = $("#shoutbox");
                shoutBox.text("");
                for (var i = 0; i < messages.length; i++) {
                    var message = messages[i];
                    addShoutBoxEntry(message.author, message.message, i)
                }
            }

            function addShoutBoxEntry(author, message, index) {
                if (index === undefined) {
                    index = $("#shoutbox > div").length;
                }

                var shoutBox = $("#shoutbox");
                var messageDiv = document.createElement('div');
                messageDiv.classList.add("col-sm-12");
                messageDiv.id = "message_" + index;

                var messageAuthor = document.createElement('div');
                messageAuthor.innerHTML = author;
                messageAuthor.classList.add("col-sm-2", "msg-auth", "text-muted", "text-right");

                var messageText = document.createElement('div');
                messageText.innerHTML = message;
                messageText.classList.add("col-sm-10", "msg-text");

                messageDiv.appendChild(messageAuthor);
                messageDiv.appendChild(messageText);

                $(messageDiv).appendTo(shoutBox).hide().fadeIn(500);

                // jQuery scrollTop method not working...
                var textarea = document.getElementById('shoutbox');
                textarea.scrollTop = textarea.scrollHeight;

            }

            function clearForm() {
                document.getElementById("text").value = '';
            }
            window.setInterval(function () {
                updateShoutbox()
            }, 10000);
            updateShoutbox()
        </script>
        <script>
            var text_max = 32;
            /**
             * instantiating global vars and adding a listener to the textarea
             */
            function init() {
                $("#count_message").text(text_max + ' Zeichen übrig');
                $('#text').attr('maxlength', text_max);
                $("#text").on("input", function (e) {
                    updateForm();
                });
            }

            /**
             *     updating character-counter and limiting textarea
             */
            function updateForm() {
                var text = $("#text");
                var submit_btn = $("#submit_btn");
                var text_length = text.val().length;
                var text_remaining = text_max - text_length;

                text.removeClass("invalid-data");
                submit_btn.removeClass("btn-danger");

                if (text_remaining <= 0) {
                    text.addClass("invalid-data");
                    submit_btn.addClass("btn-danger");
                }

                $("#count_message").text(text_remaining + ' Zeichen \u00fcbrig');
            }
            init();
            updateForm();
        </script>
        <!-- CONTENT -->
    </div>
    <br/>
    <div class="row" id="footer">
        <div class="col-sm-12 text-center">
            <h4>Disclaimer</h4>
            <p><cite>Ich hafte nicht f&uuml;r meine Inhalte</cite></p>
            <p>
                <small>ST 2017</small>
            </p>
        </div>
    </div>
</div>
</body>
</html>