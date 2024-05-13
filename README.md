
# SST Forecasting Using Big Data Tools

## Project Overview

This project is dedicated to forecasting Sea Surface Temperature (SST) using a sophisticated data pipeline and machine learning models. Leveraging the ERA5 reanalysis hourly data from the Climate Data Store (CDS), our approach employs two forecasting models: Facebook's Prophet and the RandomForest Regressor from Apache Spark's MLlib. This project showcases the integration of big data technologies and their scalability with an increasing influx of data, critical for dynamic environmental forecasting.

### Key Objectives

- **Scalability**: Demonstrate how our big data solution scales with increased data inflow.
- **Comparative Analysis**: Provide a comparative study of the two forecasting models used.
- **Significance**: Highlight the importance of forecasting SST in the context of global climate monitoring and its wider impacts.

## Architecture

The project utilizes a robust architecture involving several big data tools:
- **Apache Airflow**: Manages the workflow automation.
- **Apache Spark**: Processes data and runs ML models.
- **Apache Cassandra**: Serves as the primary database for storing incoming and processed data.
- **PostgreSQL**: Stores processed data for reporting and visualization.
- **Tableau**: Used for visualizing the forecasting results.

### Data Pipeline

1. **Data Ingestion**: A Docker service pulls data from the CDS cloud using the CDS API, pushing it to Cassandra. This process is triggered by Apache Airflow.
2. **Data Processing**: Triggered by Airflow, this step involves the Spark data-processing service to handle and prepare data for modeling.
3. **Model Inference**: Within the same Spark data-processing service, the Facebook Prophet model runs, forecasting SSTs with a 95% confidence interval.
4. **Data Storage and Visualization**: Post-modeling, the data is pushed to a PostgreSQL database. A Tableau dashboard connects to this database, refreshing the dashboard with new data for visualization.

## Getting Started

### Prerequisites

Ensure Docker and Docker Compose are installed on your machine. Access to CDS API credentials and necessary configurations for Apache Airflow, Apache Spark, Cassandra, PostgreSQL, and Tableau are also required.

### Installation and Setup

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   ```

2. **Navigate to Deployment Directory**
   ```bash
   cd path/to/deployment/directory
   ```

3. **Build and Run the Docker Compose**
   ```bash
   docker-compose up --build -d
   ```

This will start all the necessary services, including launching the Airflow dashboard accessible at `http://localhost:8080`.

### Configuring Tableau

After setting up the infrastructure, connect Tableau to the PostgreSQL database to access and visualize the forecasted SST data.

## Usage

Details on using the deployed system, accessing the Airflow dashboard, and interpreting the data on the Tableau dashboard can be included here based on your project specifics.

## Contributors

List of team members and their roles, if applicable.

## License

Specify the license under which this project is made available.
