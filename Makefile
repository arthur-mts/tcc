.PHONY: database down-database download-data

download-data:
	wget https://dadosabertos.camara.leg.br/arquivos/deputados/json/deputados.json -O scripts/deputados.json
	wget https://dadosabertos.camara.leg.br/arquivos/proposicoes/json/proposicoes-2023.json -O scripts/proposicoes-2023.json
	wget https://dadosabertos.camara.leg.br/arquivos/proposicoesAutores/json/proposicoesAutores-2023.json -O scripts/proposicoesAutores-2023.json

generate-model-build:
	docker compose -f docker-compose-execute.yaml build
generate-model:
	docker compose -f docker-compose-execute.yaml up

jupyer-local-build:
	docker compose -f docker-compose-jupyter-local.yaml build
jupyer-local:
	docker compose -f docker-compose-jupyter-local.yaml up
jupyer-local-down:
	docker compose -f docker-compose-jupyter-local.yaml down