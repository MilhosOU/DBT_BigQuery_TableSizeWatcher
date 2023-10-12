{% set project = var('project') %}
{% set schema = var('schema') %}
{% set tables = var('tables') %}
{% set sample_size = var('sample_size') %}
{% set cte_list = [] %}

{% if schema is not none %}

with

{% for table in tables %}

    {% set cte_name = "cte_" ~ table %}
    {% do cte_list.append(cte_name) %}

    {{ cte_name }} as (

        {% set column_query %}
        select
            column_name,
            data_type
        from {{ project }}.{{ schema }}.INFORMATION_SCHEMA.COLUMNS
        where table_name = '{{ table }}'
        {% endset %}

        {% set results = run_query(column_query) %}

        with
            sample_data as (
                select *
                from {{ project }}.{{ schema }}.{{ table }}
                order by rand()
                limit {{ sample_size }}
            ),
            avg_sizes as (
                {% for row in results %}
                    select
                        '{{ row['column_name'] }}' as column_name,
                        '{{ row['data_type'] }}' as data_type, 
                        avg(case
                            when '{{ row['data_type'] }}' = 'BYTES'
                            then length(cast('{{ row['column_name'] }}' as bytes))
                            else length(cast('{{ row['column_name'] }}' as string))
                        end) as avg_size
                    from sample_data
                    group by 1, 2
                    {% if not loop.last %}
                        union all
                    {% endif %}
                {% endfor %}
            ),
            row_count as (
                select count(*) as total_row_count
                from {{ project }}.{{ schema }}.{{ table }}
            )
        select
            '{{ schema }}' as schema_name,
            '{{ table }}' as table_name,
            a.column_name,
            a.data_type,
            a.avg_size,
            r.total_row_count,
            a.avg_size * r.total_row_count as estimated_column_size_chars,
            (a.avg_size * r.total_row_count) / POW(2, 30) as estimated_column_size_gb
        from avg_sizes a, row_count r)

{% if not loop.last %}
    ,
{% endif %}

{% endfor %}

{% for cte in cte_list %}
    select
        CURRENT_DATE as date,
        {{ sample_size }} as sample_size,
        *
    from {{ cte }}
    {% if not loop.last %}
    union all
    {% endif %}
{% endfor %}

{% endif %}
