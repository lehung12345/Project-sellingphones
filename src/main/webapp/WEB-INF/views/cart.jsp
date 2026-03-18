<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:if test="${not empty param.lang}">
    <c:set var="lang" value="${param.lang}" scope="session"/>
</c:if>

<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'vi'}"/>
<fmt:setBundle basename="i18n.messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'vi'}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key="cart.title"/></title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body { background: #f5f6f8; }
        .cart-box {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,.05);
        }
        .qty-box {
            background: #f1f3f5;
            border-radius: 30px;
            padding: 6px 14px;
            display: inline-flex;
            align-items: center;
            gap: 14px;
            font-weight: 600;
        }
        .qty-box a {
            text-decoration: none;
            color: #000;
            font-size: 18px;
            width: 24px;
            text-align: center;
        }
        .remove-link {
            color: red;
            font-size: 14px;
            text-decoration: none;
        }
        .remove-link:hover { text-decoration: underline; }
        .checkout-btn {
            background: #111;
            color: #fff;
            border-radius: 25px;
            padding: 8px 28px;
            text-decoration: none;
        }
        .checkout-btn:hover { background: #000; }
        .continue-link {
            text-decoration: none;
            color: #555;
        }
        .continue-link:hover { text-decoration: underline; }
    </style>
</head>

<body>
<div class="container py-5">
    <div class="cart-box p-4">

        <h4 class="fw-bold mb-4">
            <fmt:message key="cart.header"/>
        </h4>

        <c:choose>

            <c:when test="${not empty cart}">
                <table class="table align-middle">
                    <thead class="border-bottom">
                    <tr class="text-uppercase small text-muted">
                        <th><fmt:message key="cart.product"/></th>
                        <th><fmt:message key="cart.price"/></th>
                        <th class="text-center"><fmt:message key="cart.quantity"/></th>
                        <th class="text-end"><fmt:message key="cart.total"/></th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${cart}" var="item">
                        <tr>
                            <td>
                                <div class="fw-semibold">${item.product.name}</div>
                                <a href="${pageContext.request.contextPath}/cart/remove/${item.product.id}"
                                   class="remove-link">
                                    <fmt:message key="cart.delete"/>
                                </a>
                            </td>

                            <td>
                                <fmt:formatNumber value="${item.product.price}" type="number"/>đ
                            </td>

                            <td class="text-center">
                                <div class="qty-box">
                                    <a href="${pageContext.request.contextPath}/cart/decrease/${item.product.id}">−</a>
                                    <span>${item.quantity}</span>
                                    <a href="${pageContext.request.contextPath}/cart/increase/${item.product.id}">+</a>
                                </div>
                            </td>

                            <td class="text-end fw-bold">
                                <fmt:formatNumber
                                        value="${item.product.price * item.quantity}"
                                        type="number"/>đ
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="d-flex justify-content-between align-items-center mt-4">
                    <a href="${pageContext.request.contextPath}/products" class="continue-link">
                        ← <fmt:message key="cart.continue"/>
                    </a>

                    <div class="d-flex align-items-center gap-4">
                        <div class="fw-bold">
                            <fmt:message key="cart.grand_total"/>
                            <span class="text-danger fs-5">
                                <fmt:formatNumber value="${total}" type="number"/>đ
                            </span>
                        </div>

                        <a href="${pageContext.request.contextPath}/checkout" class="checkout-btn">
                            <fmt:message key="cart.checkout"/>
                        </a>
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <div class="py-4">
                    <p class="text-muted text-center">
                        <fmt:message key="cart.empty"/>
                    </p>
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/products" class="continue-link">
                            ← <fmt:message key="cart.continue"/>
                        </a>
                    </div>
                </div>
            </c:otherwise>

        </c:choose>

    </div>
</div>
</body>
</html>
