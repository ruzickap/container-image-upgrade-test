FROM <container_name>:<version>

RUN set -eux && \
    if [ "$(id -u)" -eq 0 ]; then \
      if command -v apt-get >/dev/null 2>&1; then \
        apt-get update -qq && \
        apt-get upgrade -y && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* && \
        useradd --create-home --home-dir /home/appuser appuser; \
      elif command -v apk >/dev/null 2>&1; then \
        apk update && \
        apk upgrade && \
        rm -rf /var/cache/apk/* && \
        adduser -D -h /home/appuser appuser; \
      elif command -v dnf >/dev/null 2>&1; then \
        dnf upgrade -y && \
        dnf clean all && \
        rm -rf /var/cache/dnf && \
        adduser --create-home --home-dir /home/appuser appuser; \
      fi
    fi

USER appuser

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ -f /etc/passwd ] || exit 1

CMD [ "sh" ]
