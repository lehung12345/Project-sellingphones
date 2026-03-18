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
        <fmt:message key="checkout.title"/>
    </title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f5f6f8;
            color: #333;
        }
        .checkout-container {
            margin: 50px 0;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,.05);
        }
        .card-title {
            font-weight: 700;
            border-bottom: 2px solid #eee;
            padding-bottom: 12px;
            margin-bottom: 20px;
        }
        .total-price {
            font-size: 1.5rem;
            color: #dc3545;
            font-weight: 800;
        }
        .payment label {
            display: block;
            padding: 12px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 10px;
            cursor: pointer;
        }
        .payment input:checked + span {
            font-weight: 600;
            color: #0d6efd;
        }
        .btn-confirm {
            background: #0d6efd;
            border-radius: 8px;
            padding: 12px;
            font-weight: 600;
        }
    </style>
</head>

<body>

<div class="container checkout-container">

    <!-- HEADER -->
    <h2 class="text-center fw-bold mb-5">
        <fmt:message key="checkout.header"/>
    </h2>

    <c:choose>

        <c:when test="${empty cart}">
            <div class="text-center text-muted">
                <p>
                    <fmt:message key="checkout.cart_empty"/>
                </p>
                <a href="${pageContext.request.contextPath}/products"
                   class="btn btn-outline-primary mt-3">
                    <fmt:message key="checkout.back_shop"/>
                </a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="row g-4">

                <!-- LEFT -->
                <div class="col-lg-5">
                    <div class="card h-100">
                        <div class="card-body p-4">

                            <h4 class="card-title">
                                <fmt:message key="checkout.shipping_info"/>
                            </h4>

                            <div class="mb-3">
                                <small class="text-muted">
                                    <fmt:message key="checkout.fullname"/>
                                </small>
                                <div class="fw-semibold">${user.fullname}</div>
                            </div>

                            <div class="mb-3">
                                <small class="text-muted">
                                    <fmt:message key="checkout.email"/>
                                </small>
                                <div class="fw-semibold">${user.email}</div>
                            </div>

                            <div class="mb-3">
                                <small class="text-muted">
                                    <fmt:message key="checkout.phone"/>
                                </small>
                                <div class="fw-semibold">${user.phone}</div>
                            </div>

                            <div class="mb-3">
                                <small class="text-muted">
                                    <fmt:message key="checkout.address"/>
                                </small>
                                <div class="fw-semibold">${user.address}</div>
                            </div>

                            <hr class="my-4">

                            <h4 class="card-title">
                                <fmt:message key="checkout.payment_method"/>
                            </h4>

                            <form method="post"
                                  action="${pageContext.request.contextPath}/checkout/submit"
                                  class="payment">

                                <!-- REQUIRED -->
                                <input type="hidden" name="fullName" value="${user.fullname}">
                                <input type="hidden" name="phone" value="${user.phone}">
                                <input type="hidden" name="address" value="${user.address}">

                                <label>
                                    <input type="radio" name="paymentMethod" value="COD" checked>
                                    <span class="ms-2">
                                        <fmt:message key="checkout.cod"/>
                                    </span>
                                </label>

                                <label>
                                    <input type="radio" name="paymentMethod" value="PAYPAL">
                                    <span class="ms-2">
                                        <fmt:message key="checkout.paypal"/>
                                    </span>
                                </label>

                                <button type="submit"
                                        class="btn btn-primary btn-confirm w-100 mt-4">
                                        <c:if test="${outOfStock}">disabled</c:if>>
                                    <fmt:message key="checkout.confirm"/>
                                </button>
                            </form>

                        </div>
                    </div>
                </div>

                <!-- RIGHT -->
                <div class="col-lg-7">
                    <div class="card">
                        <div class="card-body p-4">

                            <h4 class="card-title">
                                <fmt:message key="cart.header"/>
                            </h4>

                            <table class="table align-middle">
                                <thead>
                                <tr>
                                    <th>
                                        <fmt:message key="cart.product"/>
                                    </th>
                                    <th class="text-center">
                                        <fmt:message key="cart.quantity"/>
                                    </th>
                                    <th class="text-end">
                                        <fmt:message key="cart.total"/>
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${cart}" var="item">
                                    <tr>
                                        <td>
                                            <div class="fw-bold">
                                                ${item.product.name}
                                            </div>

                                            <c:if test="${item.product.quantity < item.quantity}">
                                                <div style="color:red; font-size:13px;">
                                                    Không đủ hàng (còn ${item.product.quantity})
                                                </div>
                                            </c:if>

                                            <small class="text-muted">
                                                <fmt:formatNumber
                                                        value="${item.product.price}"
                                                        type="number"/> ₫
                                            </small>
                                        </td>
                                        <td class="text-center">
                                            x${item.quantity}
                                        </td>
                                        <td class="text-end fw-bold">
                                            <fmt:formatNumber
                                                    value="${item.product.price * item.quantity}"
                                                    type="number"/> ₫
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <div class="d-flex justify-content-between align-items-center
                                        mt-4 p-3 bg-light rounded">
                                <span class="fw-bold">
                                    <fmt:message key="cart.grand_total"/>
                                </span>
                                <span class="total-price">
                                    <fmt:formatNumber value="${total}" type="number"/> ₫
                                </span>
                            </div>

                        </div>
                    </div>

                    <div class="mt-3 text-end">
                        <a href="${pageContext.request.contextPath}/cart"
                           class="text-muted text-decoration-none small">
                            ← <fmt:message key="checkout.edit_cart"/>
                        </a>
                    </div>
                </div>

            </div>
        </c:otherwise>

    </c:choose>

</div>

</body>
</html>
