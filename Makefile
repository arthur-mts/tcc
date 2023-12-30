.PHONY: database down-database download-data

download-data:
    wget https://dadosabertos.camara.leg.br/arquivos/deputados/json/deputados.json -O scripts/deputados.json
    wget https://dadosabertos.camara.leg.br/arquivos/proposicoes/json/proposicoes-2023.json -O scripts/proposicoes-2023.json
    wget https://dadosabertos.camara.leg.br/arquivos/proposicoesAutores/json/proposicoesAutores-2023.json -O scripts/proposicoesAutores-2023.json

down-database:
	docker compose --project-directory database down -v

database:
	docker compose --project-directory database up -d
