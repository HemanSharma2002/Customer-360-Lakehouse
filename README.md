# Customer 360 Lakehouse

## Project Overview

**Customer 360 Lakehouse** is a Databricks-based data engineering project that will build a unified view of customers by integrating data from multiple business domains such as customers, orders, payments, web/app activity, and support interactions.

This project will focus primarily on **batch data engineering** using **Parquet source files**, PySpark, Delta Lake, dimensional modeling, incremental processing, SCD Type 2, and parameterized Databricks Jobs.

> **Note:** This is the initial project plan. This README will be updated throughout the project as new requirements, components, technologies, and engineering patterns are added.

---

## Project Goals

The initial goals are to learn and implement:

- Databricks batch data pipelines
- PySpark
- Parquet file processing
- Delta Lake
- Bronze / Silver / Gold architecture
- Incremental data processing
- Full and incremental loads
- Delta `MERGE`
- Fact and dimension tables
- Dimensional modeling
- Slowly Changing Dimensions (SCD Type 2)
- Data quality validation
- Data deduplication
- Parameterized Databricks Jobs
- Job dependencies and orchestration
- Retry and failure handling
- Business-oriented Gold datasets
- Power BI analytics

Additional concepts will be added as the project progresses.

---

## Initial Architecture

```text
                    Source Systems
                         |
          +--------------+--------------+
          |              |              |
      Customers        Orders       Payments
          |              |              |
      Web/App Activity             Support Tickets
          |              |              |
          +--------------+--------------+
                         |
                         v
                  Parquet Files
                   Raw / Landing
                         |
                         v
                    Bronze Delta
                         |
                         v
               Silver Standardized
                         |
              +----------+----------+
              |                     |
              v                     v
       Dimension Tables       Fact Tables
              |                     |
              +----------+----------+
                         |
                         v
                  Customer 360
                         |
                         v
                       Gold
                         |
                         v
                     Power BI
```

The architecture is intentionally kept simple at the beginning and will evolve as new requirements are introduced.

---

## Source Data

The initial source format for the project will be:

**Parquet**

Example source domains:

- Customers
- Orders
- Payments
- Web/App Activity
- Support Tickets

The exact schemas, columns, and data-generation approach will be defined during implementation.

---

## Medallion Architecture

### Bronze

Responsible primarily for ingesting and persisting source data with minimal transformation.

```text
Parquet → Bronze Delta
```

### Silver

Responsible for:

- Standardization
- Data type handling
- Data quality
- Deduplication
- Business-rule preparation
- Incremental processing

```text
Bronze → Silver
```

### Gold

Responsible for business-oriented datasets and Customer 360 analytics.

```text
Silver → Gold → Power BI
```

---

## Customer 360

The main business objective is to combine information from multiple domains into a unified customer view.

The final Customer 360 layer may contain information such as:

- Customer profile
- Customer region
- Order history
- Payment activity
- Customer lifetime value
- Engagement/activity information
- Support interactions

The exact metrics and attributes will be defined as the project progresses.

---

## Dimensional Modeling

The project will introduce dimensional modeling concepts that were not the primary focus of the previous Real-Time Sales Analytics project.

The initial model is expected to contain:

```text
                 Customer Dimension
                        |
                        |
             +----------+----------+
             |                     |
             v                     v
        Order Fact             Payment Fact
             |
             v
       Customer 360 / Gold
```

The final fact and dimension structure will be determined after the source schemas and business requirements are finalized.

---

## SCD Type 2

A major learning objective is implementing **Slowly Changing Dimension Type 2**.

The purpose is to preserve historical versions of changing customer attributes.

For example:

```text
Customer
   |
   +-- Region changes
   |
   v
Old record retained
   +
New record created
```

The exact SCD Type 2 implementation and columns will be designed during the Silver/Dimension phase.

---

## Incremental Processing

The project will support incremental processing rather than rebuilding every dataset from scratch for every run.

The design will explore:

- Identifying new records
- Identifying changed records
- Incremental transformations
- Delta `MERGE`
- Historical dimension maintenance

Full-load processing may also be supported where appropriate.

---

## Databricks Job Parameters

Parameterized Databricks Jobs will be an important part of the project.

The initial design may use parameters such as:

```text
environment = dev / test / prod
load_type   = full / incremental
run_date    = YYYY-MM-DD
```

Parameters may be passed from the workflow to individual notebook tasks.

The exact parameters will be finalized during workflow implementation.

---

## Job Orchestration

The project will use Databricks Jobs to orchestrate the pipeline.

The initial conceptual flow is:

```text
                Databricks Job
                     |
        +------------+------------+
        |            |            |
    Customers      Orders      Payments
        |            |            |
        +------------+------------+
                     |
                     v
                  Silver
                     |
                     v
              Dimensions / Facts
                     |
                     v
                Customer 360
                     |
                     v
                   Gold
                     |
                     v
                 Power BI
```

Job retries and failure handling will be incorporated where appropriate.

---

## Data Quality

Data quality will be introduced as part of the Silver processing.

Potential checks include:

- Required fields
- Valid identifiers
- Valid dates
- Valid numeric values
- Duplicate records
- Referential consistency
- Domain-specific business rules

The final rules will be documented once the source schemas are defined.

---

## Technology Stack

Initial technology stack:

| Technology | Purpose |
|---|---|
| Databricks | Data engineering platform |
| PySpark | Data processing |
| Spark | Distributed processing |
| Parquet | Source data format |
| Delta Lake | Lakehouse storage |
| Unity Catalog | Data governance/catalog |
| Databricks Jobs | Workflow orchestration |
| Power BI | Analytics and visualization |
| Git / GitHub | Version control |

Additional technologies may be added as the project evolves.

---

## Expected Repository Structure

```text
Customer-360-Lakehouse/
│
├── README.md
│
├── architecture/
│   └── architecture-diagram.png
│
├── notebooks/
│   ├── ingestion/
│   ├── transformation/
│   ├── dimensions/
│   ├── facts/
│   ├── customer_360/
│   ├── data_quality/
│   └── monitoring/
│
├── sql/
│   └── table_definitions.sql
│
├── docs/
│   └── design_notes.md
│
├── workflows/
│   └── README.md
│
└── data/
    └── sample/
```

The repository structure may change as implementation progresses.

---

## Planned Development Phases

### Phase 1 — Source Data

- Define source domains
- Define Parquet schemas
- Generate/create sample source data
- Set up raw storage

### Phase 2 — Bronze

- Build Bronze ingestion
- Store source data as Delta
- Validate ingestion

### Phase 3 — Silver

- Standardize data
- Apply data-quality rules
- Deduplicate
- Build incremental transformations

### Phase 4 — Dimensions

- Design dimensions
- Implement SCD Type 2
- Handle new and changed customer records

### Phase 5 — Facts

- Build fact tables
- Establish relationships with dimensions
- Implement incremental fact processing

### Phase 6 — Customer 360

- Combine customer-related facts and dimensions
- Create business metrics
- Build Gold datasets

### Phase 7 — Jobs

- Parameterize notebooks
- Build Databricks Jobs
- Add dependencies
- Configure retries
- Test failure scenarios

### Phase 8 — Analytics

- Connect Gold data to Power BI
- Build business dashboards
- Validate analytical results

### Phase 9 — Documentation

- Finalize architecture
- Document design decisions
- Document data model
- Document job parameters
- Document testing and recovery behavior

---

## Project Status

**Status:** 🚧 Initial planning

### Completed

- Project concept defined
- Initial architecture defined
- Parquet selected as the source format
- Databricks + PySpark + Delta Lake selected as the initial technology stack
- Parameterized Databricks Jobs identified as a core requirement

### Upcoming

- Define source schemas
- Create Parquet source datasets
- Design Unity Catalog structure
- Build Bronze ingestion

---

## Design Notes

This project will intentionally evolve.

Whenever a new capability is added—such as CDC, SCD variations, additional source systems, optimization, monitoring, new Gold datasets, or other engineering patterns—the README and design notes will be updated to reflect the actual implementation.

The documentation should describe what the project **actually implements**, rather than claiming features that have not yet been built.
