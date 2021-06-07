package com.kh.relief.qna.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.relief.qna.model.service.QnaService;
import com.kh.relief.qna.model.vo.Qna;
import com.kh.relief.qna.model.exception.QnaException;
import com.kh.relief.qna.model.vo.PageInfo;
import com.kh.relief.qna.Pagination;
import com.kh.relief.account.model.vo.Account;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.relief.qna.controller.QnaController;

@Controller
@RequestMapping("/qna")
public class QnaController {
	@Autowired
	private QnaService qService;

	// 로깅 필드 선언
	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);

	@GetMapping("/list")
	public ModelAndView qnaList(ModelAndView mv,
			@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage) {
		// -> 메뉴바 클릭 시 page라는 파라미터는 없으므로 required=false, 넘어오는 값 없을 시 기본 값 1로 설정

		// 게시글 개수 구하기
		int listCount = qService.selectQlistCount();
		// System.out.println(listCount);

		// PageInfo 객체 생성
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		/* PageInfo pi = Pagination.getPageInfo(currentPage, listCount); */
		// System.out.println(pi);

		// 요청 페이지에 맞는 게시글 리스트 조회
		List<Qna> list = qService.selectQlist(pi);
		// System.out.println(list);

		if (list != null) {
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			mv.setViewName("qna/listPage");
		} else {
			mv.addObject("msg", "QNA 조회에 실패하였습니다.");
			mv.setViewName("common/errorPage");
		}

		return mv;
	}

	// 게시글 작성 페이지로 이동
	@GetMapping("/write")
	public String writePageView() {
		return "qna/writePage";
	}

	// 게시글 작성 - 파일첨부(리네임)
	@PostMapping("insert")
	public String qnaInsert(Qna q, HttpServletRequest request) {

		// 2) DB insert
		int result = qService.insertQna(q);

		// insert 성공 시 목록 페이지로 리다이렉트
		if (result > 0) {
			if (logger.isDebugEnabled())
				logger.debug("{} 이라는 새글 등록!", q.getQtitle());
			return "redirect:/qna/list";
		} else { // insert 실패시 BoardException("게시글 등록에 실패하였습니다") 발생
			throw new QnaException("게시글 등록에 실패하였습니다");
		}
	}

	/*
	 * // 게시글 상세 페이지
	 * 
	 * @GetMapping("/detail") public String qnaDetail(int qid, HttpServletRequest
	 * request, HttpServletResponse response, Model model) {
	 * 
	 * // *** Ajax 이후 댓글 처리 *** List<Reply> rlist = qService.selectReplyList(qid);
	 * 
	 * if (q != null) { model.addAttribute("qna", q); // *** Ajax 이후 댓글 처리 ***
	 * model.addAttribute("rlist", rlist); return "board/detailPage"; } else {
	 * model.addAttribute("msg", "게시글 상세보기에 실패했습니다."); return "common/errorPage"; }
	 * }
	 * 
	 * // 댓글 작성
	 * 
	 * @PostMapping(value = "/insertReply", produces =
	 * "application/json; charset=utf-8") public @ResponseBody String
	 * insertReply(Reply r, HttpSession session) { // 글 작성자 loginUser에서 가져옴 Account
	 * loginUser = (Account) session.getAttribute("loginUser"); String rwriter =
	 * loginUser.getAid(); r.setRwriter(rwriter);
	 * 
	 * List<Reply> rlist = qService.insertReply(r);
	 * 
	 * return rlist; }
	 */
}
