<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký | Hệ thống</title>

    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .glass-container {
            width: 760px;
            height: 520px; /* Tăng thêm một chút để chứa nhiều trường input */
            background: rgba(255, 255, 255, 0.1);
            border-radius: 18px;
            backdrop-filter: blur(10px);
            box-shadow: 0 18px 40px rgba(0, 0, 0, 0.25);
            display: flex;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .form-side {
            width: 50%;
            padding: 24px 32px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .overlay-side {
            width: 50%;
            background: rgba(255, 255, 255, 0.15);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 28px;
            color: white;
        }

        .form-input {
            width: 100%;
            padding: 10px 14px;
            margin: 5px 0;
            background: rgba(255, 255, 255, 0.12);
            border: 1px solid rgba(255, 255, 255, 0.25);
            border-radius: 10px;
            color: white;
            font-size: 14px;
            outline: none;
            transition: all 0.3s;
        }

        .input-error {
            border: 1px solid #ff4d4d !important;
            background: rgba(255, 77, 77, 0.1) !important;
        }

        .form-input::placeholder {
            color: rgba(255, 255, 255, 0.65);
        }

        /* Box thông báo lỗi */
        #error-box {
            width: 100%;
            background: rgba(255, 77, 77, 0.2);
            border: 1px solid rgba(255, 77, 77, 0.4);
            color: #ffdada;
            padding: 8px;
            border-radius: 8px;
            font-size: 12px;
            margin-bottom: 10px;
            text-align: center;
            display: none;
        }

        .btn-glass {
            background: linear-gradient(90deg, #8b5cf6, #a78bfa);
            padding: 10px 42px;
            border-radius: 24px;
            color: white;
            font-weight: 600;
            font-size: 14px;
            border: none;
            cursor: pointer;
            margin-top: 15px;
            transition: all 0.3s;
        }

        .btn-glass:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(139, 92, 246, 0.4);
        }

        .ghost-btn {
            background: transparent;
            border: 1.8px solid white;
            color: white;
            padding: 9px 32px;
            border-radius: 24px;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.3s;
        }

        .ghost-btn:hover {
            background: rgba(255,255,255,0.15);
        }

        h1 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: white;
        }

        p {
            font-size: 0.9rem;
            margin-bottom: 26px;
            opacity: 0.9;
        }

        /* Shake animation */
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        .shake { animation: shake 0.3s ease-in-out; }
    </style>
</head>
<body>

<div class="glass-container">
    <div class="form-side">
        <c:if test="${not empty error}">
            <div style="width:100%; background:rgba(255,77,77,0.2); border:1px solid rgba(255,77,77,0.4); color:#ffdada; padding:8px; border-radius:8px; font-size:12px; margin-bottom:10px; text-align:center;">
                ${error}
            </div>
        </c:if>

        <div id="error-box"></div>

        <form id="registerForm" action="/register" method="post" class="w-full flex flex-col items-center" novalidate>
            <h1>Tạo tài khoản</h1>

            <input type="text"     id="fullname" name="fullname"  placeholder="Họ tên"        class="form-input">
            <input type="email"    id="email"    name="email"     placeholder="Email"         class="form-input">
            <input type="tel"      id="phone"    name="phone"     placeholder="Số điện thoại" class="form-input">
            <input type="text"     id="address"  name="address"   placeholder="Địa chỉ"       class="form-input">
            <input type="password" id="password" name="password"  placeholder="Mật khẩu"      class="form-input">
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" class="form-input">

            <button type="submit" class="btn-glass">Đăng ký</button>
        </form>
    </div>

    <div class="overlay-side">
        <h1>Chào mừng!</h1>
        <p>Đã có tài khoản? Đăng nhập ngay để tiếp tục trải nghiệm</p>
        <a href="/login" class="ghost-btn">Đăng nhập</a>
    </div>
</div>

<script>
    const form = document.getElementById('registerForm');
    const errorBox = document.getElementById('error-box');

    form.addEventListener('submit', function(e) {
        const fullname = document.getElementById('fullname');
        const email = document.getElementById('email');
        const phone = document.getElementById('phone');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');

        let msg = "";
        let valid = true;

        // Reset
        [fullname, email, phone, password, confirmPassword].forEach(el => el.classList.remove('input-error'));
        errorBox.style.display = "none";

        // Validate logic
        if (fullname.value.trim() === "") {
            msg = "Vui lòng nhập họ tên!";
            fullname.classList.add('input-error');
            valid = false;
        } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
            msg = "Email không hợp lệ!";
            email.classList.add('input-error');
            valid = false;
        } else if (!/^(0[3|5|7|8|9])([0-9]{8})$/.test(phone.value)) {
            msg = "Số điện thoại không đúng định dạng!";
            phone.classList.add('input-error');
            valid = false;
        } else if (password.value.length < 6) {
            msg = "Mật khẩu phải từ 6 ký tự!";
            password.classList.add('input-error');
            valid = false;
        } else if (password.value !== confirmPassword.value) {
            msg = "Mật khẩu nhập lại không khớp!";
            confirmPassword.classList.add('input-error');
            valid = false;
        }

        if (!valid) {
            e.preventDefault();
            errorBox.innerText = msg;
            errorBox.style.display = "block";

            const container = document.querySelector('.glass-container');
            container.classList.add('shake');
            setTimeout(() => container.classList.remove('shake'), 300);
        }
    });

    // Xóa báo lỗi khi gõ
    form.querySelectorAll('input').forEach(input => {
        input.addEventListener('input', () => {
            input.classList.remove('input-error');
            errorBox.style.display = "none";
        });
    });
</script>

</body>
</html>