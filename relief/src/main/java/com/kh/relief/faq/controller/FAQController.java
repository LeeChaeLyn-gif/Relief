package com.kh.relief.faq.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.board.model.service.BoardService;
import com.kh.relief.common.PageInfo;
import com.kh.relief.common.Pagination;
import com.kh.relief.faq.model.exception.FAQException;
import com.kh.relief.faq.model.service.FAQService;
import com.kh.relief.faq.model.vo.FAQ;

@Controller
@RequestMapping("/faq")
public class FAQController {
	@Autowired
	private FAQService fService;
	
	@Autowired
	private BoardService bService;
	
	//로깅 필드 선언
	private static final Logger logger = LoggerFactory.getLogger(FAQController.class);
	
	
//	fqa 페이지 이동
	@GetMapping("/list")
	public ModelAndView listPageView(ModelAndView mv,
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage) {
		List<Category> clist = bService.selectcList();
		
		// 게시글 개수 구하기
		int listCount = fService.selectListCount();
		// System.out.println(listCount);
		
		// PageInfo 객체 생성
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		// System.out.println(pi);
		
		// 요청 페이지에 맞는 게시글 리스트 조회
		List<FAQ> list = fService.selectList(pi);
		// System.out.println(list);
		
		if(list != null) {
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			mv.addObject("clist", clist);
			mv.setViewName("faq/listPage");
		} else {
			throw new FAQException("게시글 전체 조회에 실패하였습니다.");
		}	
		
		return mv;
	}
	
	@GetMapping("/detail")
	public String detailPageView(@RequestParam int faq_id,
			   Model model) {
		FAQ f = fService.selectFAQ(faq_id);
		
		if(f != null) {
			model.addAttribute("faq", f);
			return "faq/detailPage";
		} else {
			throw new FAQException("공지사항 게시글 보기에 실패했습니다.");
		}
	}
	
	
	@GetMapping("/write")
	public String writePageView() {
		return "/faq/writePage";
	}
	
	@GetMapping("/updatePage")
	public String updatePageView(int faq_id, Model model) {
		FAQ f = fService.selectFAQ(faq_id);
		
		model.addAttribute("faq", f);
		
		return "/faq/updatePage";
	}
	
	@PostMapping("update")
	public String updateFAQ(FAQ f,
        @RequestParam(value="uploadFile") MultipartFile file,
        HttpServletRequest request) {
		
		System.out.println(f);
		
		if(!file.getOriginalFilename().equals("")) {
			if(f.getRename_fileName() != null) {
				deleteFile(f.getRename_fileName(), request);
			}
			
			String renameFileName = saveFile(file, request);
			
			if(renameFileName != null) {
				f.setFileName(file.getOriginalFilename());
				f.setRename_fileName(renameFileName);
			}
		}
		
		int result = fService.updateFAQ(f);
		
		if(result > 0) {
			return "redirect:/faq/detail?faq_id=" + f.getFaq_id();
		} else {
			throw new FAQException("게시글 수정에 실패하였습니다.");
		}
	}
	
	@PostMapping("/insert")
	public String insertFAQ(FAQ f,
				            @RequestParam(value="uploadFile") MultipartFile file,
				            HttpServletRequest request,
				            HttpSession session) {
	
		/* 로그인과 연동되면,
		 * 	f.setAccount_id(session.getId());
		 * */
		
		// 1) 업로드 파일 서버에 저장
		// 파일이 첨부 되었다면
		if(!file.getOriginalFilename().equals("")) {
			// 파일 저장 메소드 별도로 작성 - 리네임명 리턴
			String rename_FileName = saveFile(file, request);
			// DB에 저장하기 위한 파일명 세팅
			if(rename_FileName != null) {
				f.setFileName(file.getOriginalFilename());
				f.setRename_fileName(rename_FileName);
			}
		}
		
		// 2) DB insert
		int result = fService.insertFAQ(f);
		
		// insert 성공 시 목록 페이지로 리다이렉트
		if(result > 0) {
			if(logger.isDebugEnabled()) {
				logger.debug('"'+f.getTitle()+'"'+"라는 새글 등록!");
			}
			
			return "redirect:/faq/list";
		} else { // insert 실패시 BoardException("게시글 등록에 실패하였습니다") 발생
			throw new FAQException("게시글 등록에 실패하였습니다.");
		}
	}
	
	// 파일 저장 메소드
	public String saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\FAQuploadFiles";
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
	
	// 파일 삭제 메소드
	public void deleteFile(String fileName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\FAQuploadFiles";
		File f = new File(savePath + "\\" + fileName);
		if(f.exists()) f.delete();
	}
	
	@GetMapping("/delete")
	public String boardDelete(int faq_id, HttpServletRequest request) {
		FAQ f = fService.selectFAQ(faq_id);
		
		if(f.getRename_fileName() != null) {
			deleteFile(f.getRename_fileName(), request);
		}
		int result = fService.deleteFAQ(faq_id);
		
	
		if(result > 0) {
			return "redirect:/faq/list";
		}else {
			throw new FAQException("게시물 삭제에 실패하였습니다");
		}
	}

}
