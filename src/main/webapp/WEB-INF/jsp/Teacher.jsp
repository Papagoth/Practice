<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.13/js/bootstrap-multiselect.js"></script>
    <link rel="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.13/css/bootstrap-multiselect.css"
          type="text/css"/>
    <title>Teacher</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/css/style.css" type="text/css">
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.13.2/datatables.min.css"/>
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.13.2/datatables.min.js"></script>
    <script>


        $(function () {
            $('.who').bind("change keyup input click", function () {
                if (this.value.length >= 2) {
                    $.ajax({
                        url: "/subjectFind/" + this.value, //Путь к обработчику
                        type: 'get',
                        cache: false,
                        success: function (data) {
                            $(".search_result").html(data).fadeIn(); //Выводим полученые данные в списке
                            for (let i = 0; i < data.length; i++) {
                                //$('ul').append('<li id="' + data[i].name + "' value='" + JSON.stringify(data[i]) + "'>" + data[i].name + "</li>");
                                $('.search_result').append("<li data-attr='" + JSON.stringify(data[i]) + "'> " + data[i].name + "</li>");
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
                $('#subjects option:contains("' + $(this).text().trim() + '")').prop('selected', true);
                if ($("#" + $(this).text().trim() + "").length) {
                } else {
                    $('#resulter').append("<li id='" + $(this).text().trim() + "'> " + $(this).text().trim() + "</li>");
                }
                $(".who").val($(this).text().trim())
                $(".search_result").fadeOut();
            })


            $("#resulter").on("click", "li", function () {
                $('#subjects option:contains("' + $(this).text().trim() + '")').prop('selected', false);
                $(this).remove();
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

        function showTeacher(id) {
            $.get('/getOneTeacher/' + id, function (data) {
                $("#subjects").val('');
                $('li').remove();
                $("#id").val(data.id);
                $("#speciality").val(data.speciality);
                $("#borndate").val(data.borndate);
                $("#fio").val(data.fio);
                for (let i = 0; i < data.subjects.length; i++) {
                    //$('#subjects').prepend('<option  value=' + JSON.stringify(data.subjects[i]) + ' selected = "selected">' + data.subjects[i].name + '</option>');
                    $('#subjects option:contains("' + data.subjects[i].name.trim() + '")').prop('selected', true);
                    $('#resulter').append("<li id='" + data.subjects[i].name.trim() + "'> " + data.subjects[i].name.trim() + "</li>");
                    //console.log($('#subjects option:contains("' + data.subjects[i].name + '")').attr('data-attr'));
                }
                document.getElementById('teacherForm').removeAttribute("class");
            });
        }

        function send() {
            $('li').remove();
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
                ],
                "language":
                    {
                        "processing": "Подождите...",
                        "search": "Поиск:",
                        "lengthMenu": "Показать _MENU_ записей",
                        "info": "Записи с _START_ до _END_ из _TOTAL_ записей",
                        "infoEmpty": "Записи с 0 до 0 из 0 записей",
                        "infoFiltered": "(отфильтровано из _MAX_ записей)",
                        "loadingRecords": "Загрузка записей...",
                        "zeroRecords": "Записи отсутствуют.",
                        "emptyTable": "В таблице отсутствуют данные",
                        "paginate": {
                            "first": "Первая",
                            "previous": "Предыдущая",
                            "next": "Следующая",
                            "last": "Последняя"
                        },
                        "aria": {
                            "sortAscending": ": активировать для сортировки столбца по возрастанию",
                            "sortDescending": ": активировать для сортировки столбца по убыванию"
                        },
                        "select": {
                            "rows": {
                                "_": "Выбрано записей: %d",
                                "1": "Выбрана одна запись"
                            },
                            "cells": {
                                "_": "Выбрано %d ячеек",
                                "1": "Выбрана 1 ячейка "
                            },
                            "columns": {
                                "1": "Выбран 1 столбец ",
                                "_": "Выбрано %d столбцов "
                            }
                        },
                        "searchBuilder": {
                            "conditions": {
                                "string": {
                                    "startsWith": "Начинается с",
                                    "contains": "Содержит",
                                    "empty": "Пусто",
                                    "endsWith": "Заканчивается на",
                                    "equals": "Равно",
                                    "not": "Не",
                                    "notEmpty": "Не пусто",
                                    "notContains": "Не содержит",
                                    "notStartsWith": "Не начинается на",
                                    "notEndsWith": "Не заканчивается на"
                                },
                                "date": {
                                    "after": "После",
                                    "before": "До",
                                    "between": "Между",
                                    "empty": "Пусто",
                                    "equals": "Равно",
                                    "not": "Не",
                                    "notBetween": "Не между",
                                    "notEmpty": "Не пусто"
                                },
                                "number": {
                                    "empty": "Пусто",
                                    "equals": "Равно",
                                    "gt": "Больше чем",
                                    "gte": "Больше, чем равно",
                                    "lt": "Меньше чем",
                                    "lte": "Меньше, чем равно",
                                    "not": "Не",
                                    "notEmpty": "Не пусто",
                                    "between": "Между",
                                    "notBetween": "Не между ними"
                                },
                                "array": {
                                    "equals": "Равно",
                                    "empty": "Пусто",
                                    "contains": "Содержит",
                                    "not": "Не равно",
                                    "notEmpty": "Не пусто",
                                    "without": "Без"
                                }
                            },
                            "data": "Данные",
                            "deleteTitle": "Удалить условие фильтрации",
                            "logicAnd": "И",
                            "logicOr": "Или",
                            "title": {
                                "0": "Конструктор поиска",
                                "_": "Конструктор поиска (%d)"
                            },
                            "value": "Значение",
                            "add": "Добавить условие",
                            "button": {
                                "0": "Конструктор поиска",
                                "_": "Конструктор поиска (%d)"
                            },
                            "clearAll": "Очистить всё",
                            "condition": "Условие",
                            "leftTitle": "Превосходные критерии",
                            "rightTitle": "Критерии отступа"
                        },
                        "searchPanes": {
                            "clearMessage": "Очистить всё",
                            "collapse": {
                                "0": "Панели поиска",
                                "_": "Панели поиска (%d)"
                            },
                            "count": "{total}",
                            "countFiltered": "{shown} ({total})",
                            "emptyPanes": "Нет панелей поиска",
                            "loadMessage": "Загрузка панелей поиска",
                            "title": "Фильтры активны - %d",
                            "showMessage": "Показать все",
                            "collapseMessage": "Скрыть все"
                        },
                        "buttons": {
                            "pdf": "PDF",
                            "print": "Печать",
                            "collection": "Коллекция <span class=\"ui-button-icon-primary ui-icon ui-icon-triangle-1-s\"><\/span>",
                            "colvis": "Видимость столбцов",
                            "colvisRestore": "Восстановить видимость",
                            "copy": "Копировать",
                            "copyKeys": "Нажмите ctrl or u2318 + C, чтобы скопировать данные таблицы в буфер обмена.  Для отмены, щелкните по сообщению или нажмите escape.",
                            "copyTitle": "Скопировать в буфер обмена",
                            "csv": "CSV",
                            "excel": "Excel",
                            "pageLength": {
                                "-1": "Показать все строки",
                                "_": "Показать %d строк",
                                "1": "Показать 1 строку"
                            },
                            "removeState": "Удалить",
                            "renameState": "Переименовать",
                            "copySuccess": {
                                "1": "Строка скопирована в буфер обмена",
                                "_": "Скопировано %d строк в буфер обмена"
                            },
                            "createState": "Создать состояние",
                            "removeAllStates": "Удалить все состояния",
                            "savedStates": "Сохраненные состояния",
                            "stateRestore": "Состояние %d",
                            "updateState": "Обновить"
                        },
                        "decimal": ".",
                        "infoThousands": ",",
                        "autoFill": {
                            "cancel": "Отменить",
                            "fill": "Заполнить все ячейки <i>%d<i><\/i><\/i>",
                            "fillHorizontal": "Заполнить ячейки по горизонтали",
                            "fillVertical": "Заполнить ячейки по вертикали",
                            "info": "Информация"
                        },
                        "datetime": {
                            "previous": "Предыдущий",
                            "next": "Следующий",
                            "hours": "Часы",
                            "minutes": "Минуты",
                            "seconds": "Секунды",
                            "unknown": "Неизвестный",
                            "amPm": [
                                "AM",
                                "PM"
                            ],
                            "months": {
                                "0": "Январь",
                                "1": "Февраль",
                                "10": "Ноябрь",
                                "11": "Декабрь",
                                "2": "Март",
                                "3": "Апрель",
                                "4": "Май",
                                "5": "Июнь",
                                "6": "Июль",
                                "7": "Август",
                                "8": "Сентябрь",
                                "9": "Октябрь"
                            },
                            "weekdays": [
                                "Вс",
                                "Пн",
                                "Вт",
                                "Ср",
                                "Чт",
                                "Пт",
                                "Сб"
                            ]
                        },
                        "editor": {
                            "close": "Закрыть",
                            "create": {
                                "button": "Новый",
                                "title": "Создать новую запись",
                                "submit": "Создать"
                            },
                            "edit": {
                                "button": "Изменить",
                                "title": "Изменить запись",
                                "submit": "Изменить"
                            },
                            "remove": {
                                "button": "Удалить",
                                "title": "Удалить",
                                "submit": "Удалить",
                                "confirm": {
                                    "_": "Вы точно хотите удалить %d строк?",
                                    "1": "Вы точно хотите удалить 1 строку?"
                                }
                            },
                            "multi": {
                                "restore": "Отменить изменения",
                                "title": "Несколько значений",
                                "noMulti": "Это поле должно редактироватся отдельно, а не как часть групы",
                                "info": "Выбранные элементы содержат разные значения для этого входа.  Чтобы отредактировать и установить для всех элементов этого ввода одинаковое значение, нажмите или коснитесь здесь, в противном случае они сохранят свои индивидуальные значения."
                            },
                            "error": {
                                "system": "Возникла системная ошибка (<a target=\"\\\" rel=\"nofollow\" href=\"\\\">Подробнее<\/a>)."
                            }
                        },
                        "searchPlaceholder": "Что ищете?",
                        "stateRestore": {
                            "creationModal": {
                                "button": "Создать",
                                "search": "Поиск",
                                "columns": {
                                    "search": "Поиск по столбцам",
                                    "visible": "Видимость столбцов"
                                },
                                "name": "Имя:",
                                "order": "Сортировка",
                                "paging": "Страницы",
                                "scroller": "Позиция прокрутки",
                                "searchBuilder": "Редактор поиска",
                                "select": "Выделение",
                                "title": "Создать новое состояние",
                                "toggleLabel": "Включает:"
                            },
                            "removeJoiner": "и",
                            "removeSubmit": "Удалить",
                            "renameButton": "Переименовать",
                            "duplicateError": "Состояние с таким именем уже существует.",
                            "emptyError": "Имя не может быть пустым.",
                            "emptyStates": "Нет сохраненных состояний",
                            "removeConfirm": "Вы уверены, что хотите удалить %s?",
                            "removeError": "Не удалось удалить состояние.",
                            "removeTitle": "Удалить состояние",
                            "renameLabel": "Новое имя для %s:",
                            "renameTitle": "Переименовать состояние"
                        },
                        "thousands": " "
                    }
            });
            showAllTeacher();


            $("#teacherForm").on('submit', function (e) {

                e.preventDefault();

                let str = '[';
                for (let i = 0; i < $('#subjects').val().length; i++) {
                    if (i == $('#subjects').val().length - 1) {

                        str += $('#subjects option:contains("' + $('#subjects').val()[i] + '")').attr('data-attr');
                    } else {

                        str += $('#subjects option:contains("' + $('#subjects').val()[i] + '")').attr('data-attr') + ',';

                    }
                }
                str += ']';
                if ($("#teacherForm").valid()) {

                    $.ajax({
                        type: 'POST',
                        url: "/addTeacher",
                        contentType: 'application/json; charset=utf-8',
                        data: JSON.stringify({
                            id: $("#id").val(),
                            speciality: $("#speciality").val(),
                            fio: $("#fio").val(),
                            borndate: $("#borndate").val(),
                            subjects: JSON.parse(str)
                        }),
                        dataType: 'json',
                        async: true
                    }).always(function () {
                        var table = $('#myTable').DataTable();
                        table.clear();
                        showAllTeacher();
                        document.getElementById('teacherForm').classList.add('visible');
                    });


                }
            });


        });

        function showAllTeacher() {
            var table = $('#myTable').DataTable();
            $.get('/getAllTeacher', function (data) {
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
                        "ChangeButton": '<button type="button" class="img_button" onclick="showTeacher(' + data[i].id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button>',
                        "DeleteButton": '<a class="ssilka"href="/DeleteTeacher/' + data[i].id + '">Удалить учителя</a>'
                    }).draw();

                    //$('#myTable').append('<tr   id= "' + data[i].id + '"><td>' + data[i].fio + '</td><td>' + data[i].borndate + '</td><td>' + string + '</td><td>' + data[i].speciality + '</td><td><button type="button" class="img_button" onclick="show_teacher(' + data[i].id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteTeacher/' + data[i].id + '">Удалить учителя</a></td></tr>');
                }
            });
        }

        //function send_teacher() {
        //    let str = '[';
        //    for (let i = 0; i < $('#subjects').val().length; i++) {
        //        if (i == $('#subjects').val().length - 1) {
        //            str += $("#" + $('#subjects').val()[i] + "").attr('data-attr');
        //        } else {
        //            str += $("#" + $('#subjects').val()[i] + "").attr('data-attr') + ',';
        //        }
        //    }
        //    str += ']';
        //    if ($("#teacherForm").valid()) {
        //        $.ajax(
        //            {
        //                url: '/addTeacher',
        //                dataType: 'json',
        //                type: 'POST',
        //                cache: false,
        //                contentType: 'application/json',
        //                data: JSON.stringify({
        //                    id: $("#id").val(),
        //                    speciality: $("#speciality").val(),
        //                    fio: $("#fio").val(),
        //                    borndate: $("#borndate").val(),
        //                    subjects: JSON.parse(str)
        //                }),
        //                success: function () {
        //                    var table = $('#myTable').DataTable();
        //                    document.getElementById('teacherForm').classList.add('visible');
        //                    var string = "";
        //                    for (let j = 0; j < data.subjects.length; j++) {
        //                        if (j == data.subjects.length - 1) {
        //                            string += data.subjects[j].name;
        //                        } else {
        //                            string += data.subjects[j].name + ',';
        //                        }
        //                    }
        //                    if ($("#" + data.id + "").length) {
        //                        $("#" + data.id + "").remove()
        //                        table.row.add({
        //                            "DT_RowId": data.id,
        //                            "fio": data.fio,
        //                            "subjects": string,
        //                            "speciality": data.speciality,
        //                            "borndate": data.borndate,
        //                            "ChangeButton": '<button type="button" class="img_button" onclick="show_teacher(' + data.id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button>',
        //                            "DeleteButton": '<a class="ssilka"href="/DeleteTeacher/' + data.id + '">Удалить учителя</a>'
        //                        }).draw()
        //                        //$('#myTable').append('<tr   id= "' + data.id + '"><td>' + data.fio + '</td><td>' + data.borndate + '</td><td>' + string + '</td><td>' + data.speciality + '</td><td><button type="button" class="img_button" onclick="show_teacher(' + data.id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteTeacher/' + data.id + '">Удалить учителя</a></td></tr>');
        //                    } else {
        //                        table.row.add({
        //                            "DT_RowId": data.id,
        //                            "fio": data.fio,
        //                            "subjects": string,
        //                            "speciality": data.speciality,
        //                            "borndate": data.borndate,
        //                            "ChangeButton": '<button type="button" class="img_button" onclick="show_teacher(' + data.id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button>',
        //                            "DeleteButton": '<a class="ssilka"href="/DeleteTeacher/' + data.id + '">Удалить учителя</a>'
        //                        }).draw();
        //                        //$('#myTable').append('<tr   id= "' + data.id + '"><td>' + data.fio + '</td><td>' + data.borndate + '</td><td>' + string + '</td><td>' + data.speciality + '</td><td><button type="button" class="img_button" onclick="show_teacher(' + data.id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteTeacher/' + data.id + '">Удалить учителя</a></td></tr>');
        //                    }
        //                }
        //            }
        //        )
        //    }
        //}

    </script>
</head>

<body>
<div class="size1">

    <jsp:include page="header.jsp"/>

    <div class="roboto">
        <div class="size2">
            <form id="teacherForm" class="visible">
                <div><input type='hidden' name='id' id='id'/></div>
                <div><label class="subject_label">Специализация</label><input type='text' name='speciality'
                                                                              id='speciality'/></div>
                <div><label class="subject_label">Дата рождения</label><input type='text' name='borndate'
                                                                              id='borndate'/></div>
                <div><label class="subject_label">ФИО</label><input type='text' name='fio' id='fio'/></div>
                <select name="subjects" multiple="multiple" id="subjects" class="visible">
                    <c:forEach items='${subjectList}' var='subjects'>
                        <option value='${subjects.name}'
                                data-attr='${subjects}'>${subjects.name}</option>
                    </c:forEach>
                </select>

                <div>
                    <div>
                        <input ENGINE="text" name="referal" placeholder="Живой поиск" value="" class="who"
                               autocomplete="off">
                        <ul class="search_result"></ul>
                    </div>

                    <div class="result_div">
                        <p>Выбранные элементы</p>
                        <ul id="resulter">
                        </ul>
                    </div>

                </div>


                <div>
                    <img class="icon" onclick="hide()" alt="logo_1" src="/resources/image/back.png">

                    <button type="button " class="img_button"><img class="icon" alt="logo_1"
                                                                   src="/resources/image/disc.png">
                    </button>
                </div>
            </form>


            <button type="button" onclick="send()" class="img_button"><img class="icon" alt="logo_1"
                                                                           src="/resources/image/plus.png"></button>
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
    </div>
    <jsp:include page="footer.jsp"/>
</div>
<script src="/resources/js/jquery.multi-select.js" type="text/javascript"></script>
</body>
</html>