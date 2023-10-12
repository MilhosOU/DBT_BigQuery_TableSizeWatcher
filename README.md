# BQ_TableSizeWatcher

## Description

Monitors and estimates sizes of specified tables and columns in a BigQuery cluster.

## Why This Tool Is Important

In large BigQuery clusters, managing resources efficiently is crucial. Tables can quickly grow in size, leading to increased costs and slower query performance. BQ_TableSizeWatcher helps in identifying the size footprint of individual tables and columns, allowing for proactive management and optimization.

Specifying a sample size is important for efficiency. Querying large tables in their entirety can be costly and slow. Using a sample allows for quicker, less resource-intensive size estimations, while still providing a reasonable approximation.

## Variables

- `project`: The BigQuery project ID.
- `schema`: The BigQuery schema you want to monitor.
- `tables`: List of tables to monitor.
- `sample_size`: Number of rows to sample for size estimation.

## Example

To run the model, set the variables like so:

```
dbt build --select BQ_TableSizeWatcher --vars '{"schema": "<YOUR-SCHEMA>", "tables": [<YOUR-TABLES>], "sample_size": <YOUR-SAMPLE-SIZE>}'
```
