-- customer360_catalog
-- │
-- ├── raw
-- │   └── source files / landing data
-- │
-- ├── bronze
-- │   └── raw ingested Delta tables
-- │
-- ├── silver
-- │   └── cleaned + standardized data
-- │
-- ├── gold
-- │   ├── dimensions
-- │   ├── facts
-- │   └── customer_360
-- │
-- └── quarantine
--     └── rejected / invalid records
CREATE CATALOG IF NOT EXISTS customer360;
create schema if not exists customer_360.raw;
create schema if not exists customer_360.bronze;
create schema if not exists customer_360.silver;
create schema if not exists customer_360.gold;
create schema if not exists customer_360.quarantine;
drop schema if exists customer_360.default;

create volume if not exists customer_360.raw.source_files;