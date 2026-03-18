<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Hệ thống Quản trị</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-color: #4f46e5;
            --primary-hover: #4338ca;
            --bg-color: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --input-border: #e2e8f0;
            --input-focus: #6366f1;
            --error-red: #ef4444;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Plus Jakarta Sans', sans-serif; }

        body {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: var(--bg-color);
            background-image: radial-gradient(#e2e8f0 1px, transparent 1px);
            background-size: 20px 20px;
        }

        .login-card {
            background: var(--card-bg);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            border-radius: 24px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05);
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        /* Hiệu ứng rung khi có lỗi */
        .shake { animation: shake 0.4s ease-in-out; }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-8px); }
            50% { transform: translateX(8px); }
            75% { transform: translateX(-8px); }
        }

        .header { text-align: center; margin-bottom: 32px; }
        .header h2 { color: var(--text-main); font-size: 24px; font-weight: 700; }

        .form-group { margin-bottom: 24px; position: relative; }
        .form-group i {
            position: absolute;
            left: 16px;
            top: 14px;
            color: var(--text-muted);
            font-size: 18px;
            transition: color 0.3s;
        }

        input {
            width: 100%;
            padding: 14px 16px 14px 48px;
            border: 1.5px solid var(--input-border);
            border-radius: 12px;
            font-size: 15px;
            transition: all 0.2s ease;
        }

        input:focus {
            outline: none;
            border-color: var(--input-focus);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
        }

        /* Style cho câu thông báo lỗi bên dưới ô nhập */
        .error-hint {
            color: var(--error-red);
            font-size: 12px;
            margin-top: 5px;
            display: none; /* Mặc định ẩn */
            font-weight: 500;
        }

        input.invalid { border-color: var(--error-red); background-color: #fffafb; }
        .invalid + .error-hint { display: block; }

        .options {
            display: flex;
            justify-content: space-between;
            align-items: center; /* Căn giữa tất cả theo chiều dọc */
            margin-bottom: 24px;
            width: 100%;
        }

        .remember-me {
            display: flex;
            align-items: center; /* Quan trọng: Giúp checkbox và chữ nằm trên 1 đường thẳng */
            gap: 10px; /* Khoảng cách giữa ô checkbox và chữ */
            font-size: 14px;
            color: var(--text-muted);
            cursor: pointer;
            user-select: none; /* Ngăn bôi đen chữ khi click nhanh */
        }

        .remember-me input {
            width: 18px; /* Tăng kích thước ô tích một chút cho dễ bấm */
            height: 18px;
            margin: 0; /* Xóa margin mặc định của trình duyệt */
            cursor: pointer;
            accent-color: var(--primary-color); /* Màu ô tích trùng màu nút bấm */
        }

        .forgot-pw {
            color: var(--primary-color);
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            white-space: nowrap; /* Không cho chữ "Quên mật khẩu" bị nhảy dòng */
        }

        button {
            width: 100%;
            padding: 14px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        button:hover { background-color: var(--primary-hover); }

        .error-message {
            background-color: #fef2f2;
            color: #b91c1c;
            padding: 12px;
            border-radius: 10px;
            font-size: 13px;
            text-align: center;
            margin-bottom: 20px;
            border: 1px solid #fee2e2;
        }
    </style>
</head>
<body>

<div class="login-card" id="loginCard">
    <div class="header">
        <h2>Quản trị hệ thống</h2>
        <p style="color: var(--text-muted); font-size: 14px; margin-top: 5px;">Vui lòng đăng nhập</p>
    </div>

    <% if(request.getParameter("error") != null) { %>
        <div class="error-message">
            <i class="fa-solid fa-circle-exclamation"></i> Email hoặc mật khẩu không đúng!
        </div>
    <% } %>

    <form id="loginForm" action="${pageContext.request.contextPath}/admin/login" method="post" novalidate>

        <div class="form-group">
            <i class="fa-regular fa-envelope"></i>
            <input type="email" id="email" name="email" placeholder="Email quản trị">
            <div class="error-hint">Vui lòng nhập Email</div>
        </div>

        <div class="form-group">
            <i class="fa-regular fa-lock"></i>
            <input type="password" id="password" name="password" placeholder="Mật khẩu">
            <div class="error-hint">Mật khẩu không được để trống</div>
        </div>

        <div class="options">
            <label class="remember-me">
                <input type="checkbox" name="remember">
                <span>Ghi nhớ đăng nhập</span>
            </label>
            <a href="#" class="forgot-pw">Quên mật khẩu?</a>
        </div>

        <button type="submit">Đăng nhập</button>
    </form>
</div>

<script>
    const loginForm = document.getElementById('loginForm');
    const loginCard = document.getElementById('loginCard');

    loginForm.addEventListener('submit', function(e) {
        let isValid = true;
        const email = document.getElementById('email');
        const password = document.getElementById('password');

        // Reset trạng thái
        email.classList.remove('invalid');
        password.classList.remove('invalid');
        loginCard.classList.remove('shake');

        // Validate Email (trống hoặc sai định dạng)
        const emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
        if (!email.value.trim() || !email.value.match(emailPattern)) {
            email.classList.add('invalid');
            isValid = false;
        }

        // Validate Password
        if (!password.value.trim()) {
            password.classList.add('invalid');
            isValid = false;
        }

        // Nếu có lỗi
        if (!isValid) {
            e.preventDefault(); // Ngừng gửi form

            // Hiệu ứng rung khung hình để gây chú ý
            setTimeout(() => {
                loginCard.classList.add('shake');
            }, 10);
        }
    });

    // Xóa lỗi khi người dùng bắt đầu nhập lại
    document.querySelectorAll('input').forEach(input => {
        input.addEventListener('input', function() {
            this.classList.remove('invalid');
        });
    });
</script>

</body>
</html>