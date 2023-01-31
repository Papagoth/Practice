<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Party</title>

    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">

</head>

<body>
<div class="size1">

    <jsp:include page="header.jsp"/>

    <div class="roboto">

        <table>
            <thead>
            <th>Название группы</th>
            <th>Название курса</th>
            <th>Кнопка изменения</th>
            <th>Кнопка удаления</th>

            </thead>
            <c:forEach items="${Party}" var="party">
            <tr>
                <td>${party.name}</td>
                <td>${party.course}</td>
                <td><a class="ssilka" href="<c:url value="/ChangeParty/${party.id}"/>">Изменить группу</a></td>
                <td><a class="ssilka" href="<c:url value="/DeleteParty/${party.id}"/>">Удалить группу</a></td>
                </c:forEach>
        </table>
    </div>
    <div class=" size2">
        <a class="ssilka" href="<c:url value="/AddParty"/>">Добавить группу</a>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>