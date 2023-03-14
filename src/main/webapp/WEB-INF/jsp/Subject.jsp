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
    <script data-src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.13.2/datatables.min.css"/>
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.13.2/datatables.min.js"></script>

    <script>

        $(function () {
//Живой поиск
            $('.who').bind("change keyup input click", function () {
                if (this.value.length >= 2) {
                    $.ajax({
                        url: "/partyFind/" + this.value, //Путь к обработчику
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


        function showAllSubject() {
            $.get("/getAllSubject", function (data) {
                var table = $('#myTable').DataTable();
                for (let i = 0; i < data.length; i++) {
                    table.row.add({
                        "DT_RowId": data[i].id,
                        "name": data[i].name,
                        "party": data[i].party.name,
                        "studyingtime": data[i].studyingtime,
                        "ChangeButton": '<button type="button" class="img_button" onclick="showOneSubject(' + data[i].id + ')"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button>',
                        "DeleteButton": '<a class="ssilka"href="/DeleteStudent/' + data[i].id + '">Удалить студента</a>'
                    }).draw();
                    //$('#myTable').append('<tr><td>' + data[i].name + '</td><td>' + data[i].party.name + '</td><td>' + data[i].studyingtime + '</td><td><button type="button" onclick="show_onesubject(' + data[i].id + ')" class="img_button"><img class="icon" alt="logo_1"src="/resources/image/recycle.png"/></button></td><td><a class="ssilka"href="/DeleteSubject/' + data[i].id + '">Удалить предмет</a></td></tr>');

                }
            });
        }

        $(document).ready(function () {
            var table = $('#myTable').DataTable({
                "columns": [
                    {
                        "title": "Название предмета", "data": "name", "visible": true,
                    },
                    {
                        "title": "Название группы", "data": "party", "visible": true,
                    },
                    {
                        "title": "Время обучения", "data": "studyingtime", "visible": true,
                    },
                    {
                        "title": "Кнопка изменения", "data": "ChangeButton", "visible": true,
                    },
                    {
                        "title": "Кнопка удаления", "data": "DeleteButton", "visible": true,
                    }
                ], "language":
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
            showAllSubject();


            $("#subjectForm").on('submit', function (e) {
                e.preventDefault();
                $("#span_name").text("");
                if ($("#subjectForm").valid()) {
                    $.ajax({
                        type: 'POST',
                        url: "/addSubject",
                        contentType: 'application/json; charset=utf-8',
                        data: JSON.stringify({
                            id: $("#id").val(),
                            name: $("#name").val(),
                            party: JSON.parse($(".who").text()),
                            studyingtime: $("#studyingtime").val()
                        }),
                        dataType: 'json',
                        async: true
                    }).done(function () {
                        var table = $('#myTable').DataTable();
                        table.clear();
                        showAllSubject();
                        document.getElementById('subjectForm').classList.add('visible');
                    }).fail(function (data) {
                        if (data.status == 404) {
                            $("#span_name").text("Название должно быть уникальным");
                        }
                    });
                }
            });


        });


        function send() {
            document.getElementById('subjectForm').removeAttribute("class");
            $("#id").val('');
            $("#name").val('');
            $("#studyingtime").val('');
            //$('#party option[value=""]').prop('selected', true);
            $('.who').val('');
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


        function showOneSubject(id) {
            $.get('/getOneSubject/' + id, function (data) {
                $("#id").val(id);
                $("#name").val(data.name);
                $("#studyingtime").val(data.studyingtime);
                //$('#party option:contains("' + data.party.name + '")').prop('selected', true);
                $('.who').text(JSON.stringify(data.party))
                $('.who').val(data.party.name)
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

    <div class="roboto">
        <div class="size2">
            <form id="subjectForm" class="visible">
                <div><input type='hidden' name='id' id='id'/></div>
                <div><label class="subject_label">Название предмета</label><input type='text' name='name' id='name'/>
                </div>
                <span id="span_name"></span>
                <div><label class="subject_label">Кол-во занятий</label><input type='number' name='studyingtime'
                                                                               id='studyingtime'/></div>
                <input ENGINE="text" name="referal" placeholder="Живой поиск" value='' class="who" autocomplete="off">
                <ul class="search_result"></ul>
                <div>
                    <img class="icon" alt="logo_1" onclick="hide()" src="/resources/image/back.png">
                    <button type="button " class="img_button"><img class="icon" alt="logo_1"
                                                                   src="/resources/image/disc.png">
                    </button>
                </div>
            </form>


            <button type="button" onclick="send()" class="img_button"><img class="icon" alt="logo_1"
                                                                           src="/resources/image/plus.png"></button>
            <table id='myTable'>
                <thead>
                <th>Название предмета</th>
                <th>Название группы</th>
                <th>Время обучения</th>
                <th>Кнопка изменения</th>
                <th>Кнопка удаления</th>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <div class=" size2">

    </div>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>