# Define colors
RED := \033[0;31m
ORANGE := \033[0;91m
YELLOW := \033[0;33m
GREEN := \033[0;32m
CYAN := \033[0;36m
BLUE := \033[0;34m
PURPLE := \033[0;35m
MAGENTA := \033[0;95m
BROWN := \033[0;33m
BLACK := \033[0;30m
RESET := \033[0m


list:
	@echo "$(GREEN)Danh sách lệnh task"

	@echo "\n$(CYAN)Nhóm lệnh chung"
	@echo "$(MAGENTA)1. Cài đặt môi trường docker:                    $(YELLOW)make setup"
	@echo "$(MAGENTA)2. Build docker:                                 $(YELLOW)make build"
	@echo "$(MAGENTA)3. Dừng docker:                                  $(YELLOW)make stop"
	@echo "$(MAGENTA)4. Chạy docker:                                  $(YELLOW)make up"
	@echo "$(MAGENTA)5. Tắt docker:                                   $(YELLOW)make down"
	@echo "$(MAGENTA)6. Vào container develop:                        $(YELLOW)make develop"
	@echo "$(MAGENTA)7. Vào container db:                             $(YELLOW)make db"

	@echo "\n$(CYAN)Nhóm database"
	@echo "$(MAGENTA)1. Import file sql vào database:                 $(YELLOW)make db-import database={tên database} source={tên file sql - chỉ load trong thư mục init}"
	@echo "$(MAGENTA)2. Export database ra file sql:                  $(YELLOW)make db-export database={tên database} source={tên file sql - chỉ load trong thư mục init}"

	@echo "\n$(CYAN)Nhóm supervisor"
	@echo "$(MAGENTA)1. Hiện danh sách supervisor:                    $(YELLOW)make supervisor-show"
	@echo "$(MAGENTA)2. Khởi động lại supervisor:                     $(YELLOW)make supervisor-restart name={tên supervisor}"

	@echo "\n$(CYAN)Nhóm composer"
	@echo "$(MAGENTA)1. Update composer:                              $(YELLOW)make composer-update"

	@echo "\n$(CYAN)Nhóm data"
	@echo "$(MAGENTA)1. Thực thi dữ liệu:                             $(YELLOW)make data"

	@echo "$(RESET)"
setup:
	@make build
	@make up 
	@make composer-update
build:
	docker-compose build --no-cache --force-rm
stop:
	docker-compose stop
up:
	@echo "$(GREEN)"
	@echo "Bật docker ..."
	@echo "$(MAGENTA)"
	docker compose up -d

	@echo "$(GREEN)"
	@echo "Chạy script up ..."
	@echo "$(CYAN)"
	docker compose exec dev bash -c "sh /script/up.sh"
	@echo "$(RESET)"

down:
	@echo "$(GREEN)"
	@echo "Tắt docker ..."
	@echo "$(MAGENTA)"
	docker compose down
	@echo "$(RESET)"

develop:
	@echo "$(GREEN)"
	@echo "Vào container develop ..."
	@echo "$(MAGENTA)"
	docker compose exec dev bash
	@echo "$(RESET)"
db:
	@echo "$(GREEN)"
	@echo "Vào container db ..."
	@echo "$(MAGENTA)"
	docker compose exec db bash
	@echo "$(RESET)"

db-import:
	@echo "$(GREEN)"
	@echo "Import dữ liệu file sql vào database: ${database} => ${source}.sql "
	@echo "$(MAGENTA)"
	docker compose exec db bash -c "mysql -u root -p ${database} < /data/init/${source}.sql"
	@echo "$(RESET)"

db-export:
	@echo "$(GREEN)"
	@echo "Export dữ liệu từ database thành file sql: ${database} => ${source}.sql "
	@echo "$(MAGENTA)"
	docker compose exec db bash -c "mysqldump -u root -p ${database} > /data/init/${source}.sql"
	@echo "$(RESET)"

supervisor-show:
	@echo "$(GREEN)"
	@echo "Hiện danh sách supervisor ..."
	@echo "$(CYAN)"
	@docker compose exec dev bash -c "supervisorctl status"
	@echo "$(RESET)"

supervisor-restart:
	@echo "$(GREEN)"
	@echo "Khởi động lại tiến trình supervisor ${name} ..."
	@echo "$(CYAN)"
	docker compose exec dev bash -c "supervisorctl restart ${name}"
	@echo "$(RESET)"

composer-update:
	docker exec dev bash -c "composer update"
data:
	docker exec dev bash -c "php artisan migrate"
	docker exec dev bash -c "php artisan db:seed"
