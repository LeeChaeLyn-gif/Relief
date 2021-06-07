package com.kh.relief.account.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.relief.account.NaverLoginBO;
import com.kh.relief.account.model.service.AccountService;
import com.kh.relief.account.model.service.MailSendService;
import com.kh.relief.account.model.vo.Account;



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
	private MailSendService mss;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naerLoginBO, NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	private static final Logger logger = LoggerFactory.getLogger(AccountController.class);
	
	// 로그인 페이지로 이동
	@GetMapping("/login")
	public String login(Model model, HttpSession session) {
		
		 String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		 
		 model.addAttribute("url", naverAuthUrl);
		
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
	
	// 회원가입
	@GetMapping("/join")
	public String joinMember() {
		return "login/joinPage";
	}
	@PostMapping("/join")
	public String insertAccount(@ModelAttribute Account a,
								@RequestParam String post,
								@RequestParam String address1,
								@RequestParam String address2,
								Model model,
								RedirectAttributes rd) {
		a.setAddress(post + "," + address1 + "," + address2);
		
		// bcrypt 암호화
		a.setPwd(bcryptPasswordEncoder.encode(a.getPwd()));
		
		// 이메일 중복 확인
		int checkEmail = aService.checkEmail(a);
		
		if(checkEmail > 0) {
			model.addAttribute("msg", "해당 이메일로 가입된 계정이 존재합니다.");
			return "login/alertPage";
		} else {
		
		int result = aService.insertAccount(a);
		
		// 이메일 인증
		String authKey = mss.sendAuthMail(a.getEmail());
		a.setAuthKey(authKey);
		
		Map<String, String> map = new HashMap<String, String>();
        map.put("email", a.getEmail());
        map.put("authKey", a.getAuthKey());
		
		// DB 업데이트
		int result2 = aService.updateAuthKey(a);	
		
		if(result > 0) {
			rd.addFlashAttribute("msg", "회원가입이 완료되었습니다. 이메일인증을 진행하고 로그인해주세요.");
			return "redirect:/account/login";
		} else {
			model.addAttribute("msg", "회원 가입에 실패하였습니다.");
			return "login/alertPage";
		}
		}
	}
	
	// 이메일 인증 완료시
	@GetMapping("/signUpConfirm")
	public String signUpConfirm(@RequestParam Map<String, String> map, Model model){
		String email = map.get("email");
	    int result = aService.updateAuthStatus(email);
	    
	    model.addAttribute("msg", "인증이 완료되었습니다. 로그인해주세요.");
	    return "login/alertPage";
	}
	
	@PostMapping("checkId")
	public void checkId(String aid, HttpServletResponse response) throws IOException {
		int result = aService.checkId(aid);
		PrintWriter out = response.getWriter();
		if(result > 0) {
			out.print("fail");
		} else {
			out.print("success");
		}
	}
	
	// 네이버 로그인
	@RequestMapping(value="/callback", method= {RequestMethod.GET, RequestMethod.POST})
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
		OAuth2AccessToken oauthToken;
		
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		
		JSONObject response_obj = (JSONObject)jsonObj.get("response");

		String email = (String)response_obj.get("email");
		String phone = (String)response_obj.get("mobile");
		String name = (String)response_obj.get("name");
		Account a = new Account();
		a.setAid(email);
		a.setEmail(email);
		a.setPhone(phone);
		a.setName(name);
		Account loginUser = aService.login(a);
		int result = 0;
		if(loginUser == null) {
			result = aService.insertNaverAccount(a);
			if(result > 0) {
				model.addAttribute("loginUser", a);
				model.addAttribute("msg","로그인 되었습니다.");
				return "login/callbackPage";
			} else {
				model.addAttribute("msg", "회원 가입에 실패하였습니다.");
				return "login/alertPage";
			}
			
		} else {
			model.addAttribute("loginUser", loginUser);
			model.addAttribute("msg","로그인 되었습니다.");
			return "login/callbackPage";
		}
		
	}
	@PostMapping("/updateNaver")
	public String updateNaverAccount(@ModelAttribute("loginUser") Account a,
									 @RequestParam String pwd,
									 @RequestParam String post,
									 @RequestParam String address1,
									 @RequestParam String address2,
									 Model model) {
		a.setPwd(bcryptPasswordEncoder.encode(pwd));
		
		a.setAddress(post + "," + address1 + "," + address2);
		
		int result = aService.updateNaverAccount(a);
		
		if(result > 0) {
			model.addAttribute("msg", "다행의 가족이 되신걸 환영합니다!");
			return "login/callbackPage";
		} else {
			model.addAttribute("msg", "정보 수정에 실패하였습니다.");
			return "login/alertPage";
		}
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/home";
	}
	
	// 아이디 찾기 페이지 이동
	@GetMapping("/findId")
	public String findIdViewPage() {
		return "login/findId";
	}
	
	// 아이디 찾기
	@PostMapping("/findId")
	public String findId(@RequestParam String email,
						 @RequestParam String name,
						 Model model) {
		Account a = new Account();
		a.setEmail(email);
		a.setName(name);
		Account findUser = aService.findId(a);
		
		if(findUser != null) {
			String authKey = mss.sendFindIdMail(findUser.getEmail());
			findUser.setAuthKey(authKey);
			
			Map<String, String> map = new HashMap<String, String>();
	        map.put("email", findUser.getEmail());
	        map.put("authKey", findUser.getAuthKey());
			
			// DB 업데이트
			int result = aService.updateAuthKey(findUser);
			
			model.addAttribute("msg", "인증 이메일을 발송했습니다. 이메일을 확인해주세요.");
			return "login/alertPage";
		} else {
			model.addAttribute("msg", "입력하신 정보에 해당하는 회원정보가 존재하지 않습니다.");
			return "login/alertPage";
		}
	}
	
	// 아이디 찾기 이메일 인증 완료시
	@GetMapping("/findIdResult")
	public String findIdResult(@RequestParam Map<String, String> map, Model model){
		String email = map.get("email");
		String authKey = map.get("authKey");
		Account a = new Account();
		a.setEmail(email);
		a.setAuthKey(authKey);
		
	    Account user = aService.findIdResult(a);
	    
	    model.addAttribute("user", user);
	    model.addAttribute("msg", "인증이 완료되었습니다.");
	    return "login/findIdResult";
	}
	
	// 비밀번호찾기 페이지 이동
	@GetMapping("/findPwd")
	public String findPwdViewPage() {
		return "login/findPwd";
	}
	
	@PostMapping("/findPwd")
	public String findPwd(@ModelAttribute Account a,
						  Model model) {
		Account findUser = aService.findPwd(a);
		
		if(findUser != null) {
			String authKey = mss.sendFindPwdMail(findUser.getEmail());
			findUser.setAuthKey(authKey);
			
			Map<String, String> map = new HashMap<String, String>();
	        map.put("email", findUser.getEmail());
	        map.put("authKey", findUser.getAuthKey());
	        
	        int result = aService.updateAuthKey(findUser);
	        
	        model.addAttribute("msg", "인증 이메일을 발송했습니다. 이메일을 확인해주세요.");
			return "login/alertPage";
		} else {
			model.addAttribute("msg", "입력하신 정보에 해당하는 회원정보가 존재하지 않습니다.");
			return "login/alertPage";
		}
	}
	
	@GetMapping("/findPwdResult")
	public String findPwdResult(@RequestParam Map<String, String> map, Model model) {
		String email = map.get("email");
		String authKey = map.get("authKey");
		Account a = new Account();
		a.setEmail(email);
		a.setAuthKey(authKey);
		
		
		Account user = aService.findIdResult(a);
	    
	    model.addAttribute("user", user);
	    model.addAttribute("msg", "인증이 완료되었습니다.");
	    
		return "/login/findPwdResult";
	}
	@PostMapping("/findPwdUpdate")
	public String findPwdUpdate(@ModelAttribute Account a, Model model) {
		
		a.setPwd(bcryptPasswordEncoder.encode(a.getPwd()));
		
		int result = aService.findPwdUpdate(a);
		
		if(result > 0) {
			model.addAttribute("msg", "비밀번호 수정이 완료 되었습니다. 로그인 해주세요.");
			return "login/alertPage";
		} else {
			model.addAttribute("msg", "알 수 없는 오류 발생 !");
			return "login/alertPage";
		}
	}
	  
}
