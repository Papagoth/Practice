<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Subject</title>

  <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
</head>

<body>
<div class="size1">

<jsp:include page="header.jsp"/>

        <div class="roboto">
  <table>
    <thead>
    <th>Название предмета</th>
    <th>Название группы</th>
    <th>Время обучения</th>
    <th>Кнопка изменения</th>
    <th>Кнопка удаления</th>
    </thead>
    <c:forEach items="${Subject}" var="subject">
      <tr>

        <td>${subject.name}</td>
        <td>${subject.party.name}</td>
        <td>${subject.studyingtime}</td>
        <td> <a class="ssilka" href="<c:url value="/ChangeSubject/${subject.id}"/>">Изменить предмет</a></td>
        <td> <a class="ssilka" href="<c:url value="/DeleteSubject/${subject.id}"/>">Удалить предмет</a></td>
    </c:forEach>
  </table>
  </div>
 <div class=" size2">
 <a class="ssilka" href="<c:url value="/AddSubject"/>">Добавить предмет</a>
 </div>
<jsp:include page="footer.jsp"/>

</div>
</body>
</html>