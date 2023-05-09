<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="page_head.jsp">
		<jsp:param name="pageTitle" value="Category Management"/>
	</jsp:include>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
</head>
<body>
<div class="container">
	<jsp:directive.include file="header.jsp"/>	
	
	<div class="row">&nbsp;</div>
	
	<div class="row">
		<div class="col text-center"><h2>Categories Management</h2></div>
	</div>
	<div class="row">&nbsp;</div>
	<div class="row">
		<div class="col text-center"><h4><a href="category_form.jsp"><i class="fas fa-plus"></i>   Create New Category</a></h4></div>
	</div>
	<div class="row">&nbsp;</div>
	<c:if test="${message != null}">
		<div class="row">
			<div class="col text-center"><h4 class="message">${message}</h4></div>
		</div>	
	</c:if>
	
	<div class="row justify-content-center" style="max-width: 900px;margin: 0 auto;">
		<table  class="table table-bordered table-striped table-hover table-responsive-sm">
			<thead class="thead-dark">
				<tr>
					<th class="col-2">Index</th>
					<th class="col-2">ID</th>
					<th>Name</th> 
					<th class="col-2">Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="cat" items="${listCategory}" varStatus="status">
					<tr>
						<td>${status.index + 1}</td>
						<td>${cat.categoryId}</td>
						<td>${cat.name}</td>
						<td>
							<a href="edit_category?id=${cat.categoryId}">Edit   <i class="fas fa-edit"></i></a> &nbsp;
							<a href="javascript:void(0);" class="deleteLink" id="${cat.categoryId}">Delete   <i class="fas fa-trash"></i></a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="d-flex justify-content-center">
		    <ul class="pagination">
		        <c:forEach begin="1" end="${endPage}" var="pageNumber">
		            <li class="page-item">
		                <a class="page-link" href="list_category?page=${pageNumber}">${pageNumber}</a>
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
	<div class="row">&nbsp;</div>
	<jsp:directive.include file="footer.jsp"/>
	<script>
		$(document).ready(function() {
			$(".deleteLink").each(function(){
				$(this).on("click",function(){
					categoryId = $(this).attr("id");
					if(confirm("Are you sure delete the category with ID " + categoryId + " ?"))
					{
						window.location = "delete_category?id=" + categoryId;
					}
				});
			});
		});
	</script>
</div>
</body>
</html>