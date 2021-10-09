up:
	docker-compose up -d --remove-orphans --build

ps:
	docker-compose ps

logs:
	docker-compose logs -f --tail=100

qup:
	docker-compose up -d --remove-orphans localstack
	sleep 10
	docker run --rm -it -v $(shell pwd)/../.aws:/root/.aws amazon/aws-cli --region=us-east-2 --endpoint-url=http://host.docker.internal:4566 sqs create-queue --queue-name sqs2stdout

qls:
	docker run --rm -it -v $(shell pwd)/../.aws:/root/.aws amazon/aws-cli --region=us-east-2 --endpoint-url=http://host.docker.internal:4566 sqs list-queues

qhealth:
	curl localhost:4566 | jq

init:
	make qup && make up && make ps && make qhealth && make qls

stop:
	docker-compose stop

rm:
	docker-compose rm -f

rmi:
	docker rmi -f chaseisabelle/sqs2stdout

pull:
	docker pull chaseisabelle/sqs2stdout

nuke:
	make stop && make rm && make rmi

redo:
	make nuke && make pull && make init