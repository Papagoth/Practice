<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Login</title>
    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
</head>
<body>

<div>


    <form action="/login" method="post">
        <div>
            <input type="text" name="username" path="username" id="username" placeholder="Введите логин"/>
            <errors path="username"></errors>
            ${usernameError}
        </div>
        <div>
            <input type="password" name="password" path="password" id="password" placeholder="введите пароль"/>
            <errors path="password"></errors>
            ${passwordError}
        </div>
        <button type="submit">Авторизироваться</button>
    </form>
    <a class="ssilka" href="<c:url value="/registration"/>"> Регистрация</a>
</div>

</body>
</html>