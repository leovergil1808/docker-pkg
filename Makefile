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
