fail:
	go install -buildmode=shared std
	go install -buildmode=shared -linkshared -gcflags='-d export' github.com/bryanpkc/pkgdef-example/arith
	go build -linkshared -o main main.go
	ldd ./main | grep arith.so
	./main
	sed -i.orig 's/x+y/x-y/' arith/add.go
	go install -buildmode=shared -linkshared -gcflags='-d export' github.com/bryanpkc/pkgdef-example/arith
	ldd ./main | grep arith.so
	./main

clean:
	mv arith/add.go.orig arith/add.go
	rm ./main

realclean:
	rm -rf $(shell go env GOPATH)/pkg
