package com.boston311.controller;

import com.boston311.dao.ComplaintDAO;
import com.boston311.dao.DepartmentDAO;
import com.boston311.model.Citizen;
import com.boston311.model.Complaint;
import com.boston311.model.Department;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/complaints")
public class ComplaintController {

    @Autowired
    private ComplaintDAO complaintDAO;

    @Autowired
    private DepartmentDAO departmentDAO;

    // Show complaint creation form
    @GetMapping("/new")
    public String showComplaintForm(Model model, HttpSession session) {
        List<Department> departments = departmentDAO.getAllDepartments();

        // ✅ Validate: if no departments, redirect or show error
        if (departments == null || departments.isEmpty()) {
            model.addAttribute("error", "No departments available. Please try again later.");
            return "error"; // Or redirect to dashboard with error param
        }

        model.addAttribute("complaint", new Complaint());
        model.addAttribute("departments", departments);

        return "complaint/form";
    }

    // Handle form submission
    @PostMapping("/submit")
    public String submitComplaint(@ModelAttribute("complaint") Complaint complaint, HttpSession session) {
        Citizen loggedInCitizen = (Citizen) session.getAttribute("loggedInCitizen");
        if (loggedInCitizen == null) {
            return "redirect:/citizen/login";
        }

        complaint.setDateReported(new Date());
        complaint.setStatus("Open");
        complaint.setCitizen(loggedInCitizen);

        complaintDAO.saveComplaint(complaint);
        session.setAttribute("issueAdded", true);
        return "redirect:/citizen/dashboard";
    }

    // Show success page after submission
    @GetMapping("/success")
    public String showSuccessPage() {
        return "complaint/success";
    }

    // Edit complaint form
    @GetMapping("/edit/{id}")
    public String editComplaintForm(@PathVariable int id, Model model, HttpSession session) {
        Complaint complaint = complaintDAO.getComplaintById(id);
        Citizen citizen = (Citizen) session.getAttribute("loggedInCitizen");

        if (citizen == null || complaint == null || complaint.getCitizen().getId() != citizen.getId()) {
            return "redirect:/citizen/dashboard";
        }

        model.addAttribute("complaint", complaint);
        model.addAttribute("departments", departmentDAO.getAllDepartments());
        return "complaint/edit";
    }

    // Update complaint
    @PostMapping("/edit")
    public String updateComplaint(@ModelAttribute("complaint") Complaint updatedComplaint) {
        Complaint existing = complaintDAO.getComplaintById(updatedComplaint.getId());

        existing.setDescription(updatedComplaint.getDescription());
        existing.setLocation(updatedComplaint.getLocation());
        existing.setSeverity(updatedComplaint.getSeverity());
        existing.setDepartment(updatedComplaint.getDepartment());

        complaintDAO.saveComplaint(existing);
        return "redirect:/citizen/dashboard";
    }

    // Cancel complaint
    @GetMapping("/cancel/{id}")
    public String cancelComplaint(@PathVariable int id, HttpSession session) {
        Complaint complaint = complaintDAO.getComplaintById(id);
        Citizen citizen = (Citizen) session.getAttribute("loggedInCitizen");

        if (citizen != null && complaint != null && complaint.getCitizen().getId() == citizen.getId()) {
            complaint.setStatus("Cancelled");
            complaintDAO.saveComplaint(complaint);
        }

        return "redirect:/citizen/dashboard";
    }

    // View complaint details
    @GetMapping("/view/{id}")
    public String viewComplaint(@PathVariable int id, Model model, HttpSession session) {
        Complaint complaint = complaintDAO.getComplaintById(id);
        Citizen citizen = (Citizen) session.getAttribute("loggedInCitizen");

        if (citizen == null || complaint == null || complaint.getCitizen().getId() != citizen.getId()) {
            return "redirect:/citizen/dashboard";
        }

        model.addAttribute("complaint", complaint);
        return "complaint/view";
    }
}