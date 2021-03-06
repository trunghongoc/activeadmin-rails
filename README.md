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
#### 1. SSH public key là gì?
* SSH key là chứng chỉ truy cập trong giao thức SSH
* Chức năng của nó tương tự như việc nhập thủ công tài khoản và mật khẩu, song việc đăng nhập sẽ diễn ra tự động, mà không cần phải nhập mật khẩu.
* Giao thức SSH: (Secure Shell) được sử dụng để quản lý mạng, hệ điều hành và cấu hình. Nó cũng nằm trong nhiều công cụ chuyển file và các công cụ quản lý cấu hình.
#### 2. Quá trình đăng nhập bằng SSH key
* Mỗi máy tính sẽ có 1 SSH key và key này là duy nhất, không bị trùng lặp với  bất kỳ máy tính nào.
* Khi đăng nhập vào server theo cú pháp <em><u>ssh user_name@IP_VPS</u></em>, thay vì bạn phải nhập mật khẩu, giao thức SSH sẽ kiểm tra SSH key public trên máy bạn, sau đó kiểm tra key này có trên server hay không, nếu có sẽ đăng nhập thành công.
#### 3. Ưu nhược điểm của việc đăng nhập bằng SSH public key
* Ưu điểm:<br>
    &nbsp;&nbsp;&nbsp;&nbsp;Độ bảo mật cao: việc đăng nhập không cần mật khẩu tạo độ tin cậy cao, trong bối cảnh chỉ máy tính cá nhân của mình mới có thể truy cập vào máy chủ, sẽ an toàn hơn việc dùng mật khẩu để đăng nhập. Nếu bạn lựa chọn hình thức  đăng nhập bằng mật khẩu, việc để lộ mật khẩu là không tránh khỏi, và việc này diễn ra thường xuyên thông qua các hình thức đánh cắp, hacker chiếm được mật khẩu và chiếm quyền kiểm soát server của bạn, vậy bạn mất trắng.
* Nhược điểm: chính vì việc chỉ có máy được chấp nhận mới được đăng nhập vào server, khi máy tính cá nhân của bạn bị hỏng, sẽ không bao giờ đăng nhập lại được nữa (song điều này chỉ xảy ra  với tài khoản của bạn, quản trị viên quyền cao hơn có thể thêm lại SSH key của bạn vào server một lần nữa, và việc đăng nhập lại diễn ra bình thường)
#### 4. Cách thêm SSH public key vào server
* Lấy SSH key trên máy tính cá nhân bằng lệnh: <em><u>cat /home/laptop_name/.ssh/id_rsa.pub</u></em> , lệnh này có thể thay đổi phụ thuộc vào tên máy tính của bạn.
* Thêm SSH key vừa lấy được vào server:<br>
    Tạo thư mục .ssh và file  authorized_keys trong thư mục .ssh:<br>
      &nbsp;&nbsp;&nbsp;&nbsp;mkdir ~/.ssh<br>
      &nbsp;&nbsp;&nbsp;&nbsp;chmod 700 ~/.ssh<br>
      &nbsp;&nbsp;&nbsp;&nbsp;touch ~/.ssh/authorized_keys<br>
      &nbsp;&nbsp;&nbsp;&nbsp;chmod 600 ~/.ssh/authorized_keys<br>
    Mở file authorized_keys vừa tạo và insert key vào<br>
    <strong>Chú ý: </strong> phải tắt SELinux để có thể đăng nhập bằng SSH key<br>
    Cách tắt SELinux:<br>
      &nbsp;&nbsp;&nbsp;&nbsp;Mở file: <em><u>/etc/selinux/config</u></em><br>
      &nbsp;&nbsp;&nbsp;&nbsp;Tìm <em><u>SELINUX=enforcing</u></em> và sửa thành <em><u>SELINUX=disabled</u></em><br>
      &nbsp;&nbsp;&nbsp;&nbsp;Khởi động lại server: <em><u>reboot</u></em><br>
      &nbsp;&nbsp;&nbsp;&nbsp;Đăng nhập lại vào server để kiểm tra độ thành công.<br>
#### 5. Tắt tính năng đăng nhập bằng mật khẩu
* Sau khi đã add SSH key vào server, bạn hiện có 2 hình thức đăng nhập: 1 qua SSH, 1 qua cách truyền thống (nhập mật khẩu)
* Cần phải tắt tính năng đăng nhập bằng mật khẩu để tăng tính bảo mật.
* Các bước để tắt tính năng đăng nhập bằng mật khẩu:
    Mở file: <em><u>/etc/ssh/sshd_config</u></em><br>
    Đổi thành:<br>
      &nbsp;&nbsp;&nbsp;&nbsp;PasswordAuthentication no<br>
      &nbsp;&nbsp;&nbsp;&nbsp;UsePAM no<br>
#### 6. Cài đặt RUBY
* Cài đặt và cập nhật môi trường trước khi cài ruby:
  sudo apt-get update
  sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs
* cài ruby sử dụng rbenv<br>
	&nbsp;&nbsp;&nbsp;&nbsp;cd<br>
	&nbsp;&nbsp;&nbsp;&nbsp;git clone https://github.com/rbenv/rbenv.git ~/.rbenv<br>
	&nbsp;&nbsp;&nbsp;&nbsp;echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc<br>
	&nbsp;&nbsp;&nbsp;&nbsp;echo 'eval "$(rbenv init -)"' >> ~/.bashrc<br>
	&nbsp;&nbsp;&nbsp;&nbsp;exec $SHELL<br>

	&nbsp;&nbsp;&nbsp;&nbsp;git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build<br>
	&nbsp;&nbsp;&nbsp;&nbsp;echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc<br>
	&nbsp;&nbsp;&nbsp;&nbsp;exec $SHELL<br>

	&nbsp;&nbsp;&nbsp;&nbsp;rbenv install 2.4.0<br>
	&nbsp;&nbsp;&nbsp;&nbsp;rbenv global 2.4.0<br>
	&nbsp;&nbsp;&nbsp;&nbsp;ruby -v<br>
#### 7. Cài đặt bundler
* Chạy:<br>
&nbsp;&nbsp;&nbsp;&nbsp;<em><u>gem install bundler</u></em><br>
* Chạy lại lệnh sau khi đã cài bundler hoàn tất:<br>
&nbsp;&nbsp;&nbsp;&nbsp;<em><u>rbenv rehash </u></em><br>
#### 8. Cài đặt nginx
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7<br>
sudo apt-get install -y apt-transport-https ca-certificates<br>
* Add Passenger APT repository<br>
&nbsp;&nbsp;&nbsp;&nbsp;sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'<br>
&nbsp;&nbsp;&nbsp;&nbsp;sudo apt-get update<br>

* Install Passenger & Nginx<br>
&nbsp;&nbsp;&nbsp;&nbsp;sudo apt-get install -y nginx-extras passenger<br>
* khởi động nginx:<br>
&nbsp;&nbsp;&nbsp;&nbsp;sudo service nginx start<br>
* Truy cập vào địa chỉ website của bạn và bạn sẽ thấy màn hình chào của nginx:<br>
&nbsp;&nbsp;&nbsp;&nbsp;Vd: http://123.123.123.123<br>
* Cập nhật cấu hình nginx để chỉ Passenger tới phiên bản ruby đang sử dụng (mở bằng vim):<br>
&nbsp;&nbsp;&nbsp;&nbsp;sudo vim /etc/nginx/nginx.conf<br>
&nbsp;&nbsp;&nbsp;&nbsp;Tìm các dòng sau và bỏ ghi chú:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;##<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# Phusion Passenger<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;##<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# Uncomment it if you installed ruby-passenger or ruby-passenger-enterprise<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;##<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;include /etc/nginx/passenger.conf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lưu và đóng.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mở /etc/nginx/passenger.conf và thay đổi nội dung:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sudo vim /etc/nginx/passenger.conf<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thay đổi dòng passenger_ruby để trỏ đến tệp thực thi ruby ​​của bạn:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;passenger_ruby /home/deploy/.rbenv/shims/ruby; # If you use rbenv<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# passenger_ruby /home/deploy/.rvm/wrappers/ruby-2.1.2/ruby; # If use use rvm, be sure to change the version number<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# passenger_ruby /usr/bin/ruby; # If you use ruby from source<br>

