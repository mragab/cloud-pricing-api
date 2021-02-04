help:
	echo "To start/stop the cloud pricing server, run: make start/stop"

start: startmongo startcloudpricing

stop: stopcloudpricing stopmongo

update:
	npm run update:dev -- --only=aws:bulk

startmongo:
	mkdir -p mongodb/database
	docker-compose up -d

stopmongo:
	docker-compose down

startcloudpricing: server.PID
	echo "Cloud pricing server started - PID: `cat $<`"
	echo "-----------------------------------------------------------"
	echo "If you have an empty or outdated database, run: make update"
	echo "To open the interactive graphql interface, run: make query"

server.PID:
	npm run dev cloudpricing_npm_app >> cloudpricing.log 2>&1 & echo $$! > $@;

stopcloudpricing: server.PID
	echo "Stopping cloud pricing server - PID: `cat $<` ..."
	kill `cat $<` && rm $<

query:
	open http://localhost:4000/graphql

.PHONY: help start stop query update startmongo stopmongo startcloudpricing stopcloudpricing

.DEFAULT: help

.SILENT: help start stop query update startmongo stopmongo startcloudpricing stopcloudpricing server.PID
