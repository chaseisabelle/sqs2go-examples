package main

import (
	"flag"
	"fmt"
	"github.com/chaseisabelle/sqsc"
	"log"
	"time"
)

func main() {
	reg := flag.String("region", "us-east-2", "aws region")
	url := flag.String("url", "", "the queue url")
	qep := flag.String("endpoint", "http://localhost:4566", "the queue endpoint")
	bo := flag.Int("interval", 100, "time (milliseconds) to sleep between producing messages")

	flag.Parse()

	if *reg == "" {
		log.Fatalln("aws region required")
	}

	if *url == "" {
		log.Fatalln("queue url required")
	}

	if *qep == "" {
		log.Fatalln("queue endpoint required")
	}

	if *bo <= 0 {
		log.Fatalln("sleep must be greater than 0")
	}

	cfg := &sqsc.Config{
		Region:   *reg,
		URL:      *url,
		Endpoint: *qep,
	}

	cli, err := sqsc.New(cfg)

	if err != nil {
		log.Fatalln(err)
	}

	dur := time.Duration(*bo) * time.Millisecond

	for i := 1; true; i++ {
		id, err := cli.Produce(fmt.Sprintf("message #%d", i), 0)

		if err != nil {
			log.Println(err)
		}

		if id != "" {
			log.Println(fmt.Sprintf("message #%d: %s", i, id))
		}

		time.Sleep(dur)
	}
}
