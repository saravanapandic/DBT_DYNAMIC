dbt-generator generate -s models/code_generato/source_check.yml -o models/code_generato/
dbt-generator sf-transform -m models/code_generato/ -o models/tf_code/ --split-columns 1   
