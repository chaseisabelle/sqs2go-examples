up:
	docker-compose up -d --remove-orphans --build

ps:
	docker-compose ps

logs:
	docker-compose logs -f --tail=100

qup:
	docker-compose up -d --remove-orphans localstack
	sleep 10
	docker run --rm -it -v $(shell pwd)/.aws:/root/.aws amazon/aws-cli --region=us-east-2 --endpoint-url=http://host.docker.internal:4566 sqs create-queue --queue-name sqs2nothing
	docker run --rm -it -v $(shell pwd)/.aws:/root/.aws amazon/aws-cli --region=us-east-2 --endpoint-url=http://host.docker.internal:4566 sqs create-queue --queue-name sqs2stdout
	docker run --rm -it -v $(shell pwd)/.aws:/root/.aws amazon/aws-cli --region=us-east-2 --endpoint-url=http://host.docker.internal:4566 sqs create-queue --queue-name sqs2log
	docker run --rm -it -v $(shell pwd)/.aws:/root/.aws amazon/aws-cli --region=us-east-2 --endpoint-url=http://host.docker.internal:4566 sqs create-queue --queue-name sqs2file

qls:
	docker run --rm -it -v $(shell pwd)/.aws:/root/.aws amazon/aws-cli --region=us-east-2 --endpoint-url=http://host.docker.internal:4566 sqs list-queues

qhealth:
	curl localhost:4566 | jq

init:
	touch sqs2file.out && make qup && make up && make ps && make qhealth && make qls

stop:
	docker-compose stop

rm:
	docker-compose rm -f

rmi:
	docker rmi -f chaseisabelle/sqs2nothing \
		chaseisabelle/sqs2stdout \
		chaseisabelle/sqs2log \
		chaseisabelle/sqs2file

pull:
	docker pull chaseisabelle/sqs2nothing && \
	docker pull chaseisabelle/sqs2stdout && \
	docker pull chaseisabelle/sqs2log && \
	docker pull chaseisabelle/sqs2file

nuke:
	make stop && make rm && make rmi && make cleanup

redo:
	make nuke && make pull && make init

cleanup:
	rm -rf sqs2file.out