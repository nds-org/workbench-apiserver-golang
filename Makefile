BUILD_DATE := `date +%Y-%m-%d\ %H:%M`
VERSIONFILE := version.go
APP := apiserver

gensrc:
	rm -f $(VERSIONFILE)
	@echo "package main" > $(VERSIONFILE)
	@echo "const (" >> $(VERSIONFILE)
	@echo "  VERSION = \"0.1alpha\"" >> $(VERSIONFILE)
	@echo "  BUILD_DATE = \"$(BUILD_DATE)\"" >> $(VERSIONFILE)
	@echo ")" >> $(VERSIONFILE)
	rm -f build/bin/$(APP)-linux-amd64 build/$(APP)-darwin-amd64
	mkdir -p build/bin build/bin build/pkg
	GOOS=darwin GOARCH=amd64 go build -o build/bin/$(APP)-darwin-amd64
	docker run --rm -it -v `pwd`:/go/src/github.com/ndslabs/apiserver -v `pwd`/build/bin:/go/bin -v `pwd`/build/pkg:/go/pkg -v `pwd`/build.sh:/build.sh golang  /build.sh
	docker build -t ndslabs/apiserver:latest .
	docker push ndslabs/apiserver:latest
