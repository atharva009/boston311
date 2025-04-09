package com.boston311.controller;

import com.boston311.dao.ComplaintDAO;
import com.boston311.model.Citizen;
import com.boston311.model.Complaint;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@Controller
@RequestMapping("/complaints")
public class ComplaintController {

    @Autowired
    private ComplaintDAO complaintDAO;

    @GetMapping("/new")
    public String showComplaintForm(Model model) {
        model.addAttribute("complaint", new Complaint());
        return "complaint/form";
    }

    @PostMapping("/submit")
    public String submitComplaint(@ModelAttribute Complaint complaint) {
        complaint.setDateReported(new Date());
        complaint.setStatus("Open");
        complaintDAO.saveComplaint(complaint);
        return "redirect:/complaints/success";
    }

    @GetMapping("/success")
    public String showSuccessPage() {
        return "complaint/success";
    }

    @GetMapping("/edit/{id}")
    public String editComplaintForm(@PathVariable int id, Model model, HttpSession session) {
        Complaint complaint = complaintDAO.getComplaintById(id);
        Citizen citizen = (Citizen) session.getAttribute("loggedInCitizen");
        if (citizen == null || complaint == null || complaint.getCitizen().getId() != citizen.getId()) {
            return "redirect:/citizen/dashboard";
        }
        model.addAttribute("complaint", complaint);
        return "complaint/edit";
    }

    @PostMapping("/edit")
    public String updateComplaint(@ModelAttribute Complaint complaint) {
        Complaint existing = complaintDAO.getComplaintById(complaint.getId());
        existing.setDescription(complaint.getDescription());
        existing.setLocation(complaint.getLocation());
        existing.setSeverity(complaint.getSeverity());
        complaintDAO.saveComplaint(existing);
        return "redirect:/citizen/dashboard";
    }

    @GetMapping("/cancel/{id}")
    public String cancelComplaint(@PathVariable int id, HttpSession session) {
        Complaint complaint = complaintDAO.getComplaintById(id);
        Citizen citizen = (Citizen) session.getAttribute("loggedInCitizen");
        if (citizen != null && complaint.getCitizen().getId() == citizen.getId()) {
            complaint.setStatus("Cancelled");
            complaintDAO.saveComplaint(complaint);
        }
        return "redirect:/citizen/dashboard";
    }

}