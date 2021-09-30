<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>

<html lang="en">

<head>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">

	<title>List Customers</title>
	
	<!-- reference our style sheet -->

<%--	<link type="text/css"--%>
<%--		  rel="stylesheet"--%>
<%--		  href="${pageContext.request.contextPath}/resources/css/style.css" />--%>

</head>

<body>

	<div class="container-fluid" id="wrapper">
		<div class="bg-dark pt-3 pb-3" id="header">
			<h2 class="text-light text-center">CRM - Customer Relationship Manager</h2>
		</div>
	</div>
	
	<div class="container-fluid mt-2 mb-2" id="container">
	
		<div id="content">
		
			<p class="p-2 text-light bg-secondary">
				User: <security:authentication property="principal.username" />, Role(s): <security:authentication property="principal.authorities" />
			</p>
		

			<security:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
			
				<!-- put new button: Add Customer -->
			
				<input type="button" value="Add Customer"
					   onclick="window.location.href='showFormForAdd'; return false;"
					   class="add-button btn btn-info text-light mb-2"
				/>
			
			</security:authorize>
	
		
			<!--  add our html table here -->
		
			<table class="table table-striped table-bordered mt-2 mb-2">
					<thead class="table-dark">
					<tr>
						<th scope="col">First Name</th>
						<th scope="col">Last Name</th>
						<th scope="col">Email</th>

						<%-- Only show "Action" column for managers or admin --%>
						<security:authorize access="hasAnyRole('MANAGER', 'ADMIN')">

							<th scope="col">Action</th>

						</security:authorize>

					</tr>
				</thead>

				<tbody>
					<!-- loop over and print our customers -->
					<c:forEach var="tempCustomer" items="${customers}">

						<!-- construct an "update" link with customer id -->
						<c:url var="updateLink" value="/customer/showFormForUpdate">
							<c:param name="customerId" value="${tempCustomer.id}" />
						</c:url>

						<!-- construct an "delete" link with customer id -->
						<c:url var="deleteLink" value="/customer/delete">
							<c:param name="customerId" value="${tempCustomer.id}" />
						</c:url>

						<tr>
							<td> ${tempCustomer.firstName} </td>
							<td> ${tempCustomer.lastName} </td>
							<td> ${tempCustomer.email} </td>

							<security:authorize access="hasAnyRole('MANAGER', 'ADMIN')">

								<td class="d-flex justify-content-around">
									<security:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
										<!-- display the update link -->
										<button class="btn btn-primary sm-6"><a style="color: lightgrey; text-decoration: none;" href="${updateLink}">Update</a></button>
									</security:authorize>

									<security:authorize access="hasAnyRole('ADMIN')">
										<button class="btn btn-secondary">
											<a style="color: lightgrey; text-decoration: none;" href="${deleteLink}"
											   onclick="if (!(confirm('Are you sure you want to delete this customer?'))) return false">Delete</a>
										</button>
									</security:authorize>
								</td>

							</security:authorize>

						</tr>

					</c:forEach>
				</tbody>
						
			</table>
				
		</div>
	
	</div>
	
	<p></p>
		
	<!-- Add a logout button -->
	<form:form action="${pageContext.request.contextPath}/logout" 
			   method="POST">
	
		<input type="submit" value="Logout" class="add-button btn btn-primary m-2" />
	
	</form:form>

</body>

</html>









