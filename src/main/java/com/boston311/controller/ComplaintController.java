package com.boston311.controller;

import com.boston311.dao.ComplaintDAO;
import com.boston311.model.Complaint;
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
}