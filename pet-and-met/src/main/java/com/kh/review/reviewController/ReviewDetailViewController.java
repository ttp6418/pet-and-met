package com.kh.review.reviewController;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.review.model.service.ReviewService;
import com.kh.review.model.vo.Files;
import com.kh.review.model.vo.Review;

/**
 * Servlet implementation class ReviewDetailViewController
 */
@WebServlet("/detail.rv")
public class ReviewDetailViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewDetailViewController() {
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int reviewNo = Integer.parseInt(request.getParameter("rno")); // 글번호
		
		// 글번호를 가지고 조회수 증가
		int result = new ReviewService().increaseView(reviewNo);
		
		if(result > 0) {
			
			Review rv = new ReviewService().detailReview(reviewNo);
			
			ArrayList<Files> list = new ReviewService().getFiles(reviewNo);
			
			request.setAttribute("rv", rv);
			request.setAttribute("list", list);
			
			request.getRequestDispatcher("views/review/reviewDetailView.jsp").forward(request, response);
			
		} else {
			request.getSession().setAttribute("alertMsg", "조회 실패");
			response.sendRedirect(request.getContextPath() + "/reviewList.rv?currentPage=1");
		}
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}