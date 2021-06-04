package com.kh.relief.admin.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.relief.account.model.vo.Account;
import com.kh.relief.admin.Pagination;
import com.kh.relief.admin.model.serivce.AdminService;
import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.admin.model.vo.Chart;
import com.kh.relief.admin.model.vo.Comment;
import com.kh.relief.admin.model.vo.Faq;
import com.kh.relief.admin.model.vo.Notice;
import com.kh.relief.admin.model.vo.PageInfo;
import com.kh.relief.admin.model.vo.Qna;
import com.kh.relief.admin.model.vo.Report;
import com.kh.relief.admin.model.vo.Sanctions;
import com.kh.relief.admin.model.vo.Search;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService aService;
	
	@GetMapping("/main")
	public String adminMain(Model model) {
		// 전체 회원수 조회
		int aCount = aService.aCount();
		int todayAccount = aService.todayAccount();
		int rCount = aService.reportCount();
		List<Chart> chart = aService.chart();
		model.addAttribute("chart", chart);
		model.addAttribute("aCount", aCount);
		model.addAttribute("todayAccount", todayAccount);
		model.addAttribute("rCount", rCount);
		return "admin/mainPage";
	}
	
	@GetMapping("/notice")
	public ModelAndView noticeList(@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
							 ModelAndView mv) {
		
		int listCount = aService.selectnListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Notice> nList = aService.selectnList(pi);
		
		if(nList != null) {
			mv.addObject("nList", nList);
			mv.addObject("pi", pi);
			mv.setViewName("admin/noticeList");
		}
		return mv;
	}
	
	// 검색
	@GetMapping("/nSearch")
	public String noticeSearch(@ModelAttribute Search search,
							   @RequestParam(value="page", required=false, defaultValue="1") int currentPage,
							   Model model) {
		int listCount = aService.searchNListCount(search);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Notice> nList = aService.searchNList(search, pi);
		model.addAttribute("pi", pi);
		model.addAttribute("nList", nList);
		model.addAttribute("search", search);
		return "admin/noticeList";
	}
	
	// 공지사항 등록페이지
	@GetMapping("/insertNotice")
	public String insertNoticeView() {
		return "admin/insertNotice";
	}
	
	// 공지사항 등록
	@PostMapping("/insertNotice")
	public String insertNotice(@ModelAttribute Notice n, Model model, HttpSession session,
							   @RequestParam(name="uploadFile") MultipartFile file,
							   HttpServletRequest request) {
		Account loginUser = (Account) session.getAttribute("loginUser");
		String aid = loginUser.getAid();
		n.setAid(aid);
		
		if(!file.getOriginalFilename().equals("")) {
			// 파일 저장 메소드 별도로 작성 - 리네임명 리턴
			String renameFileName = saveFile(file, request);
			// DB에 저장하기 위한 파일명 세팅
			if(renameFileName != null) {
				n.setFileName(file.getOriginalFilename());
				n.setRenameFileName(renameFileName);
			}
		}
		int result = aService.insertNotice(n);
		
		if(result > 0) {
			return "redirect:/admin/notice";
		} else {
			model.addAttribute("msg", "공지사항 등록에 실패하였습니다.");
			return "admin/alertPage";
		}
	}

	// 파일 업로드
	private String saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\nuploadFiles";
		File folder = new File(savePath);
		if(!folder.exists()) folder.mkdirs();	// -> 해당 경로가 존재하지 않는다면 디렉토리 생성
		
		// 파일명 리네임 규칙 "년월일시분초_랜덤값.확장자"
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String originalFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new Date()) + "_"
							  + (int)(Math.random() * 100000)
							  + originalFileName.substring(originalFileName.lastIndexOf("."));
		
		// 저장하고자 하는 경로 + 파일명
		String renamePath = folder + "\\" + renameFileName;
		
		try {
			// 업로드 된 MultipartFile이 rename명으로 서버에 저장 됨
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException | IOException e) {
			System.out.println("파일 업로드 에러 : " + e.getMessage());
		}
		
		return renameFileName;
	}
	
	// 공지 상세 페이지
	@GetMapping("/noticeDetail")
	public String selectNotice(Model model, int nid) {
		Notice n = aService.selectNotice(nid);
		
		if(n != null) {
			model.addAttribute("n", n);
			return "admin/noticeDetail";
		}else {
			model.addAttribute("msg", "공지 상세보기 실패!");
			return "admin/alertPage";
		}
	}
	
	// 공지 수정 페이지 이동
	@GetMapping("/noticeUpdate")
	public String updateNoticeView(int nid, Model model) {
		Notice n = aService.selectNotice(nid);
		model.addAttribute("n", n);
		
		return "admin/noticeUpdate";
	}
	
	// 공지 수정
	@PostMapping("/noticeUpdate")
	public String updateNotice(@ModelAttribute Notice n,HttpServletRequest request,
							   @RequestParam(name="uploadFile") MultipartFile file,
							   Model model) {
		// 1. 새로 업로드 된 파일이 있다면
		if(!file.getOriginalFilename().equals("")) {
			// -> 기존 파일이 존재하는 경우 기존 파일 삭제(deleteFile 메소드 생성)
			if(n.getRenameFileName() != null) {
				deleteFile(n.getRenameFileName(), request);
			}
			// 새로 업로드 된 파일 저장(saveFile 기존 메소드 호출)
			String renameFileName = saveFile(file, request);
			// 잘 저장 되었다면 Board 객체에 원본명, 리네임명 기입
			if(renameFileName != null) {
				n.setFileName(file.getOriginalFilename());
				n.setRenameFileName(renameFileName);
			}
		}
		
		int result = aService.updateNotice(n);
		if(result > 0) {
			return "redirect:/admin/noticeDetail?nid=" + n.getNid();
		} else {
			model.addAttribute("msg", "공지사항수정에 실패하였습니다.");
			return "/admin/alertPage";
		}
	}

	private void deleteFile(String renameFileName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\nuploadFiles";
		File f = new File(savePath + "\\" + renameFileName);
		if(f.exists()) f.delete();
		
	}
	
	// 공지사항 삭제
	@GetMapping("/noticedelete")
	public String deleteNotice(int nid, HttpServletRequest request,Model model) {
		Notice n = aService.selectNotice(nid);
		
		if(n.getRenameFileName() != null) {
			deleteFile(n.getRenameFileName(), request);
		}
		
		int result = aService.deleteNotice(nid);
		
		if(result > 0) {
			return "redirect:/admin/notice";
		} else {
			model.addAttribute("msg", "공지사항수정에 실패하였습니다.");
			return "/admin/alertPage";
		}
	}
	
	// 카테고리 페이지
	@GetMapping("/category")
	public String categoryPage(@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
							   Model model) {
		
		int listCount = aService.selectcListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Category> cList = aService.selectcList(pi);
						
		if(cList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("cList", cList);
			return "/admin/categoryList";
		} else {
			model.addAttribute("msg", "카테고리 리스트를 불러오는데에 실패하였습니다.");
			return "/admin/alertPage";
		}
	}
	
	// 카테고리 추가 페이지
	@GetMapping("/insertCategory")
	public String insertCategoryView() {
		return "/admin/insertCategory";
	}
	
	@GetMapping("/selectcnameList")
	public void selectcnameList(int cgroup, HttpServletResponse response) throws IOException {
		List<Category> cnList = aService.selectcnameList(cgroup);
		
		JSONArray jArr = new JSONArray();
		
		for(Category category : cnList) {
			JSONObject jCategory = new JSONObject();
			
			jCategory.put("cid", category.getCid());
			jCategory.put("cname", category.getCname());
			jCategory.put("cid2", category.getCid2());
			jCategory.put("cgroup", category.getCgroup());
			
			jArr.add(jCategory);
		}
		
		JSONObject sendJson = new JSONObject();
		sendJson.put("list", jArr);
		
		PrintWriter out = response.getWriter();
		out.print(sendJson);
		
		out.flush();
		out.close();
	}
	
	// 카테고리 추가
	@PostMapping("/insertCategory")
	public String insertCategory(@ModelAttribute Category c, Model model) {
		c.setCgroup(c.getCgroup() + 1);
		
		int result = aService.insertCategory(c);
		
		if(result > 0) {
			return "redirect:/admin/category";
		} else {
			model.addAttribute("msg", "카테고리 추가 실패");
			return "/admin/alertPage";
		}
	}
	
	// 카테고리 검색
	@GetMapping("/cSearch")
	public String categorySearch(@ModelAttribute Search search,
							   @RequestParam(value="page", required=false, defaultValue="1") int currentPage,
							   Model model) {
		int listCount = aService.searchCListCount(search);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Category> cList = aService.searchCList(pi, search);
		model.addAttribute("pi", pi);
		model.addAttribute("cList", cList);
		model.addAttribute("search", search);
		return "/admin/categoryList";
	}
	
	// 카테고리 수정페이지로 이동
	@GetMapping("/categoryUpdate")
	public String categoryUpdateView(Model model, int cid) {
		Category c = aService.selectCategory(cid);
		if(c != null) {
			model.addAttribute("c", c);
			return "/admin/categoryUpdate";
		} else {
			model.addAttribute("msg", "카테고리 수정페이지를 불러오는데 실패하였습니다.");
			return "/admin/alertPage";
		}
	}
	
	// 카테고리 수정 유효성 검사
	@GetMapping("/checkCategory")
	public void checkCategory(int cid, HttpServletResponse response) throws IOException {		
		int result = aService.checkCategory(cid);
		
		PrintWriter out = response.getWriter();
		
		if(result > 0) {
			out.write("fail");
		} else {
			out.write("success");
		}
	}
	
	// 카테고리 수정
	@PostMapping("/updateCategory")
	public String updateCategory(@ModelAttribute Category c, Model model) {
		c.setCgroup(c.getCgroup() + 1);
		int result = aService.updateCategory(c);
		
		if(result > 0) {
			return "redirect:/admin/category";
		} else {
			model.addAttribute("msg", "카테고리 변경에 실패하였습니다.");
			return "/admin/alertPage";
		}
	}
	
	// 카테고리 삭제
	@GetMapping("/categoryDelete")
	public String deleteCategory(Model model, int cid) {
		int result = aService.deleteCategory(cid);
		
		if(result > 0) {
			return "redirect:/admin/category";
		} else {
			model.addAttribute("msg", "카테고리 삭제에 실패하였습니다.");
			return "/admin/alertPage";
		}
	}
	
	// 신고 리스트
	@GetMapping("/report")
	public String reportList(@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
							 Model model) {
		int listCount = aService.selectrListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		List<Report> rList = aService.selectrList(pi);
		if(rList != null) {
			model.addAttribute("rList", rList);
			model.addAttribute("pi", pi);
			return "/admin/reportList";
		} else {
			model.addAttribute("msg", "신고게시판 출력에 실패!");
			return "/admin/alertPage";
		}
	}
	
	// 신고 검색
	@GetMapping("/rSearch")
	public String reportSearch(@ModelAttribute Search search,
			   				   @RequestParam(value="page", required=false, defaultValue="1") int currentPage,
			   				   Model model) {
		int listCount = aService.searchRListCount(search);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Report> rList = aService.searchRList(pi, search);
		model.addAttribute("pi", pi);
		model.addAttribute("rList", rList);
		model.addAttribute("search", search);
		return "/admin/reportList";
	}
	
	@GetMapping("/reportDetail")
	public String reportDetailView(int rpid, Model model) {
		Report r = aService.selectReport(rpid);	
		if(r != null) {
			model.addAttribute("r", r);
			return "/admin/reportDetail";
		} else {
			model.addAttribute("msg", "신고 세부사항 보기 실패");
			return "/admin/alertPage";
		}
	}
	
	// 제재
	@PostMapping("/ban")
	public String ban(@ModelAttribute Sanctions s, Model model,
					  @RequestParam(name="aid") String aid,
					  @RequestParam(name="ban") int ban) {
		int result = aService.insertSanctions(s);
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		if(ban == 7) {
			cal.add(Calendar.DATE, 7);
		} else if(ban == 15) {
			cal.add(Calendar.DATE, 15);
		} else {
			cal.add(Calendar.YEAR, 100);
		}
		
		String d = df.format(cal.getTime());
		java.sql.Date  sanction = java.sql.Date.valueOf(d);
		Account a = new Account();
		a.setSanctions(sanction);
		a.setAid(aid);
		if(result > 0) {
			int result2 = aService.banUser(a);
			if(result2 > 0) {
				model.addAttribute("msg", "제재 성공");
				model.addAttribute("url", "report");
				return "/admin/alertPage2";
			} else {
				model.addAttribute("msg", "제재 실패");
				model.addAttribute("url", "report");
				return "/admin/alertPage2";
			}
		} else {
			model.addAttribute("msg", "제재추가 실패");
			model.addAttribute("url", "report");
			return "/admin/alertPage2";
		}
	}
	
	// 제재 회원 목록
	@GetMapping("/block")
	public String blockUserView(@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
								Model model) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String d = df.format(cal.getTime());
		java.sql.Date  today = java.sql.Date.valueOf(d);
		
		int listCount = aService.selectBlockListCount(today);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Account> aList = aService.blockUser(today, pi);
		
		if(aList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("aList", aList);
			return "/admin/banUserList";
		} else {
			model.addAttribute("msg", "제재회원목록 출력 실패");
			return "/admin/alertPage";
		}
	}
	
	// 유저 정지 해제
	@GetMapping("/unbanUser")
	public String unbanUser(@RequestParam(value="sArr") List<String> sArr, Model model) {
		int result = aService.unbanUser(sArr);
		
		if(result > 0) {
			model.addAttribute("msg", "제재 해제 완료");
			return "/admin/alertPage";
		} else {
			model.addAttribute("msg", "제재 해제 실패");
			model.addAttribute("url","block");
			return "/admin/alertPage2";
		}
	}
	
	// 제재 유저 목록 검색
	@GetMapping("/bSearch")
	public String bUserSearch(@ModelAttribute Search search,
						   	  @RequestParam(value="page", required=false, defaultValue="1") int currentPage,
						   	  Model model) {
		int listCount = aService.searchBListCount(search);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Account> aList = aService.searchBList(pi, search);
		
		model.addAttribute("pi", pi);
		model.addAttribute("aList", aList);
		model.addAttribute("search", search);
		
		return "/admin/banUserList";
	}
	
	// QNA 페이지
	@GetMapping("/qna")
	public String qnaListView(@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
							  Model model) {
		int listCount = aService.selectQnaListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		List<Qna> qList = aService.selectqList(pi);
		
		if(qList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("qList", qList);
			return "/admin/qnaList";
		} else {
			model.addAttribute("msg","문의사항 목록 출력 실패");
			return "/admin/alertPage";
		}
	}
	
	// QNA 상세 보기
	@GetMapping("/qnaDetail")
	public String qnaDetail(int qid, Model model) {
		Qna q = aService.selectQna(qid);
		
		if(q != null) {
			model.addAttribute("q", q);
			return "/admin/qnaDetail";
		} else {
			model.addAttribute("msg", "문의사항 세부보기 실패");
			model.addAttribute("url", "qna");
			return "/admin/alertPage2";
		}
	}
	
	// QNA답변페이지 이동
	@GetMapping("/qnaUpdate")
	public String qnaUpdateView(int qid, Model model) {
		Qna q = aService.selectQna(qid);
		model.addAttribute("q", q);
		return "/admin/qnaUpdate";
	}
	
	// QNA 답변
	@PostMapping("/qnaUpdate")
	public String qnaUpdate(Model model, @ModelAttribute Qna q) {
		int result = aService.updateQna(q);
		
		if(result > 0) {
			model.addAttribute("msg", "답변이 정상적으로 처리 되었습니다.");
			model.addAttribute("url", "qnaDetail?qid="+q.getQid());
			return "/admin/alertPage2";
		} else {
			model.addAttribute("msg", "답변 등록에 실패 하였습니다.");
			model.addAttribute("url", "qnaDetail?qid="+q.getQid());
			return "/admin/alertPage2";
		}
	}
	
	// QNA 검색
	@GetMapping("/qSearch")
	public String qnaSearch(@ModelAttribute Search search,
		   	  				@RequestParam(value="page", required=false, defaultValue="1") int currentPage,Model model) {
		int listCount = aService.searchQListCount(search);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Qna> qList = aService.searchQList(search, pi);
		
		if(qList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("qList", qList);
			model.addAttribute("search", search);
			return "/admin/qnaList";
		} else {
			model.addAttribute("msg", "검색결과가 없습니다.");
			model.addAttribute("url", "qna");
			return "/admin/alertPage2";
		}
	}
	
	// FAQ 리스트
	@GetMapping("/faq")
	public String faqListView(@RequestParam(value="page", required=false, defaultValue="1") int currentPage,Model model) {
		int listCount = aService.selectfListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		List<Faq> fList = aService.selectfList(pi);
		
		if(fList != null) {
			model.addAttribute("fList", fList);
			model.addAttribute("pi", pi);
			return "/admin/faqList";
		} else {
			model.addAttribute("msg", "FAQ 리스트를 불러오는데에 실패하였습니다.");
			return "/admin/alertPage";
		}
	}
	
	// FAQ 등록 페이지 이동
	@GetMapping("/insertFaq")
	public String insnertFaqView(Model model, HttpSession session) {
		return "/admin/insertFaq";
	}
	
	// FAQ 등록
	@PostMapping("/insertFaq")
	public String insertFaq(@ModelAttribute Faq f,Model model, @RequestParam(name="uploadFile") MultipartFile file,
			   				HttpServletRequest request,HttpSession session) {
		Account loginUser = (Account)session.getAttribute("loginUser");
		String aid = loginUser.getAid();
		f.setAid(aid);
		
		if(!file.getOriginalFilename().equals("")) {
			// 파일 저장 메소드 별도로 작성 - 리네임명 리턴
			String renameFileName = saveFile(file, request);
			// DB에 저장하기 위한 파일명 세팅
			if(renameFileName != null) {
				f.setFileName(file.getOriginalFilename());
				f.setRenameFileName(renameFileName);
			}
		}
		
		int result = aService.insertFaq(f);
		
		if(result > 0) {
			model.addAttribute("msg", "FAQ등록 완료");
			model.addAttribute("url", "faq");
			return "/admin/alertPage2";
		} else {
			model.addAttribute("msg", "FAQ등록 실패");
			model.addAttribute("url", "faq");
			return "/admin/alertPage2";
		}
		
	}
	
	// FAQ 검색
	@GetMapping("/fSearch")
	public String faqSearch(@ModelAttribute Search search,
 							@RequestParam(value="page", required=false, defaultValue="1") int currentPage,Model model) {
		int listCount = aService.searchFListCount(search);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Faq> fList = aService.searchFList(search, pi);
		
		if(fList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("fList", fList);
			model.addAttribute("search", search);
			return "/admin/faqList";
		} else {
			model.addAttribute("msg", "검색결과가 없습니다.");
			model.addAttribute("url", "faq");
			return "/admin/alertPage2";
		}
	}
	
	// FAQ 상세보기
	@GetMapping("/faqDetail")
	public String faqDetail(int fid, Model model) {
		Faq f = aService.selectFaq(fid);
		
		if(f != null) {
			model.addAttribute("f", f);
			return "/admin/faqDetail";
		} else {
			model.addAttribute("msg", "FAQ를 불러오는데에 실패 하였습니다.");
			model.addAttribute("url", "faq");
			return "/admin/alertPage2";	
		}
	}
	
	// FAQ 삭제
	@GetMapping("/faqdelete")
	public String faqdelete(int fid,Model model, HttpServletRequest request) {
		Faq f = aService.selectFaq(fid);
		
		if(f.getRenameFileName() != null) {
			deleteFile(f.getRenameFileName(), request);
		}
		int result = aService.deleteFaq(fid);
		
		if(result > 0) {
			model.addAttribute("msg", "FAQ 삭제 성공");
			model.addAttribute("url", "faq");
			return "/admin/alertPage2";
		} else {
			model.addAttribute("msg", "FAQ 삭제 실패");
			model.addAttribute("url", "faqDetail?fid=" + fid);
			return "/admin/alertPage2";
		}
	}
	
	// FAQ 업데이트페이지 이동
	@GetMapping("/faqUpdate")
	public String faqUpdateView(Model model, int fid) {
		Faq f = aService.selectFaq(fid);
		model.addAttribute("f", f);
		return "/admin/faqUpdate";
	}
	
	// FAQ 업데이트
	@PostMapping("/faqUpdate")
	public String faqUpdate(@ModelAttribute Faq f,HttpServletRequest request,
						    @RequestParam(name="uploadFile") MultipartFile file,
						    Model model) {
		// 1. 새로 업로드 된 파일이 있다면
		if(!file.getOriginalFilename().equals("")) {
			// -> 기존 파일이 존재하는 경우 기존 파일 삭제(deleteFile 메소드 생성)
			if(f.getRenameFileName() != null) {
				deleteFile(f.getRenameFileName(), request);
			}
			// 새로 업로드 된 파일 저장(saveFile 기존 메소드 호출)
			String renameFileName = saveFile(file, request);
			// 잘 저장 되었다면 Board 객체에 원본명, 리네임명 기입
			if(renameFileName != null) {
				f.setFileName(file.getOriginalFilename());
				f.setRenameFileName(renameFileName);
			}
		}
		
		int result = aService.updateFaq(f);
		
		if(result > 0) {
			model.addAttribute("msg", "정상적으로 수정 되었습니다.");
			model.addAttribute("url", "faqDetail?fid=" + f.getFid() );
			return "/admin/alertPage2";
		} else {
			model.addAttribute("msg", "수정에 실패하였습니다.");
			model.addAttribute("url", "faqDetail?fid=" + f.getFid() );
			return "/admin/alertPage2";
		}
	}
	
	// 광고관리 페이지
	@GetMapping("/ad")
	public String adListView(@ModelAttribute Search search,
			   				 @RequestParam(value="page", required=false, defaultValue="1") int currentPage,Model model) {
		int listCount = aService.selectAdListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		List<Notice> nList = aService.selectAdList(pi);
		
		if(nList != null) {
			model.addAttribute("nList", nList);
			model.addAttribute("pi", pi);
			return "/admin/adList";
		} else {
			model.addAttribute("msg", "광고리스트 출력 실패");
			return "/admin/alertPage";
		}
	}
	
	
	// 광고 업데이트
	@GetMapping("/adUpdate")
	public String adUpdate(@RequestParam(value="iArr1", required=false) List<Integer> iArr1,@RequestParam(value="iArr2", required=false) List<Integer> iArr2,
						   Model model) {
		int result1 = 0;
		int result2 = 0;
		if(!iArr1.isEmpty()) {
			result1 = aService.adUpdate1(iArr1);
		}
		if(!iArr2.isEmpty()) {
			result2 = aService.adUpdate2(iArr2);
		}
		

			model.addAttribute("msg", "광고등록에 성공 하였습니다.");
			model.addAttribute("url", "ad");
			return "/admin/alertPage2";
		
	}
	
	@GetMapping("/adSearch")
	public String adSerach(@ModelAttribute Search search,
						   @RequestParam(value="page", required=false, defaultValue="1") int currentPage,Model model) {
		int listCount = aService.searchadListCount(search);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Notice> nList = aService.searchadList(pi, search);
		
		if(nList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("nList", nList);
			model.addAttribute("search", search);
			return "/admin/adList";
		} else {
			model.addAttribute("msg", "검색결과가 없습니다.");
			model.addAttribute("url", "ad");
			return "/admin/alertPage2";
		}
	}
	
	// admin 댓글 추적 게시글보기
	@GetMapping("/commentDetail")
	public String commentDetail(int cmid) {
		Comment c = aService.commentDetail(cmid);
		int bid = c.getBid();
		return "redirect:/board/detail?board_id=" + bid;
	}
}
