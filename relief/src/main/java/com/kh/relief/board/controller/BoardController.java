package com.kh.relief.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import java.util.ArrayList;
import java.util.List;



import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.relief.account.model.vo.Account;
import com.kh.relief.admin.model.serivce.AdminService;
import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.admin.model.vo.Report;
import com.kh.relief.admin.model.vo.Notice;
import com.kh.relief.board.Pagination;
import com.kh.relief.board.model.service.BoardService;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.board.model.vo.BoardImage;
import com.kh.relief.board.model.vo.CategoryBoard;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.board.model.vo.PageInfo;
import com.kh.relief.board.model.vo.Reply;
import com.kh.relief.board.model.vo.SearchBoard;
import com.kh.relief.board.model.vo.Sort;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.relief.board.model.exception.BoardException;
import com.kh.relief.board.model.vo.Wish;
import com.kh.relief.review.model.vo.Review;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardService bService;

	@Autowired
	private AdminService aService;

	@GetMapping("/list")
	public String searchListview(@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			Model model, HttpSession session, @RequestParam(name = "searchValue") String searchValue) {
		// 고객의 주소값 기준으로 검색하기 위한 주소값 뽑아내기
		Account loginUser = (Account) session.getAttribute("loginUser");
		SearchBoard sb = new SearchBoard();
		List<Board> bList = new ArrayList<>();
		PageInfo pi = new PageInfo();
		int listCount = 0;
		if (loginUser != null) {
			String address = loginUser.getAddress();
			String[] arr = address.split(",");
			String ad = arr[1];
			String[] adArr = ad.split(" ");
			String addr = "";
			if (adArr[0].contains("도")) {
				addr = adArr[0] + " " + adArr[1];
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
				model.addAttribute("clist", cList);
				model.addAttribute("secondCid", secondCid);
				model.addAttribute("firstCid", firstCid);
				model.addAttribute("cid", cid);
				model.addAttribute("bList", bList);
				model.addAttribute("listCount", listCount);
				model.addAttribute("searchValue", searchValue);
				model.addAttribute("pi", pi);
				return "/board/listPage";
				
		listCount = bService.selectbListCount(sb);
		pi = Pagination.getPageInfo(currentPage, listCount);
		bList = bService.selectbList(sb, pi);

		if (bList.isEmpty()) {
			model.addAttribute("msg", "검색된 결과가 존재하지 않습니다.");
			model.addAttribute("url", "/home");
			return "/board/alertPage";
		} else {

			for (int i = 0; i < bList.size(); i++) {
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
	public String sortList(@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			Model model, @ModelAttribute Sort s, HttpSession session) {
		Account loginUser = (Account) session.getAttribute("loginUser");
		SearchBoard sb = new SearchBoard();
		List<Board> bList = new ArrayList<>();
		PageInfo pi = new PageInfo();
		int listCount = 0;
		if (loginUser != null) {
			String address = loginUser.getAddress();
			String[] arr = address.split(",");
			String ad = arr[1];
			String[] adArr = ad.split(" ");
			String addr = "";
			if (adArr[0].contains("도")) {
				addr = adArr[0] + " " + adArr[1];
			} else {
				addr = adArr[0];
			}
			sb = new SearchBoard(s.getSearchValue(), addr);
		}
		if (sb != null && s.getSortValue().equals("desc")) {
			listCount = bService.selectbListCount(sb);
			pi = Pagination.getPageInfo(currentPage, listCount);
			bList = bService.descbList(sb, pi);
		} else if (sb != null && s.getSortValue().equals("asc")) {
			listCount = bService.selectbListCount(sb);
			pi = Pagination.getPageInfo(currentPage, listCount);
			bList = bService.ascbList(sb, pi);
		}
		for (int i = 0; i < bList.size(); i++) {
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
		model.addAttribute("clist", cList);
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
	public String category1(@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			int cid, Model model, HttpSession session) {
		Account loginUser = (Account) session.getAttribute("loginUser");
		CategoryBoard cb = new CategoryBoard();
		String addr = "";

		if (loginUser != null) {
			String address = loginUser.getAddress();
			String[] arr = address.split(",");
			String ad = arr[1];
			String[] adArr = ad.split(" ");
			if (adArr[0].contains("도")) {
				addr = adArr[0] + " " + adArr[1];
			} else {
				addr = adArr[0];
			}
		}

		List<Category> c1 = bService.selectcListFromCid2(cid);
		List<Integer> iList = new ArrayList<>();
		List<Integer> iList2 = new ArrayList<>();
		for (int i = 0; i < c1.size(); i++) {
			iList.add(c1.get(i).getCid());
		}

		List<Category> c2 = bService.selectcListFromiList(iList);

		for (int i = 0; i < c2.size(); i++) {
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
		model.addAttribute("clist", cList);
		model.addAttribute("secondCid", secondCid);
		model.addAttribute("firstCid", firstCid);
		model.addAttribute("cid", cid1);
		model.addAttribute("bList", bList);
		model.addAttribute("listCount", listCount);
		model.addAttribute("categoryValue", cid);
		model.addAttribute("categoryName", c5.getCname());
		model.addAttribute("pi", pi);
		return "/board/listPage";

		if (!bList.isEmpty()) {
			for (int i = 0; i < bList.size(); i++) {
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
	public String category2(@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			int cid, Model model, HttpSession session) {
		List<Category> c1 = bService.selectcListFromCid2(cid);
		List<Integer> iList = new ArrayList<>();

		Account loginUser = (Account) session.getAttribute("loginUser");
		CategoryBoard cb = new CategoryBoard();
		String addr = "";

		if (loginUser != null) {
			String address = loginUser.getAddress();
			String[] arr = address.split(",");
			String ad = arr[1];
			String[] adArr = ad.split(" ");
			if (adArr[0].contains("도")) {
				addr = adArr[0] + " " + adArr[1];
			} else {
				addr = adArr[0];
			}
		}

		for (int i = 0; i < c1.size(); i++) {
			iList.add(c1.get(i).getCid());
		}

		cb = new CategoryBoard(0, iList, addr);
		int listCount = bService.selectbListFromCategoryCount(cb);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		List<Board> bList = bService.selectbListFromCategory(cb, pi);

		if (!bList.isEmpty()) {
			for (int i = 0; i < bList.size(); i++) {
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
			model.addAttribute("clist", cList);
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
	public String category3(@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			int cid, Model model, HttpSession session) {
		Account loginUser = (Account) session.getAttribute("loginUser");
		CategoryBoard cb = new CategoryBoard();
		String addr = "";

		if (loginUser != null) {
			String address = loginUser.getAddress();
			String[] arr = address.split(",");
			String ad = arr[1];
			String[] adArr = ad.split(" ");
			if (adArr[0].contains("도")) {
				addr = adArr[0] + " " + adArr[1];
			} else {
				addr = adArr[0];
			}
		}

		cb = new CategoryBoard(cid, null, addr);
		int listCount = bService.selectbListFromCategoryCount2(cb);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		List<Board> bList = bService.selectbListFromCategory2(cb, pi);

		if (!bList.isEmpty()) {
			for (int i = 0; i < bList.size(); i++) {
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
			model.addAttribute("clist", cList);
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

	// 로깅 필드 선언
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	// 오늘의 추천 상품 조회
	@RequestMapping(value = "/todayList", produces = "application/json; charset=utf-8")
	public @ResponseBody String boardTodayList() {
		List<Board> list = bService.selectTodayList();
		for (int i = 0; i < list.size(); i++) {
			Image img = bService.selectImage(list.get(i).getBoard_id());
			list.get(i).setRenameFileName(img.getRenameFileName());
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();

		return gson.toJson(list);
	}

	// 게시글 상세 페이지
	@GetMapping("/detail")
	public String boardDetail(int board_id, HttpServletRequest request, HttpServletResponse response, Model model) {

		List<Image> ilist = bService.selectImageList(board_id);
		String filename = ilist.get(0).getRenameFileName();
		boolean flagblist = false; // blist라는 이름의 쿠키가 있는지 확인
		boolean flagbid = false; // blist 안에 해당 bid가 포함되어 있는지 확인

		Cookie[] cookies = request.getCookies();

		try {
			if (cookies != null) {
				for (Cookie c : cookies) {
					if (c.getName().equals("blist")) {
						flagblist = true;
						String blist = URLDecoder.decode(c.getValue(), "UTF-8");
						// , 구분자 기준으로 나누기
						String[] list = blist.split(",");
						for (String st : list) {
							// 쿠키 안에 지금 클릭한 게시글의 bid가 들어 있다면 => 읽었음을 표시
							if (st.equals(String.valueOf(board_id)))
								flagbid = true;
						}
						if (!flagbid) { // 게시글을 읽지 않았다면
							// 지금 게시글을 읽었다는 의미로 blist에 bid를 추가해서 인코딩한 문자로 쿠키 값을 새롭게 설정
							c.setValue(URLEncoder.encode(blist + "," + board_id + "," + filename, "UTF-8"));
							c.setPath("/");
							response.addCookie(c); // 응답에 담아 보냄
						}
					}
				}
				if (!flagblist) {
					// blist라는 쿠키가 존재하지 않는 경우 새로 생성해서 지금 게시글의 bid를 value로 추가
					Cookie c1 = new Cookie("blist", URLEncoder.encode(board_id + "," + filename, "UTF-8"));
					c1.setPath("/");
					response.addCookie(c1); // 응답에 담아 보냄
				}
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		// flagbid가 true이면 읽은 게시글, flagbid가 false이면 읽지 않은 게시글
		// !flagbid를 전달하여 true이면 조회수 증가 필요, false이면 조회수 증가 불필요
		Board b = bService.selectBoard(board_id, !flagbid);

		List<Reply> comlist = bService.selectReplyList(board_id);
		
		List<Category> clist = bService.selectcList();

		if (b != null) {
			Category c = bService.selectCategory1(b.getCategory_id());
			b.setRenameFileName(ilist.get(0).getRenameFileName());
			List<Review> rlist = bService.selectrList(b.getAccount_id());
			model.addAttribute("c", c);
			model.addAttribute("clist", clist);
			model.addAttribute("board", b);
			model.addAttribute("ilist", ilist);
			model.addAttribute("rlist", rlist);
			model.addAttribute("comlist", comlist);
			return "board/detailPage";
		} else {
			model.addAttribute("msg", "게시글 상세보기에 실패했습니다.");
			return "common/errorPage";
		}
	}

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
		if (wish == null) {
			result = bService.insertWish(w);
		}

		if (result > 0) {
			model.addAttribute("msg", "찜목록에 상품이 추가되었습니다.");
			model.addAttribute("url", "/board/detail?board_id=" + board_id);
			return "/board/alertPage";
		} else {
			model.addAttribute("msg", "찜목록에 이미 존재하는 상품입니다.");
			model.addAttribute("url", "/board/detail?board_id=" + board_id);
			return "/board/alertPage";
		}
	}
	
	@GetMapping("/insertPage")
	public String insertPage(Model model, HttpSession session) {
		
		List<Category> list = bService.selectCategory();
		model.addAttribute("list",list);
		
		// 주소 스플릿처리하기
		Account loginUser = (Account) session.getAttribute("loginUser");
		
		if(loginUser != null) {
			String userAddr = loginUser.getAddress();
			
			String[] arr = userAddr.split(",");
			String addr = arr[1];
			String[] addr2 = addr.split(" ");
			String addr3 = "";
			
			addr3 = addr2[0] + " " + addr2[1];
			model.addAttribute("addr", addr3);
		}
		return "/board/insertPage";
	}
	
	@PostMapping("/insert")
	public String insertBoard(@ModelAttribute Board b,MultipartHttpServletRequest mtfrequest,Model model, HttpServletRequest request, HttpSession session) {
		Account loginUser = (Account) session.getAttribute("loginUser");
		String accountId = loginUser.getAid();
		b.setAccount_id(accountId);
		if(b.getPrice_status() == null) {
			b.setPrice_status("N");
		}
		
		int result = bService.insertBoard(b);
		int bid = bService.selectbId();
		int result2 = 0;
		
		List<MultipartFile> fList = mtfrequest.getFiles("file");
		if(!fList.isEmpty()) {
			
			List<String> renameFilename = saveFile(fList, request);
			BoardImage bi = new BoardImage();
			bi.setBid(bid);
			for(int i = 0; i < renameFilename.size(); i++) {
				
				bi.setList(renameFilename.get(i));
				
				result2 = bService.insertImage(bi);
			}
			
			
		}
		
		return "/home";
	}
	
	private List<String> saveFile(List<MultipartFile> fList, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "//buploadFiles";
		File folder = new File(savePath);
		List<String> saveList = new ArrayList<>();
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		for (MultipartFile mf : fList) {
            String originFileName = mf.getOriginalFilename(); // 원본 파일 명
            long fileSize = mf.getSize(); // 파일 사이즈

            String saveFile = folder + "\\" + System.currentTimeMillis() + originFileName;
            String saveFile2 = System.currentTimeMillis() + originFileName;
            
            saveList.add(saveFile2);
            try {
                mf.transferTo(new File(saveFile));
            } catch (IllegalStateException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
		
		return saveList;
	}

	@GetMapping("/category")
	public void category(int cid, HttpServletResponse response) throws IOException {
		List<Category> list = bService.selectCategory2(cid);
		
		JSONArray jArr = new JSONArray();
		
		for(Category category : list) {
			JSONObject jCategory = new JSONObject();
			jCategory.put("cid", category.getCid());
			jCategory.put("cid2", category.getCid2());
			jCategory.put("cname", category.getCname());
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
	
	@RequestMapping(value = "/url",method = RequestMethod.POST)
    public String getData(Model model,MultipartHttpServletRequest req){
 
        //get image file.
        List<MultipartFile> multipartFileList = new ArrayList<>();
        try{
            MultiValueMap<String, MultipartFile> files = req.getMultiFileMap();
            for (Map.Entry<String, List<MultipartFile>> entry : files.entrySet()) {
                List<MultipartFile> fileList = entry.getValue();
                for (MultipartFile file : fileList) {
                    if (file.isEmpty()) continue;
                    multipartFileList.add(file);
                }
            }
 
            if(multipartFileList.size()>0) {
                for(MultipartFile file: multipartFileList) {
                    file.transferTo(new File( File.separator + file.getOriginalFilename()));
                }
            }
            }catch (Exception e){
            e.printStackTrace();
            logger.info(" has no multipartFile!");
        }
 
 
        model.addAttribute("log","사진 "+multipartFileList.size()+"장 전송완료!");
        return "html템플릿 주소 :: #resultDiv";
    }
	
	
	@GetMapping("/reportUser")
	public String reportUser(String accountId2 , int bid, Model model) {

		model.addAttribute("accountId2", accountId2);
		model.addAttribute("bid", bid);
		
		return "/board/reportPage";
	}
	
	@PostMapping("/report")
	public String reportBoard(HttpSession session,@ModelAttribute Report r, Model model) {
		Account loginUser = (Account) session.getAttribute("loginUser");
		String accountId = loginUser.getAid();
		r.setAid(accountId);
		if(r.getBid() != 0) {
			int result = bService.reportUser(r);
		} else if(r.getChid() != 0) {
			int result2 = bService.reportUser2(r);
		} else {
			int result3 = bService.reportUser3(r);
		}
		model.addAttribute("msg", "신고가 완료되었습니다.");
		return "/board/alertPage2";
	}
	

	// 댓글 작성
	@PostMapping(value = "/insertReply", produces = "application/json; charset=utf-8")
	public @ResponseBody String insertReply(Reply r, HttpSession session) {
		Account loginUser = (Account) session.getAttribute("loginUser");
		String rAid = loginUser.getAid();
		r.setAid(rAid);

		List<Reply> relist = bService.insertReply(r);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();

		return gson.toJson(relist);
	}

}
