# Đối với cài máy chủ ở local ( máy tính cá nhân )
## Liên quan đến wsl
### 1. Danh sách wsl
wsl --list

### 2. Mở powershell và xóa wsl ( nếu cần )
wsl --unregister <Tên wsl>

# Cài đặt máy chủ
### Tạo ssh key trên máy tính
ssh-keygen -t rsa -b 4096 -f ~/.ssh/{ten thu muc}/id_rsa

### 1. Thay đổi mật khẩu đăng nhập root ( nếu cần )
sudo passwd root

### 2. Thêm user trên máy chủ ( vì ko nên xài tải khoản root để bảo mật )
sudo adduser {tên người dùng}

### 3. Thêm user đó vào danh sách người dùng root
usermod -aG sudo {tên người dùng}

### 4. Tạo shh key trên máy chủ ( add vào github v.v.. nếu cần)
ssh-keygen -t rsa -b 4096

### 5. Tạo thư mục chứng chứa key chứng thực ( nếu chưa có )
mkdir ~/.ssh/
touch ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

### 6. Chỉnh sửa thiết lập ssh trên sv
- Mở file thiết lập ssh => vim /etc/ssh/sshd_config
- Cấp quyển cho phép kết nối bằng public key  => PubkeyAuthentication yes
- Xóa quyền kết nối bằng mật khẩu => PasswordAuthentication no
- Cấp quyên cho chứng thực bằng thư mục phụ AuthorizedKeysFile      .ssh/authorized_keys .ssh/authorized_keys2
- Hủy quyền đăng nhập root #PermitRootLogin yes
- Chạy lại máy chủ sudo service ssh restart

### Cài đặt ubuntu
# 1. Cập nhật package 
apt-get update

# 2. Cài git và sedet up thông tin liên quan
apt-get -y install git
git config --global user.name "Quan"
git config --global user.email "leovergil@gmail.com"
git config --global --list

# 3. Cài vim 
apt-get -y install vim

# 4. Cài composer
apt-get -y install composer

# 5. Thêm kho lưu trữ Docker vào hệ thống và cài đặt
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io
docker --version

# 6. Tạo thư mục docker ( nếu cần ) [ Nơi lưu trữ chính: data ( tạo nếu cần ) ]
mkdir {tên thư mục docker}

# 7. Cấu hình docker ( clone về )
git clone {url}

# 8. Cấp quyền cho toàn bộ file trong docker
chmod 0777 *

# 9 Xóa 2 folder trong mysql là data và ibdata ( nên xóa khi khởi tạo )
mkdir -rf mysql/data
mkdir -rf mysql/ibdata

# 10. Chuẩn bị các dự án cần thiết
git clone {url dự án}

# 11. Build container ( tốn thời gian tùy hệ thống và mảng )
docker compose build --no-cache

# 12. Chỉnh sửa vhost ( nếu cần hoặc phải cấu hình ssl )
- Tham khảo file default.conf
- Thiết lập vào file vhost.conf nếu không có thì tạo để mount vào VM

# 13. Thêm các file cấu hình ssl ( nếu cần )
- Cần thêm 3 file là .crt .key và .ca-bundle khi mua từ nhà cung cấp

# 14. Chạy web
docker compose up -d

### Set up cho từng dự án cụ thể
# 1. Đối với laravel cần set vhost vào mục public

# 2. Thêm database 
Đối với dự án php thuần thì phải vào container của mysql import db thì mới chạy dc


### Ghi nhớ
# 1. Thư mục chứa source mặc định của apache
/var/www/html
# 2. Thư mục chứa access log mặc định của apache
/var/log/httpd
# 3. Thư mục chứa và các file cấu hình thiết lập ssl
/etc/ssl
{domain}.crt
{domain}.key
My_CA_Bundle.ca-bundle

### Liên quan đến docker
# 1. Danh sách container
docker ps

# 2. Dừng container

# 3. Xóa container

# 4. Vào container
docker compose exec -it {tên container} bash