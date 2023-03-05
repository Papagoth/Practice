<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Teacher</title>
    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.13.2/datatables.min.css"/>
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.13.2/datatables.min.js"></script>
    <script>

        $(function () {
//Живой поиск
            $('.who').bind("change keyup input click", function () {
                if (this.value.length >= 2) {
                    $.ajax({
                        url: "/Subject_Find/" + this.value, //Путь к обработчику
                        type: 'get',
                        cache: false,
                        success: function (data) {
                            console.log(data)
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

        $.validator.addMethod('symbols', function (value, element) {
            return value.match(new RegExp("^" + "[А-Яа-яЁё ]" + "+$"));
        }, "Здесь должны быть только русские символы");
        $(function () {
            $("#borndate").datepicker({dateFormat: 'dd/mm/yy'});
        });
        $(function () {
            $("#teacherForm").validate
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

        function show_teacher(id) {
            $.get('/get_oneteacher/' + id, function (data) {
                $("#id").val(data.id);
                $("#speciality").val(data.speciality);
                $("#borndate").val(data.borndate);
                $("#fio").val(data.fio);
                for (let i = 0; i < data.subjects.length; i++) {
                    $('#subjects').prepend('<option value=' + JSON.stringify(data.subjects[i]) + '>' + data.subjects[i].name + '</option>');
                    $('#subjects option:contains("' + data.subjects[i].name + '")').prop('selected', true);
                }
                document.getElementById('teacherForm').removeAttribute("class");
            });
        }

        function send() {
            $("#id").val('');
            $("#fio").val('');
            $("#speciality").val('');
            $("#borndate").val('');
            $("#subjects").val('');
            document.getElementById('teacherForm').removeAttribute("class");
        }

        function hide() {
            document.getElementById('teacherForm').classList.add('visible');
        }

        $(document).ready(function () {

            var table = $('#myTable').DataTable({
                "columns": [
                    {
                        "title": "ФИО", "data": "fio", "visible": true,
                    },
                    {
                        "title": "Дата рождения", "data": "borndate", "visible": true,
                    },
                    {
                        "title": "Предметы", "data": "subjects", "visible": true,
                    },
                    {
                        "title": "Специальность", "data": "speciality", "visible": true,
                    },
                    {
                        "title": "Кнопка изменения", "data": "ChangeButton", "visible": true,
                    },
                    {
                        "title": "Кнопка удаления", "data": "DeleteButton", "visible": true,
                    }
                ]
            });
            show_allteacher();
        });

        function show_allteacher() {
            var table = $('#myTable').DataTable();
            $.get('/get_allteacher', function (data) {
                for (let i = 0; i < data.length; i++) {
                    var string = "";
                    for (let j = 0; j < data[i].subjects.length; j++) {
                        if (j == data[i].subjects.length - 1) {
                            string += data[i].subjects[j].name;
                        } else {
                            string += data[i].subjects[j].name + ',';
                        }
                    }

                    table.row.add({
                        "DT_RowId": data[i].id,
                        "fio": data[i].fio,
                        "subjects": string,
                        "speciality": data[i].speciality,
                        "borndate": data[i].borndate,
                        "ChangeButton": '<button type="button" class="img_button" onclick="show_teacher(' + data[i].id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button>',
                        "DeleteButton": '<a class="ssilka"href="/DeleteTeacher/' + data[i].id + '">Удалить учителя</a>'
                    }).draw();

                    //$('#myTable').append('<tr   id= "' + data[i].id + '"><td>' + data[i].fio + '</td><td>' + data[i].borndate + '</td><td>' + string + '</td><td>' + data[i].speciality + '</td><td><button type="button" class="img_button" onclick="show_teacher(' + data[i].id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteTeacher/' + data[i].id + '">Удалить учителя</a></td></tr>');
                }
            });
        }

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

            if ($("#teacherForm").valid()) {
                $.ajax(
                    {
                        url: '/AddTeacher',
                        dataType: 'json',
                        type: 'POST',
                        cache: false,
                        contentType: 'application/json',
                        data: JSON.stringify({
                            id: $("#id").val(),
                            speciality: $("#speciality").val(),
                            fio: $("#fio").val(),
                            borndate: $("#borndate").val(),
                            subjects: JSON.parse(str)
                        }),
                        success: function () {
                            var table = $('#myTable').DataTable();
                            document.getElementById('teacherForm').classList.add('visible');
                            var string = "";
                            for (let j = 0; j < data.subjects.length; j++) {
                                if (j == data.subjects.length - 1) {
                                    string += data.subjects[j].name;
                                } else {
                                    string += data.subjects[j].name + ',';
                                }
                            }
                            if ($("#" + data.id + "").length) {
                                $("#" + data.id + "").remove();

                                table.row.add({
                                    "DT_RowId": data.id,
                                    "fio": data.fio,
                                    "subjects": string,
                                    "speciality": data.speciality,
                                    "borndate": data.borndate,
                                    "ChangeButton": '<button type="button" class="img_button" onclick="show_teacher(' + data.id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button>',
                                    "DeleteButton": '<a class="ssilka"href="/DeleteTeacher/' + data.id + '">Удалить учителя</a>'
                                }).draw();

                                //$('#myTable').append('<tr   id= "' + data.id + '"><td>' + data.fio + '</td><td>' + data.borndate + '</td><td>' + string + '</td><td>' + data.speciality + '</td><td><button type="button" class="img_button" onclick="show_teacher(' + data.id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteTeacher/' + data.id + '">Удалить учителя</a></td></tr>');
                            } else {
                                table.row.add({
                                    "DT_RowId": data.id,
                                    "fio": data.fio,
                                    "subjects": string,
                                    "speciality": data.speciality,
                                    "borndate": data.borndate,
                                    "ChangeButton": '<button type="button" class="img_button" onclick="show_teacher(' + data.id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button>',
                                    "DeleteButton": '<a class="ssilka"href="/DeleteTeacher/' + data.id + '">Удалить учителя</a>'
                                }).draw();
                                //$('#myTable').append('<tr   id= "' + data.id + '"><td>' + data.fio + '</td><td>' + data.borndate + '</td><td>' + string + '</td><td>' + data.speciality + '</td><td><button type="button" class="img_button" onclick="show_teacher(' + data.id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteTeacher/' + data.id + '">Удалить учителя</a></td></tr>');
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

    <div class="roboto">
        <div class="size2">
            <form id="teacherForm" class="visible">
                <div><input type='hidden' name='id' id='id'/></div>
                <div><input type='text' name='speciality' id='speciality'/></div>
                <div><input type='text' name='borndate' id='borndate'/></div>
                <div><input type='text' name='fio' id='fio'/></div>
                <select name="subjects" multiple="multiple" id="subjects">
                    <c:forEach items='${subjectList}' var='subjects'>
                        <option value='${subjects}'>${subjects.name}</option>
                    </c:forEach>
                </select>
                <div>
                    <input ENGINE="text" name="referal" placeholder="Живой поиск" value="" class="who"
                           autocomplete="off">
                    <ul class="search_result"></ul>
                </div>

                <button type="button " onclick="hide()" class="img_button"><img class="icon" alt="logo_1"
                                                                                src="/resources/image/back.png">
                </button>
                <button type="button " onclick="send_teacher()" class="img_button"><img class="icon" alt="logo_1"
                                                                                        src="/resources/image/disc.png">
                </button>
            </form>
        </div>

        <div class="size2">
            <table id="myTable">
                <thead>
                <th>ФИО</th>
                <th>Дата рождения</th>
                <th>Предметы</th>
                <th>Специальность</th>
                <th>Кнопка изменения</th>
                <th>Кнопка удаления</th>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <div class=" size2">
        <button type="button" onclick="send()" class="img_button"><img class="icon" alt="logo_1"
                                                                       src="/resources/image/plus.png"></button>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>