<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Student</title>
    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
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
            $("#studentForm").validate
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

        function show_onestudent(id) {
            $.get('/get_onestudent/' + id, function (data) {
                $("#id").val(id);
                $("#fio").val(data.fio);
                $("#borndata").val(data.borndata);
                $("#sticket").val(data.sticket);
                $('#party option:contains("' + data.party.name + '")').prop('selected', true);
                document.getElementById('studentForm').removeAttribute("class");
            });
        }


        function show_allstudent() {
            $.get('/get_allstudent', function (data) {
                for (let i = 0; i < data.length; i++) {
                    $('#myTable').append('<tr id = ' + data[i].id + '><td>' + data[i].fio + '</td><td>' + data[i].party.name + '</td><td>' + data[i].sticket + '</td><td>' + data[i].borndata + '</td><td><button type="button" onclick="show_onestudent(' + data[i].id + ')" class="img_button"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteStudent/' + data[i].id + '">Удалить студента</a></td></tr>');
                }
            });
        }

        $(document).ready(function () {
            show_allstudent();
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
            document.getElementById('studentForm').removeAttribute("class");
            $("#id").val('');
            $("#fio").val('');
            $("#borndata").val('');
            $("#sticket").val('');
            $('#party option[value=""]').prop('selected', true);
        }

        function send_student() {
            $("#span_name").text("");
            if ($("#studentForm").valid()) {
                $.ajax(
                    {
                        url: "/AddStudent",
                        dataType: 'json',
                        type: 'POST',
                        cache: false,
                        contentType: 'application/json',
                        data: JSON.stringify({
                            id: $("#id").val(),
                            fio: $("#fio").val(),
                            party: JSON.parse($("#party").val()),
                            borndata: $("#borndata").val(),
                            sticket: $("#sticket").val()
                        }),
                        success: function (data) {
                            document.getElementById('studentForm').classList.add('visible');
                            if ($("#" + data.id + "").length) {
                                $("#" + data.id + "").remove();
                                $('#myTable').append('<tr id = ' + data.id + '><td>' + data.fio + '</td><td>' + data.party.name + '</td><td>' + data.sticket + '</td><td>' + data.borndata + '</td><td><button type="button" onclick="show_onestudent(' + data.id + ')" class="img_button"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteStudent/' + data.id + '">Удалить студента</a></td></tr>');
                            } else {
                                $('#myTable').append('<tr id = ' + data.id + '><td>' + data.fio + '</td><td>' + data.party.name + '</td><td>' + data.sticket + '</td><td>' + data.borndata + '</td><td><button type="button" onclick="show_onestudent(' + data.id + ')" class="img_button"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteStudent/' + data.id + '">Удалить студента</a></td></tr>');
                            }
                        },
                        error: function (data) {
                            if (data.status == 404) {
                                $("#span_name").text("Номер должен быть уникальным");
                            }
                        }
                    }
                )
            }
        }

        function hide() {
            document.getElementById('studentForm').classList.add('visible');
        }

    </script>

</head>
<body>
<div class="size1">

    <jsp:include page="header.jsp"/>



    <div class="roboto">
        <div class="size2">
            <form id="studentForm" class="visible">
                <div><input type='hidden' name='id' id='id'/></div>
                <div><label>ФИО студента</label><input type='text' name='fio' id='fio'/></div>
                <div><label>Номер билета</label><input type='number' name='sticket' id='sticket'/></div>
                <div><label>Дата рождения</label><input type='text' name='borndata' id='borndata'/></div>
                <span id="span_name"></span>
                <select name="party" id="party">
                    <option value=''>Выберите группу</option>
                </select>
                <div>
                    <button type="button " onclick="send_student()" class="img_button"><img class="icon" alt="logo_1"
                        src="/resources/image/disc.png">
                    </button>
                </div>
                <div>
                    <button type="button " onclick="hide()" class="img_button"><img class="icon" alt="logo_1"
                        src="/resources/image/back.png">
                    </button>
                </div>
            </form>
        </div>
        <table id='myTable'>
            <thead>
            <th>ФИО</th>
            <th>Название группы</th>
            <th>Номер студ билета</th>
            <th>Дата рождения</th>
            <th>Кнопка изменения</th>
            <th>Кнопка удаления</th>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div class=" size2">
        <button type="button" onclick="send()" class="img_button"><img class="icon" alt="logo_1"
                                                                       src="/resources/image/plus.png"></button>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>