package com.kh.relief.board.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

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
	
	
}
