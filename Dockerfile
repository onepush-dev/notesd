# notesd on Railway: the official image (cassiozen/notesd 1.5.1, MIT), unmodified.
#  - Runs as root so it can write to Railway's root-owned volume at /data
#    (upstream runs as distroless uid 65532, which cannot write there).
#  - NOTESD_OWNER_USERNAME is baked in; the template generates
#    NOTESD_OWNER_PASSWORD per deploy, so notesd creates the owner account on
#    first start and sign-up is never open to the first visitor.
FROM ghcr.io/cassiozen/notesd:1.5.1@sha256:0c3049ee80c0d5ce7e65c8f2ab84ba61beec91063807c1b9f4a219eb0db2761a
USER 0:0
ENV PORT=8080 \
    NOTESD_DATA_DIR=/data \
    NOTESD_OWNER_USERNAME=admin
EXPOSE 8080
ENTRYPOINT ["notesd"]
