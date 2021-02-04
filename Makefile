update:
	npm run update:dev -- --only=aws:bulk

startmongo:
	mkdir -p mongodb/database
	docker-compose up -d

stopmongo:
	docker-compose down

run:
	npm run dev

query:
	open http://localhost:4000/graphql
