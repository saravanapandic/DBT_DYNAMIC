
{% macro base_model_userInput(sql_query, UNIQUE_KEY=[], ARRIVAL_COLUMN = None, materialized="incremental" , sql_incr_cln ="fdf" , model_incr_cln="dfsdf") %}
  {{ return(adapter.dispatch('base_model_userInput', 'ownmacro')(sql_query, UNIQUE_KEY, ARRIVAL_COLUMN, materialized, sql_incr_cln, model_incr_cln)) }}
{% endmacro %}

{% macro default__base_model_userInput(sql_query, UNIQUE_KEY, ARRIVAL_COLUMN, materialized,sql_incr_cln, model_incr_cln) %}
{% set SQL_model =ctes_input(sql_query) %}
{% set base_model_sql %}
{{ "{{ config(materialized='" ~ materialized ~ "',unique_key=" ~ UNIQUE_KEY ~ "}}" }}

{{SQL_model }}

{{ "{% if is_incremental() %}"}}
{{"where " ~ sql_incr_cln ~ "> (select max(" ~ model_incr_cln ~") from {{this}}" }}

{% endset %}



{% if execute %}
{{ print(base_model_sql) }}
{% do return(base_model_sql) %}

{% endif %}
{% endmacro %}
