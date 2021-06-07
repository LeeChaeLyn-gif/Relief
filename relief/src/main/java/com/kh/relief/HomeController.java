package com.kh.relief;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.relief.account.model.vo.Account;
import com.kh.relief.board.model.service.BoardService;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.category.model.service.CategoryService;
import com.kh.relief.admin.model.vo.Category;
import com.sun.javafx.collections.MappingChange.Map;

import com.kh.relief.account.NaverLoginBO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private BoardService bService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Model model, HttpServletResponse response, HttpServletRequest request) {
		
		List<Category> clist = bService.selectcList();
		model.addAttribute("clist", clist);
		
		/*
		 * List<Wish> wlist = bService.selectWlist(); model.addAttribute("wlist",
		 * wlist);
		 */
		
		boolean flagblist = false; // blist라는 이름의 쿠키가 있는지 확인
		boolean flagbid = false; // blist 안에 해당 bid가 포함되어 있는지 확인

		String blist = "";
		Cookie[] cookies = request.getCookies();

		try {
			if (cookies != null) {
				for (Cookie c : cookies) {
					// 읽은 게시글의 bid를 모아서 보관하는 blist가 쿠키 안에 있다면
					if (c.getName().equals("blist")) {
						flagblist = true;
						// 기존 쿠키 값 먼저 읽어옴(, 등의 특수문자 인코딩 때문에 decode 처리)
						blist = URLDecoder.decode(c.getValue(), "UTF-8");
						// , 구분자 기준으로 나누기
						String[] list = blist.split(",");
						for (String st : list) {
							// 쿠키 안에 지금 클릭한 게시글의 bid가 들어 있다면 => 읽었음을 표시
							
						}
					}
				}
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		System.out.println(blist);
		
		
		
		return "home";
	}
	
	@GetMapping(value="wishCount", produces="application/json; charset=utf-8")
	@ResponseBody
	public HashMap<String, Integer> wishCount(HttpSession session){
		Account loginUser = (Account) session.getAttribute("loginUser");
		String aid = loginUser.getAid();
		int wCount = bService.wishCount(aid);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("wCount", wCount);
		return map;
	}
	
	@GetMapping(value="recentlist", produces="application/json; charset=utf-8")
	@ResponseBody
	public HashMap<String, Object> recentList(HttpServletRequest request){
		Cookie[] cookies = request.getCookies();
		String[] list = null;
		String[] ilist = null;
		try {
			if (cookies != null) {
				for (Cookie c : cookies) {
					// 읽은 게시글의 bid를 모아서 보관하는 blist가 쿠키 안에 있다면
					if (c.getName().equals("blist")) {
						// 기존 쿠키 값 먼저 읽어옴(, 등의 특수문자 인코딩 때문에 decode 처리)
						String blist = URLDecoder.decode(c.getValue(), "UTF-8");
						// , 구분자 기준으로 나누기
						list = blist.split(",");
						
					}
					if (c.getName().equals("ilist")) {
						String image = URLDecoder.decode(c.getValue(), "UTF-8");
						ilist = image.split(",");
					}
				}
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		System.out.println(list);
		System.out.println(ilist);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("blist", list);
		map.put("ilist", ilist);
		return map;
	}
	
}
