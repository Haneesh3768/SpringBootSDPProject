<%@page import="com.klef.jfsd.springboot.model.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%

	Admin admin = (Admin) session.getAttribute("admin");

	if(admin==null)
	{
		response.sendRedirect("/admin/sessionexpiry");
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* Additional custom styles */
        .table-hover tbody tr:hover {
            background-color: rgba(0, 123, 255, 0.1);
        }
        .table-custom thead {
            background-color: #022356; /* Dark blue header */
            color: #f4f7f6;
        }
        .card-header {
            background-color: #022356 !important; /* Dark blue header for card */
            
        }
   
        .main-content {
            padding: 2rem;
            background-color: #f8f9fa;
        }

        header {
            background-color: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        header h1 {
    font-size: 24px;
    font-weight:bolder;
    color: #2c3e50;
    font-family: 'Poppins', sans-serif;
    
}

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-info span {
            color: #555;
            font-weight: 500;
        }

        .logout-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

       esponsive adjustments */
        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }

            header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .dashboard-cards {
                grid-template-columns: 1fr;
            }
        }
        

        .btn {
            padding: 4px 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn-profile {
            background-color: #0d6efd;
            color: white;
        }

        .btn-profile:hover {
            background-color: #0b5ed7;
        }

        .btn-interview {
            background-color: #28a745;
            color: white;
        }

        .btn-interview:hover {
            background-color: #218838;
        }

        .btn-reject {
            background-color: #dc3545;
            color: white;
        }

        .btn-reject:hover {
            background-color: #c82333;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-pending {
            background-color: #ffc107;
            color: #212529;
        }
        
        .status-interview {
            background-color: #262dc3;
            color: white;
        }

        .status-accepted {
            background-color: #28a745;
            color: white;
        }

        .status-rejected {
            background-color: #dc3545;
            color: white;
        }
        .status-shortlisted {
    background-color: #dcfce7;
    color: #166534;
}


* {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            line-height: 1.6;
        }

        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin: 20px;
        }

        .card-header {
            background-color: #022356;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }

        .card-header h4 {
            margin: 0;
            font-size: 1.2rem;
        }

        .header-controls {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .search-container {
            display: flex;
            align-items: center;
            background-color: rgba(255, 255, 255, 0.2);
            border-radius: 6px;
            overflow: hidden;
        }

        .search-icon {
            padding: 10px;
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .search-input {
            border: none;
            background: transparent;
            color: white;
            padding: 10px;
            width: 250px;
        }

        .search-input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .filter-button {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .filter-button:hover {
            background-color: rgba(255, 255, 255, 0.3);
        }

        .filter-dropdown {
            position: absolute;
            right: 20px;
            top: 100px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            width: 300px;
            padding: 20px;
            display: none;
            z-index: 1000;
        }

        .filter-dropdown.show {
            display: block;
        }

        .filter-group {
            margin-bottom: 15px;
        }

        .filter-label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        .filter-select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
        }

        .apply-filter-btn {
            width: 100%;
            padding: 10px;
            background-color: #022356;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .apply-filter-btn:hover {
            background-color: #0b3368;
        }

        .card-body {
            padding: 20px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table thead {
            background-color: #022356;
            color: white;
        }

        .table th,
        .table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table tbody tr:hover {
            background-color: rgba(13, 110, 253, 0.07);
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-pending {
            background-color: #ffc107;
            color: #212529;
        }

        .btn-group {
            display: flex;
            gap: 5px;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-primary {
            background-color: #0d6efd;
            color: white;
        }

        .btn-success {
            background-color: #28a745;
            color: white;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }

        .pagination {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            list-style: none;
        }

        .pagination .page-item {
            margin: 0 5px;
        }

        .pagination .page-link {
            text-decoration: none;
            color: #022356;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .pagination .page-item.active .page-link {
            background-color: #022356;
            color: white;
        }

        @media (max-width: 768px) {
            .card-header {
                flex-direction: column;
                gap: 10px;
            }

            .header-controls {
                width: 100%;
                justify-content: space-between;
            }

            .search-input {
                width: 100%;
            }
        }
         .btn {
            padding: 8px 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn-profile {
            background-color: #0d6efd;
            color: white;
        }

        .btn-profile:hover {
            background-color: #0b5ed7;
        }

        .btn-interview {
            background-color: #28a745;
            color: white;
        }

        .btn-interview:hover {
            background-color: #218838;
        }

        .btn-reject {
            background-color: #dc3545;
            color: white;
        }

        .btn-reject:hover {
            background-color: #c82333;
        }
        
           .main-content {
            background-color: #f4f7fa;
            padding: 2rem;
        }

        .student-management-card {
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
            border: none;
            transition: all 0.3s ease;
        }

        .student-management-card:hover {
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
            transform: translateY(-5px);
        }

        .card-header-custom {
            background: linear-gradient(135deg, #022356 0%, #0d47a1 100%);
            color: white;
            padding: 1.25rem 1.5rem;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header-custom h4 {
            margin: 0;
            font-weight: 600;
            font-size: 1.2rem;
        }

        .search-filter-container {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .search-container-professional {
            position: relative;
            flex-grow: 1;
        }

        .search-container-professional input {
            width: 100%;
            padding: 0.5rem 1rem 0.5rem 2.5rem;
            border: 1px solid #e0e4e8;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .search-container-professional .search-icon {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        .table-professional {
            margin-bottom: 0;
        }

        .table-professional thead {
            background-color: #f8f9fa;
            border-bottom: 2px solid #e9ecef;
        }

        .table-professional thead th {
            color: #495057;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            padding: 1rem;
            vertical-align: middle;
        }

        .table-professional tbody td {
            padding: 1rem;
            vertical-align: middle;
            color: #495057;
        }

        .table-professional tbody tr {
            transition: background-color 0.3s ease;
        }

        .table-professional tbody tr:hover {
            background-color: rgba(13, 110, 253, 0.05);
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 35px;
            height: 35px;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .status-badge-professional {
            display: inline-block;
            padding: 0.35rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-registered {
            background-color: #e6f3ff;
            color: #0d6efd;
        }

        .status-blocked {
            background-color: #fff0f0;
            color: #dc3545;
        }

        @media (max-width: 768px) {
            .search-filter-container {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
        		
        
    </style>
    <script src="JavaScript/dashboard.js" defer></script>
</head>
<body>
<script src="${pageContext.request.contextPath}/JavaScript/dashboard.js"></script>
    <div class="sidebar-container">
        <!-- Menu Icon (Hamburger) -->
        <div class="menu-icon">
            <i class="fas fa-bars" onclick="toggleSidebar()"></i>
        </div>

        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header"><br><br>
                <h2>Hello Admin</h2>
            </div>
            <ul>
                <li><a href="dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-btn" onclick="toggleDropdown('students')">
                        <i class="fas fa-users"></i> Manage Students
                        <span class="arrow">&#9662;</span>
                    </a>
                    <ul class="dropdown-content" id="students-dropdown">
                        <li><a href="viewstudents"><i class="fas fa-eye"></i> View Students</a></li>
                        <li><a href="addstudent"><i class="fas fa-user-edit"></i> Add Student</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-btn" onclick="toggleDropdown('employers')">
                        <i class="fas fa-building"></i> Manage Employers
                        <span class="arrow">&#9662;</span>
                    </a>
                    <ul class="dropdown-content" id="employers-dropdown">
                        
                        <li><a href="getpendingrecruiters"><i class="fas fa-user-edit"></i>Validate Employer</a></li>
                    </ul>
                </li>
                <li><a href="jobpostings"><i class="fas fa-briefcase"></i> Job Postings</a></li>
                
            </ul>
        </div>
    </div>

    <div class="main-content" id="mainContent">
        <header>
            <h1>CareerStream</h1>
            <div class="user-info">
                <span><%= session.getAttribute("adminName") != null ? session.getAttribute("adminName") : "Admin" %></span>
                <button class="logout-btn" onclick="window.location.href='/admin/logout'">Logout</button>
            </div>
        </header>

        <div class="card student-management-card">
            <div class="card-header-custom">
                <h4>Student Management</h4>
                <div class="search-filter-container">
                    <div class="search-container-professional">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" id="searchInput" placeholder="Search students...">
                    </div>
                    <div class="dropdown">
                        <button class="btn btn-outline-light dropdown-toggle" type="button" id="filterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-filter"></i> Filter
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="filterDropdown">
                            <li><a class="dropdown-item" href="#" data-status="Registered">Registered</a></li>
                            <li><a class="dropdown-item" href="#" data-status="Blocked">Blocked</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-professional mb-0">
                        <thead>
                            <tr>
                                <th>Student ID</th>
                                <th>Name</th>
                                <th>Gender</th>
                                <th>Email</th>
                                <th>Contact</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${studentlist}" var="student">
                                <tr>
                                    <td>${student.id}</td>
                                    <td>${student.name}</td>
                                    <td>${student.gender}</td>
                                    <td>${student.email}</td>
                                    <td>${student.contact}</td>
                                    <td>
                                        <span class="status-badge-professional 
                                            ${student.status == 'Registered' ? 'status-registered' : 'status-blocked'}">
                                            ${student.status}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn btn-sm btn-outline-success action-btn" 
                                                onclick="window.location.href='/admin/setstudentstatus/${student.id}/Registered'">
                                                <i class="fas fa-check"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger action-btn" 
                                                onclick="window.location.href='/admin/setstudentstatus/${student.id}/Blocked'">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            const rows = document.querySelectorAll('.table-professional tbody tr');
            const filterItems = document.querySelectorAll('.dropdown-menu .dropdown-item');

            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                rows.forEach(row => {
                    const rowText = row.textContent.toLowerCase();
                    row.style.display = rowText.includes(searchTerm) ? '' : 'none';
                });
            });

            filterItems.forEach(item => {
                item.addEventListener('click', function() {
                    const status = this.getAttribute('data-status');
                    rows.forEach(row => {
                        const statusCell = row.querySelector('.status-badge-professional');
                        row.style.display = statusCell.textContent.includes(status) ? '' : 'none';
                    });
                });
            });
        });
    </script>
</body>
</html>