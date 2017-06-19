<%--
  Created by IntelliJ IDEA.
  User: Stefan
  Date: 30.05.2017
  Time: 18:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MeinVerein</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
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
        <li><a href="${pageContext.request.getContextPath()}/index">Nachrichten</a></li>
        <li><a href="${pageContext.request.getContextPath()}/vorstand.html">Vorstand</a></li>
        <li><a href="${pageContext.request.getContextPath()}kontakt">Kontakt</a></li>
    </ul>
</div>
<div class="container">
    <jsp:useBean id="message" scope="request" class="model.MessageBean"/>
    <h3>
        <jsp:getProperty name="message" property="subject"/>
    </h3>
    <div class="content">
        <jsp:getProperty name="message" property="message"/>
    </div>
    <div class="content-info">
        <p>
            <jsp:getProperty name="message" property="firstName"/>
            <jsp:getProperty name="message" property="lastName"/>
            <br/>
            <jsp:getProperty name="message" property="email"/>
            <br/>
            geschrieben am <i>
            <jsp:getProperty name="message" property="date"/>
        </i></p>
    </div>
</div>
<!-- CONTENT -->
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
