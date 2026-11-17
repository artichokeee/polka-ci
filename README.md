# Полка CI – учебный набор

Набор курса "Рабочий день тестировщика: Docker и CI/CD". Магазин "Полка" в контейнере, магазин с базой
Postgres, учебный Jenkins и проверки API, которые гоняют Jenkins и GitHub Actions. Все запускается на вашей
машине: нужен только Docker Desktop.

Скачать набор без входа на GitHub: зеленая кнопка **Code** → **Download ZIP**, или архив метки `course-v1` на
вкладке **Tags**. Курс опирается именно на метку `course-v1`: что бы ни менялось в репозитории потом, задания
берут файлы оттуда.

## Что где

| Папка или файл | Что это | Урок |
|---|---|---|
| `compose/compose.yaml` | магазин и база Postgres одной командой | 5 |
| `compose/compose-broken.yaml` | тот же файл с одной ошибкой | 5 |
| `compose/seed.sql` | тестовые заказы, база загружает их при первом запуске | 5 |
| `jenkins/` | учебный Jenkins: образ, плагины, настройка кодом | 7–10 |
| `Jenkinsfile` | конвейер задачи `shelf-checks` | 8 |
| `jenkins/Jenkinsfile.broken` | тот же конвейер с одной ошибкой, задача `shelf-checks-broken` | 9 |
| `jenkins/Jenkinsfile.login-check`, `jenkins/Jenkinsfile.leak` | задачи про пароль тестового аккаунта | 10 |
| `collection/` | проверки API "Полки" для newman и Postman | 8, 11 |
| `.github/workflows/shelf-checks.yml` | те же проверки в GitHub Actions | 11, 12 |
| `broken/shelf-checks.yml` | workflow с одной ошибкой | 11 |

## Магазин

Образ `ghcr.io/artichokeee/polka-shop`, теги `ru-3.6` и `ru-3.7` – две версии магазина.

```
docker run -d --name polka -p 3300:3300 ghcr.io/artichokeee/polka-shop:ru-3.7
curl http://localhost:3300/api/health
docker rm -f polka
```

В PowerShell вместо `curl` пишите `curl.exe`.

## Магазин с базой

```
cd compose
docker compose up -d
docker compose ps
docker compose down -v
```

## Учебный Jenkins

```
cd jenkins
cp .env.example .env
```

Откройте `.env` и впишите в `JENKINS_ADMIN_PASSWORD` пароль, который придумаете сами. Потом:

```
docker compose up -d --build
```

Первый запуск собирает образ Jenkins – несколько минут. Затем откройте http://localhost:8090 и войдите как
`admin` с вашим паролем. Остановить – `docker compose down`, остановить и забыть все сборки – `docker compose down -v`.

## GitHub Actions

Кнопка **Use this template** → **Create a new repository** создает ваш собственный репозиторий из набора.
Workflow `shelf-checks.yml` запускается на каждый push и кнопкой **Run workflow** на вкладке **Actions**.

## Уборка

После урока остановите то, что запускали: `docker rm -f <имя>` для отдельных контейнеров,
`docker compose down -v` в папке `compose` и `docker compose down` в папке `jenkins`.
