
{% macro base_model_userInput(sql_query, UNIQUE_KEY=[], ARRIVAL_COLUMN = None, materialized="incremental") %}
  {{ return(adapter.dispatch('base_model_userInput', 'ownmacro')(sql_query, UNIQUE_KEY, ARRIVAL_COLUMN, materialized)) }}
{% endmacro %}

{% macro default__base_model_userInput(sql_query, UNIQUE_KEY, ARRIVAL_COLUMN, materialized) %}
{% set SQL_model =ctes_input(sql_query) %}
{% set base_model_sql %}

{{ "{{ config(materialized='" ~ materialized ~ "',unique_key=" ~ UNIQUE_KEY ~ "}}" }}

{{SQL_model }}

{% endset %}



{% if execute %}
{{ print(base_model_sql) }}
{% do return(base_model_sql) %}

{% endif %}
{% endmacro %}
