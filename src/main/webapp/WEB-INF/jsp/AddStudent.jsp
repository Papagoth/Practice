<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>


<html>
<head>
    <meta charset="utf-8">
    <title>AddStudent</title>
    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>
    <script>

        $(function () {
            $("#borndata").datepicker();
        });
        $.validator.addMethod('symbols', function (value, element) {
            return value.match(new RegExp("^" + "[А-Яа-яЁё ]" + "+$"));
        }, "Здесь должны быть только русские символы");

        $(function () {
            $("#StudentForm").validate
            ({
                rules: {
                    fio: {
                        required: true,
                        symbols: true,
                        minlength: 4
                    },
                    sticket: {
                        required: true,
                        number: true,
                        min: 10000000,
                        max: 99999999
                    },
                    borndate: {
                        required: true
                    }
                },
                messages: {
                    sticket: {
                        required: 'Это поле не должно быть пустым',
                        min: 'Минимальное число 10000000 для билета',
                        max: 'Максимальное число 99999999 для билета'
                    },
                    fio: {
                        required: 'Это поле не должно быть пустым',
                        number: 'Здесь не может быть символов',
                        minlength: 'Здесь не может быть меньше 4 символов'
                    },
                    borndate: {
                        required: "Это поле не должно быть пустым"
                    }
                }
            });
        })

        function send_student() {
            $("#span_name").text("");
            if ($("#StudentForm").valid()) {
                $.ajax(
                    {
                        url: "/AddStudent",
                        dataType: 'json',
                        type: 'POST',
                        cache: false,
                        contentType: 'application/json',
                        data: JSON.stringify({
                            fio: $("#fio").val(),
                            party: JSON.parse($("#party").val()),
                            borndata: $("#borndata").val(),
                            sticket: $("#sticket").val()
                        }),
                        error: function (data) {
                            if (data.status == 404) {
                                $("#span_name").text("Номер должен быть уникальным");
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
        <form id="StudentForm">
            <div><input type='text' name='fio' id='fio'/></div>
            <div><input type='text' name='borndata' id='borndata'/></div>
            <div><input type='number' name='sticket' id='sticket'/></div>
            <span id="span_name"></span>
            <select name="party" id="party">
                <option value=''>Выберите группу</option>
                <c:forEach items="${PartyList}" var="party">
                    <option value='${party}'>${party.name}</option>
                </c:forEach>
            </select>
            <div><input id="btn" type='button' onclick="send_student()" value='Save'/></div>
        </form>
    </div>
    <div class="size2">
        <a class="ssilka" href="<c:url value="/Student"/>">Назад</a>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>