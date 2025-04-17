package com.boston311.controller;

import com.boston311.dao.ComplaintDAO;
import com.boston311.dao.DepartmentDAO;
import com.boston311.dao.WorkerDAO;
import com.boston311.model.Complaint;
import com.boston311.model.Department;
import com.boston311.model.Worker;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/department")
public class DepartmentController {

    @Autowired
    private DepartmentDAO departmentDAO;

    @Autowired
    private ComplaintDAO complaintDAO;

    @Autowired
    private WorkerDAO workerDAO;

    // Show registration form
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("department", new Department());
        return "department/register";
    }

    // Process registration
    @PostMapping("/register")
    public String registerDepartment(@ModelAttribute Department department) {
        departmentDAO.saveDepartment(department);
        return "redirect:/department/login";
    }

    // Show login form
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("department", new Department());
        return "department/login";
    }

    // Process login
    @PostMapping("/login")
    public String loginDepartment(@ModelAttribute Department department, HttpSession session, Model model) {
        Department existing = departmentDAO.getDepartmentByEmail(department.getEmail());

        if (existing != null && existing.getPassword().equals(department.getPassword())) {
            session.setAttribute("departmentId", existing.getId());
            session.setAttribute("departmentName", existing.getName());
            return "redirect:/department/dashboard";
        }

        model.addAttribute("error", "Invalid credentials. Please try again.");
        return "department/login";
    }

    // Show department dashboard
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        Integer deptId = (Integer) session.getAttribute("departmentId");
        if (deptId == null) {
            return "redirect:/department/login";
        }

        List<Complaint> complaints = complaintDAO.getByDepartmentId(deptId);
        List<Worker> workers = workerDAO.getWorkersByDepartment(deptId);

        model.addAttribute("complaints", complaints);
        model.addAttribute("workers", workers);
        model.addAttribute("departmentName", session.getAttribute("departmentName"));

        return "department/dashboard";
    }

    // Logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}