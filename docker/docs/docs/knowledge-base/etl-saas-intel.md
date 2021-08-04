---
title: ETL SaaS Intel
slug: /knowledge-base
---

:::info
Intel provided by Talend (mid-2020)
:::

## What we can do that they can’t
- all-in-one solution for ETL management / monitoring and big data processing
	- ETL service itself can be deploy in _one machine_, whereas with Talend there’s at least a few components involved
- Data validation is on by default, and does not require further configuration from users aside from specifying data dictionary with corresponding table name (edit one file only, can be used throughout the system)
- Spark is bundled into our solution —> no need to create always-on spark cluster, which means we save time and $$$
- For similar building blocks we can create an abstraction to save time —> eg. Create [read from DBx —> write to temp —> TRANSFORMx —> write to STORAGEx], only need to supply dbname and output location. Data validation is already abstracted.
- support most forms of database security validation, whereas in Talend it needs a lot of hacky workaround
- Can switch dev/prod environment with a single click

## Technical info
- supports Thai encoding
- `data preparation` —> supports basic transformation, such as `concat`, `rename` —> all done via GUI
- `data stewardship` —> (data) bug report system from downstream user to data owner
- `pipeline designer` —> lightweight ETL, can only designate output destination from `source A` to `source B`, does not provide _data validation_ at this stage
- Talend studio —> for designing ETL
- `data quality` —> data profiling such as `stats`, `missing rate`
- **zero coding**, altho the generated code is in `Java`. No proprietary code
- can share repo between users
- All architecture components can be hosted on either on-prem or cloud. Could be _all_ on-prem, or _some_ on prem. Eg. Processing server on prep, database on cloud
	-  `Talend management platform` (cloud only, frontend, maintained by Talend by default) —> provides monitoring
- storage providers, aside on cloud, are NAS / FTP, etc.
- Talend would perform initial deployment and provides training session. Then the IT team would  then maintain the infrastructure
	- Could ask Izeno (partnered Talend firm in SEAsia) to maintain, but this means more $$$
- need to create table data dict manually via GUI
- Security:
	- supports VPC if all required infra components are on cloud
	- somewhat supports SSL/mTLS cert, but have to store the key in the JVM (during deployment stage, not always work if set SSL connection parameter via JDBC parameter in GUI)
	- tunneling is not supported out of the box, have to set it up on the server side
- `schema validation` isn’t baked into `ingest/write` operation, have to create validation flow manually:
	- Ingestion > validate > transform > validate > write
- can encrypt / decrypt / masking (nullification) data
- provides `db connection` overview —> ETL uses _what_ connection, eg. Postgres1, mysql1, mysql2, etc.
- for spark job, have to submit spark job to a spark cluster —> something like always-on spark cluster, $$$$$$
- can submit python script in a pipeline —> albeit very hacky
- pricing —> waiting for email reply
- execution time (discussion to deployment) —> waiting for email reply
- doesn’t seem to have built in dev/prod environment switch out of the box
