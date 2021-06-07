package com.kh.relief.board.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.relief.account.model.vo.Account;
import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.board.Pagination;
import com.kh.relief.board.model.service.BoardService;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.board.model.vo.CategoryBoard;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.board.model.vo.PageInfo;
import com.kh.relief.board.model.vo.SearchBoard;
import com.kh.relief.board.model.vo.Sort;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.relief.board.model.exception.BoardException;
import com.kh.relief.board.model.vo.Wish;
import com.kh.relief.category.model.service.CategoryService;


@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService bService;
	
	@GetMapping("/list")
	public String searchListview(@RequestParam(value="page", required=false, defaultValue="1") int currentPage, Model model, 
								 HttpSession session, @RequestParam(name="searchValue") String searchValue) {
		// 고객의 주소값 기준으로 검색하기 위한 주소값 뽑아내기
		Account loginUser = (Account) session.getAttribute("loginUser");
		SearchBoard sb = new SearchBoard();
		List<Board> bList = new ArrayList<>();
		PageInfo pi = new PageInfo();
		int listCount = 0;
		if(loginUser != null) {
			String address = loginUser.getAddress();
			String[] arr = address.split(",");
			String ad = arr[1];
			String[] adArr = ad.split(" ");
			String addr = "";
			if(adArr[0].contains("도")) {
				addr = adArr[0] +" "+ adArr[1];
			} else {
				addr = adArr[0];
			}
			sb = new SearchBoard(searchValue, addr);
		}
		

			listCount = bService.selectbListCount(sb);
			pi = Pagination.getPageInfo(currentPage, listCount);
			bList = bService.selectbList(sb, pi);
		
			if(bList.isEmpty()) {
				model.addAttribute("msg", "검색된 결과가 존재하지 않습니다.");
				model.addAttribute("url", "/home");
				return "/board/alertPage";
			}else {
			
				for(int i = 0; i < bList.size(); i++) {
					Image image = bService.selectiList(bList.get(i).getBoard_id());
					bList.get(i).setRenameFileName(image.getRenameFileName());
				}
				
				// 카테고리 리스트
				List<Category> cList = bService.selectcList();
				// 검색 물품 카테고리 가져오기
				int cid = bList.get(0).getCategory_id();
				Category c1 = bService.selectCategory1(cid);
				// 2차 카테고리 id
				int secondCid = c1.getCid2();
				// 1차 카테고리 id
				Category c2 = bService.selectCategory1(secondCid);
				int firstCid = c2.getCid2();
				
				model.addAttribute("cList", cList);
				model.addAttribute("secondCid", secondCid);
				model.addAttribute("firstCid", firstCid);
				model.addAttribute("cid", cid);
				model.addAttribute("bList", bList);
				model.addAttribute("listCount", listCount);
				model.addAttribute("searchValue", searchValue);
				model.addAttribute("pi", pi);
				return "/board/listPage";
			}
	}
	
	@GetMapping("/sort")
	public String sortList(@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
						   Model model, @ModelAttribute Sort s,HttpSession session) {
		Account loginUser = (Account) session.getAttribute("loginUser");
		SearchBoard sb = new SearchBoard();
		List<Board> bList = new ArrayList<>();
		PageInfo pi = new PageInfo();
		int listCount = 0;
		if(loginUser != null) {
			String address = loginUser.getAddress();
			String[] arr = address.split(",");
			String ad = arr[1];
			String[] adArr = ad.split(" ");
			String addr = "";
			if(adArr[0].contains("도")) {
				addr = adArr[0] +" "+ adArr[1];
			} else {
				addr = adArr[0];
			}
			sb = new SearchBoard(s.getSearchValue(), addr);
		}
		if(sb != null&& s.getSortValue().equals("desc")) {
			listCount = bService.selectbListCount(sb);
			pi = Pagination.getPageInfo(currentPage, listCount);
			bList = bService.descbList(sb, pi);
		} else if(sb != null&& s.getSortValue().equals("asc")) {
			listCount = bService.selectbListCount(sb);
			pi = Pagination.getPageInfo(currentPage, listCount);
			bList = bService.ascbList(sb, pi);
		}
		for(int i = 0; i < bList.size(); i++) {
			Image image = bService.selectiList(bList.get(i).getBoard_id());
			bList.get(i).setRenameFileName(image.getRenameFileName());
		}
		
		// 카테고리 리스트
		List<Category> cList = bService.selectcList();
		// 검색 물품 카테고리 가져오기
		int cid = bList.get(0).getCategory_id();
		Category c1 = bService.selectCategory1(cid);
		// 2차 카테고리 id
		int secondCid = c1.getCid2();
		// 1차 카테고리 id
		Category c2 = bService.selectCategory1(secondCid);
		int firstCid = c2.getCid2();
		
		model.addAttribute("cList", cList);
		model.addAttribute("secondCid", secondCid);
		model.addAttribute("firstCid", firstCid);
		model.addAttribute("cid", cid);
		model.addAttribute("sortValue", s.getSortValue());
		model.addAttribute("bList", bList);
		model.addAttribute("listCount", listCount);
		model.addAttribute("searchValue", s.getSearchValue());
		model.addAttribute("pi", pi);
		return "/board/listPage";
	}
	
	
	// 1차 카테고리로 검색(지역내)
	@GetMapping("/category1")
	public String category1(@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
						    int cid, Model model,HttpSession session) {
		Account loginUser = (Account) session.getAttribute("loginUser");
		CategoryBoard cb = new CategoryBoard();
		String addr = "";

		if(loginUser != null) {
			String address = loginUser.getAddress();
			String[] arr = address.split(",");
			String ad = arr[1];
			String[] adArr = ad.split(" ");
			if(adArr[0].contains("도")) {
				addr = adArr[0] +" "+ adArr[1];
			} else {
				addr = adArr[0];
			}
		}
		
		List<Category> c1 = bService.selectcListFromCid2(cid);
		List<Integer> iList = new ArrayList<>();
		List<Integer> iList2 = new ArrayList<>();
		for(int i = 0; i < c1.size(); i++) {
			iList.add(c1.get(i).getCid());
		}
		
		List<Category> c2 = bService.selectcListFromiList(iList);
		
		for(int i = 0; i < c2.size(); i++) {
			iList2.add(c2.get(i).getCid());
		}
		
		cb = new CategoryBoard(0, iList2, addr);
		
		int listCount = bService.selectbListFromCategoryCount(cb);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		List<Board> bList = bService.selectbListFromCategory(cb, pi);
		
		if(!bList.isEmpty()) {
		for(int i = 0; i < bList.size(); i++) {
			Image image = bService.selectiList(bList.get(i).getBoard_id());
			bList.get(i).setRenameFileName(image.getRenameFileName());
		}
		
		// 카테고리 리스트
		List<Category> cList = bService.selectcList();
		// 검색 물품 카테고리 가져오기
		int cid1 = bList.get(0).getCategory_id();
		Category c3 = bService.selectCategory1(cid1);
		// 2차 카테고리 id
		int secondCid = c3.getCid2();
		// 1차 카테고리 id
		Category c4 = bService.selectCategory1(secondCid);
		int firstCid = c4.getCid2();
		
		// 카테고리 이름 출력용
		Category c5 = bService.selectCategory1(cid);
		
		model.addAttribute("cList", cList);
		model.addAttribute("secondCid", secondCid);
		model.addAttribute("firstCid", firstCid);
		model.addAttribute("cid", cid1);
		model.addAttribute("bList", bList);
		model.addAttribute("listCount", listCount);
		model.addAttribute("categoryValue", cid);
		model.addAttribute("categoryName", c5.getCname());
		model.addAttribute("pi", pi);
		return "/board/listPage";
		} else {
			model.addAttribute("msg", "검색된 결과가 존재하지 않습니다.");
			model.addAttribute("url", "/home");
			return "/board/alertPage";
		}
	}
	
	@GetMapping("/category2")
	public String category2(@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
							int cid, Model model,HttpSession session) {
		List<Category> c1 = bService.selectcListFromCid2(cid);
		List<Integer> iList = new ArrayList<>();
		
		Account loginUser = (Account) session.getAttribute("loginUser");
		CategoryBoard cb = new CategoryBoard();
		String addr = "";

		if(loginUser != null) {
			String address = loginUser.getAddress();
			String[] arr = address.split(",");
			String ad = arr[1];
			String[] adArr = ad.split(" ");
			if(adArr[0].contains("도")) {
				addr = adArr[0] +" "+ adArr[1];
			} else {
				addr = adArr[0];
			}
		}
		
		for(int i = 0; i < c1.size(); i++) {
			iList.add(c1.get(i).getCid());
		}
		
		cb = new CategoryBoard(0, iList, addr);
		int listCount = bService.selectbListFromCategoryCount(cb);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		List<Board> bList = bService.selectbListFromCategory(cb, pi);
		
		if(!bList.isEmpty()) {
			for(int i = 0; i < bList.size(); i++) {
				Image image = bService.selectiList(bList.get(i).getBoard_id());
				bList.get(i).setRenameFileName(image.getRenameFileName());
			}
			
			// 카테고리 리스트
			List<Category> cList = bService.selectcList();
			// 검색 물품 카테고리 가져오기
			int cid1 = bList.get(0).getCategory_id();
			Category c3 = bService.selectCategory1(cid1);
			// 2차 카테고리 id
			int secondCid = c3.getCid2();
			// 1차 카테고리 id
			Category c4 = bService.selectCategory1(secondCid);
			int firstCid = c4.getCid2();
			
			// 카테고리 이름 출력용
			Category c5 = bService.selectCategory1(cid);
			
			model.addAttribute("cList", cList);
			model.addAttribute("secondCid", secondCid);
			model.addAttribute("firstCid", firstCid);
			model.addAttribute("cid", cid1);
			model.addAttribute("bList", bList);
			model.addAttribute("listCount", listCount);
			model.addAttribute("categoryValue2", cid);
			model.addAttribute("categoryName", c5.getCname());
			model.addAttribute("pi", pi);
			return "/board/listPage";
		} else {
			model.addAttribute("msg", "검색된 결과가 존재하지 않습니다.");
			model.addAttribute("url", "/home");
			return "/board/alertPage";
		}
	}
	
	@GetMapping("/category3")
	public String category3(@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
							int cid, Model model, HttpSession session) {
		Account loginUser = (Account) session.getAttribute("loginUser");
		CategoryBoard cb = new CategoryBoard();
		String addr = "";
		
		if(loginUser != null) {
			String address = loginUser.getAddress();
			String[] arr = address.split(",");
			String ad = arr[1];
			String[] adArr = ad.split(" ");
			if(adArr[0].contains("도")) {
				addr = adArr[0] +" "+ adArr[1];
			} else {
				addr = adArr[0];
			}
		}
		
		cb = new CategoryBoard(cid, null, addr);
		int listCount = bService.selectbListFromCategoryCount2(cb);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		List<Board> bList = bService.selectbListFromCategory2(cb, pi);
		
		if(!bList.isEmpty()) {
			for(int i = 0; i < bList.size(); i++) {
				Image image = bService.selectiList(bList.get(i).getBoard_id());
				bList.get(i).setRenameFileName(image.getRenameFileName());
			}
			
			// 카테고리 리스트
			List<Category> cList = bService.selectcList();
			// 검색 물품 카테고리 가져오기
			int cid1 = bList.get(0).getCategory_id();
			Category c3 = bService.selectCategory1(cid1);
			// 2차 카테고리 id
			int secondCid = c3.getCid2();
			// 1차 카테고리 id
			Category c4 = bService.selectCategory1(secondCid);
			int firstCid = c4.getCid2();
			
			// 카테고리 이름 출력용
			Category c5 = bService.selectCategory1(cid);
			
			model.addAttribute("cList", cList);
			model.addAttribute("secondCid", secondCid);
			model.addAttribute("firstCid", firstCid);
			model.addAttribute("cid", cid1);
			model.addAttribute("bList", bList);
			model.addAttribute("listCount", listCount);
			model.addAttribute("categoryValue3", cid);
			model.addAttribute("categoryName", c5.getCname());
			model.addAttribute("pi", pi);
			return "/board/listPage";
		} else {
			model.addAttribute("msg", "검색된 결과가 존재하지 않습니다.");
			model.addAttribute("url", "/home");
			return "/board/alertPage";
		}
	}
	
	
	@Autowired
	private CategoryService cService;

	// 로깅 필드 선언
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	// 오늘의 추천 상품 조회
	@RequestMapping(value = "/todayList", produces = "application/json; charset=utf-8")
	public @ResponseBody String boardTodayList() {
		List<Board> list = bService.selectTodayList();
		for(int i = 0; i < list.size(); i++) {
			Image img = bService.selectImage(list.get(i).getBoard_id());
			list.get(i).setRenameFileName(img.getRenameFileName());
		}
		// 날짜 포맷하기 위해 GsonBuilder를 이용해서 Gson 객체 생성
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();

		return gson.toJson(list);
	}

	// 게시글 상세 페이지
	@GetMapping("/detail")
	public String boardDetail(int board_id, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		// menu select
		// detail select
		
		// model .. 
		// model ...
		List<Image> ilist = bService.selectImageList(board_id);
		String filename = ilist.get(0).getRenameFileName();
		boolean flagblist = false; // blist라는 이름의 쿠키가 있는지 확인
		boolean flagbid = false; // blist 안에 해당 bid가 포함되어 있는지 확인

		Cookie[] cookies = request.getCookies();

		try {
			if (cookies != null) {
				for (Cookie c : cookies) {
					// 읽은 게시글의 bid를 모아서 보관하는 blist가 쿠키 안에 있다면
					if (c.getName().equals("blist")) {
						flagblist = true;
						// 기존 쿠키 값 먼저 읽어옴(, 등의 특수문자 인코딩 때문에 decode 처리)
						String blist = URLDecoder.decode(c.getValue(), "UTF-8");
						// , 구분자 기준으로 나누기
						String[] list = blist.split(",");
						for (String st : list) {
							// 쿠키 안에 지금 클릭한 게시글의 bid가 들어 있다면 => 읽었음을 표시
							if (st.equals(String.valueOf(board_id) + "/" + String.valueOf(filename)))
								flagbid = true;
						}
						if (!flagbid) { // 게시글을 읽지 않았다면
							// 지금 게시글을 읽었다는 의미로 blist에 bid를 추가해서 인코딩한 문자로 쿠키 값을 새롭게 설정
							c.setValue(URLEncoder.encode(blist + "," + board_id + "/" + filename, "UTF-8"));
							response.addCookie(c); // 응답에 담아 보냄
						}
					}
				}
				if (!flagblist) {
					// blist라는 쿠키가 존재하지 않는 경우 새로 생성해서 지금 게시글의 bid를 value로 추가
					Cookie c1 = new Cookie("blist", URLEncoder.encode(String.valueOf(board_id) + "/" + String.valueOf(filename), "UTF-8"));
					response.addCookie(c1); // 응답에 담아 보냄
				}
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		// flagbid가 true이면 읽은 게시글, flagbid가 false이면 읽지 않은 게시글
		// !flagbid를 전달하여 true이면 조회수 증가 필요, false이면 조회수 증가 불필요
		Board b = bService.selectBoard(board_id, !flagbid);
		
		List<Category> clist = bService.selectcList();
		
		if (b != null) {
			b.setRenameFileName(ilist.get(0).getRenameFileName());
			model.addAttribute("clist", clist);
			model.addAttribute("board", b);
			model.addAttribute("ilist", ilist);
			return "board/detailPage";
		} else {
			model.addAttribute("msg", "게시글 상세보기에 실패했습니다.");
			return "common/errorPage";
		}
	}

	// 검색
	/*
	 * @GetMapping("/search") public String boardSearch(@ModelAttribute Search
	 * search, Model model) { List<Board> searchList = bService.searchList(search);
	 * model.addAttribute("list", searchList); return "board/listPage"; }
	 */
	
	// 찜목록에 추가
	@GetMapping("/wish")
	public String wishInsert(int board_id, HttpSession session, Model model) {
		Account loginUser = (Account) session.getAttribute("loginUser");
		String aid = loginUser.getAid();
		Wish w = new Wish();
		w.setAccountId(aid);
		w.setBoardId(board_id);
		Wish wish = bService.selectWish(w);
		int result = 0;
		if(wish == null) {
			result = bService.insertWish(w);
		}
		
		
		if(result > 0) {
			model.addAttribute("msg", "찜목록에 상품이 추가되었습니다.");
			model.addAttribute("url", "/board/detail?board_id=" + board_id);
			return "/board/alertPage";
		} else {
			model.addAttribute("msg", "찜목록에 이미 존재하는 상품입니다.");
			model.addAttribute("url", "/board/detail?board_id=" + board_id);
			return "/board/alertPage";
		}
	}
}
