package com.ib.cat.controller.member;

import com.ib.cat.dto.member.Auth;
import com.ib.cat.entity.Member;
import com.ib.cat.service.member.MailService;
import com.ib.cat.service.member.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    @Autowired
    MemberService memberService;
    @Autowired
    MailService mailService;
    @Autowired
    PasswordEncoder passwordEncoder;

    String kakao_client_id = "fc6944c62dae67a30e23da58dc978e9f";
    String kakao_redirect_uri = "http://localhost:8080/kakaocallback";

    String google_client_id = "516786604299-idqmu109ihn6h70b2kda60m32se1rir7.apps.googleusercontent.com";
    String google_redirect_uri = "http://localhost:8080/test/googlecallback";

    @GetMapping("member/login")
    public String getLogin(Model model){

        String kakao = "https://kauth.kakao.com/oauth/authorize?"
                + "client_id="+kakao_client_id+
                "&redirect_uri="+kakao_redirect_uri+
                "&response_type=code";

        String google = "https://accounts.google.com/o/oauth2/v2/auth"
                + "?client_id="+google_client_id
                + "&redirect_uri="+ google_redirect_uri
                + "&response_type=code"
                + "&scope=email%20profile%20openid"
                + "&access_type=offline";

        model.addAttribute("kakao", kakao);
        model.addAttribute("google", google);
        return "member/login";
    }

    @PostMapping("member/login")
    public String postLogin(){
        return "member/login";
    }

    @GetMapping("/member/session")
    public String getSession(HttpSession httpSession){
        Object object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String id = ((User) object).getUsername();
        Member member = memberService.findById(id);
        Auth auth = new Auth();
        auth.setId(id);
        auth.setName(member.getName());
        auth.setImgs(member.getImgs());
        auth.setRegdate(member.getRegdate());

        httpSession.setAttribute("auth", auth);
        return "redirect:/main";
    }
    //이메일 전송
    @RequestMapping(value="/member/sendEmail", method = {RequestMethod.POST})
    @ResponseBody
    public void sendEmail(String id){
        if(memberService.idCheck(id) == 1){
        Member member = memberService.findById(id);
        mailService.emailSend(member.getEmail(), member.getId(), member.getAuth());
        }
    }

}
