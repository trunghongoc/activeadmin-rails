# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
=======
## Hướng dẫn deploy rails lên VPS
### Đăng nhập vào VPS
Cú pháp: <em><u>ssh user_name@IP_VPS</u></em>
Trong đó:
* <em><u>user_name</u></em> là tài khoản dùng để đăng nhập VPS
* <em><u>IP_VPS</u></em> là địa chỉ IP của VPS
Ví dụ: ssh root@123.123.123.123
* <strong>Lưu ý:</strong> Trong lần đầu tiên đăng nhập, bắt buộc phải thay đổi mật khẩu.
### Đăng nhập vào VPS bằng SSH public key
1. SSH public key là gì?
* SSH key là chứng chỉ truy cập trong giao thức SSH
* Chức năng của nó tương tự như việc nhập thủ công tài khoản và mật khẩu, song việc đăng nhập sẽ diễn ra tự động, mà không cần phải nhập mật khẩu.
* Giao thức SSH: (Secure Shell) được sử dụng để quản lý mạng, hệ điều hành và cấu hình. Nó cũng nằm trong nhiều công cụ chuyển file và các công cụ quản lý cấu hình.
2. Quá trình đăng nhập bằng SSH key
* Mỗi máy tính sẽ có 1 SSH key và key này là duy nhất, không bị trùng lặp với  bất kỳ máy tính nào.
* Khi đăng nhập vào server theo cú pháp <em><u>ssh user_name@IP_VPS</u></em>, thay vì bạn phải nhập mật khẩu, giao thức SSH sẽ kiểm tra SSH key public trên máy bạn, sau đó kiểm tra key này có trên server hay không, nếu có sẽ đăng nhập thành công.
3. Ưu nhược điểm của việc đăng nhập bằng SSH public key
* Ưu điểm:
* * Độ bảo mật cao: việc đăng nhập không cần mật khẩu tạo độ tin cậy cao, trong bối cảnh chỉ máy tính cá nhân của mình mới có thể truy cập vào máy chủ, sẽ an toàn hơn việc dùng mật khẩu để đăng nhập. Nếu bạn lựa chọn hình thức  đăng nhập bằng mật khẩu, việc để lộ mật khẩu là không tránh khỏi, và việc này diễn ra thường xuyên thông qua các hình thức đánh cắp, hacker chiếm được mật khẩu và chiếm quyền kiểm soát server của bạn, vậy bạn mất trắng.
* Nhược điểm: chính vì việc chỉ có máy được chấp nhận mới được đăng nhập vào server, khi máy tính cá nhân của bạn bị hỏng, sẽ không bao giờ đăng nhập lại được nữa (song điều này chỉ xảy ra  với tài khoản của bạn, quản trị viên quyền cao hơn có thể thêm lại SSH key của bạn vào server một lần nữa, và việc đăng nhập lại diễn ra bình thường)
4. Cách thêm SSH public key vào server
* Lấy SSH key trên máy tính cá nhân bằng lệnh: <em><u>cat /home/laptop_name/.ssh/id_rsa.pub</u></em> , lệnh này có thể thay đổi phụ thuộc vào tên máy tính của bạn.
* Thêm SSH key vừa lấy được vào server:
* * Tạo thư mục .ssh và file  authorized_keys trong thư mục .ssh:
* * * mkdir ~/.ssh
* * * chmod 700 ~/.ssh
* * * touch ~/.ssh/authorized_keys
* * * chmod 600 ~/.ssh/authorized_keys


