# Учебный Jenkins курса "Рабочий день тестировщика: Docker и CI/CD": LTS, плагины с версиями,
# настройка кодом (JCasC). Собирается из docker-compose.yml рядом: docker compose up -d --build
FROM docker:29.9.1-cli AS docker-cli
FROM node:22.23.3-bookworm-slim AS node

FROM jenkins/jenkins:2.580.2-lts-jdk21
USER root
# Docker CLI: сборка запускает магазин через Docker вашей машины.
COPY --from=docker-cli /usr/local/bin/docker /usr/local/bin/docker
# Node.js и newman: проверки API из папки collection.
COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/lib/node_modules/npm /usr/local/lib/node_modules/npm
RUN ln -s ../lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
 && npm install -g newman@6.2.1 --no-fund --no-audit \
 && npm cache clean --force \
 && git config --system --add safe.directory '*'
USER jenkins
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
COPY --chown=jenkins:jenkins casc/ /usr/share/jenkins/casc/
