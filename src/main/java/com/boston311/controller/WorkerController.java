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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/worker")
public class WorkerController {

    @Autowired
    private WorkerDAO workerDAO;

    @Autowired
    private DepartmentDAO departmentDAO;

    @Autowired
    private ComplaintDAO complaintDAO;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // Show worker registration form
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("worker", new Worker());
        model.addAttribute("departments", departmentDAO.getAllDepartments());
        return "worker/register";
    }

    // Process worker registration
    @PostMapping("/register")
    public String registerWorker(@ModelAttribute("worker") @Valid Worker worker,
                                 BindingResult result,
                                 Model model) {
        if (result.hasErrors()) {
            model.addAttribute("departments", departmentDAO.getAllDepartments());
            return "worker/register";
        }

        worker.setPassword(passwordEncoder.encode(worker.getPassword()));
        workerDAO.saveWorker(worker);
        return "redirect:/worker/login";
    }

    // Show login form
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("worker", new Worker());
        return "worker/login";
    }

    // Process login
    @PostMapping("/login")
    public String loginWorker(@ModelAttribute("worker") @Valid Worker worker,
                              BindingResult result,
                              HttpSession session,
                              Model model) {
        if (result.hasErrors()) {
            return "worker/login";
        }

        Worker dbWorker = workerDAO.getWorkerByEmail(worker.getEmail());
        if (dbWorker != null && passwordEncoder.matches(worker.getPassword(), dbWorker.getPassword())) {
            session.setAttribute("workerId", dbWorker.getId());
            session.setAttribute("workerName", dbWorker.getName());
            return "redirect:/worker/dashboard";
        }

        model.addAttribute("error", "Invalid email or password.");
        return "worker/login";
    }

    // Dashboard view
    @GetMapping("/dashboard")
    public String showDashboard(@RequestParam(value = "status", required = false) String status,
                                @RequestParam(value = "keyword", required = false) String keyword,
                                HttpSession session, Model model) {
        Integer workerId = (Integer) session.getAttribute("workerId");
        String workerName = (String) session.getAttribute("workerName");

        if (workerId == null) {
            return "redirect:/worker/login";
        }

        List<Complaint> all = complaintDAO.getAllComplaints();
        List<Complaint> complaints = all.stream()
                .filter(c -> c.getAssignedWorker() != null && c.getAssignedWorker().getId() == workerId)
                .filter(c -> (status == null || status.isEmpty() || c.getStatus().equalsIgnoreCase(status)))
                .filter(c -> (keyword == null || keyword.isEmpty() ||
                        c.getDescription().toLowerCase().contains(keyword.toLowerCase()) ||
                        c.getLocation().toLowerCase().contains(keyword.toLowerCase())))
                .toList();

        model.addAttribute("complaints", complaints);
        model.addAttribute("workerName", workerName);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("searchKeyword", keyword);

        return "worker/dashboard";
    }

    // Update complaint status (e.g., Resolved/In Progress)
    @PostMapping("/updateStatus")
    public String updateComplaintStatus(@RequestParam("complaintId") int complaintId,
                                        @RequestParam("status") String status) {
        complaintDAO.updateStatus(complaintId, status);
        return "redirect:/worker/dashboard";
    }

    @GetMapping("/resolve/{id}")
    public String resolveComplaint(@PathVariable("id") int complaintId, HttpSession session) {
        Integer workerId = (Integer) session.getAttribute("workerId");
        if (workerId == null) {
            return "redirect:/worker/login";
        }

        complaintDAO.updateStatus(complaintId, "Resolved");
        return "redirect:/worker/dashboard";
    }

    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        Integer workerId = (Integer) session.getAttribute("workerId");
        if (workerId == null) return "redirect:/worker/login";

        Worker worker = workerDAO.getWorkerById(workerId);
        model.addAttribute("worker", worker);
        model.addAttribute("departments", departmentDAO.getAllDepartments());
        return "worker/profile";
    }

    @PostMapping("/profile")
    public String updateProfile(@ModelAttribute("worker") @Valid Worker worker,
                                BindingResult result,
                                HttpSession session,
                                Model model,
                                RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            model.addAttribute("departments", departmentDAO.getAllDepartments());
            return "worker/profile";
        }

        Worker existing = workerDAO.getWorkerById(worker.getId());
        worker.setEmail(existing.getEmail());
        worker.setPassword(existing.getPassword());

        worker.setDepartment(departmentDAO.getDepartmentById(worker.getDepartment().getId()));
        workerDAO.updateWorker(worker);

        session.setAttribute("workerName", worker.getName());
        redirectAttributes.addFlashAttribute("profileUpdated", true);

        return "redirect:/worker/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}