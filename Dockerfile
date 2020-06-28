FROM golang:1.14.4 AS builder
WORKDIR /src
COPY . .
RUN make dist
RUN tar -xz -C build -f build/`ls -1 build | grep istanbul-tools`

FROM alpine:latest
COPY --from=builder /src/build/istanbul /bin/
ENTRYPOINT [ "/bin/istanbul" ]