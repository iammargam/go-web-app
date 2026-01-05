FROM golang:1.22.5 as base

WORKDIR /app

COPY . .

RUN go mod download

RUN go build -o main .

# Final stage: Distroless image to make Docker file more secure and reduce the image size

FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD [ "./main" ]