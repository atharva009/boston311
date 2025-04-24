package com.boston311.controller;

import com.boston311.dao.CitizenDAO;
import com.boston311.dao.ComplaintDAO;
import com.boston311.model.Citizen;
import com.boston311.model.Complaint;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/citizen")
public class CitizenController {

    @Autowired
    private CitizenDAO citizenDAO;

    @Autowired
    private ComplaintDAO complaintDAO;

    // Show registration form
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("citizen", new Citizen());
        return "citizen/register";
    }

    // Handle registration
    @PostMapping("/register")
    public String registerCitizen(@ModelAttribute("citizen") @Valid Citizen citizen,
                                  BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "citizen/register";
        }
        citizenDAO.saveCitizen(citizen);
        return "redirect:/citizen/login";
    }

    // Show login form
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("citizen", new Citizen());
        return "citizen/login";
    }

    // Handle login (very basic - match by email only for now)
    @PostMapping("/login")
    public String loginCitizen(@ModelAttribute("citizen") @Valid Citizen formCitizen,
                               BindingResult result, HttpSession session, Model model) {
        if (result.hasErrors()) {
            return "citizen/login";
        }

        List<Citizen> citizens = citizenDAO.getAllCitizens();
        for (Citizen c : citizens) {
            if (c.getEmail().equalsIgnoreCase(formCitizen.getEmail())) {
                session.setAttribute("loggedInCitizen", c);
                return "redirect:/citizen/dashboard";
            }
        }
        model.addAttribute("error", "Invalid email");
        return "citizen/login";
    }

    // Dashboard
    @GetMapping("/dashboard")
    public String showDashboard(@RequestParam(required = false) String status,
                                @RequestParam(required = false) String keyword,
                                HttpSession session, Model model) {
        Citizen citizen = (Citizen) session.getAttribute("loggedInCitizen");
        if (citizen == null) return "redirect:/citizen/login";

        List<Complaint> complaints = complaintDAO.getComplaintsByCitizenId(citizen.getId());

        if (status != null && !status.isEmpty()) {
            complaints = complaints.stream()
                    .filter(c -> c.getStatus().equalsIgnoreCase(status))
                    .toList();
        }

        if (keyword != null && !keyword.isEmpty()) {
            String lowerKeyword = keyword.toLowerCase();
            complaints = complaints.stream()
                    .filter(c -> c.getDescription().toLowerCase().contains(lowerKeyword) ||
                            c.getLocation().toLowerCase().contains(lowerKeyword))
                    .toList();
        }

        model.addAttribute("citizenName", citizen.getName());
        model.addAttribute("complaints", complaints);
        model.addAttribute("openCount", complaints.stream().filter(c -> "Open".equalsIgnoreCase(c.getStatus())).count());
        model.addAttribute("inProgressCount", complaints.stream().filter(c -> "In Progress".equalsIgnoreCase(c.getStatus())).count());
        model.addAttribute("resolvedCount", complaints.stream().filter(c -> "Resolved".equalsIgnoreCase(c.getStatus())).count());
        model.addAttribute("selectedStatus", status);
        model.addAttribute("searchKeyword", keyword);

        return "citizen/dashboard";
    }

    // View complaints
    @GetMapping("/complaints")
    public String viewComplaints(HttpSession session, Model model) {
        Citizen citizen = (Citizen) session.getAttribute("loggedInCitizen");
        if (citizen == null) return "redirect:/citizen/login";

        List<Complaint> complaints = complaintDAO.getComplaintsByCitizenId(citizen.getId());
        model.addAttribute("complaints", complaints);
        return "citizen/complaints";
    }

    // Show profile
    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        Citizen citizen = (Citizen) session.getAttribute("loggedInCitizen");
        if (citizen == null) return "redirect:/citizen/login";

        model.addAttribute("citizen", citizen);
        return "citizen/profile";
    }

    // Update profile
    @PostMapping("/profile")
    public String updateProfile(@ModelAttribute("citizen") @Valid Citizen updatedCitizen,
                                BindingResult result,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "citizen/profile";
        }

        Citizen current = (Citizen) session.getAttribute("loggedInCitizen");

        current.setName(updatedCitizen.getName());
        current.setPhone(updatedCitizen.getPhone());
        current.setAddress(updatedCitizen.getAddress());
        current.setZipcode(updatedCitizen.getZipcode());

        citizenDAO.saveCitizen(current);
        session.setAttribute("loggedInCitizen", current);
        redirectAttributes.addFlashAttribute("profileUpdated", true);

        return "redirect:/citizen/dashboard";
    }

    // Logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/citizen/login";
    }
}