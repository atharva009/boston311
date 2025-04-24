package com.boston311.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String showLandingPage() {
        return "landing";
    }

    @GetMapping("/logoutAndHome")
    public String logoutToHome(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}