<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<jsp:include page="page_head.jsp">
		<jsp:param name="pageTitle" value="Books Management"/>
	</jsp:include>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
</head>
<body>
<div  class="container">
	<jsp:directive.include file="header.jsp"/>	
	<div class="row">&nbsp;</div>
	
	<div class="row">
		<div class="col text-center"><h2>Books Management</h2></div>
	</div>
	<div class="row">&nbsp;</div>
	
	<div class="row">
		<div class="col text-center"><h4><a href="new_book"><i class="fa-solid fa-plus"></i> Create New Book</a></h4></div>
	</div>

	<div class="row">&nbsp;</div>
	
	<c:if test="${message != null}">
		<div class="row">
			<div class="col text-center"><h4 class="message">${message}</h4></div>
		</div>
	</c:if>
	
	<div class="row justify-content-center" style="max-width: 900px;margin: 0 auto;">
		<table  class="table table-bordered table-striped table-hover table-responsive-sm">
			<thead  class="thead-dark">
				<tr>
					<th>Index</th>
					<th>ID</th>
					<th>Image</th>
					<th>Title</th>
					<th>Author</th>
					<th>Category</th>
					<th>Price</th>
					<th class="col-3">Last Updated</th>
					<th class="col-5">Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${listBooks}" varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
					<td>${book.bookId}</td>
					
					<td>
						<img src="data:image/jpg;base64,${book.base64Image}" width="84" height="110"/>	
					</td>
					
					<td>${book.title}</td>
					<td>${book.author}</td>
					<td>${book.category.name}</td>
					<td>${book.price}</td>
					<td>${book.lastUpdateTime}</td>
					<td>
						<a href="edit_book?id=${book.bookId}">Edit   <i class="fas fa-edit"></i></a> &nbsp;
						<a href="javascript:void(0);" class="deleteLink" id="${book.bookId}">Remove    <i class="fas fa-trash"></i></a>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="d-flex justify-content-center">
		    <ul class="pagination">
		        <c:forEach begin="1" end="${endPage}" var="pageNumber">
		            <li class="page-item">
		                <a class="page-link" href="list_books?page=${pageNumber}">${pageNumber}</a>
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
					bookId = $(this).attr("id");
					if(confirm("Are you sure delete the book with ID " + bookId + " ?"))
					{
						window.location = "delete_book?id=" + bookId;
					}
				});
			});
		});
	</script>
</div>
</body>
</html>