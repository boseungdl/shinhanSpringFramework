<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>

<body>
	<div class="container">
		<%@ include file="../common/header.jsp"%>
		<hr>
		<button id="btnSalary" class="btn btn-danger">조회(only급여)</button>
		<button id="btnJob" class="btn btn-danger">조회(only직책)</button>
		<button id="btnDept" class="btn btn-danger">조회(only부서)</button>
		<button id="btnJobJoin" class="btn btn-danger">조회(only직책join)</button>
		<button id="btnJobJoin2" class="btn btn-danger">조회(only직책join-map)</button>
		<hr>
		<h3>Restful API 사용하기</h3>
		

		<button id="btnSelect" class="btn btn-secondary">전체조회</button>
		<button id="btnDetail" class="btn btn-secondary">상세보기</button>
		<button id="btnInsert" class="btn btn-secondary">입력</button>
		<button id="btnUpdate" class="btn btn-secondary">수정</button>
		<button id="btnDelete" class="btn btn-secondary">삭제</button>
		
		<script type="text/javascript">
			$(function(){
				$("#btnSelect").click(f_select);
				$("#btnDetail").click(f_detail);
				$("#btnInsert").click(f_insert);
				$("#btnUpdate").click(f_update);
				$("#btnDelete").click(f_delete);
			});
			
			function f_select(){
				alert("f_select");
				$.ajax({
					url:"${path}/rest/emplist.do",
					data:"",
					success:function(responseData){
						console.log(responseData);
						var dynamicRows = "";
						$.each(responseData, function(index, item){
							dynamicRows += `
								<tr>
								<td>\${index}</td>
								<td><a href="${path}/emp/detail.do?empid=${emp.employee_id}">\${emp.employee_id}</a>
								</td>
								<td><a href="${path}/emp/detail.do?empid=${emp.employee_id}">\${emp.first_name}</a>
								</td>
								<td>\${emp.last_name}</td>
								<td>\${fn:toLowerCase(emp.email)}</td>
								<td>\${fn:replace(emp.phone_number,".","-")}</td>
								<td>\${emp.job_id}</td>
								<td>
								  <fmt:formatDate type="date" dateStyle="full" value="${emp.hire_date}"/>
								</td>
								<td>${emp.commission_pct}</td>
								<td> 
								 <fmt:formatNumber type="currency" value="${emp.salary}"/>
								</td>
								<td>${emp.manager_id}</td>
								<td>${emp.department_id}</td>
						
							</tr>
							`
						})
						var output = `
							<table class="table table-striped table-bordered table-hover">
							<tr>
							    <td>순서</td>
								<td>직원번호</td>
								<td>fname</td>
								<td>lname</td>
								<td>email</td>
								<td>phone</td>
								<td>job</td>
								<td>hiredate</td>
								<td>commission</td>
								<td>salary</td>
								<td>manager</td>
								<td>department</td>
							</tr>
							\${dynamicRows}
							</table>
						`
					},
					error:function(error){
						console.log(error);
					},
				})
			}
			function f_detail(){
				alert("f_detail");	
			}
			function f_insert(){
				alert("f_insert");	
			}
			function f_update(){
				alert("f_update");	
			}
			function f_delete(){
				alert("f_delete");	
			}
		</script>


		<hr>
		<div class="input-group mt-5 mb-5">
			<span class="input-group-text">부서</span> <select class="form-control"
				name="department_id">
				<option value="-1">선택안함</option>
				<c:forEach items="${deptlist}" var="dept">
					<option value="${dept.department_id}">
						${dept.department_name}</option>
				</c:forEach>
			</select> <span class="input-group-text">직책</span> <select required="required"
				class="form-control" name="job_id">
				<option value="-1">선택안함</option>
				<c:forEach items="${joblist}" var="job">
					<option ${job.job_id=='IT_PROG'?'selected':''}
						value="${job.job_id}">${job.job_id}/${job.job_title}</option>
				</c:forEach>
			</select> <span class="input-group-text">급여(이상)</span> <input type="number"
				class="form-control" name="salary" value="2000"> <span
				class="input-group-text">입사일(이후)</span> <input type="date"
				class="form-control" name="hire_date">

			<div class="input-group-text">
				<input class="form-check-input mt-0" type="checkbox" value="1"
					name="chkDate" aria-label="Checkbox for following text input"><span>모든일자</span>
			</div>
			<button id="btn_condition" class="btn btn-primary">조건조회</button>
		</div>


		<hr>
		<h1>직원List</h1>

		<%--JSP가 .java로 변환시 주석은 무시한다. ${} --%>
		<!-- HTML주석이므로 .java로 변환시 포함한다.  -->
		<div id="table_here">
			-------------------------------------------</div>
	</div>
	<script>
				$(function() {

					var result = "${resultMessage}";
					if (result != "") {
						alert(result);
					}

					var d = new Date();
					d.setFullYear(d.getFullYear() - 20);
					$('[name="hire_date"]').val(d.toISOString().split("T")[0]);

					//이벤트와 이벤트핸들러 연결...버튼을 클릭하면 함수를 수행한다를 연결 
					$("#btn_condition").on("click", f_ajax);
					//버튼을 클릭한다. 
					$("#btn_condition").trigger("click"); //이벤트 호출 
					$("#btnSalary").on("click", f_salary);
					$("#btnJob").on("click", f_job);
					$("#btnDept").on("click", f_dept);
					$("#btnJobJoin").on("click", f_jobjoin);
					$("#btnJobJoin2").on("click", f_jobjoin2);
				});
				function f_salary() {
					alert("f_salary");
					$.ajax({
						url : "${path}/emp/listBySalary.do",
						data : {
							salary : $("input[name='salary']").val()
						},
						success : function(responseData) {
							$("#table_here").html(responseData);
						},
						error : function() {
						}
					});
				}
				function f_job() {
					alert("f_job");
					$.ajax({
						url : "${path}/emp/listByJob.do",
						data : {
							job : $("select[name='job_id']").val()
						},
						success : function(responseData) {
							$("#table_here").html(responseData);
						},
						error : function() {
						}
					});
				}
				function f_dept() {
					alert("f_dept");
					$.ajax({
						url : "${path}/emp/listByDept.do",
						data : {
							deptid : $("select[name='department_id']").val()
						},
						success : function(responseData) {
							$("#table_here").html(responseData);
						},
						error : function() {
						}
					});

				}
				function f_jobjoin() {
					alert("f_jobjoin");
					$.ajax({
						url : "${path}/emp/listByJobJoin.do",
						data : {
							job : $("select[name='job_id']").val()
						},
						success : function(responseData) {
							$("#table_here").html(responseData);
						},
						error : function() {
						}
					});

				}
				function f_jobjoin2() {
					alert("f_jobjoin2");
					$.ajax({
						url : "${path}/emp/listByJobJoin2.do",
						data : {
							job : $("select[name='job_id']").val()
						},
						success : function(responseData) {
							$("#table_here").html(responseData);
						},
						error : function() {
						}
					});

				}

				function f_ajax() {
					$.ajax({
						url : "${path}/emp/list2.do",
						type : "get",
						data : {
							"deptid" : $('[name="department_id"]').val(),
							"jobid" : $('[name="job_id"]').val(),
							"salary" : $('[name="salary"]').val(),
							"hdate" : $('[name="hire_date"]').val(),
							"chk" : $('[name="chkDate"]').prop("checked")
						},
						success : function(responseData) {
							//2.data를 받아서 HTML만들까?NO
							//3.JSP를 받아서 현재화면에 대치(replace)?OK
							$("#table_here").html(responseData);
						},
						error : function(err) {
							alert(err);
						}
					});
				}
			</script>

</body>
</html>




