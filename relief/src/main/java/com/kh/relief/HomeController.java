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


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.relief.account.model.vo.Account;
import com.kh.relief.board.model.service.BoardService;
import com.kh.relief.category.model.service.CategoryService;

import com.kh.relief.admin.model.vo.Category;



import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.notice.model.vo.Notice;
import com.kh.relief.admin.model.vo.Category;


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
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model, HttpServletResponse response, HttpServletRequest request) {
		
		List<Category> clist = bService.selectcList();
		model.addAttribute("clist", clist);
		
		List<Notice> nlist = bService.selectadList();
		model.addAttribute("nlist", nlist);	
	
		
		return "home";
	}
	
	public String home2(Model model, HttpServletResponse response, HttpServletRequest request) {
		
		List<Category> clist = bService.selectcList();
		model.addAttribute("clist", clist);
		
		List<Notice> nlist = bService.selectadList();
		model.addAttribute("nlist", nlist);	
	
		
		return "home";
	}
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Model model, HttpServletResponse response, HttpServletRequest request) {
		
		List<Category> clist = bService.selectcList();
		model.addAttribute("clist", clist);
		
		List<Notice> nlist = bService.selectadList();
		model.addAttribute("nlist", nlist);	
	
		
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
	
}
