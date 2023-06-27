go get golang.org/x/mobile/bind
gomobile bind -target=android -androidapi 23 ./libsyncreve
go mod tidy
mv ./libsyncreve.aar ../../android/app/libs/
mv ./libsyncreve-sources.jar ../../android/app/libs/
