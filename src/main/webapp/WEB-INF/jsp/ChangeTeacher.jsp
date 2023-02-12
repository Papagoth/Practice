<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>ChangeTeacher</title>

    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>
    <script>
        $(function () {
            $("#datepicker").datepicker();
        });
    </script>
    <script>
        function show_teacher() {
            $.get('/change_teacher/' + document.getElementById("input_id").value, function (data) {
                $("#speciality").val(data.speciality);
                $("#datepicker").val(data.borndate);
                $("#fio").val(data.fio);
                console.log(data.subjects);
                for (let i = 0; i < data.subjects.length; i++) {
                    $('#subjects').prepend('<option value=' + JSON.stringify(data.subjects[i]) + '>' + data.subjects[i].name + '</option>');
                    $('#subjects option:contains("' + data.subjects[i].name + '")').prop('selected', true);
                }


            });
        }

        $(document).ready(function () {
            show_teacher();
        });

        $.validator.addMethod('symbols', function (value, element) {
            return value.match(new RegExp("^" + "[А-Яа-яЁё ]" + "+$"));
        }, "Здесь должны быть только русские символы");
        $(function () {
            $("#TeacherForm").validate
            ({
                rules: {
                    fio: {
                        required: true,
                        symbols: true,
                        minlength: 4
                    },
                    speciality: {
                        required: true,
                        symbols: true,
                        minlength: 3
                    }
                },
                messages: {
                    speciality: {
                        required: 'Это поле не должно быть пустым',
                        minlength: 'Здесь не может быть меньше 4 символов'
                    },
                    fio: {
                        required: 'Это поле не должно быть пустым',
                        minlength: 'Здесь не может быть меньше 3 символов'
                    }
                }
            });
        })

        function send_teacher() {
            let str = '[';
            for (let i = 0; i < $('#subjects').val().length; i++) {
                if (i == $('#subjects').val().length - 1) {
                    str += $('#subjects').val()[i];
                } else {
                    str += $('#subjects').val()[i] + ',';
                }
            }
            str += ']';
            if ($("#TeacherForm").valid()) {
                $.ajax(
                    {
                        url: "/addchange_teacher/" + document.getElementById("input_id").value,
                        dataType: 'json',
                        type: 'POST',
                        cache: false,
                        contentType: 'application/json',
                        data: JSON.stringify({
                            id: $("#input_id").val(),
                            speciality: $("#speciality").val(),
                            fio: $("#fio").val(),
                            subjects: JSON.parse(str),
                            borndate: $("#datepicker").val()
                        }),
                        success: function () {
                            show_teacher();
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
        <form id="TeacherForm">
            <div><input type='text' name='speciality' id='speciality'/></div>
            <div><input type='text' name='datepicker' id='datepicker'/></div>
            <div><input type='text' name='fio' id='fio'/></div>
            <select name="subjects" multiple="multiple" id="subjects">
                <c:forEach items='${subjectList}' var='subjects'>
                    <option value='${subjects}'>${subjects.name}</option>
                </c:forEach>
            </select>
            <div><input id="btn" type='button' onclick="send_teacher()" value='Сохранить'/></div>
        </form>
    </div>
    <div class=" size2">
        <a class="ssilka" href="<c:url value="/Teacher"/>">Назад</a>
    </div>
    <input type="hidden" id="input_id" placeholder="${id}" value="${id}"/>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>