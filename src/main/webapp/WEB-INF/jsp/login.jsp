<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Login</title>
    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
</head>
<body>

<div class="size1">
    <div class="nav_color">
        <div class="size2">
            <div class="header-margin">
                <div class="roboto">
                    <nav class="header-nav">
                        <label>Авторизация</label>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="size2">
        <form:form action="/login" method="POST">
            <div>
                <input type="text" name="username" path="username" id="username" placeholder="Введите логин"/>
                <form:errors path="username"></form:errors>
                    ${usernameError}
            </div>
            <div>
                <input type="password" name="password" path="password" id="password" placeholder="введите пароль"/>
                <form:errors path="password"></form:errors>
                    ${passwordError}
            </div>
            <button type="submit">Авторизироваться</button>
        </form:form>
        <a class="ssilka" href="<c:url value="/registration"/>"> Регистрация</a>
    </div>
    <jsp:include page="footer.jsp"/>
</div>

</body>
</html>