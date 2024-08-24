docker compose up -d rems-db
docker compose run --rm -e CMD="migrate" rems-app
docker compose down rems-db

