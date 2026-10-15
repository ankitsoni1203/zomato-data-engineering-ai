# 🍽️ Zomato AI Data Engineering — End-to-End Project

> 🎥 **Video Tutorial:** [Zomato AI Data Engineering — Watch on YouTube](https://youtu.be/kYwaNMQ3XT8?si=Ge8ilVxkmGQS6iIg)
> 💻 **Reference Repository:** [Darshil Parmar — Original Project](https://github.com/darshilparmar/zomato-ai-data-engineering-end-to-end-project)

An end-to-end data engineering and AI analytics project that transforms raw food delivery data into analytics-ready models using modern cloud technologies. The project combines data ingestion, cloud warehousing, analytics engineering, workflow orchestration, and AI-powered applications.

**Pipeline:**
`CSV Dataset → Amazon S3 → Snowflake → dbt → Apache Airflow → OpenAI → Streamlit`

## 📌 Project Overview

This project demonstrates how raw Zomato-style food delivery data can be ingested into a cloud data lake, loaded into a data warehouse, transformed into structured analytical models, and prepared for intelligent business insights.

The architecture follows a medallion approach:

- **Bronze (RAW):** Source data loaded into Snowflake using `COPY INTO`.
- **Silver (STAGING):** Cleaned and standardized data transformations using dbt.
- **Gold (MARTS):** Business-ready dimensions, facts, and analytical models.
- **AI Layer:** Planned capabilities for review enrichment, RAG-based chat, and natural-language-to-SQL querying.

## 🏗️ Architecture



### High-Level Workflow

1. **Data Ingestion:** Collect food delivery datasets in CSV format.
2. **Amazon S3:** Store raw datasets in table-specific folders.
3. **Snowflake:** Load data into RAW tables through a storage integration.
4. **dbt:** Transform raw data into staging models and analytics marts.
5. **Apache Airflow:** Orchestrate and schedule pipeline tasks.
6. **OpenAI:** Add AI-powered review analysis and natural-language analytics.
7. **Streamlit:** Provide interactive dashboards and AI applications.

## 🛠️ Tech Stack

| Technology     | Purpose                                |
| -------------- | -------------------------------------- |
| Python         | Data processing and AI integration     |
| Pandas         | Data manipulation and cleaning         |
| Amazon S3      | Cloud data lake                        |
| Snowflake      | Cloud data warehouse                   |
| SQL            | Data querying and modeling             |
| dbt            | Data transformation and testing        |
| Apache Airflow | Workflow orchestration                 |
| OpenAI API     | LLM-powered capabilities               |
| RAG            | Context-grounded conversational search |
| Streamlit      | Interactive applications               |
| Docker         | Containerized development              |
| Git & GitHub   | Version control                        |

## 📂 Repository Structure

```text
.
├── airflow/
│   ├── dags/
│   │   └── zomato_batch.py
│   ├── Dockerfile
│   └── docker-compose.yaml
├── ai/
│   ├── enrich_reviews.py
│   ├── rag_chat.py
│   └── text_to_sql.py
├── zomato_dbt/
│   ├── models/
│   │   ├── staging/
│   │   └── marts/
│   ├── macros/
│   ├── tests/
│   └── dbt_project.yml
├── snowflake/
│   ├── 01_setup.sql
│   ├── 02_storage_integration.sql
│   ├── 03_stage_and_formats.sql
│   ├── 04_raw_tables.sql
│   └── 05_copy_into.sql
├── aws/
│   └── iam/
├── docs/
│   └── architecture.png
├── .gitignore
└── README.md
```

*Adjust the folder structure to match the files actually present in your repository.*

## 🔄 How the Pipeline Works

### 1. Data Ingestion into Amazon S3

Raw CSV datasets are organized into table-specific folders, such as:

```text
raw/restaurants/
raw/users/
raw/food/
raw/menu/
raw/orders/
raw/order_items/
raw/reviews/
```

This organization separates source data by entity and simplifies downstream ingestion.

### 2. S3 to Snowflake

Snowflake accesses the S3 bucket using a storage integration backed by AWS IAM.

The setup involves:

1. Creating an S3 read policy and IAM role.
2. Configuring a Snowflake storage integration.
3. Establishing the IAM trust relationship.
4. Creating an external stage and CSV file format.
5. Loading data into Snowflake using `COPY INTO`.

This approach avoids embedding AWS access keys directly in SQL scripts.

### 3. Data Transformation with dbt

The dbt project transforms raw data into analytical models.

**Staging — Silver Layer**

- Standardize column names and data types.
- Handle missing values and source-specific placeholders.
- Normalize text fields.
- Create useful derived attributes.

**Marts — Gold Layer**

- Restaurant and customer dimensions.
- Food and date dimensions.
- Order and order-item fact models.
- Revenue and order trend analysis.
- Restaurant and delivery performance metrics.
- Review analytics.

Data-quality tests can include `unique`, `not_null`, `relationships`, and `accepted_values`.

Incremental models and snapshots can be added where required and verified through dbt runs.

### 4. Workflow Orchestration with Apache Airflow

The intended pipeline workflow is:

```text
Load RAW Data
     ↓
Run dbt Transformations and Tests
     ↓
Enrich Customer Reviews
     ↓
Build AI Analytics Marts
```

Airflow is intended to schedule and coordinate pipeline tasks, with retries, logging, and failure handling.

### 5. AI-Powered Analytics

The planned AI layer extends the data warehouse with intelligent querying and review analysis.

**LLM-Powered Review Enrichment**

Use OpenAI models to extract structured information, such as sentiment and topics, from customer reviews.

**Retrieval-Augmented Generation (RAG)**

Build a conversational interface that retrieves relevant customer reviews and generates answers grounded in those records, with supporting sources.

**Natural Language to SQL**

Allow users to ask analytical questions in plain English and translate them into SQL queries against approved Snowflake models.

Generated SQL should be validated before execution, with read-only permissions and appropriate query limits.

**Streamlit Applications**

Provide a user-friendly interface for analytics dashboards, review exploration, and conversational data access.

## 🚀 Getting Started

### Prerequisites

- Python
- Git
- AWS account and S3 bucket
- Snowflake account
- dbt with the Snowflake adapter
- Docker and Docker Compose, if using Airflow
- OpenAI API key, if using the AI features

### 1. Clone the Repository

```bash
git clone https://github.com/ankitsoni1203/zomato-data-engineering-ai.git
cd zomato-data-engineering-ai
```

### 2. Configure Snowflake and AWS

Configure your Snowflake warehouse, database, schemas, roles, storage integration, external stage, and RAW tables.

Use the SQL scripts in the `snowflake/` directory if they exist in your repository. Configure the corresponding AWS IAM policy and trust relationship.

### 3. Configure dbt

Open a terminal in the directory containing `dbt_project.yml`.

For Windows PowerShell:

```powershell
cd zomato_dbt
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install dbt-snowflake
dbt debug
dbt build
```

Configure your Snowflake connection through your local dbt profile and environment variables. Run these commands from the actual dbt project directory.

### 4. Start Airflow

If Airflow has been configured, create a local `.env` file from the supplied example template, add your configuration, and run:

```powershell
docker compose build
docker compose up -d
```

Open the Airflow UI using the address configured in your Docker Compose file.

### 5. Run AI Applications

Once the AI scripts and dependencies are implemented, configure `OPENAI_API_KEY` securely and run the relevant application:

```bash
python ai/enrich_reviews.py
streamlit run ai/rag_chat.py
streamlit run ai/text_to_sql.py
```

These commands assume the corresponding scripts exist and are ready to run.

## 🔐 Security Best Practices

- Never commit `.env` files, API keys, passwords, or AWS credentials.
- Keep credentials outside source code.
- Use AWS IAM roles and Snowflake storage integrations.
- Apply least-privilege database permissions.
- Restrict AI-generated SQL to approved, read-only operations.
- Keep large datasets, virtual environments, logs, and generated dbt artifacts out of Git.
- Monitor cloud resource and API usage to control costs.

## 📊 Dataset and Project Resources

- **Dataset and project slides:** [Google Drive Folder](https://drive.google.com/drive/folders/1FEnGWMHhHzzTUCZOw1-YnH2v3DMuM-rs?usp=sharing)
- **Reference architecture:** [View Original Diagram](https://github.com/darshilparmar/zomato-ai-data-engineering-end-to-end-project/blob/main/docs/architecture.png)

Large CSV datasets should generally be stored outside GitHub. Check the dataset's usage terms before redistributing it.

## 📈 Project Status

Update this checklist according to your actual implementation and testing.

- [x] Core S3 → Snowflake → dbt pipeline foundation
- [x] Complete and validate all staging and marts models
- [x] Verify dbt data-quality tests
- [x] Complete Airflow orchestration
- [ ] Implement LLM review enrichment
- [ ] Implement RAG-based review chat
- [ ] Implement secure natural-language-to-SQL
- [ ] Build Streamlit dashboards and AI applications
- [ ] Add verified screenshots and sample outputs

## 🔮 Future Improvements

- Add automated data-quality monitoring.
- Implement pipeline failure alerts and retries.
- Add CI checks for dbt compilation and tests.
- Improve incremental processing and idempotency.
- Build additional business intelligence dashboards.
- Document deployment and cloud cost optimization.

## 📚 References and Acknowledgements

This project was developed as a hands-on learning experience using the following educational resources.

1. **Video Tutorial:** [Zomato AI Data Engineering — End-to-End Project by Darshil Parmar](https://youtu.be/kYwaNMQ3XT8?si=Ge8ilVxkmGQS6iIg)
2. **Original GitHub Repository:** [Zomato AI Data Engineering — Darshil Parmar](https://github.com/darshilparmar/zomato-ai-data-engineering-end-to-end-project)
3. **Dataset and Project Resources:** [Google Drive](https://drive.google.com/drive/folders/1FEnGWMHhHzzTUCZOw1-YnH2v3DMuM-rs?usp=sharing)
4. **Reference Architecture:** [Architecture Diagram](https://github.com/darshilparmar/zomato-ai-data-engineering-end-to-end-project/blob/main/docs/architecture.png)

The tutorial helped me learn about modern data engineering concepts, including cloud data ingestion, Snowflake warehousing, dbt transformations, medallion architecture, workflow orchestration, and AI-powered analytics.

I am applying these concepts through hands-on implementation, debugging, and experimentation. This repository documents my learning journey and implementation progress. Credit for the original tutorial and reference materials belongs to their respective creator.

---

**Built as a hands-on learning project in modern data engineering and AI-powered analytics.**
