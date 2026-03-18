<%@ page contentType="text/html; charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- ===== LANGUAGE ===== -->
<c:if test="${not empty param.lang}">
    <c:set var="lang" value="${param.lang}" scope="session"/>
</c:if>

<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'vi'}"/>
<fmt:setBundle basename="i18n.messages"/>

<!-- ===== AUTH CHECK ===== -->
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/login"/>
</c:if>

<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'vi'}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key="product.title"/></title>

    <!-- Tailwind -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #ffffff;
            min-height: 100vh;
            color: #111;
        }
        .glass-card {
            background: rgba(255, 255, 255, 0.75);
            backdrop-filter: blur(14px);
            border: 1px solid rgba(0, 0, 0, 0.08);
            border-radius: 20px;
            transition: all .35s;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .glass-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        .product-image {
            height: 220px;
            object-fit: contain;
            padding: 20px;
            transition: transform .4s;
        }
        .glass-card:hover .product-image {
            transform: scale(1.1);
        }
        .btn-buy {
            background: linear-gradient(90deg, #8b5cf6, #a78bfa);
            border-radius: 12px;
            font-weight: 600;
            padding: 10px;
            text-align: center;
            transition: .3s;
            color: white;
        }
        .btn-buy:hover {
            box-shadow: 0 8px 20px rgba(139, 92, 246, 0.45);
        }
        .badge-hot {
            position: absolute;
            top: 15px;
            left: 15px;
            background: rgba(0,0,0,.05);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            border: 1px solid rgba(0,0,0,.08);
        }
    </style>
</head>

<body class="px-6 py-8">

<!-- ===== HEADER ===== -->
<div class="max-w-7xl mx-auto mb-10 flex justify-between items-center">

    <div>
        👋 <fmt:message key="product.hello"/>
        <b>${sessionScope.user.fullname}</b>
    </div>

    <div class="flex gap-3 items-center">

        <!-- LANGUAGE DROPDOWN -->
            <div class="relative">
                <select
                        onchange="location = this.value"
                        class="px-4 py-2 rounded-lg border border-gray-300 bg-white text-sm cursor-pointer">
                    <option disabled selected>
                        🌐 <c:choose>
                        <c:when test="${sessionScope.lang == 'en'}">English</c:when>
                        <c:otherwise>Tiếng Việt</c:otherwise>
                    </c:choose>
                    </option>
                    <option value="?lang=vi">Tiếng Việt</option>
                    <option value="?lang=en">English</option>
                </select>
            </div>

        <!-- CART -->
        <a href="${pageContext.request.contextPath}/cart"
           class="px-4 py-2 bg-purple-100 text-purple-700 rounded-lg font-medium hover:bg-purple-200">
            🛒 <fmt:message key="product.cart"/>
        </a>

        <!-- LOGOUT -->
        <a href="${pageContext.request.contextPath}/logout"
           class="px-4 py-2 bg-red-500 text-white rounded-lg font-semibold hover:bg-red-600">
            <fmt:message key="product.logout"/>
        </a>
    </div>
</div>

<!-- ===== TITLE ===== -->
<div class="text-center mb-12">
    <h1 class="text-4xl font-bold mb-2">
        <fmt:message key="product.hero_title"/>
    </h1>
    <p class="text-gray-500">
        <fmt:message key="product.hero_desc"/>
    </p>
</div>

<!-- ===== PRODUCTS ===== -->
<div class="max-w-7xl mx-auto grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">

    <c:choose>
        <c:when test="${not empty products}">
            <c:forEach var="p" items="${products}">
                <div class="glass-card relative p-4">

                    <span class="badge-hot">
                        <fmt:message key="product.badge_hot"/>
                    </span>

                    <!-- IMAGE -->
                    <a href="${pageContext.request.contextPath}/product?id=${p.id}">
                        <img src="${pageContext.request.contextPath}/images/${p.image}"
                             class="product-image"/>
                    </a>

                    <div class="mt-4 flex flex-col flex-grow">

                        <!-- NAME -->
                        <h2 class="font-semibold mb-2">
                            <a href="${pageContext.request.contextPath}/product?id=${p.id}">
                                ${p.name}
                            </a>
                        </h2>

                        <!-- PRICE -->
                        <div class="mb-4 font-bold text-lg text-purple-700">
                            <fmt:formatNumber value="${p.price}" type="number"/> ₫
                        </div>

                        <c:choose>

                            <c:when test="${p.quantity == 0}">
                                <a href="${pageContext.request.contextPath}/product?id=${p.id}"
                                   class="btn-buy mt-auto bg-gray-400">
                                    <fmt:message key="detail.out_of_stock"/>
                                </a>
                            </c:when>

                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/cart/add/${p.id}"
                                   class="btn-buy mt-auto">
                                    <fmt:message key="product.add_to_cart"/>
                                </a>
                            </c:otherwise>

                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </c:when>

        <c:otherwise>
            <p class="text-gray-500 col-span-full text-center">
                <fmt:message key="product.empty"/>
            </p>
        </c:otherwise>
    </c:choose>

</div>

</body>
</html>
