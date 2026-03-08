FROM node:14-bullseye-slim AS node
FROM ruby:3.0-slim-bullseye

# OSベース設定
RUN set -ex \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends locales task-japanese gosu sudo vim less zsh git \
  && rm -rf /var/lib/apt/lists/* \
  && echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen \
  && locale-gen \
  && update-locale LANG=ja_JP.UTF-8 \
  && ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

ENV LANG ja_JP.UTF-8

# プロジェクトで必要なパッケージインストール
RUN set -ex \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
     build-essential \
     curl \
     default-libmysqlclient-dev \
     graphicsmagick \
     imagemagick \
     libffi-dev \
     libgdbm-dev \
     libreadline-dev \
     libssl-dev \
     libxml2-dev \
     libxslt-dev \
     libyaml-dev \
     shared-mime-info \
     zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

# Nodeインストール
COPY --from=node /usr/local /usr/local
COPY --from=node /opt /opt


