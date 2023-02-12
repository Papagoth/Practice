<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>AddParty</title>
    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>
    <script>
        $.validator.addMethod('symbols', function (value, element) {
            return value.match(new RegExp("^" + "[А-Яа-яЁё ]" + "+$"));
        }, "Здесь должны быть только русские символы");
        $(function () {
            $("#PartyForm").validate
            ({
                rules: {
                    name: {
                        required: true,
                        symbols: true,
                        minlength: 3

                    },
                    course: {
                        required: true,
                        symbols: true,
                        minlength: 3
                    }
                },
                messages: {
                    name: {
                        required: 'Это поле не должно быть пустым',
                        minlength: 'Название группы должно содержать больше 3 символов'

                    },
                    course: {
                        required: 'Это поле не должно быть пустым',
                        minlength: 'Название курса должно содержать больше 3 символов'
                    }
                }
            });
        })


        function send_party() {
            $("#span_name").text("");
            if ($("#PartyForm").valid()) {
                $.ajax(
                    {
                        url: '/AddParty',
                        dataType: 'json',
                        type: 'POST',
                        cache: false,
                        contentType: 'application/json',
                        data: JSON.stringify({
                            name: $("#name").val(),
                            course: $("#course").val()
                        }),
                        error: function (data) {
                            if (data.status == 404) {
                                $("#span_name").text("Название должно быть уникальным");
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


        <form id="PartyForm">

            <div><input type='text' name='name' id='name'/></div>
            <span id="span_name"></span>
            <div><input type='text' name='course' id='course'/></div>
            <div><input id="btn" type='button' onclick="send_party()" value='Сохранить'/></div>

        </form>


    </div>
    <div class=" size2">
        <a class="ssilka" href="<c:url value="/Party"/>">Назад</a>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
</div>
</body>
</html>