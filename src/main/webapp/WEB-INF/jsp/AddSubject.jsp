<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>AddSubject</title>
    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>
    <script>
        $.validator.addMethod('symbols', function (value, element) {
            return value.match(new RegExp("^" + "[А-Яа-яЁё ]" + "+$"));
        }, "Здесь должны быть только русские символы");
        $(function () {
            $("#SubjectForm").validate
            ({
                rules: {
                    name: {
                        required: true,
                        symbols: true,
                        minlength: 2

                    },
                    studyingtime: {
                        required: true,
                        number: true,
                        min: 10,
                        max: 250
                    }
                },
                messages: {
                    name: {
                        required: 'Это поле не должно быть пустым',
                        minlength: 'Название предмета должно содержать больше 2 символов'
                    },
                    studyingtime: {
                        required: 'Это поле не должно быть пустым',
                        number: 'Здесь не может быть символов',
                        min: 'Минимальное число 10 для времени обчуения',
                        max: 'Максимальное число 250 для времени обчуения'
                    }
                }
            });
        })

        function send_subject() {
            $("#span_name").text("");
            if ($("#SubjectForm").valid()) {
                $.ajax(
                    {
                        url: "/AddSubject",
                        dataType: 'json',
                        type: 'POST',
                        cache: false,
                        contentType: 'application/json',
                        data: JSON.stringify({
                            name: $("#name").val(),
                            party: JSON.parse($('#party').val()),
                            studyingtime: $("#studyingtime").val()
                        }),
                        error: function (data) {
                            if (data.status == 404) {
                                $("#span_name").text("Навзвание должен быть уникальным");
                            }
                        }
                    }
                )
            }
        }
    </script>
</head>

<body>
<div class="size1">

    <jsp:include page="header.jsp"/>


    <div class="size2">
        <form id="SubjectForm">
            <div><input type='text' name='name' id='name'/></div>
            <span id="span_name"></span>
            <div><input type='number' name='studyingtime' id='studyingtime'/></div>
            <select name="party" id="party">
                <option value=''>Выберите группу</option>
                <c:forEach items="${partyList}" var="party">
                    <option value='${party}'>${party.name}</option>
                </c:forEach>
            </select>
            <div><input id="btn" type='button' onclick="send_subject()" value='Сохранить'/></div>
        </form>
    </div>


    <div class=" size2">
        <a class="ssilka" href="<c:url value="/Subject"/>">Назад</a>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>