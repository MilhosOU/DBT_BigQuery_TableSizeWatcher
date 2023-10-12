# BQ_TableSizeWatcher

## Description

Monitors and estimates sizes of specified tables and columns in a BigQuery cluster. This tool is indispensable for those managing large-scale BigQuery clusters, especially when dealing with billions of rows and potentially unstructured data. 

## Why This Tool Is Important

In the landscape of large BigQuery clusters, resource efficiency is non-negotiable. Tables can exponentially grow, affecting both costs and query performance. BQ_TableSizeWatcher offers granular visibility into the size footprint of individual tables and columns, enabling proactive management and optimization.

It's important to note that querying the size of each column in such massive datasets can result in significant expenses. Hence, specifying a sample size is vital for operational efficiency. Querying large tables in their entirety is both cost-prohibitive and resource-intensive. A sample provides a quick and economical size estimation, while maintaining a high degree of accuracy.

## Variables

- `project`: The BigQuery project ID.
- `schema`: The BigQuery schema you want to monitor.
- `tables`: List of tables to monitor.
- `sample_size`: Number of rows to sample for size estimation. This is critical for cost-effective data observability.

## How to Run

To run the model, set the variables as follows:

```
dbt build --select BQ_TableSizeWatcher --vars '{"schema": "<YOUR-SCHEMA>", "tables": [<YOUR-TABLES>], "sample_size": <YOUR-SAMPLE-SIZE>}'
```

## Example Output

![example-output](https://github.com/robertocommit/DBT_BigQuery_TableSizeWatcher/assets/30242227/c8224ccc-5052-42e2-922e-6e314272d1eb)
