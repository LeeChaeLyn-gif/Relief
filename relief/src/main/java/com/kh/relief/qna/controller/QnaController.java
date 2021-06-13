package com.kh.relief.qna.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.board.model.service.BoardService;
import com.kh.relief.qna.Pagination;
import com.kh.relief.qna.model.exception.QnaException;
import com.kh.relief.qna.model.service.QnaService;
import com.kh.relief.qna.model.vo.PageInfo;
import com.kh.relief.qna.model.vo.Qna;

@Controller
@RequestMapping("/qna")
public class QnaController {
	@Autowired
	private QnaService qService;
	
	@Autowired
	private BoardService bService;

	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);

	@GetMapping("/list")
	public ModelAndView qnaList(ModelAndView mv,
			@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage) {
		
		List<Category> clist = bService.selectcList();
		mv.addObject("clist", clist);

		int listCount = qService.selectQlistCount();

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		List<Qna> qlist = qService.selectQlist(pi);

		if (qlist != null) {
			mv.addObject("qlist", qlist);
			mv.addObject("pi", pi);
			mv.setViewName("qna/listPage");
		} else {
			mv.addObject("msg", "QNA 조회에 실패하였습니다.");
			mv.setViewName("common/errorPage");
		}

		return mv;
	}

	// QNA 작성 페이지로 이동
	@GetMapping("/write")
	public String writePageView(Model model) {
		List<Category> clist = bService.selectcList();
		model.addAttribute("clist", clist);
		
		return "qna/writePage";
		
		
	}

	// QNA 작성
	@PostMapping("insert")
	public String qnaInsert(Qna q, HttpServletRequest request, Model model) {

		List<Category> clist = bService.selectcList();
		model.addAttribute("clist", clist);
		
		int result = qService.insertQna(q);

		if (result > 0) {
			if (logger.isDebugEnabled())
				logger.debug("{} 이라는 새글 등록!", q.getQtitle());
			return "redirect:/qna/list";
		} else {
			throw new QnaException("게시글 등록에 실패하였습니다");
		}
	}

	 // QNA 상세 페이지
	 
	 @GetMapping("/detail") 
	 public String qnaDetail(int qid, HttpServletRequest
	 request, HttpServletResponse response, Model model) {
		 List<Category> clist = bService.selectcList();
		model.addAttribute("clist", clist);
	 
	 Qna q = qService.selectQboard(qid);
	 
	 if (q != null) { 
		 model.addAttribute("qna", q);
		 return "qna/detailPage";
	 } else {
		 model.addAttribute("msg", "게시글 상세보기에 실패했습니다."); 
		 return "common/errorPage"; }
	 }
	 
	 // QNA 수정페이지
	 
	 @GetMapping("/updatePage")
	 public String qnaUpdatePage(int qid, Model model) {
		 List<Category> clist = bService.selectcList();
		model.addAttribute("clist", clist);
		
		Qna q = qService.selectQboard(qid);
		if(q != null) {
			model.addAttribute("qna", q);
			return "qna/updatePage";
		} else {
			model.addAttribute("msg", "Q&A 수정페이지 보기에 실패하였습니다.");
			return "/board/alertPage";
		}
	 }

	 // 수정하기
	 
	 @PostMapping("/update")
	 public String qnaUpdate(@ModelAttribute Qna q, Model model) {
		 List<Category> clist = bService.selectcList();
		 model.addAttribute("clist", clist);
		 
		 int result = qService.updateQna(q);
		 if(result > 0) {
			 model.addAttribute("msg", "Q&A 수정에 성공했습니다.");
			 model.addAttribute("url", "/qna/detail?qid="+q.getQid());
			 return "/board/alertPage";
		 } else {
			 model.addAttribute("msg", "Q&A 수정에 실패했습니다.");
			 model.addAttribute("url", "/qna/detail?qid="+q.getQid());
			 return "/board/alertPage";
			 
		 }
	 }
	 
	 // 삭제하기
	 
	 @GetMapping("/delete")
	 public String qnaDelete(int qid, Model model) {
		 List<Category> clist = bService.selectcList();
		 model.addAttribute("clist", clist);
		 
		 int result = qService.deleteQna(qid);
		 if(result > 0) {
			 model.addAttribute("msg", "Q&A 삭제에 성공했습니다.");
			 model.addAttribute("url", "/qna/list");
			 return "/board/alertPage";
		 } else {
			 model.addAttribute("msg", "Q&A 삭제에 실패했습니다.");
			 model.addAttribute("url", "/qna/detail?qid="+qid);
			 return "/board/alertPage";
		 }

	 }
}
