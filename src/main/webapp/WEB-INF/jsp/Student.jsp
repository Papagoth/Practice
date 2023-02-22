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
    <script data-src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.13.2/datatables.min.css"/>
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.13.2/datatables.min.js"></script>

    <script>

        $(function () {
//Живой поиск
            $('.who').bind("change keyup input click", function () {
                if (this.value.length >= 2) {
                    $.ajax({
                        url: "/Party_Find/" + this.value, //Путь к обработчику
                        type: 'get',
                        cache: false,
                        success: function (data) {
                            $(".search_result").html(data).fadeIn(); //Выводим полученые данные в списке
                            for (let i = 0; i < data.length; i++) {
                                //$('ul').append('<li id="' + data[i].name + "' value='" + JSON.stringify(data[i]) + "'>" + data[i].name + "</li>");
                                $('ul').append("<li id='" + data[i].name + "' data-attr='" + JSON.stringify(data[i]) + "'> " + data[i].name + "</li>");
                            }
                        }
                    })
                }
            })

            $(".search_result").hover(function () {
                $(".who").blur(); //Убираем фокус с input
            })

//При выборе результата поиска, прячем список и заносим выбранный результат в input
            $(".search_result").on("click", "li", function () {
                //s_user = $(this).text();
                //$(".who").val(s_user).attr('disabled', 'disabled'); //деактивируем input, если нужно
                $(".who").text($("#" + $(this).text().trim()).attr('data-attr'));
                $(".who").val($(this).text().trim())
                $(".search_result").fadeOut();
            })
        })


        $(function () {
            $("#borndata").datepicker({dateFormat: 'dd/mm/yy'});
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
                //$('#party option:contains("' + data.party.name + '")').prop('selected', true);
                $('.who').text(JSON.stringify(data.party))
                $('.who').val(data.party.name)
                document.getElementById('studentForm').removeAttribute("class");
            });
        }


        function show_allstudent() {
            $.get('/get_allstudent', function (data) {
                var table = $('#myTable').DataTable();
                for (let i = 0; i < data.length; i++) {

                    table.row.add({
                        "DT_RowId": data[i].id,
                        "fio": data[i].fio,
                        "party": data[i].party.name,
                        "sticket": data[i].sticket,
                        "borndata": data[i].borndata,
                        "ChangeButton": '<button type="button" class="img_button" onclick="show_onestudent(' + data[i].id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button>',
                        "DeleteButton": '<a class="ssilka"href="/DeleteStudent/' + data[i].id + '">Удалить студента</a>'
                    }).draw();
                    //$('#myTable').append('<tr><td>' + data[i].fio + '</td><td>' + data[i].party.name + '</td><td>' + data[i].sticket + '</td><td>' + data[i].borndata + '</td><td><button type="button" onclick="show_onestudent(' + data[i].id + ')" class="img_button"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteStudent/' + data[i].id + '">Удалить студента</a></td></tr>');
                }
            });
        }

        $(document).ready(function () {

            var table = $('#myTable').DataTable({
                "columns": [
                    {
                        "title": "ФИО", "data": "fio", "visible": true,
                    },
                    {
                        "title": "Название группы", "data": "party", "visible": true,
                    },
                    {
                        "title": "Номер студ билета", "data": "sticket", "visible": true,
                    },
                    {
                        "title": "Дата рождения", "data": "borndata", "visible": true,
                    },
                    {
                        "title": "Кнопка изменения", "data": "ChangeButton", "visible": true,
                    },
                    {
                        "title": "Кнопка удаления", "data": "DeleteButton", "visible": true,
                    }
                ]
            });
            show_allstudent();
            // show_allparty();
        });

        //function show_allparty() {
        //    $.get('/get_allparty', function (data) {
        //        for (let i = 0; i < data.length; i++) {
        //            $('#party').append('<option value=' + JSON.stringify(data[i]) + '>' + data[i].name + '</option>');
        //        }
        //    });
        //}

        function send() {
            document.getElementById('studentForm').removeAttribute("class");
            $("#id").val('');
            $("#fio").val('');
            $("#borndata").val('');
            $("#sticket").val('');
            //$('#party option[value=""]').prop('selected', true);
            $('.who').val('');
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
                            party: JSON.parse($(".who").text()),
                            borndata: $("#borndata").val(),
                            sticket: $("#sticket").val()
                        }),
                        success: function (data) {
                            var table = $('#myTable').DataTable();
                            document.getElementById('studentForm').classList.add('visible');
                            if ($("#" + data.id + "").length) {
                                $("#" + data.id + "").remove();
                                table.row.add({
                                    "DT_RowId": data.id,
                                    "fio": data.fio,
                                    "party": data.party.name,
                                    "sticket": data.sticket,
                                    "borndata": data.borndata,
                                    "ChangeButton": '<button type="button" class="img_button" onclick="show_onestudent(' + data.id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button>',
                                    "DeleteButton": '<a class="ssilka"href="/DeleteStudent/' + data.id + '">Удалить студента</a>'
                                }).draw();
                                //$('#myTable').append('<tr><td>' + data.fio + '</td><td>' + data.party.name + '</td><td>' + data.sticket + '</td><td>' + data.borndata + '</td><td><button type="button" onclick="show_onestudent(' + data.id + ')" class="img_button"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteStudent/' + data.id + '">Удалить студента</a></td></tr>');
                            } else {
                                table.row.add({
                                    "DT_RowId": data.id,
                                    "fio": data.fio,
                                    "party": data.party.name,
                                    "sticket": data.sticket,
                                    "borndata": data.borndata,
                                    "ChangeButton": '<button type="button" class="img_button" onclick="show_onestudent(' + data.id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button>',
                                    "DeleteButton": '<a class="ssilka"href="/DeleteStudent/' + data.id + '">Удалить студента</a>'
                                }).draw();

                                //$('#myTable').append('<tr ><td>' + data.fio + '</td><td>' + data.party.name + '</td><td>' + data.sticket + '</td><td>' + data.borndata + '</td><td><button type="button" onclick="show_onestudent(' + data.id + ')" class="img_button"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteStudent/' + data.id + '">Удалить студента</a></td></tr>');
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
                <div><label class="student_label">ФИО студента</label><input type='text' name='fio' id='fio'/></div>
                <div><label class="student_label">Номер билета</label><input type='number' name='sticket' id='sticket'/>
                </div>
                <div><label class="student_label">Дата рождения</label><input type='text' name='borndata'
                                                                              id='borndata'/></div>
                <span id="span_name"></span>

                <input ENGINE="text" name="referal" placeholder="Живой поиск" value='' class="who" autocomplete="off">
                <ul class="search_result"></ul>

                <div>
                    <button type="button " onclick="hide()" class="img_button"><img class="icon" alt="logo_1"
                                                                                    src="/resources/image/back.png">
                    </button>
                    <button type="button " onclick="send_student()" class="img_button"><img class="icon" alt="logo_1"
                                                                                            src="/resources/image/disc.png">
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