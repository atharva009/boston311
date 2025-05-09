package com.boston311.controller;

import com.boston311.dao.ComplaintDAO;
import com.boston311.dao.DepartmentDAO;
import com.boston311.dao.WorkerDAO;
import com.boston311.model.Complaint;
import com.boston311.model.Department;
import com.boston311.model.Worker;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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

    @Autowired
    private PasswordEncoder passwordEncoder;

    // Show registration form
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("department", new Department());
        return "department/register";
    }

    // Process registration with validation and hashed password
    @PostMapping("/register")
    public String registerDepartment(@ModelAttribute("department") @Valid Department department,
                                     BindingResult result,
                                     Model model) {
        if (result.hasErrors()) {
            return "department/register";
        }

        department.setPassword(passwordEncoder.encode(department.getPassword()));
        departmentDAO.saveDepartment(department);
        return "redirect:/department/login";
    }

    // Show login form
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("department", new Department());
        return "department/login";
    }

    // Process login with hashed password validation
    @PostMapping("/login")
    public String loginDepartment(@ModelAttribute("department") @Valid Department department,
                                  BindingResult result,
                                  HttpSession session,
                                  Model model) {
        if (result.hasErrors()) {
            return "department/login";
        }

        Department existing = departmentDAO.getDepartmentByEmail(department.getEmail());

        if (existing != null && passwordEncoder.matches(department.getPassword(), existing.getPassword())) {
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

        long openCount = complaints.stream().filter(c -> "Open".equalsIgnoreCase(c.getStatus())).count();
        long inProgressCount = complaints.stream().filter(c -> "In Progress".equalsIgnoreCase(c.getStatus())).count();
        long resolvedCount = complaints.stream().filter(c -> "Resolved".equalsIgnoreCase(c.getStatus())).count();

        model.addAttribute("complaints", complaints);
        model.addAttribute("workers", workers);
        model.addAttribute("departmentName", session.getAttribute("departmentName"));
        model.addAttribute("openCount", openCount);
        model.addAttribute("inProgressCount", inProgressCount);
        model.addAttribute("resolvedCount", resolvedCount);

        return "department/dashboard";
    }

    // Assign worker to a complaint
    @PostMapping("/assign")
    public String assignWorkerToComplaint(@RequestParam("complaintId") int complaintId,
                                          @RequestParam("workerId") int workerId,
                                          HttpSession session) {
        Integer deptId = (Integer) session.getAttribute("departmentId");
        if (deptId == null) {
            return "redirect:/department/login";
        }

        complaintDAO.assignWorker(complaintId, workerId);
        complaintDAO.updateStatus(complaintId, "In Progress");

        return "redirect:/department/dashboard";
    }

    // Logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}