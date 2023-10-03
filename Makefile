PROJECT_DIR = $(shell pwd)
PROJECT_BIN = $(PROJECT_DIR)/bin
$(shell [ -f bin ] || mkdir -p $(PROJECT_BIN))
PATH := $(PROJECT_BIN):$(PATH)

## LINTERS
GOLANGCI_LINT = $(PROJECT_BIN)/golangci-lint

.PHONY: .install-linter .lint-version lint lint-fast
.install-linter:
	@[ -f $(PROJECT_BIN)/golangci-lint ] || curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(PROJECT_BIN) v1.54.2
.lint-version: .install-linter
	@$(GOLANGCI_LINT) --version
lint: .install-linter
	$(GOLANGCI_LINT) run ./... --config=./.golangci.pipeline.yaml
lint-fast: .install-linter
	$(GOLANGCI_LINT) run ./... --fast --config=./.golangci.pipeline.yaml

.PHONY: .dev-tools
.dev-tools:
	@[ -f $(PROJECT_BIN)/protoc-gen-go ] || GOBIN=$(PROJECT_BIN) go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.31.0
	@[ -f $(PROJECT_BIN)/protoc-gen-go-grpc ] || GOBIN=$(PROJECT_BIN) go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.3.0

.PHONY: generate .generate-api-v1
generate: .dev-tools
	make .generate-api-v1
.generate-api-v1:
	protoc --proto_path=api/chat_v1 \
	--go_out=pkg/api/chat_v1 --go_opt=paths=source_relative \
	--plugin=protoc-gen-go=bin/protoc-gen-go \
	--go-grpc_out=pkg/api/chat_v1 --go-grpc_opt=paths=source_relative \
	--plugin=protoc-gen-go-grpc=bin/protoc-gen-go-grpc \
	api/chat_v1/chat.proto
