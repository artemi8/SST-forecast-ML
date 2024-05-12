docker build -t data_ingestion_service ./data_ingestion_service/
docker build -t data_preprocessing_service ./data_preprocessing_service/
docker build -t inference_service ./inference_service/
docker build -t airflow_service ./airflow_service/


docker-compose up
