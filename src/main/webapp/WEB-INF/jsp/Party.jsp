<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Party</title>

    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <%--<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.13.2/datatables.min.css"/>
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.13.2/datatables.min.js"></script>

    <script>

        function showParty(id) {
            $.get('/getOneParty/' + id, function (data) {
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

        function showAllParty() {
            $.get('/getAllParty', function (data) {
                var table = $('#myTable').DataTable();
                for (let i = 0; i < data.length; i++) {
                    //$('#myTable').append('<tr><td>' + data[i].name + '</td><td>' + data[i].course + '</td><td><button type="button" class="img_button" onclick="show_party(' + data[i].id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteParty/' + data[i].id + '">Удалить группу</a></td></tr>');
                    table.row.add({
                        "DT_RowId": data[i].id,
                        "name": data[i].name,
                        "course": data[i].course,
                        "ChangeButton": '<button type="button" class="img_button" onclick="showParty(' + data[i].id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button>',
                        "DeleteButton": '<a class="ssilka"href="/DeleteParty/' + data[i].id + '">Удалить группу</a>'
                    }).draw();

                }
            });
        }


        $(document).ready(function () {
            var table = $('#myTable').DataTable({
                "columns": [
                    {
                        "title": "Название группы", "data": "name", "visible": true,
                    },
                    {
                        "title": "Название курса", "data": "course", "visible": true,
                    },
                    {
                        "title": "Кнопка изменения", "data": "ChangeButton", "visible": true,
                    },
                    {
                        "title": "Кнопка удаления", "data": "DeleteButton", "visible": true,
                    }
                ]
            });
            showAllParty();
            $("#partyForm").on('submit', function (e) {
                e.preventDefault();
                $("#span_name").text("");
                if ($("#partyForm").valid()) {
                    $.post('/addParty', {
                        id: $("#id").val(),
                        name: $("#name").val(),
                        course: $("#course").val()
                    }, null, "json")
                        .done(function () {

                            var table = $('#myTable').DataTable();
                            table.clear();
                            showAllParty();
                            document.getElementById('partyForm').classList.add('visible');

                            //  document.getElementById('partyForm').classList.add('visible');
                            //  var table = $('#myTable').DataTable();
                            //  if ($("#" + data.id + "").length) {
                            //      $("#" + data.id + "").remove();
                            //      //$('#myTable').append('<tr><td>' + data.name + '</td><td>' + data.course + '</td><td><button type="button" onclick="show_party(' + data.id + ')" class="img_button"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteParty/' + data.id + '">Удалить группу</a></td></tr>');
                            //      table.row.add({
                            //          "DT_RowId": data.id,
                            //          "name": data.name,
                            //          "course": data.course,
                            //          "ChangeButton": '<button type="button" class="img_button" onclick="show_party(' + data.id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button>',
                            //          "DeleteButton": '<a class="ssilka"href="/DeleteParty/' + data.id + '">Удалить группу</a>'
                            //      }).draw();
                            //  } else {
                            //      table.row.add({
                            //          "DT_RowId": data.id,
                            //          "name": data.name,
                            //          "course": data.course,
                            //          "ChangeButton": '<button type="button" class="img_button" onclick="show_party(' + data.id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button>',
                            //          "DeleteButton": '<a class="ssilka"href="/DeleteParty/' + data.id + '">Удалить группу</a>'
                            //      }).draw();
                            //      //$('#myTable').append('<tr><td>' + data.name + '</td><td>' + data.course + '</td><td><button type="button" onclick="show_party(' + data.id + ')" class="img_button"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteParty/' + data.id + '">Удалить группу</a></td></tr>');
                            //  }


                        }).fail(function (data) {
                        if (data.status == 404) {
                            $("#span_name").text("Название должно быть уникальным");
                        }
                    });
                }
            });


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
            <form id="partyForm" class="visible" action="/addParty">
                <div><input type='hidden' name='id' id='id'/></div>
                <div><label class="party_label">Название группы</label>

                    <input type='text' name='name' id='name'/>
                    <span id="span_name"></span>
                </div>
                <div><label class="party_label">Название курса</label><input type='text' name='course' id='course'/>
                </div>
                <div>
                    <img class="icon" alt="logo_1" src="/resources/image/back.png" onclick="hide()">
                    <button type="submit" class="img_button"><img class="icon" alt="logo_1"
                                                                  src="/resources/image/disc.png">
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
            <tbody></tbody>

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