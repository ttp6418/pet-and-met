<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String pagePath = "./";
	   int resultNo = (int)request.getAttribute("resultNo"); 
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <!-- jQuery 라이브러리 연동 (온라인 방식) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>

@font-face {
            font-family: 'Pretendard-Regular';
            src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
            font-weight: 400;
            font-style: normal;
        }
        * { font-family: 'Pretendard-Regular'; }

        .page-area{
            width: 1000px;
            height: 600px;
            box-sizing: border-box;
            margin: auto;
        }
       .page-head{
            border-bottom: 3px solid rgb(121, 172, 120);
            box-sizing: border-box;
            margin: auto;
            width: 800px;
            height: 20%;
        }
        .page-head>h4{ /* 헤드 텍스트 */
            font-size: 26px;
            font-weight: 700;
            color: rgb(121, 172, 120);
            display: inline-block;
            margin-top: 60px;
            margin-left: 25px;
        }
        
            /* 테이블 공통속성 */
        #change-pwd-table{
            width: 500px;
            margin: auto;
            margin-top: 120px;
        }
        #change-pwd-table th{
            text-align: center;
            font-size: 18px;
            color: dimgray;
        }

        #change-pwd-table td{ padding: 20px; }
        #change-pwd-table p{ font-size: 12px; }
        #change-pwd-table input{ margin-top: 25px; }

        #btn-login{
            margin-top: 100px;
            background-color: rgb(121, 172, 120);
            color: white;
            border: 0px;
            border-radius: 10px;
            width: 120px;
            height: 50px;
            font-size: 18px;
        }

    </style>

</head>
<body>

	<%@ include file="../../common/header.jsp" %>

    <div class="page-area">
        <div class="page-head">
            <h4>비밀번호 변경</h4>
        </div>

        <div class="page-body">
            <form action="updatePwd.ac" method="post">
                <table id="change-pwd-table" align="center">
                    <tr>
                        <th>새 비밀번호</th>
                        <td>
                        	<input type="hidden" value="<%= resultNo %>" name="resultNo">
                            <input type="password" id="newPwd" name="newPwd" required class="userPwd form-control form-control"
                            minlength="8" maxlength="20">
                            <p>영문, 숫자, 특수기호 포함 8-20자</p>
                        </td>
                    </tr>
                    <tr>
                        <th>비밀번호 확인</th>
                        <td>
                            <input type="password" id="checkPwd" required class="userPwd form-control form-control"
                            minlength="8" maxlength="20">
                            <p>영문, 숫자, 특수기호 포함 8-20자</p>
                        </td>
                    </tr>
                    </table>
                    
                    <div align="center">
		            <button type="submit" id="btn-login" onclick="return validate();">
		                확인
		            </button>
		        	</div>
                    
                </form>
                
                <script>
                // 비밀번호 일치 여부 검사
                function validate() {
                	
                	let newPwd = document.getElementById("newPwd");
                	let checkPwd = document.getElementById("checkPwd");
                	
                	if(newPwd.value != checkPwd.value){
            			alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요");
            			checkPwd.focus();
            			return false;
            		}  
                }
                </script>
            

   		</div>
                
        </div>

        <br><br><br><br><br><br><br>
        

    
    <%@ include file="../../common/footer.jsp" %>
</body>
</html>