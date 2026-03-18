<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body { background: #f4f6fb; padding: 30px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .card { border: none; border-radius: 15px; box-shadow: 0 5px 25px rgba(0,0,0,0.08); }
        .table thead { background: #4f46e5; color: white; }
        .table thead th { font-weight: 500; padding: 15px; }
        .product-item {
            font-size: 0.9rem;
            border-bottom: 1px dashed #dee2e6;
            padding: 8px 0;
            display: flex;
            justify-content: space-between;
        }
        .product-item:last-child { border-bottom: none; }
        .badge-status { padding: 6px 12px; border-radius: 20px; font-weight: 500; }
        .price-text { color: #dc3545; font-weight: 700; }
        .th-nowrap { white-space: nowrap; }
    </style>
</head>

<body>

<div class="container-fluid">
    <div class="card">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h4 class="mb-0 fw-bold text-primary">📦 Danh sách khách hàng & Đơn hàng</h4>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/admin/users"
                   class="btn btn-light border btn-sm">Trang chủ</a>
                <a href="${pageContext.request.contextPath}/admin/products"
                   class="btn btn-sm" style="background:#4f46e5;color:white">
                    Quản lý sản phẩm
                </a>
            </div>
        </div>

        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                    <tr>
                        <th width="80" class="th-nowrap">Mã đơn</th>
                        <th width="200">Khách hàng</th>
                        <th>Chi tiết sản phẩm / Số lượng</th>
                        <th width="150" class="text-end th-nowrap">Tổng thanh toán</th>
                        <th width="150" class="text-center th-nowrap">Phương thức</th>
                        <th width="130" class="text-center th-nowrap">Trạng thái</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${orders}" var="o">
                        <tr>
                            <td class="fw-bold text-muted">#${o.id}</td>

                            <td>
                                <div class="fw-bold">${o.user.fullname}</div>
                                <div class="text-muted small">📞 ${o.user.phone}</div>
                                <div class="text-muted small">📍 ${o.user.address}</div>
                            </td>

                            <td>
                                <c:forEach items="${o.items}" var="item">
                                    <div class="product-item">
                                        <span>
                                            <span class="badge bg-secondary me-2">${item.quantity}</span>
                                            <span class="fw-medium">${item.productName}</span>
                                        </span>
                                        <span class="text-muted">
                                            <fmt:formatNumber value="${item.price}" groupingUsed="true"/> ₫
                                        </span>
                                    </div>
                                </c:forEach>
                            </td>

                            <td class="text-end">
                                <span class="price-text">
                                    <fmt:formatNumber value="${o.total}" groupingUsed="true"/> ₫
                                </span>
                            </td>

                            <!-- ❗ FIX LỖI: KHÔNG DÙNG paymentMethod -->
                            <td class="text-center">
                                <span class="badge badge-status bg-info text-dark">
                                    COD
                                </span>
                            </td>

                            <td class="text-center">
                                <span class="badge badge-status bg-success-subtle text-success border border-success">
                                    Thành công
                                </span>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty orders}">
                        <tr>
                            <td colspan="6" class="text-center py-5">
                                <img src="https://cdn-icons-png.flaticon.com/512/4076/4076432.png"
                                     width="80" class="mb-3 opacity-50">
                                <p class="text-muted">Chưa có đơn hàng nào.</p>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>

                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>
