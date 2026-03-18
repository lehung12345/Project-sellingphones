<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="i18n.messages"/>
<!-- ===== LANGUAGE ===== -->
<c:if test="${not empty param.lang}">
    <c:set var="lang" value="${param.lang}" scope="session"/>
</c:if>

<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'vi'}"/>
<fmt:setBundle basename="i18n.messages"/>

<!DOCTYPE html>
<html>
<head>
    <title><fmt:message key="detail.title"/></title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 p-10">
<div class="max-w-6xl mx-auto bg-white p-8 rounded-xl shadow-lg">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-10">
        <div class="flex justify-center items-center">
            <img src="${pageContext.request.contextPath}/images/${product.image}" class="w-full max-w-md object-contain">
        </div>

        <div>
            <h1 class="text-3xl font-bold mb-4">${product.name}</h1>
            <div class="text-2xl text-purple-600 font-semibold mb-4">
                <fmt:formatNumber value="${product.price}" type="number"/> ₫
            </div>

            <div class="mb-3">
                <b><fmt:message key="detail.quantity_remains"/></b> ${product.quantity}
            </div>

            <c:if test="${product.quantity > 0 && product.quantity < 5}">
                <div class="text-orange-500 text-sm mb-3">
                    <fmt:message key="detail.low_stock"/>
                </div>
            </c:if>

            <c:if test="${product.quantity == 0}">
                <div class="text-red-500 font-semibold mb-3">
                    <fmt:message key="detail.out_of_stock"/>
                </div>
            </c:if>

            <div class="mb-4">
                <h2 class="font-semibold mb-1"><fmt:message key="detail.description"/></h2>
                <p class="text-gray-700 leading-relaxed">
                    <c:choose>
                        <c:when test="${not empty product.description}">
                            ${product.description}
                        </c:when>
                        <c:otherwise>
                            <span class="text-gray-400"><fmt:message key="detail.no_description"/></span>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>

            <div class="flex gap-3 mt-6">
                <c:choose>
                    <c:when test="${product.quantity == 0}">
                        <button class="bg-gray-400 text-white px-6 py-2 rounded-lg cursor-not-allowed">
                            <fmt:message key="detail.out_of_stock"/>
                        </button>
                        <button class="bg-gray-400 text-white px-6 py-2 rounded-lg cursor-not-allowed">
                            <fmt:message key="detail.buy_now"/>
                        </button>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/cart/add/${product.id}"
                           class="bg-purple-500 text-white px-6 py-2 rounded-lg hover:bg-purple-600">
                            <fmt:message key="detail.add_to_cart"/>
                        </a>
                        <a href="${pageContext.request.contextPath}/cart/add/${product.id}"
                           class="bg-green-500 text-white px-6 py-2 rounded-lg hover:bg-green-600">
                            <fmt:message key="detail.buy_now"/>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="mt-6">
                <a href="${pageContext.request.contextPath}/products" class="text-gray-600 hover:underline">
                    <fmt:message key="detail.back"/>
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>