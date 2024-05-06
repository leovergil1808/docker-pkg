setup:
	@make build
	@make up 
	@make composer-update
build:
	docker-compose build --no-cache --force-rm
stop:
	docker-compose stop
up:
	@echo "\033[0;32m"
	@echo "Bật docker ..."
	@echo "\033[0m"
	docker compose up -d

	@echo "\033[0;32m"
	@echo "Chạy script up ..."
	@echo "\033[0m"
	docker compose exec dev bash -c "sh /script/up.sh"
down:
	@echo "\033[0;32m"
	@echo "Tắt docker ..."
	@echo "\033[0m"
	docker compose down
develop:
	@echo "\033[0;32m"
	@echo "Vào container dev..."
	@echo "\033[0m"
	docker compose exec dev bash
db:
	@echo "\033[0;32m"
	@echo "Vào container db ..."
	@echo "\033[0m"
	docker compose exec db bash
composer-update:
	docker exec dev bash -c "composer update"
data:
	docker exec dev bash -c "php artisan migrate"
	docker exec dev bash -c "php artisan db:seed"
