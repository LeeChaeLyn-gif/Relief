package com.kh.relief.account.controller;

import java.util.Date;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.relief.account.model.service.AccountService;
import com.kh.relief.account.model.vo.Account;

@Controller
@RequestMapping("/account")
@SessionAttributes({"loginUser"})
public class AccountController {
	@Autowired
	   private AccountService aService;
	
	   
	   @Autowired
	   private BCryptPasswordEncoder bcryptPasswordEncoder;
	   
	   private String apiResult = null;

	   private static final Logger logger = LoggerFactory.getLogger(AccountController.class);
	   
	   // 로그인 페이지로 이동
	   @GetMapping("/login")
	   public String login(Model model, HttpSession session) {
	      
	      
	      return "login/signUpPage";
	   }
	   
	   // 로그인
	   @PostMapping("/login")
	   public String login(@ModelAttribute Account a, Model model) {
	      
	      Account loginUser = aService.login(a);
	      if(loginUser != null && bcryptPasswordEncoder.matches(a.getPwd(), loginUser.getPwd())) {
	         SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	         Date today = new Date();
	         if(loginUser.getSanctions() != null) {
	            String d1 = sdf.format(loginUser.getSanctions());
	            Date sanctions = new Date();
	            try {
	               sanctions = sdf.parse(d1);   
	            } catch (java.text.ParseException e) {
	               e.printStackTrace();
	            }
	            
	            if(sanctions.after(today)) {
	               model.addAttribute("msg", "해당계정은 정지 되어"+ loginUser.getSanctions() + "까지 사용 불가능합니다.");
	               return "/login/alertPage";
	            } else {
	               model.addAttribute("loginUser", loginUser);
	               
	               return "redirect:/home";
	            }
	         } else {
	         model.addAttribute("loginUser", loginUser);
	         return "redirect:/home";
	         }
	      } else {
	         model.addAttribute("msg", "로그인에 실패하였습니다.");
	         return "login/alertPage";
	      }

	   }
}
