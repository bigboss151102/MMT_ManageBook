<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="page_head.jsp">
		<jsp:param name="pageTitle" value="Review Management"/>
	</jsp:include>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
</head>
<body>
<div class="container">
	<jsp:directive.include file="header.jsp"/>	
	<div class="row">&nbsp;</div>
	<div class="row">
		<div class="col text-center"><h2>Review Management</h2></div>
	</div>
	<div class="row">&nbsp;</div>
	
	<c:if test="${message != null}">
		<div class="row">
			<div class="col text-center"><h4 class="message">${message}</h4></div>
		</div>	
	</c:if>
	
	<div class="row justify-content-center" style="max-width: 900px;margin: 0 auto;">
		<table class="table table-bordered table-striped table-hover table-responsive-sm">
			<thead class="thead-dark">
				<tr>
					<th>Index</th>
					<th>ID</th>
					<th>BooK</th> 
					<th>Rating</th>
					<th>Headline</th>
					<th>Customer</th>
					<th>Review On</th>
					<th class="col-2">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="review" items="${listReviews}" varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
					<td>${review.reviewId}</td>
					<td>${review.book.title}</td>
					<td>${review.rating}</td>
					<td>${review.headline}</td>
					<td>${review.customer.fullname}</td>
					<td>${review.reviewTime}</td>
					<td>
						<a href="edit_review?id=${review.reviewId}">Edit   <i class="fas fa-edit"></i></a> &nbsp;
						<a href="javascript:void(0);" class="deleteLink" id="${review.reviewId}">Delete   <i class="fas fa-trash"></i></a>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="d-flex justify-content-center">
		    <ul class="pagination">
		        <c:forEach begin="1" end="${endPage}" var="pageNumber">
		            <li class="page-item">
		                <a class="page-link" href="list_review?page=${pageNumber}">${pageNumber}</a>
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
	<jsp:directive.include file="footer.jsp"/>
	<script>
		$(document).ready(function() {
			$(".deleteLink").each(function(){
				$(this).on("click",function(){
					reviewId = $(this).attr("id");
					if(confirm("Are you sure delete the Review with ID " + reviewId + " ?"))
					{
						window.location = "delete_review?id=" + reviewId;
					}
				});
			});
		});
	</script>
</div>
</body>
</html>