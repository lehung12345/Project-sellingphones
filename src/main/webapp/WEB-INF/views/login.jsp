<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập | Hệ thống</title>

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
            height: 420px; /* Tăng nhẹ chiều cao để chứa thông báo lỗi */
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
            padding: 28px 32px;
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
            margin: 6px 0;
            background: rgba(255, 255, 255, 0.12);
            border: 1px solid rgba(255, 255, 255, 0.25);
            border-radius: 10px;
            color: white;
            font-size: 14px;
            outline: none;
            transition: all 0.3s;
        }

        /* Khi input bị lỗi */
        .input-error {
            border: 1px solid #ff4d4d !important;
            background: rgba(255, 77, 77, 0.1) !important;
        }

        .form-input::placeholder {
            color: rgba(255, 255, 255, 0.65);
        }

        /* Thông báo lỗi */
        #error-box {
            width: 100%;
            background: rgba(255, 77, 77, 0.2);
            border: 1px solid rgba(255, 77, 77, 0.4);
            color: #ffdada;
            padding: 8px;
            border-radius: 8px;
            font-size: 13px;
            margin-bottom: 12px;
            text-align: center;
            display: none; /* Ẩn mặc định */
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
            margin-top: 18px;
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
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
        }

        .ghost-btn:hover {
            background: rgba(255,255,255,0.15);
        }

        h1 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: white;
        }

        p {
            font-size: 0.9rem;
            margin-bottom: 26px;
            opacity: 0.9;
        }

        /* Hiệu ứng rung khi lỗi */
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
            <div id="server-error" class="error-msg"
                 style="display:block; width:100%; background:rgba(255,77,77,0.2); border:1px solid rgba(255,77,77,0.4); color:#ffdada; padding:8px; border-radius:8px; font-size:13px; margin-bottom:12px; text-align:center;">
                ${error}
            </div>
        </c:if>

        <div id="error-box"></div>

        <form id="loginForm" action="/login" method="post" class="w-full flex flex-col items-center" novalidate>
            <h1>Đăng nhập</h1>

            <input type="email" id="email" name="email" placeholder="Email" class="form-input">
            <input type="password" id="password" name="password" placeholder="Mật khẩu" class="form-input">

            <button type="submit" class="btn-glass">Đăng nhập</button>
        </form>
    </div>

    <div class="overlay-side">
        <h1>Xin chào, bạn!</h1>
        <p>Chưa có tài khoản? Đăng ký ngay để bắt đầu trải nghiệm</p>
        <a href="/register" class="ghost-btn">Đăng ký</a>
    </div>
</div>

<script>
    const loginForm = document.getElementById('loginForm');
    const emailInput = document.getElementById('email');
    const passwordInput = document.getElementById('password');
    const errorBox = document.getElementById('error-box');
    const serverError = document.getElementById('server-error');

    loginForm.addEventListener('submit', function(e) {
        let errorMessage = "";
        let valid = true;

        // Reset trạng thái
        errorBox.style.display = "none";
        if(serverError) serverError.style.display = "none";
        emailInput.classList.remove('input-error');
        passwordInput.classList.remove('input-error');

        // Validate Email
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (emailInput.value.trim() === "") {
            errorMessage = "Vui lòng nhập Email!";
            emailInput.classList.add('input-error');
            valid = false;
        } else if (!emailPattern.test(emailInput.value)) {
            errorMessage = "Định dạng Email không hợp lệ!";
            emailInput.classList.add('input-error');
            valid = false;
        }
        // Validate Password (chỉ check khi email đã ok)
        else if (passwordInput.value.trim() === "") {
            errorMessage = "Vui lòng nhập mật khẩu!";
            passwordInput.classList.add('input-error');
            valid = false;
        } else if (passwordInput.value.length < 6) {
            errorMessage = "Mật khẩu phải từ 6 ký tự trở lên!";
            passwordInput.classList.add('input-error');
            valid = false;
        }

        if (!valid) {
            e.preventDefault(); // Chặn gửi form
            errorBox.innerText = errorMessage;
            errorBox.style.display = "block";

            // Thêm hiệu ứng rung cho container
            const container = document.querySelector('.glass-container');
            container.classList.add('shake');
            setTimeout(() => container.classList.remove('shake'), 300);
        }
    });

    // Ẩn thông báo lỗi khi người dùng bắt đầu nhập lại
    [emailInput, passwordInput].forEach(input => {
        input.addEventListener('input', () => {
            input.classList.remove('input-error');
            errorBox.style.display = "none";
            if(serverError) serverError.style.display = "none";
        });
    });
</script>

</body>
</html>