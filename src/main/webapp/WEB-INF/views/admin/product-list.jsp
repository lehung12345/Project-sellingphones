<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.demo.entity.Product" %>

<%
  // Lấy danh sách sản phẩm từ request attribute do Controller gửi sang
  List<Product> products = (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý sản phẩm</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: #f4f6fb;
      padding: 30px;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    h2 { color: #4f46e5; font-weight: 700; }

    .table-container {
      background: #fff;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 10px 25px rgba(0,0,0,0.08);
      margin-top: 20px;
    }

    /* Tùy chỉnh Header bảng */
    .table thead th {
      background: #4f46e5;
      color: #fff;
      border: none;
      padding: 15px;
      font-weight: 500;
    }

    /* Nút màu tím theo style của bạn */
    .btn-purple {
      background: #4f46e5;
      color: #fff;
      border-radius: 8px;
      text-decoration: none;
      transition: all 0.3s;
      display: inline-flex;
      align-items: center;
      gap: 5px;
    }
    .btn-purple:hover {
      background: #4338ca;
      color: #fff;
      transform: translateY(-1px);
    }

    .product-img {
      width: 60px;
      height: 60px;
      object-fit: cover;
      border-radius: 8px;
      border: 1px solid #eee;
    }

    .btn-sm { border-radius: 6px; padding: 5px 12px; }
  </style>
</head>
<body>

<div class="container-fluid">

  <div class="d-flex justify-content-between align-items-center mb-3">
    <div class="d-flex align-items-center gap-3">
      <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary btn-sm">
        ⬅ Quay lại
      </a>
      <h2 class="m-0">Quản lý sản phẩm</h2>
    </div>

    <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn-purple px-4 py-2">
      ➕ Thêm sản phẩm
    </a>
  </div>

  <div class="table-container">
    <table class="table table-hover align-middle mb-0">
      <thead>
      <tr>
        <th width="100">ID</th>
        <th>Tên sản phẩm</th>
        <th width="150">Giá bán</th>
        <th width="120">Hình ảnh</th>
        <th width="200" class="text-center">Thao tác</th>
      </tr>
      </thead>
      <tbody>
      <% if (products == null || products.isEmpty()) { %>
      <tr>
        <td colspan="5" class="text-center text-muted py-5">
          <img src="https://cdn-icons-png.flaticon.com/512/4076/4076432.png" width="80" style="opacity: 0.5; margin-bottom: 10px;"><br>
          Chưa có sản phẩm nào trong hệ thống
        </td>
      </tr>
      <% } else {
        for (Product p : products) { %>
      <tr>
        <td class="text-muted">#<%= p.getId() %></td>
        <td>
          <span class="fw-bold" style="color: #333;"><%= p.getName() %></span>
        </td>
        <td>
                        <span class="text-danger fw-bold">
                            <%= String.format("%,d", p.getPrice()) %> đ
                        </span>
        </td>
        <td>
          <% if (p.getImage() != null && !p.getImage().isEmpty()) { %>
          <img src="${pageContext.request.contextPath}/images/<%= p.getImage() %>" class="product-img">
          <% } else { %>
          <div class="product-img bg-light d-flex align-items-center justify-content-center text-muted" style="font-size: 10px;">No img</div>
          <% } %>
        </td>
        <td class="text-center">
          <div class="d-flex justify-content-center gap-2">
            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=<%= p.getId() %>"
               class="btn btn-success btn-sm px-3">
              Sửa
            </a>
            <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=<%= p.getId() %>"
               class="btn btn-danger btn-sm px-3"
               onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')">
              Xóa
            </a>
          </div>
        </td>
      </tr>
      <% }} %>
      </tbody>
    </table>
  </div>

</div>



</body>
</html>