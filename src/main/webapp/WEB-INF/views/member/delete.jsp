<%--
  Created by IntelliJ IDEA.
  User: jiseo
  Date: 2022-07-14
  Time: 오전 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.all.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.min.css'>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@300&display=swap" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
</head>
<body>
    <div class="modal-body">
        <form action="/member/delete" method="post" name="deleteForm" id="deleteForm" >
                <div class="mb-3">
                <b style="font-family: Cambria; font-size: larger;">회원 탈퇴</b>

                </div>
                <div class="form-group mt-2 mb-3">
                    <label for="pwModal">비밀번호</label>
                    <input type="password"class="form-control"style="border-radius: 10px;" id="pwModal" name="pwModal" placeholder="비밀번호를 입력해주세요."required oninput="PwCheck()">
                    <div id="oldPw_Check"></div>
                </div>

                <div style="display: inline">
                    <label for="pwModal">회원 탈퇴 확인</label>
                    <input type="checkbox" onclick="checkAuth()">
                </div>
                <div id="check"></div>

                <input type="hidden" name="check_id" id="check_id" value="${auth.id}">

                <div class="form-group text-end mt-2">
                    <input type="button" id="delete" class="btn btn-dark" style="font-family: Consolas; display: inline;" value="확인" onclick="deleteInfo()"/>
                    <button type="button" id="ModalCloseId" class="btn btn-danger" data-bs-dismiss="modal" style= "font-family: Consolas; display: inline">Close</button>
                </div>
        </form>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
    var pw_Check = false;
    var check = false

    function PwCheck(){
        $("#oldPw_Check").css("font-size", "8px");
        var oldPw = $('#pwModal').val();
        var id = $('#check_id').val();
        $.ajax({
            url:'/member/oldPwCheck', //Controller에서 인식할 주소
            type:'post', //POST 방식으로  전달
            data:{oldPw,id:oldPw,id},
            success:function(data){
                if (data==1){
                    $("#oldPw_Check").prop("disabled", true);
                    $("#oldPw_Check").text("알맞은 비밀번호입니다.");
                    $("#oldPw_Check").css("color", "green");
                    pw_Check = true;
                }else if(data == 0){
                    $("#oldPw_Check").prop("disabled", true);
                    $("#oldPw_Check").text("틀린 비밀번호입니다.");
                    $("#oldPw_Check").css("color", "red");
                    pw_Check = false;
                }
            }
        });
    }

    function checkAuth(){
        $("#check").css("display", "none");
        check = !check;
    }

    function deleteInfo(){
        $("#check").css("font-size", "8px");
        if(check == true && pw_Check == true){
            deleteForm.submit();
        }else {
            PwCheck();
            $("#check").prop("disabled", true);
            $("#check").text("체크 해주세요.");
            $("#check").css("color", "red");
        }
    }
</script>
</html>
