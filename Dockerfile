FROM <container_name>:<version>

# Create a non-root user and switch to it
RUN set -eux && \
    if command -v adduser >/dev/null 2>&1; then \
      adduser -D -h /home/appuser appuser; \
    else \
      useradd -m -d /home/appuser appuser; \
    fi

RUN set -eux && \
    if command -v apt-get >/dev/null 2>&1; then \
      apt-get update -qq && \
      apt-get upgrade -y -qq && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/*; \
    elif command -v apk >/dev/null 2>&1; then \
      apk update && \
      apk upgrade && \
      rm -rf /var/cache/apk/*; \
    elif command -v dnf >/dev/null 2>&1; then \
      dnf upgrade -y && \
      dnf clean all && \
      rm -rf /var/cache/dnf; \
    fi

USER appuser

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ -f /etc/passwd ] || exit 1

CMD [ "sh" ]
