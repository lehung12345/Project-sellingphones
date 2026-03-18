<%@ page contentType="text/html;charset=UTF-8" %>
<%--<link rel="stylesheet" href="../../../resources/static/assets/style.css">--%>
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/style.css">
<div class="container">
    <h2>Sửa người dùng</h2>

    <form method="post"
          action="${pageContext.request.contextPath}/admin/users">

        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${user.id}">

        <div class="form-group">
            <label>Họ tên</label>
            <input name="fullname" value="${user.fullname}">
        </div>

        <div class="form-group">
            <label>Phone</label>
            <input name="phone" value="${user.phone}">
        </div>

        <div class="form-group">
            <label>Địa chỉ</label>
            <input name="address" value="${user.address}">
        </div>

        <button type="submit">Cập nhật</button>
    </form>

</div>
