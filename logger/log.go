package logger

import (
	"bytes"
	"log"
	"net/http"
	"os"

	glog "github.com/kataras/golog"
)

var Logger = glog.New()

type remote struct{}

func (r remote) Write(data []byte) (n int, err error) {
	go func() {
		req, err := http.NewRequest("POST", "http://localhost:8010/log", bytes.NewBuffer(data))
		if err == nil {
			req.Header.Set("Content-Type", "application/json")

			client := &http.Client{}
			resp, _ := client.Do(req)
			defer resp.Body.Close()
		}
	}()
	return len(data), nil
}

func SetLoggingOutput(localStdout bool) {
	if localStdout {
		configureLocal()
		return
	}
	configureRemote()
}

func configureLocal() {
	file, err := os.OpenFile("logs.txt", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0666)
	if err != nil {
		log.Fatal(err)
	}

	Logger.SetOutput(os.Stdout)
	Logger.SetLevel("debug")
	Logger.SetLevelOutput("info", file)
}

func configureRemote() {
	r := remote{}
	Logger.SetLevelFormat("info", "json")
	Logger.SetLevelOutput("info", r)
}
