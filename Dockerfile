FROM alpine:3.19

# Define the project name | 定义项目名称
ARG PROJECT=core
# Define the config file name | 定义配置文件名
ARG CONFIG_FILE=core.yaml
# Define the author | 定义作者
ARG AUTHOR="yuansu.china.work@gmail.com"

LABEL org.opencontainers.image.authors=${AUTHOR}

WORKDIR /app
ENV PROJECT=${PROJECT}
ENV CONFIG_FILE=${CONFIG_FILE}

ENV TZ=Asia/Shanghai
RUN apk update --no-cache && apk add --no-cache tzdata

COPY ./${PROJECT}_api ./
COPY ./api/etc/${CONFIG_FILE} ./etc/
COPY ./api/internal/i18n/locale/ ./etc/locale/

EXPOSE 9100

ENTRYPOINT ./${PROJECT}_api -f etc/${CONFIG_FILE}