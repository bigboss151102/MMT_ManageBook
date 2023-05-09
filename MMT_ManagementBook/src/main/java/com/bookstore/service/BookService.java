package com.bookstore.service;

import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CategoryDAO;
import com.bookstore.entity.Book;
import com.bookstore.entity.Category;

public class BookService {
	
	private CategoryDAO categoryDAO;
	private BookDAO bookDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public BookService(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		bookDAO = new BookDAO();
		categoryDAO = new CategoryDAO();
	}
	
	public void listBook() throws ServletException, IOException
	{
		listBook(null);
	}
	
	public void listBook(String message) throws ServletException, IOException
	{
		String indexPage = request.getParameter("page");
		if(indexPage == null)
		{
			indexPage = "1";
		}
		
		int index = Integer.parseInt(indexPage);
		
		if(message != null)
		{
			request.setAttribute("message", message);
		}
		
		long count = bookDAO.count();
		long endPage = count/5;
		if(count % 5 != 0)
		{
			endPage++;
		}
		
		List<Book> listBooks = bookDAO.findAllPagedBook(index);
		request.setAttribute("listBooks", listBooks);
		request.setAttribute("endPage", endPage);
		String listPage  = "book_list.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(listPage);
		requestDispatcher.forward(request, response);
		
	}
	
	public void showBookNewForm() throws ServletException, IOException {
		List<Category> listCategory = categoryDAO.listAll();
		
		request.setAttribute("listCategory", listCategory);
		
		String newPage = "book_form.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(newPage);
		requestDispatcher.forward(request, response);
		
	}

	public void createBook() throws ServletException, IOException {
		
		Integer categoryId = Integer.parseInt(request.getParameter("category"));
		String title = request.getParameter("title");
		
		
		Book existBook = bookDAO.findByTitle(title);
		
		if(existBook != null)
		{
			String message = "Not create new book because title " + title + " already exist.";
			listBook(message);
			return;
		}
		
		Book newBook = new Book();
		readBookFields(newBook);
		
		Book createBook = bookDAO.create(newBook);
		if(createBook.getBookId() > 0)
		{
			String message = "A new book created susscessfully";
			request.setAttribute("message", message);
			listBook(message);
		}
	}
	
	public void readBookFields(Book book) throws ServletException, IOException
	{
		Integer categoryId = Integer.parseInt(request.getParameter("category"));
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String description = request.getParameter("description");
		String isbn = request.getParameter("isbn");
		float price = Float.parseFloat(request.getParameter("price"));
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date publishDate = null;
		
		try {
			publishDate = dateFormat.parse(request.getParameter("publishDate"));
			
		}catch (ParseException ex) {
			ex.printStackTrace();
			throw new ServletException("Error parsing publish date (format is yyyy-MM-dd)");
		}

		book.setTitle(title);
		book.setAuthor(author);
		book.setDescription(description);
		book.setIsbn(isbn);
		book.setPublishDate(publishDate);
		
		Category category = categoryDAO.get(categoryId);
		book.setCategory(category);
		
		book.setPrice(price);
		
		Part part = request.getPart("bookImage");
		
		if(part != null && part.getSize() > 0)
		{
			long size = part.getSize();
			byte[] imageBytes = new byte[(int) size];
			
			InputStream inputStream = part.getInputStream();
			inputStream.read(imageBytes);
			inputStream.close();
			
			book.setImage(imageBytes);
		}
	}
	
	public void editBook() throws ServletException, IOException {
		
		Integer bookId = Integer.parseInt(request.getParameter("id"));
		Book book = bookDAO.get(bookId);
		List<Category> listCategory = categoryDAO.listAll();
		
		request.setAttribute("book", book);
		request.setAttribute("listCategory", listCategory);
		
		String editPage = "book_form.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(editPage);
		requestDispatcher.forward(request, response);
		
	}
	public void updateBook() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("bookId"));
		String title = request.getParameter("title");

		Book existBook = bookDAO.get(bookId);
		Book bookByTitle = bookDAO.findByTitle(title);
		
		if(bookByTitle != null && !existBook.equals(bookByTitle)) 
		{
			String message = "Could not update Book because name title already exist !";
			listBook(message);
			return;
		}
		
		readBookFields(existBook);
		
		bookDAO.update(existBook);
		
		String message = "Update book successfully.";
		listBook(message);
	}
	public void deleteBook() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("id"));
		
		bookDAO.delete(bookId);
		String message = "Delete book successfully.";
		listBook(message);
		
	}
	
	
	public void listBooksByCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("id"));
		
		String indexPage = request.getParameter("page");
		
		if(indexPage == null)
		{
			indexPage = "1";
		}
		
		int index = Integer.parseInt(indexPage);
		
		
		
		long count = bookDAO.count();
		long endPage = count/12;
		if(count % 12 != 0)
		{
			endPage++;
		}
		
		List<Book> listBooks = bookDAO.findAllPagedBookByCategory(categoryId, index);
		Category category = categoryDAO.get(categoryId);
		
		request.setAttribute("listBooks", listBooks);
		request.setAttribute("category", category);
		request.setAttribute("endPage", endPage);
		
		
		String listPage = "frontend/book_list_by_category.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(listPage);
		requestDispatcher.forward(request, response);
	}
	
	
	public void viewBookDetail() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("id"));
		Book book = bookDAO.get(bookId);

		request.setAttribute("book", book);
		
		String detailPage =  "frontend/book_detail.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(detailPage);
		requestDispatcher.forward(request, response);
	}
	public void search() throws ServletException, IOException {
		String keyword = request.getParameter("keyword");
		String indexPage = request.getParameter("page");
		
		List<Book> result = null;
		
		if(indexPage == null)
		{
			indexPage = "1";
		}
		
		int index = Integer.parseInt(indexPage);
		
		if (keyword == null || keyword.equals("")) {
		    result = bookDAO.findAllPagedBook(index);
		} else {
		    result = bookDAO.search(keyword);
		}
		
		long count = bookDAO.count();
		long endPage =  (count/5);
		if(count % 5 != 0)
		{
			endPage ++;
		}
			
		request.setAttribute("keyword", keyword);
		request.setAttribute("result", result);
		request.setAttribute("endPage", endPage);
		
		
		String resultPage =  "frontend/search_result.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultPage);
		requestDispatcher.forward(request, response);
	}
	
}
