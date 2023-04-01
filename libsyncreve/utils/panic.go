package utils

func IfPanic(err error) {
	if err != nil {
		panic(err)
	}
}
