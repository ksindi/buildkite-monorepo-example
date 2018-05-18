FROM buildkite/agent:3.0

RUN apk add --no-cache \
  # Languages
  python3 python3-dev py-setuptools \
  # Libraries
  musl-dev libressl-dev libffi-dev yaml-dev libxslt-dev \
  # Utilities
  make jq wget curl \
  # System
  ca-certificates openssl

RUN pip3 install --upgrade pip setuptools
RUN python3 -m ensurepip && \
    pip3 install setuptools \
      buildpipe

RUN update-ca-certificates

COPY hooks/ /buildkite/hooks

ENTRYPOINT []
CMD ["buildkite-agent-entrypoint", "start"]
