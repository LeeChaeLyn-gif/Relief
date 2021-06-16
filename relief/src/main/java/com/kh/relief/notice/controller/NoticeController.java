package com.kh.relief.notice.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.relief.common.PageInfo;
import com.kh.relief.common.Pagination;
import com.kh.relief.notice.model.exception.NoticeException;
import com.kh.relief.notice.model.service.NoticeService;
import com.kh.relief.notice.model.vo.Notice;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	@Autowired
	private NoticeService nService;
	
	//로깅 필드 선언
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	 
//	Notice 페이지 이동
	@GetMapping("/list")
	public ModelAndView listPageView(ModelAndView mv,
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage) {
		// 게시글 개수 구하기
		int listCount = nService.selectListCount();
		// System.out.println(listCount);
		
		// PageInfo 객체 생성
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		// System.out.println(pi);
		
		// 요청 페이지에 맞는 게시글 리스트 조회
		List<Notice> list = nService.selectList(pi);
		// System.out.println(list);
		
		if(list != null) {
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			mv.setViewName("notice/listPage");
		} else {
			throw new NoticeException("게시글 전체 조회에 실패하였습니다.");
			
		}	
		
		return mv;
	}
	
	@GetMapping("/detail")
	public String detailPageView(@RequestParam int notice_id,
			   HttpServletRequest request,
			   HttpServletResponse response,
			   Model model) {
		
		boolean flagnlist = false;
		boolean flagnotice_id = false;
		
		Cookie[] cookies = request.getCookies();
		
		try {
			if(cookies != null) {
				for(Cookie c : cookies) {
					if(c.getName().equals("nlist")) {
						flagnlist = true;
						String nlist = URLDecoder.decode(c.getValue(), "UTF-8");
						String[] list = nlist.split(",");
						
						for(String st : list) {
							if(st.equals(String.valueOf(notice_id))) flagnotice_id = true;
						}
						
						if(!flagnotice_id) {
							c.setValue(URLEncoder.encode(nlist + "," + notice_id, "UTF-8"));
							response.addCookie(c);
						}		
					}
				}
				if(!flagnlist) {	
					Cookie c1 = new Cookie("nlist", URLEncoder.encode(String.valueOf(notice_id), "UTF-8"));
					response.addCookie(c1);
				}
				
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		Notice n = nService.selectNotice(notice_id, !flagnotice_id);
		
		if(n != null) {
			model.addAttribute("notice", n);
			return "notice/detailPage";
		} else {
			throw new NoticeException("게시글 상세보기에 실패했습니다.");
		}
				
	}
	
	
	@GetMapping("/write")
	public String writePageView() {
		return "/notice/writePage";
	}
	
	@GetMapping("/updatePage")
	public String updatePageView(int notice_id, Model model) {
		Notice n = nService.selectNotice(notice_id, false);
		
		model.addAttribute("notice", n);
		
		return "/notice/updatePage";
	}
	
	@PostMapping("update")
	public String updateFAQ(Notice n,
        @RequestParam(value="uploadFile") MultipartFile file,
        HttpServletRequest request) {
		
		System.out.println(n);
		
		if(!file.getOriginalFilename().equals("")) {
			if(n.getRename_fileName() != null) {
				deleteFile(n.getRename_fileName(), request);
			}
			
			String renameFileName = saveFile(file, request);
			
			if(renameFileName != null) {
				n.setFileName(file.getOriginalFilename());
				n.setRename_fileName(renameFileName);
			}
		}
		
		int result = nService.updateNotice(n);
		
		if(result > 0) {
			return "redirect:/notice/detail?notice_id=" + n.getNotice_id();
		} else {
			throw new NoticeException("게시글 수정에 실패하였습니다.");
		}
	}
	
	@PostMapping("/insert")
	public String insertFAQ(Notice n,
				            @RequestParam(value="uploadFile") MultipartFile file,
				            HttpServletRequest request,
				            HttpSession session) {
	
		/* 로그인과 연동되면,
		 * 	n.setAccount_id(session.getId());
		 * */
		
		// 1) 업로드 파일 서버에 저장
		// 파일이 첨부 되었다면
		if(!file.getOriginalFilename().equals("")) {
			// 파일 저장 메소드 별도로 작성 - 리네임명 리턴
			String rename_FileName = saveFile(file, request);
			// DB에 저장하기 위한 파일명 세팅
			if(rename_FileName != null) {
				n.setFileName(file.getOriginalFilename());
				n.setRename_fileName(rename_FileName);
			}
		}
		
		// 2) DB insert
		int result = nService.insertNotice(n);
		
		// insert 성공 시 목록 페이지로 리다이렉트
		if(result > 0) {
			if(logger.isDebugEnabled()) {
				logger.debug('"'+n.getTitle()+'"'+"라는 새글 등록!");
			}
			
			return "redirect:/notice/list";
		} else { // insert 실패시 BoardException("게시글 등록에 실패하였습니다") 발생
			throw new NoticeException("게시글 등록에 실패하였습니다.");
		}
	}
	
	// 파일 저장 메소드
	public String saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\NoticeuploadFiles";
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
		String savePath = root + "\\NoticeuploadFiles";
		File f = new File(savePath + "\\" + fileName);
		if(f.exists()) f.delete();
	}
	
	@GetMapping("/delete")
	public String boardDelete(int notice_id, HttpServletRequest request) {
		Notice n = nService.selectNotice(notice_id, false);
		
		if(n.getRename_fileName() != null) {
			deleteFile(n.getRename_fileName(), request);
		}
		int result = nService.deleteNotice(notice_id);
		
	
		if(result > 0) {
			return "redirect:/notice/list";
		}else {
			throw new NoticeException("게시물 삭제에 실패하였습니다");
		}
	}
}
