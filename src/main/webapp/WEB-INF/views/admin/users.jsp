<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<style>
    body {
        font-family: "Segoe UI", sans-serif;
        background: #f4f6fb;
        padding: 30px;
    }

    h1 {
        color: #4f46e5;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background: #fff;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 10px 25px rgba(0,0,0,.1);
    }

    th, td {
        padding: 12px 15px;
        text-align: left;
    }

    th {
        background: #4f46e5;
        color: #fff;
    }

    tr:nth-child(even) {
        background: #f8f9ff;
    }

    .btn {
        padding: 6px 12px;
        border-radius: 6px;
        border: none;
        cursor: pointer;
    }

    .btn-edit {
        background: #22c55e;
        color: #fff;
    }

    .btn-delete {
        background: #ef4444;
        color: #fff;
    }

    .btn-nav {
        background: #4f46e5; /* Màu tím trùng với header bảng */
        color: white;
        text-decoration: none;
        padding: 10px 20px;
        border-radius: 8px;
        font-weight: 600;
        transition: background 0.3s;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }

    .btn-nav:hover {
        background: #4338ca;
        color: white;
    }
</style>

<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
    <h1 style="margin: 0;">Quản lý người dùng</h1>

    <div style="display: flex; gap: 10px;">
        <a href="${pageContext.request.contextPath}/admin/orders" class="btn-nav">
            📦 Đơn hàng
        </a>
        <a href="${pageContext.request.contextPath}/admin/products" class="btn-nav">
            📦 Quản lý sản phẩm
        </a>
        <a href="${pageContext.request.contextPath}/admin/login" class="btn-nav">
            Đăng xuất
        </a>
    </div>
</div>

<table>
    <tr>
        <th>ID</th>
        <th>Họ tên</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Action</th>
    </tr>

    <c:forEach items="${users}" var="u">
        <tr>
            <td>${u.id}</td>
            <td>${u.fullname}</td>
            <td>${u.email}</td>
            <td>${u.phone}</td>
            <td style="display:flex;gap:5px;">
                <!-- EDIT -->
                <form method="get"
                      action="${pageContext.request.contextPath}/admin/users">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" value="${u.id}">
                    <button type="submit" class="btn btn-edit">Sửa</button>
                </form>

                <!-- DELETE -->
                <form method="post"
                      action="${pageContext.request.contextPath}/admin/users"
                      onsubmit="return confirm('Xóa user này?')">

                    <input type="hidden" name="id" value="${u.id}">
                    <input type="hidden" name="action" value="delete">
                    <button type="submit" class="btn btn-delete">Xóa</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
