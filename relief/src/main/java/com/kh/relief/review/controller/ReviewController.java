package com.kh.relief.review.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.relief.common.PageInfo;
import com.kh.relief.common.Pagination;
import com.kh.relief.review.model.exception.ReviewException;
import com.kh.relief.review.model.service.ReviewService;
import com.kh.relief.review.model.vo.Review;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	private ReviewService rService;
	
	@GetMapping("/list")
	public ModelAndView listReview(ModelAndView mv,
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage) {
		
		// 게시글 개수 구하기
		int listCount = rService.selectListCount();
		// System.out.println(listCount);
		 
		// PageInfo 객체 생성
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		// System.out.println(pi);
		
		// 요청 페이지에 맞는 게시글 리스트 조회
		List<Review> list = rService.selectList(pi);
		// System.out.println(list);
		
		if(list != null) {
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			mv.setViewName("review/listPage");
		} else {
			throw new ReviewException("게시글 전체 조회에 실패하였습니다.");
		}	
		
		return mv;
	}
	
	@GetMapping("/detail")
	public ModelAndView detailReview(@RequestParam(value="review_id", defaultValue="0") int review_id,
			                   @RequestParam(value="t_history_id", defaultValue="0") int t_history_id,
			                   ModelAndView mv) {
		
		Review r = rService.selectReview(review_id, t_history_id);
		
		if(r != null) {
			mv.addObject("r", r);
			mv.setViewName("review/detailPage");
		} else {
			throw new ReviewException("리뷰 가져오기 실패하였습니다.");
		}
		
		return mv;
	}
	
	@GetMapping("/write")
	public ModelAndView writeReview(@RequestParam int t_history_id,
			ModelAndView mv) {
		
		mv.addObject("t_history_id", t_history_id);
		mv.setViewName("review/writePage");
		
		return mv;
	}
	
	@GetMapping("/modify")
	public String updateReview(@RequestParam(value="review_id") int review_id,
			  				   Model model) {
		
		Review r = rService.selectReview(review_id, 0);
		
		if(r != null) {
			model.addAttribute("r", r);
			
			return "review/updatePage";
		} else {
			throw new ReviewException("리뷰 가져오기에 실패하였습니다.");
		}
		
	}
	
	@PostMapping("/update")
	public String updateReview(Review review) {
		System.out.println(review);
		
		int result = rService.updateReview(review);
		
		if(result > 0) {
			return "redirect:/mypage/purchaseHistory";
		} else {
			throw new ReviewException("리뷰 수정에 실패하였습니다.");
		}

	}
	
	@PostMapping("/insert")
	public String insertReview(Review review,
							   HttpSession session) {
		System.out.println(review);
		
		int result = rService.insertReview(review);
		
		if(result > 0) {
			return "redirect:/mypage/purchaseHistory";
		} else {
			throw new ReviewException("리뷰 등록에 실패하였습니다.");
		}

	}
	
	@GetMapping("/delete")
	public String deleteReview(@RequestParam int review_id) {
		
		int result = rService.deleteReview(review_id);
		
		if(result > 0 ) {
			return "redirect:/review/list";
		} else {
			throw new ReviewException("리뷰 가져오기에 실패하였습니다.");
		}
	}
	
}
