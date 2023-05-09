<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="page_head.jsp">
		<jsp:param name="pageTitle" value="Orders Management"/>
	</jsp:include>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
</head>
<body>
<div class="container">
	<jsp:directive.include file="header.jsp"/>	
	<div class="row">&nbsp;</div>
	
	<div class="row">
		<div class="col text-center"><h2>Book Orders Management</h2></div>
	</div>
	<div class="row">&nbsp;</div>
	<c:if test="${message != null}">
		<div class="row">
			<div class="col text-center"><h4 class="message">${message}</h4></div>
		</div>
	</c:if>
	
	<div align="center">
		<table class="table table-bordered table-striped table-hover table-responsive-sm mx-auto" style="width: 100%;">
			<thead class="thead-dark">
				<tr>
					<th>Index</th>
					<th>Order ID</th>
					<th>Ordered By</th> 
					<th>Number Book</th>
					<th>Total</th>
					<th>Payment Method</th>
					<th>Status</th>
					<th>Order Date</th>
					<th class="col-3">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="order" items="${listOrder}" varStatus="status">
					<tr>
						<td>${status.index + 1}</td>
						<td>${order.orderId}</td>
						<td>${order.customer.fullname}</td>
						<td>${order.bookCopies}</td>
						<td>$ ${order.total}</td>
						<td>${order.paymentMethod}</td>
						<td>${order.status}</td>
						<td>${order.orderDate}</td>
						<td>
							<a href="view_order?id=${order.orderId}">Details    <i class="fa-solid fa-eye"></i></a> &nbsp;
							<a href="edit_order?id=${order.orderId}">Edit   <i class="fas fa-edit"></i></a> &nbsp;
							<a href="javascript:void(0);" class="deleteLink" id="${order.orderId}">Delete    <i class="fas fa-trash"></i></a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="d-flex justify-content-center">
		    <ul class="pagination">
		        <c:forEach begin="1" end="${endPage}" var="pageNumber">
		            <li class="page-item">
		                <a class="page-link" href="list_order?page=${pageNumber}">${pageNumber}</a>
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
					orderId = $(this).attr("id");
					if(confirm("Are you sure delete the Order with ID " + orderId + " ?"))
					{
						window.location = "delete_order?id=" + orderId;
					}
				});
			});
		});
	</script>
</div>
</body>
</html>