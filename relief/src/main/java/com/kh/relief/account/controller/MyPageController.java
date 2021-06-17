package com.kh.relief.account.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.relief.account.model.exception.MyPageException;
import com.kh.relief.account.model.service.MyPageService;
import com.kh.relief.account.model.vo.Account;
import com.kh.relief.account.model.vo.T_History;
import com.kh.relief.account.model.vo.T_Status;
import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.board.model.service.BoardService;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.chat.model.vo.Chat;
import com.kh.relief.common.PageInfo;
import com.kh.relief.common.Pagination;
import com.kh.relief.review.model.exception.ReviewException;

@Controller
@RequestMapping("/mypage")
public class MyPageController {
	@Autowired
	private MyPageService myService;
	
	@Autowired
	private BoardService bService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	
//	confirm 페이지 이동
	@GetMapping("/confirm")
	public String confirmView(Model model) {
		
		List<Category> clist = bService.selectcList();
		
		model.addAttribute("clist", clist);
		
		return "/mypage/confirmPage";
	}
	
	// 회원 페이지로 이동
	@PostMapping("/memberInfo")
	public String memberInfoView(HttpSession session,
						@RequestParam(value="password")String password, Model model) {
		
		Account account =  (Account)session.getAttribute("loginUser");
		
		String pwd = myService.matchesPwd(account);
		
		List<Category> clist = bService.selectcList();
		
		if(bcryptPasswordEncoder.matches(password, pwd)) {
			
			Account a = myService.memberInfo(account);
			String[] addr = a.getAddress().split(",");
			
			for(String tt : addr){
				System.out.println(tt);
			}
			
			model.addAttribute("a", a);
			model.addAttribute("postCode", addr[0]);
			model.addAttribute("addr", addr[1]);
			model.addAttribute("addr_details", addr[2]);
			model.addAttribute("clist", clist);
			return "/mypage/memberInfoPage";
			
		} else {
			model.addAttribute("msg", "비밀번호가 다릅니다");
			return "/mypage/confirmPage";
		}
		
	}

	// 회원정보 수정
	@PostMapping("/updateMember")
	public String updateMember(HttpSession session,
							   @RequestParam("postCode") String postCode,
							   @RequestParam("addr") String addr,
							   @RequestParam("addr_details") String addr_details,
							   @RequestParam("phone") String phone,
							   @RequestParam(value="pwd1", defaultValue="0") String pwd1,
							   RedirectAttributes rd,
							   Model model) {
		//테스트 코드 
		boolean flag = false;
		
		Account a =  (Account)session.getAttribute("loginUser");
		a.setAddress(postCode + "," + addr + "," + addr_details);
		a.setPhone(phone);
		
		// 패스워드 값 변경 확인
		if(!pwd1.equals("0")) {
			a.setPwd(bcryptPasswordEncoder.encode(pwd1));
			flag = true;
		}
		
		int result = myService.updateMember(a, flag);
		
		if(result > 0) {
			rd.addFlashAttribute("msg", "회원 정보가 수정 되었습니다.");
			return "redirect:home";
		} else {
			throw new MyPageException("회원 정보 수정에 실패하였습니다.");
		}
	}
	
	// 회원 삭제
	@GetMapping("/deleteMember")
	public String deleteMember(@RequestParam(value="aid") String aid, Model model) {
		int result = myService.deleteMember(aid);
		
		if(result > 0) {
			return "redirect:/home.jsp";
		} else {
			throw new MyPageException("회원 삭제에 실패하였습니다.");
		}	
	}
	
	// 찜목록
    @GetMapping("/wishList")
	public ModelAndView wishListView(HttpSession session, ModelAndView mv,
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage) {
    	Account a =  (Account)session.getAttribute("loginUser");
    	String account_id = a.getAid();
    	
    	int listCount = myService.selectWishListCount(account_id);
    	
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Board> list = myService.selectWishList(pi, account_id);
//		System.out.println(list);
		
		if(list != null) {
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			mv.setViewName("mypage/wishListPage");
		} else {
			throw new MyPageException("게시글 전체 조회에 실패하였습니다.");
		}	
		
		return mv;
	}
	
    // 찜 목록 삭제
    @GetMapping("/deleteWish")
    public String deleteWish(@RequestParam int pk_Id,
    						Model model, HttpSession session) {
    	int result = myService.deleteWish(pk_Id);
  
    	if(result > 0) {
    		return "redirect:/mypage/wishList";
    	} else {
    		throw new MyPageException("게시글 삭제에 실패했습니다.");
    	}
    	
    }
    
    // 판매 페이지
	@GetMapping("/salesHistory")
	public ModelAndView salesHistoryView(HttpSession session, ModelAndView mv,
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage) {
    	Account a =  (Account)session.getAttribute("loginUser");
    	String seller_id = a.getAid();
    	
    	int listCount = myService.selectSalesListCount(seller_id);
    	
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Board> list = myService.selectSalesList(pi, seller_id);
		
		if(list != null) {
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			mv.setViewName("mypage/salesHistoryPage");
		} else {
			throw new MyPageException("게시글 전체 조회에 실패하였습니다.");
		}	
		
		return mv;
		
	}
	
	// 판매페이지 거래 상태 변경하기
	@GetMapping("/statusUpdate")
	public String statusUpdate(Model model, @RequestParam(value="status") String status) {
		String str[] = status.split(",");
//		str[0] = t_history_id, str[1] = status 'Y' or 'A'
		T_Status t_status = new T_Status(Integer.parseInt((str[0])), str[1]); 
		
		int result = myService.statusUpdate(t_status);
		
		if(result > 0) {
			return "redirect:/mypage/salesHistory";
		} else {
			throw new MyPageException("게시글 상태 수정에 실패했습니다.");
		}
	}
	
	
	
	//  업버튼
	@GetMapping("/updatePull_Date")
	public String updatePull_Date(@RequestParam("board_id") int board_id,
								  Model model){
		int result = myService.updatePull_Date(board_id);
		
		if(result > 0) {
			return "redirect:/mypage/salesHistory";
		} else {
			throw new MyPageException("게시글 전체 조회에 실패하였습니다.");
		} 

	}
	
	// 구매 페이지
	@GetMapping("/purchaseHistory")
	public ModelAndView purchaseHistoryView(HttpSession session, ModelAndView mv,
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage) {
		Account a =  (Account)session.getAttribute("loginUser");
    	String consumer_id = a.getAid();
    	
    	int listCount = myService.selectPHListCount(consumer_id);
    	
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Board> list = myService.selectPHList(pi, consumer_id);
		
		if(list != null) {
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			mv.setViewName("mypage/purchaseHistoryPage");
		} else {
			throw new MyPageException("게시글 전체 조회에 실패하였습니다.");
		}	
		
		return mv;
		
	}
	
	// T_HISTORY 사용하는 테이블 공용 delete 함수
	@GetMapping("/deleteT_History")
	public String deleteT_History(@RequestParam(value="t_history_id") int t_history_id,
								  @RequestParam(value="pageNum") int pageNum,
								  Model model, HttpSession session) {
		int result = myService.deleteT_History(t_history_id);
		
		// 0 : 구매 페이지
		// 1 : 판매 페이지
		// 2 : 숨기기 페이지
		String page = "";
		
		if(pageNum == 0) {
			page = "redirect:/mypage/purchaseHistory";
		} else if(pageNum==1) {
			page = "redirect:/mypage/salesHistory";
		} else {
			page = "redirect:/mypage/hiddenList";
		}
		
		if(result > 0) {
			return page;
		} else {
			throw new MyPageException("게시글 삭제에 실패했습니다.");
		}
	
	}
	
	// 숨김페이지 리스트
	@GetMapping("/hiddenList")
	public ModelAndView hiddenListView(HttpSession session, ModelAndView mv,
					@RequestParam(value="page", required=false, defaultValue="1") int currentPage) {
		Account a =  (Account)session.getAttribute("loginUser");
    	String seller_id = a.getAid();
    	
    	int listCount = myService.selectHiddenListCount(seller_id);
    	
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Board> list = myService.selectHiddenList(pi, seller_id);
		
		System.out.println(list);
		
		if(list != null) {
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			mv.setViewName("mypage/hiddenListPage");
		} else {
			throw new MyPageException("게시글 전체 보기에 실패하였습니다.");
		}	
		
		return mv;
	}
	
	// 숨김페이지 숨김 해제
	@GetMapping("/unHide")
	public String unHide(@RequestParam(value="t_history_id") int t_history_id,
								  Model model, HttpSession session) {
		
		int result = myService.unHide(t_history_id);
		
		
		if(result > 0) {
			return "redirect:/mypage/hiddenList";
		} else {
			throw new MyPageException("게시글 숨기기에 실패했습니다.");
		}
	}
	
	// 판매자가 구매 확정을 위해 ID 리스트 가져옴
	@GetMapping("/selectConsumer")
	public String selectConsumer(HttpSession session, @RequestParam(value="status") String status,
								Model model) {
		Account account =  (Account)session.getAttribute("loginUser");
		
		String str[] = status.split(",");
//		str[0] = t_history_id
		int t_history_id = Integer.parseInt(str[0]);
		
		List<Chat> list = myService.selectConsumer(account);
		
		ArrayList<String> result = new ArrayList<>();
		
		if(list != null) {
			// 중복id값이 있는지 Account_Id, Account_Id2 확인 후 제거
			for(Chat Ids : list){
				if(!result.contains(Ids.getAccountId())) {
	            	result.add(Ids.getAccountId());
	            }
				
				if(!result.contains(Ids.getAccountId2())) {
	            	result.add(Ids.getAccountId2());
	            }
			}
			
		// 본인 아이디 값 제거 
		result.remove(account.getAid());
		System.out.println("##################@@@@@@@@@@@@@ " + result);
		model.addAttribute("list", result);
		model.addAttribute("t_history_id", t_history_id);
		
		return "/mypage/selectConsumerPage";
		
		} else {
			throw new MyPageException("대화 상대 목록 불러오기를 실패했습니다.");
		}
		
	}
	
	@GetMapping("T_Complete")
	public void T_Complete(HttpSession session, 
							@RequestParam(value="t_history_id") int t_history_id,
							@RequestParam(value="consumer_id") String consumer_id,
							HttpServletResponse response) throws IOException {
		
		T_History t = new T_History();
		t.setT_history_id(t_history_id);
		t.setConsumer_id(consumer_id);
		
		int result = myService.T_Complete(t);
		
		// Ajax 통신
		PrintWriter out = response.getWriter();

		if(result > 0 ) {
			out.write("true");
		} else {
			out.write("false");
		}
		
		out.flush();
		out.close();
	}
	
	@GetMapping("hide")
	public String Hide(@RequestParam int t_history_id) {
		
		System.out.println("@@@@@@@@@@@"+t_history_id);
		int result = myService.Hide(t_history_id);
		
		if(result > 0) {
			return "redirect:/mypage/salesHistory";
		} else {
			throw new MyPageException("숨김처리 실패 하였습니다.");
		}
	}
}
