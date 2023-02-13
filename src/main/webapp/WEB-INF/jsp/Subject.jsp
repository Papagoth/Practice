<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Subject</title>

    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>
    <script>
        function show_allsubject() {
            $.get("/get_allsubject", function (data) {
                for (let i = 0; i < data.length; i++) {
                    $('#myTable').append('<tr id = ' + data[i].id + '><td>' + data[i].name + '</td><td>' + data[i].party.name + '</td><td>' + data[i].studyingtime + '</td><td><button type="button" onclick="show_onesubject(' + data[i].id + ')">Изменить предмет</button></td><td><a class="ssilka"href="/DeleteSubject/' + data[i].id + '">Удалить предмет</a></td></tr>');
                }
            });
        }

        $(document).ready(function () {
            show_allsubject();
            show_allparty();
        });

        function show_allparty() {
            $.get('/get_allparty', function (data) {
                for (let i = 0; i < data.length; i++) {
                    $('#party').append('<option value=' + JSON.stringify(data[i]) + '>' + data[i].name + '</option>');
                }
            });
        }

        function send() {
            document.getElementById('subjectForm').removeAttribute("class");
            $("#id").val('');
            $("#name").val('');
            $("#studyingtime").val('');
            $('#party option[value=""]').prop('selected', true);
        }

        $.validator.addMethod('symbols', function (value, element) {
            return value.match(new RegExp("^" + "[А-Яа-яЁё ]" + "+$"));
        }, "Здесь должны быть только русские символы");
        $(function () {
            $("#subjectForm").validate
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
            if ($("#subjectForm").valid()) {
                $.ajax(
                    {
                        url: "/AddSubject",
                        dataType: 'json',
                        type: 'POST',
                        cache: false,
                        contentType: 'application/json',
                        data: JSON.stringify({
                            id: $("#id").val(),
                            name: $("#name").val(),
                            party: JSON.parse($('#party').val()),
                            studyingtime: $("#studyingtime").val()
                        }),
                        success: function (data) {
                            document.getElementById('subjectForm').classList.add('visible');
                            if ($("#" + data.id + "").length) {
                                $("#" + data.id + "").remove();
                                $('#myTable').append('<tr id = ' + data.id + '><td>' + data.name + '</td><td>' + data.party.name + '</td><td>' + data.studyingtime + '</td><td><button type="button" onclick="show_onesubject(' + data.id + ')">Изменить предмет</button></td><td><a class="ssilka"href="/DeleteSubject/' + data.id + '">Удалить предмет</a></td></tr>');
                            } else {
                                $('#myTable').append('<tr id = ' + data.id + '><td>' + data.name + '</td><td>' + data.party.name + '</td><td>' + data.studyingtime + '</td><td><button type="button" onclick="show_onesubject(' + data.id + ')">Изменить предмет</button></td><td><a class="ssilka"href="/DeleteSubject/' + data.id + '">Удалить предмет</a></td></tr>');
                            }
                        },
                        error: function (data) {
                            if (data.status == 404) {
                                $("#span_name").text("Навзвание должен быть уникальным");
                            }
                        }
                    }
                )
            }
        }

        function show_onesubject(id) {
            $.get('/get_onesubject/' + id, function (data) {
                $("#id").val(id);
                $("#name").val(data.name);
                $("#studyingtime").val(data.studyingtime);
                $('#party option:contains("' + data.party.name + '")').prop('selected', true);
                document.getElementById('subjectForm').removeAttribute("class");
            });
        }

        function hide() {
            document.getElementById('subjectForm').classList.add('visible');
        }
    </script>
</head>

<body>
<div class="size1">

    <jsp:include page="header.jsp"/>
    <div class="size2">
        <form id="subjectForm" class="visible">
            <div><input type='hidden' name='id' id='id'/></div>
            <div><label>Название предмета</label><input type='text' name='name' id='name'/></div>
            <span id="span_name"></span>
            <div><label>Кол-во занятий</label><input type='number' name='studyingtime' id='studyingtime'/></div>
            <select name="party" id="party">
                <option value=''>Выберите группу</option>
            </select>
            <div><input id="btn" type='button' onclick="send_subject()" value='Сохранить'/></div>
            <div><input type='button' onclick="hide()" value='Назад'/></div>

        </form>
    </div>
    <div class="roboto">
        <table id='myTable'>
            <thead>
            <th>Название предмета</th>
            <th>Название группы</th>
            <th>Время обучения</th>
            <th>Кнопка изменения</th>
            <th>Кнопка удаления</th>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div class=" size2">
        <button type="button" onclick="send()">Добавить предмет</button>
    </div>
    <jsp:include page="footer.jsp"/>

</div>
</body>
</html>