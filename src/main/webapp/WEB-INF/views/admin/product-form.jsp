<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="org.example.demo.entity.Product" %>

<%
    // Lấy đối tượng product từ request để kiểm tra là thêm mới hay chỉnh sửa
    Product product = (Product) request.getAttribute("product");
    boolean isEdit = (product != null && product.getId() != null);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><%= isEdit ? "Cập nhật sản phẩm" : "Thêm sản phẩm mới" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f4f6fb;
            padding-top: 60px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        /* Màu tím đồng bộ với Admin Dashboard */
        .card-header {
            background: #4f46e5;
            color: #fff;
            border-radius: 15px 15px 0 0 !important;
            padding: 20px;
            font-weight: 600;
        }

        .form-label {
            font-weight: 600;
            color: #444;
            margin-bottom: 8px;
        }

        .form-control {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #ddd;
        }

        .form-control:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 0.25rem rgba(79, 70, 229, 0.1);
        }

        .btn-save {
            background: #4f46e5;
            color: #fff;
            border-radius: 8px;
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-save:hover {
            background: #4338ca;
            color: #fff;
            transform: translateY(-1px);
        }

        .btn-cancel {
            border-radius: 8px;
            padding: 10px 25px;
        }

        .preview-img {
            max-width: 120px;
            border-radius: 10px;
            margin-top: 10px;
            border: 2px solid #eee;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">

            <div class="card">
                <div class="card-header text-center">
                    <h4 class="mb-0"><%= isEdit ? "Sửa sản phẩm #" + product.getId() : "Thêm sản phẩm mới" %></h4>
                </div>
                <div class="card-body p-4">

                    <%-- Lưu ý: enctype="multipart/form-data" là bắt buộc để upload file --%>
                    <form method="post" action="${pageContext.request.contextPath}/admin/products" enctype="multipart/form-data">

                        <% if (isEdit) { %>
                        <input type="hidden" name="id" value="<%= product.getId() %>">
                        <% } %>

                        <div class="mb-3">
                            <label class="form-label">Tên sản phẩm</label>
                            <input type="text" name="name" class="form-control"
                                   placeholder="Nhập tên sản phẩm..." required
                                   value="<%= isEdit ? product.getName() : "" %>">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Giá bán (VNĐ)</label>
                            <input type="number" name="price" class="form-control"
                                   placeholder="Ví dụ: 500000" required
                                   value="<%= isEdit ? product.getPrice() : "" %>">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Số lượng sản phẩm</label>
                            <input type="number" name="quantity" class="form-control"
                                   min="0"
                                   value="<%= isEdit ? product.getQuantity() : 0 %>">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mô tả sản phẩm</label>
                            <textarea name="description" class="form-control" rows="4"
                                      placeholder="Nhập mô tả chi tiết sản phẩm..."><%= isEdit ? product.getDescription() : "" %></textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Hình ảnh sản phẩm</label>
                            <input type="file" name="image" class="form-control" accept="image/*">

                            <% if (isEdit && product.getImage() != null && !product.getImage().isEmpty()) { %>
                            <div class="text-center mt-2">
                                <small class="text-muted d-block mb-1">Ảnh hiện tại:</small>
                                <img src="${pageContext.request.contextPath}/images/<%= product.getImage() %>"
                                     class="preview-img">
                            </div>
                            <% } %>
                        </div>

                        <div class="d-flex justify-content-between mt-4 gap-2">
                            <a href="${pageContext.request.contextPath}/admin/products"
                               class="btn btn-light border btn-cancel flex-grow-1">Hủy bỏ</a>

                            <button type="submit" class="btn btn-save flex-grow-1">
                                <%= isEdit ? "Lưu thay đổi" : "Tạo sản phẩm" %>
                            </button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>



</body>
</html>