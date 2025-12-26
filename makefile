run:
	air --build.cmd "go build -o app/api/main ./app/api" --build.bin "./app/api/main"

test:
	go test -v ./...

coverage:
	go test -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out -o coverage.html

build:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o bin/app main.go

pretty:  
	make run | jq -R 'fromjson? | select(type == "object")'

upgrade:
	go get -u -v ./...
	go mod tidy
	go mod vendor

lint:
	CGO_ENABLED=0 go vet ./...
	staticcheck -checks=all ./...

dev-tools:
	go install github.com/air-verse/air@latest
	brew install jq

swagger:
	go install github.com/swaggo/swag/cmd/swag@latest
	go get -u github.com/swaggo/http-swagger
	go get -u github.com/swaggo/swag
	swag init --parseDependency -g main.go