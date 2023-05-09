<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="page_head.jsp">
		<jsp:param name="pageTitle" value="Customers Management"/>
	</jsp:include>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
</head>
<body>
<div class="container">
	<jsp:directive.include file="header.jsp"/>	
	<div class="row">&nbsp;</div>
	
	<div class="row">
		<div class="col text-center"><h2>Customers Management</h2></div>
	</div>
	
	<div class="row">
		<div class="col text-center"><h4><a href="new_customer"><i class="fas fa-plus"></i>   Create New Customer</a></h4></div>
	</div>
	
	<div class="row">&nbsp;</div>
	
	<c:if test="${message != null}">
		<div class="row">
			<div class="col text-center"><h4 class="message">${message}</h4></div>
		</div>
	</c:if>
	
	<div align = "center">
		<table class="table table-bordered table-striped table-hover table-responsive-sm">
			<thead class="thead-dark">
				<tr>
					<th>Index</th>
					<th>ID</th>
					<th>E-Mail</th>
					<th>First Name</th>
					<th class="col-1">Last Name</th>
					<th class="col-1">City</th>
					<th>Country</th>
					<th>Registered Date</th>
					<th class="col-2">Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="customer" items="${listCustomers}" varStatus="status">
					<tr>
						<td>${status.index + 1}</td>
						<td>${customer.customerId}</td>
						<td>${customer.email}</td>
						<td>${customer.firstname}</td>
						<td>${customer.lastname}</td>
						<td>${customer.city}</td>
						<td>${customer.countryName}</td>
						<td>${customer.registerDate}</td>
						<td>
							<a href="edit_customer?id=${customer.customerId}">Edit   <i class="fas fa-edit"></i></a> &nbsp;
							<a href="javascript:void(0);" class="deleteLink" id="${customer.customerId}">Delete   <i class="fas fa-trash"></i></a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="d-flex justify-content-center">
	    	<ul class="pagination">
		        <c:forEach begin="1" end="${endPage}" var="pageNumber">
		            <li class="page-item">
		                <a class="page-link" href="list_customer?page=${pageNumber}">${pageNumber}</a>
		            </li>
		        </c:forEach>
		    </ul>
		</div>
	</div>
	<div class="row">&nbsp;</div>
	<div class="row">&nbsp;</div>
	<div class="row">&nbsp;</div>
	<div class="row">&nbsp;</div>
	<div class="row">&nbsp;</div>
	<div class="row">&nbsp;</div>
	<jsp:directive.include file="footer.jsp"/>
	<script>
		$(document).ready(function() {
			$(".deleteLink").each(function(){
				$(this).on("click",function(){
					customerId = $(this).attr("id");
					if(confirm("Are you sure delete the customer with ID " + customerId + " ?"))
					{
						window.location = "delete_customer?id=" + customerId;
					}
				});
			});
		});
	</script>
</div>
</body>
</html>