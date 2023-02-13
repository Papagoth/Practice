<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Teacher</title>
    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
</head>

<body>
<div class="size1">

    <jsp:include page="header.jsp"/>

    <div class="roboto">
        <div class="size2">
            <table>
                <thead>
                <th>ФИО</th>
                <th>Дата рождения</th>
                <th>Предметы</th>
                <th>Спициальность</th>
                <th>Кнопка изменения</th>
                <th>Кнопка удаления</th>
                </thead>
                <c:forEach items="${teacher}" var="teacher">
                <tr>
                    <td>${teacher.fio}</td>
                    <td>${teacher.borndate}</td>
                    <td>${teacher.parseIntoString()}</td>
                    <td>${teacher.speciality}</td>
                    <td><a class="ssilka" href="<c:url value="/ChangeTeacher/${teacher.id}"/>">Изменить учителя</a></td>
                    <td><a class="ssilka" href="<c:url value="/DeleteTeacher/${teacher.id}"/>">Удалить учителя</a></td>
                    </c:forEach>

            </table>


        </div>
    </div>

    <div class=" size2">
        <a class="ssilka" href="<c:url value="/AddTeacher"/>">Добавить учителя</a>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>