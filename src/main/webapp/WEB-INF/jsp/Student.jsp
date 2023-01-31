<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Student</title>
    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
</head>
<body>
<div class="size1">

    <jsp:include page="header.jsp"/>

    <div class="roboto">
        <table>
            <thead>
            <th>ФИО</th>
            <th>Название группы</th>
            <th>Номер студ билета</th>
            <th>Дата рождения</th>
            <th>Кнопка изменения</th>
            <th>Кнопка удаления</th>
            </thead>
            <c:forEach items="${Student}" var="student">
            <tr>

                <td>${student.fio}</td>
                <td>${student.party.name}</td>
                <td>${student.sticket}</td>
                <td>${student.borndata}</td>
                <td><a class="ssilka" href="<c:url value="/ChangeStudent/${student.id}"/>">Изменить студента</a></td>
                <td><a class="ssilka" href="<c:url value="/DeleteStudent/${student.id}"/>">Удалить студента</a></td>
                </c:forEach>
        </table>
    </div>
    <div class=" size2">
        <a class="ssilka" href="<c:url value="/AddStudent"/>">Добавить студента</a>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>