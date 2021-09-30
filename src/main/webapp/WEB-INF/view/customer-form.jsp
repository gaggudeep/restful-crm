<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>

<head>
	<title>Save Customer</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">


<%--	<link type="text/css"--%>
<%--		  rel="stylesheet"--%>
<%--		  href="${pageContext.request.contextPath}/resources/css/style.css">--%>

<%--	<link type="text/css"--%>
<%--		  rel="stylesheet"--%>
<%--		  href="${pageContext.request.contextPath}/resources/css/add-customer-style.css">--%>
</head>

<body>

	<div class="container-fluid" id="wrapper">
		<div class="bg-dark pt-3 pb-3" id="header">
			<h2 class="text-light text-center">CRM - Customer Relationship Manager</h2>
		</div>
	</div>

	<div class="container w-50 mt-2 mb-2" id="container">
		<h3 class="p-2 text-light bg-secondary">Save Customer</h3>
	
		<form:form action="saveCustomer" modelAttribute="customer" method="POST">

			<!-- need to associate this data with customer id -->
			<form:hidden path="id" />
					
			<table class="table">
				<tbody>
					<tr class="form-group md-6">
						<td><label>First name:</label></td>
						<td><form:input cssClass="form-control" path="firstName" /></td>
					</tr>
				
					<tr class="form-group md-6">
						<td><label>Last name:</label></td>
						<td><form:input cssClass="form-control" path="lastName" /></td>
					</tr>

					<tr class="form-group md-6">
						<td><label>Email:</label></td>
						<td><form:input cssClass="form-control" path="email" /></td>
					</tr>

					<tr>
						<td><label></label></td>
						<td><input class="btn btn-primary save" type="submit" value="Save" /></td>
					</tr>

				
				</tbody>
			</table>
		
		
		</form:form>
	
		<button class="btn btn-info">
			<a style="text-decoration: none; color: lightgrey;" href="${pageContext.request.contextPath}/customer/list">Back to List</a>
		</button>
	
	</div>

</body>

</html>










