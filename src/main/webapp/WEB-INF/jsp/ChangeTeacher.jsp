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
        $(function() {
            $( "#datepicker" ).datepicker();
        } );
    </script>
    <script>

        $.validator.addMethod('symbols', function(value, element) {
            return value.match(new RegExp("^" + "[А-Яа-яЁё ]" + "+$"));
        }, "Здесь должны быть только русские символы");
        $(function () {
            $("#TeacherForm").validate
            ({
                rules: {
                    fio: {
                        required:true,
                        symbols:true,
                        minlength:4
                    },
                    speciality: {
                        required:true,
                        symbols:true,
                        minlength:3
                    }
                },
                messages: {
                    speciality: {
                        required:'Это поле не должно быть пустым',
                        minlength: 'Здесь не может быть меньше 4 символов'
                    },
                    fio: {
                        required:'Это поле не должно быть пустым',
                        minlength: 'Здесь не может быть меньше 3 символов'
                    }
                }
            });
        })
    </script>
</head>

<body>
<div class="size1">
    <jsp:include page="header.jsp"/>
    <div class="size2">
        <form:form action="${pageContext.request.contextPath}/ChangeTeacher/${TeacherForm.id}" method="post"
                   modelAttribute="TeacherForm" id="TeacherForm">

            <div>
                <form:input type="text" name="fio" path="fio" value="${TeacherForm.fio}"
                            placeholder="${TeacherForm.fio}"/>
                <form:errors path="fio"></form:errors>
            </div>
            <div>

                <form:input id="datepicker" type="text" path="borndate" name="borndate" value="${TeacherForm.borndate}"
                            readonly="true"/>
                <form:errors path="borndate"></form:errors>
            </div>
            <div>
                <form:select path="subjects" name="subjects" multiple="multiple">
                    <c:forEach items="${TeacherForm.subjects}" var="subjects">
                        <option value="${subjects.id}" selected>${subjects.name}</option>
                    </c:forEach>
                    <c:forEach items="${SubjectList}" var="subjects">
                        <option value="${subjects.id}">${subjects.name}</option>
                    </c:forEach>
                </form:select>
                <form:errors path="subjects"></form:errors>
            </div>
            <div>
                <form:input type="text" name="speciality" path="speciality" value="${TeacherForm.speciality}"
                            placeholder="${TeacherForm.speciality}"/>
                <form:errors path="speciality"></form:errors>
            </div>

            <button type="submit">Добавить</button>
        </form:form>
    </div>
    <div class=" size2">
        <a class="ssilka" href="<c:url value="/Teacher"/>">Назад</a>
    </div>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>