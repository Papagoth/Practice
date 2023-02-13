<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Party</title>

    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>
    <script>

        function show_party(id) {
            $.get('/get_oneparty/' + id, function (data) {
                $("#id").val(id);
                $("#name").val(data.name);
                $("#course").val(data.course);
                document.getElementById('partyForm').removeAttribute("class");
            });
        }

        function send() {
            $("#id").val('');
            $("#name").val('');
            $("#course").val('');
            document.getElementById('partyForm').removeAttribute("class");


        }

        function show_allparty() {
            $.get('/get_allparty', function (data) {
                for (let i = 0; i < data.length; i++) {
                    $('#myTable').append('<tr id = ' + data[i].id + '><td>' + data[i].name + '</td><td>' + data[i].course + '</td><td><button type="button" class="img_button" onclick="show_party(' + data[i].id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteParty/' + data[i].id + '">Удалить группу</a></td></tr>');
                }
            });
        }

        $(document).ready(function () {
            show_allparty();
        });

        $.validator.addMethod('symbols', function (value, element) {
            return value.match(new RegExp("^" + "[А-Яа-яЁё ]" + "+$"));
        }, "Здесь должны быть только русские символы");
        $(function () {
            $("#partyForm").validate
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
            if ($("#partyForm").valid()) {
                $.ajax(
                    {
                        url: '/AddParty',
                        dataType: 'json',
                        type: 'POST',
                        cache: false,
                        contentType: 'application/json',
                        data: JSON.stringify({
                            id: $("#id").val(),
                            name: $("#name").val(),
                            course: $("#course").val()
                        }),
                        success: function (data) {
                            document.getElementById('partyForm').classList.add('visible');
                            if ($("#" + data.id + "").length) {
                                $("#" + data.id + "").remove();
                                $('#myTable').append('<tr id = ' + data.id + '><td>' + data.name + '</td><td>' + data.course + '</td><td><button type="button" onclick="show_party(' + data.id + ')" class="img_button"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteParty/' + data.id + '">Удалить группу</a></td></tr>');
                            } else {
                                $('#myTable').append('<tr id = ' + data.id + '><td>' + data.name + '</td><td>' + data.course + '</td><td><button type="button" onclick="show_party(' + data.id + ')" class="img_button"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteParty/' + data.id + '">Удалить группу</a></td></tr>');
                            }
                        },
                        error: function (data) {
                            if (data.status == 404) {
                                $("#span_name").text("Название должно быть уникальным");
                            }

                        }
                    }
                )
            }
        }

        function hide() {
            document.getElementById('partyForm').classList.add('visible');
        }
    </script>
</head>

<body>
<div class="size1">
    <jsp:include page="header.jsp"/>


    <div class="roboto">
        <div class="size2">
            <form id="partyForm" class="visible">
                <div><input type='hidden' name='id' id='id'/></div>
                <div><label>Название группы</label><input type='text' name='name' id='name'/></div>
                <span id="span_name"></span>
                <div><label>Название курса</label><input type='text' name='course' id='course'/></div>

                <div>
                    <button type="button " onclick="send_party()" class="img_button"><img class="icon" alt="logo_1"
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
            <th>Название группы</th>
            <th>Название курса</th>
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