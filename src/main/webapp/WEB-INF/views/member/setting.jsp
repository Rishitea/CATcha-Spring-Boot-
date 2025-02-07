<%--
  Created by IntelliJ IDEA.
  User: jiseo
  Date: 2022-07-16
  Time: 오후 8:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <div class="modal-body">
        <form name="changeForm" id="changeForm" method="post" action="/member/change" enctype="multipart/form-data">

            <div class="mb-3 " style="text-align: center">
                <b style="font-family: Cambria; font-size: 40px; ">정보 수정</b>
            </div>
            <div style="text-align: center;">
                <label for="file" ><img id="img" src="/img/profile/${auth.imgs}" style=" cursor: pointer; border-radius: 130px; height: 130px; width: 130px; position: relative"></label>
                <label for="file"><img id="camara" src="/img/icon/camara.png" style=" cursor: pointer; border-radius: 40px; height: 40px; width: 40px;position: absolute;left: 280px; top: 180px"></label>
                <input type="file" id="file" name="file" onchange="readURL(file);" hidden>
                <div id="file_check"></div>
            </div>

            <div class="form-group mt-2 mb-2">
                <label>이메일</label>
                <input class="form-control" style="border-radius: 10px;" type="email" value="${auth.email}" name="email"  readonly >
            </div>
            <c:choose>
                <c:when test="${auth.auth == '1'}">
                    <div class="form-group mt-3">
                        <label>비밀번호 변경</label>
                        <input class="form-control" style="border-radius: 10px;" type="password" placeholder="기존 비밀번호를 입력해주세요." name="oldPw" id="oldPw" oninput="oldPwCheck()" >
                        <div id="oldPw_Check"></div>
                    </div>

                    <div class="form-group mt-2">
                        <input class="form-control" style="border-radius: 10px;" type="password" placeholder="변경할 비밀번호를 입력해주세요." name="newPw" id="newPw" oninput="checkNewPw()">
                        <div id="newPw_check"></div>
                    </div>

                    <div class="form-group mt-2">
                        <input class="form-control" style="border-radius: 10px;" type="password" placeholder="변경할 비밀번호를 재입력해주세요." name="regPw" id="regPw" oninput="matchNewPw()">
                        <div id="regnewPw_check"></div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="form-group mt-3">
                        <label>비밀번호 변경</label>
                        <input class="form-control" style="border-radius: 10px;" type="password" placeholder="기존 비밀번호를 입력해주세요." name="oldPw" readonly>
                    </div>

                    <div class="form-group mt-2">
                        <input class="form-control" style="border-radius: 10px;" type="password" placeholder="변경할 비밀번호를 입력해주세요." name="newPw" readonly>
                    </div>

                    <div class="form-group mt-2">
                        <input class="form-control" style="border-radius: 10px;" type="password" placeholder="변경할 비밀번호를 재입력해주세요." name="regPw" readonly>
                    </div>
                </c:otherwise>
            </c:choose>


            <div class="form-group mt-3">
                <label>닉네임</label>
                <input class="form-control" style="border-radius: 10px;" value="${auth.name}" type="text" name="name" readonly>
            </div>

            <input type="hidden" id="idCheck" name="id" value="${auth.id}">

            <div class="form-group text-end mt-2">
                <input type="button" id="delete" class="btn btn-danger" style="float: left" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#deleteModal" value="회원 탈퇴">
                <input type="button" id="change" class="btn btn-dark" style="font-family: Consolas; display: inline;" value="확인" onclick="changeInfo()"/>
                <button type="button" id="ModalCloseId" class="btn btn-danger" data-bs-dismiss="modal" style= "font-family: Consolas; display: inline">Close</button>
            </div>
        </form>
    </div>

</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
    var oldPw_Check = true;
    var newPw_Check = true;
    var regPw_Check = true;
    var img_Check = true;

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('img').src = e.target.result;
                $("#file_check").css("display", "none");
                fileCheck(input)
            };
            reader.readAsDataURL(input.files[0]);
            img_Check = true;
        } else {
            document.getElementById('img').src = "";
            $("#file_check").css("display", "block");
            $("#file_check").text("프로필을 선택해주세요.");
            $("#file_check").css("color", "red");
            img_Check = false;
        }
    }

    function oldPwCheck(){
        $("#oldPw_Check").css("font-size", "8px");
        var oldPw = $('#oldPw').val();
        var id = $('#idCheck').val();
        $.ajax({
            url:'/member/oldPwCheck', //Controller에서 인식할 주소
            type:'post', //POST 방식으로 전달
            data:{oldPw,id:oldPw,id},
            success:function(data){
                if (data==1){
                    $("#oldPw_Check").css("display", "block");
                    $("#oldPw_Check").text("알맞은 비밀번호입니다.");
                    $("#oldPw_Check").css("color", "green");
                    oldPw_Check = true;
                }else if(data == 0){
                    $("#oldPw_Check").css("display", "block");
                    $("#oldPw_Check").text("틀린 비밀번호입니다.");
                    $("#oldPw_Check").css("color", "red");
                    oldPw_Check = false;
                }
                if(oldPw == ""){
                    $("#oldPw_Check").css("display", "none");
                    oldPw_Check = true;
                }
            }
        });
    }

    function checkNewPw(){
        var newPw = $('#newPw').val();
        var passReg = /^^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&~^])[A-Za-z\d@$!%*#?&~^]{8,14}$/;
        $("#newPw_check").css("font-size", "8px");

        if(passReg.test(newPw)){
            $("#newPw_check").css("display", "block");
            $("#newPw_check").text("사용가능한 비밀번호 입니다.");
            $("#newPw_check").css("color", "green");
            newPw_Check = true;
            matchPw();
        }else if(!passReg.test(newPw)){
            $("#newPw_check").css("display", "block");
            $("#newPw_check").text("영소문자와 숫자,특수문자(@,$,!,%,*,#,?,&,~,<,^)를 조합해 8~14자리로 이루어져야 합니다.");
            $("#newPw_check").css("color", "red");
            newPw_Check = false;
        }
        if(newPw == ""){
            $("#newPw_check").css("display", "none");
            newPw_Check = true;
        }
    }

    function matchNewPw() {
        var passReg = /^^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&~^])[A-Za-z\d@$!%*#?&~^]{8,14}$/;
        var newPw = $('#newPw').val();
        var regPw = $('#regPw').val();
        $("#regnewPw_check").css("font-size", "8px");
        console.log(newPw == regPw && regPw != "");
        console.log(newPw != regPw || passReg.test(regPw));

        if(newPw == regPw && regPw != ""){
            $("#regnewPw_check").css("display", "block");
            $("#regnewPw_check").text("알맞은 비밀번호입니다.");
            $("#regnewPw_check").css("color", "green");
            regPw_Check = true;
        }else if(newPw != regPw || passReg.test(regPw)){
            $("#regnewPw_check").css("display", "block");
            $("#regnewPw_check").text("비밀번호 틀립니다");
            $("#regnewPw_check").css("color", "red");
            regPw_Check = false;
        }
        if(regPw == ""){
            $("#regnewPw_check").css("display", "none");
            regPw_Check = true;
        }
    }

    function changeInfo(){
        if(oldPw_Check == true && newPw_Check == true && regPw_Check == true && img_Check == true){
            changeForm.submit();

        }else{
            oldPwCheck();
            checkNewPw();
            matchNewPw();
        }
    }

    function fileCheck(obj) {
        $("#file_check").css("font-size", "8px");
        var file_kind = obj.value.lastIndexOf('.');
        var file_name = obj.value.substring(file_kind+1,obj.length);
        var file_type = file_name.toLowerCase();
        var check_file_type=new Array();
        check_file_type=['jpg','png','jpeg'];

        if(check_file_type.indexOf(file_type)==-1){
            img_check = false;
        }else{
            img_check = true;
        }
    }
</script>
</html>
