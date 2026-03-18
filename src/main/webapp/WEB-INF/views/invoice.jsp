<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- ===== LANGUAGE ===== -->
<c:if test="${not empty param.lang}">
    <c:set var="lang" value="${param.lang}" scope="session"/>
</c:if>

<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'vi'}"/>
<fmt:setBundle basename="i18n.messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'vi'}">
<head>
    <meta charset="UTF-8">

    <title>
        <fmt:message key="invoice.title"/> - #${order.id}
    </title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f6f7fb;
            padding: 50px 0;
        }
        .invoice-wrapper {
            max-width: 900px;
            margin: auto;
            background: #fff;
            border-radius: 14px;
            padding: 40px;
            box-shadow: 0 12px 30px rgba(0,0,0,.08);
        }
        .invoice-title {
            font-size: 26px;
            font-weight: 800;
            color: #2563eb;
            letter-spacing: 1px;
        }
        .divider {
            height: 1px;
            background: #e5e7eb;
            margin: 25px 0;
        }
        table thead th {
            border-bottom: 2px solid #e5e7eb;
            font-weight: 600;
        }
        table tbody td {
            border-top: 1px solid #f1f5f9;
        }
        .total-box {
            border: 1px dashed #d1d5db;
            border-radius: 10px;
            padding: 25px;
            width: 100%;
        }
        @media print {
            .no-print { display: none; }
            body { background: white; }
        }
    </style>
</head>

<body>

<div class="invoice-wrapper">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-start">
        <div>
            <div class="invoice-title">
                <fmt:message key="invoice.header"/>
            </div>
            <div class="text-muted">
                <fmt:message key="invoice.order_id"/>:
                <strong>#${order.id}</strong>
            </div>
        </div>
        <div class="text-end">
            <h5 class="fw-bold mb-0">GearShop</h5>
            <small class="text-muted">Hanoi, Vietnam</small>
        </div>
    </div>

    <div class="divider"></div>

    <!-- SHIPPING INFO -->
    <div class="row mb-4">
        <div class="col-md-6">
            <h6 class="text-uppercase text-muted">
                <fmt:message key="checkout.shipping_info"/>
            </h6>
            <p class="fw-bold mb-1">${order.fullName}</p>
            <p class="mb-1 text-muted">📧 ${order.email}</p>
            <p class="mb-0 text-muted">📞 ${order.phone}</p>
        </div>

        <div class="col-md-6 text-md-end">
            <h6 class="text-uppercase text-muted">
                <fmt:message key="checkout.address"/>
            </h6>
            <p class="text-muted mb-1">${order.address}</p>
            <p class="mb-0">
                <strong>
                    <fmt:message key="checkout.payment_method"/>:
                </strong>
                <span class="badge bg-info text-dark">COD</span>
            </p>
        </div>
    </div>

    <!-- PRODUCT TABLE -->
    <table class="table align-middle">
        <thead>
        <tr>
            <th style="width:5%">#</th>
            <th>
                <fmt:message key="cart.product"/>
            </th>
            <th class="text-center">
                <fmt:message key="cart.quantity"/>
            </th>
            <th class="text-end">
                <fmt:message key="cart.price"/>
            </th>
            <th class="text-end">
                <fmt:message key="cart.total"/>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${order.items}" var="i" varStatus="st">
            <tr>
                <td>${st.index + 1}</td>
                <td class="fw-semibold">${i.productName}</td>
                <td class="text-center">${i.quantity}</td>
                <td class="text-end">
                    <fmt:formatNumber value="${i.price}" type="number"/> ₫
                </td>
                <td class="text-end fw-bold">
                    <fmt:formatNumber value="${i.price * i.quantity}" type="number"/> ₫
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- TOTAL -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="total-box">

                <div class="d-flex justify-content-between mb-2">
                    <span class="text-muted">
                        <fmt:message key="invoice.subtotal"/>
                    </span>
                    <span class="fw-semibold">
                        <fmt:formatNumber value="${order.total}" type="number"/> ₫
                    </span>
                </div>

                <div class="d-flex justify-content-between mb-3">
                    <span class="text-muted">
                        <fmt:message key="invoice.shipping_fee"/>
                    </span>
                    <span class="text-success fw-bold">
                        <fmt:message key="invoice.free"/>
                    </span>
                </div>

                <hr>

                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="fw-bold mb-0">
                        <fmt:message key="cart.grand_total"/>
                    </h5>
                    <h3 class="fw-bold text-danger mb-0">
                        <fmt:formatNumber value="${order.total}" type="number"/> ₫
                    </h3>
                </div>
            </div>
        </div>
    </div>

    <!-- ACTION -->
    <div class="d-flex justify-content-between mt-4 no-print">
        <a href="${pageContext.request.contextPath}/products"
           class="btn btn-outline-secondary">
            ← <fmt:message key="cart.continue"/>
        </a>
        <button onclick="window.print()" class="btn btn-primary">
            🖨 <fmt:message key="invoice.print"/>
        </button>
    </div>

    <p class="text-center mt-4 text-muted small">
        <fmt:message key="invoice.thanks"/>
    </p>

</div>

</body>
</html>
