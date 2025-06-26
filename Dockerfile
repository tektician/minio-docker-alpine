FROM alpine:3.22.0

WORKDIR /app

ENV MINIO_VERSION=RELEASE.2025-06-13T11-33-47Z
ENV MINIO_SHA256=668d3fa0334da86a481da79cc88740f751bf60d8cf15ff988f4bceafa22ca4b0

RUN set -eux; \
    mkdir -p /data/; \
    wget -O /app/minio "https://dl.min.io/server/minio/release/linux-amd64/minio.${MINIO_VERSION}"; \
    echo "${MINIO_SHA256}  /app/minio" | sha256sum -c; \
    chmod +x /app/minio; \
    /app/minio --version

EXPOSE 9001 9002

CMD ["/app/minio", "server", "--address", ":9002", "--console-address", ":9001", "/data/"]

LABEL org.opencontainers.image.description='An image based on alpine linux latest tag instead of RHEL as base, with exposed ports on 9001 for the UI, and 9002 for the API server'
LABEL org.opencontainers.image.title="MinIO"
LABEL org.opencontainers.image.version=$MINIO_VERSION
LABEL org.opencontainers.image.source="https://github.com/minio/minio"
LABEL org.opencontainers.image.licenses="AGPL-3.0"
