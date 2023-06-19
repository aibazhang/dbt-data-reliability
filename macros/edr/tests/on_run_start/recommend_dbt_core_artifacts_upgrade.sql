{% macro recommend_dbt_core_artifacts_upgrade() %}
    {% if elementary.get_config_var("mute_dbt_upgrade_recommendation") %}
        {% do return(none) %}
    {% endif %}

    {% set major, minor, revision = dbt_version.split(".") %}
    {% set major = major | int %}
    {% set minor = minor | int %}
    {% if major < 1 or major == 1 and minor < 4 %}
        {%- set msg %}
You are using dbt version {{ dbt_version }}.
Elementary received major performance improvements in dbt version 1.4.0 or later.
You can find instructions for upgrading here: https://docs.getdbt.com/docs/installation
More information on the performance impact can be found here: https://docs.elementary-data.com/dbt/on-run-end_hooks#performance-impact-of-on-run-end-hooks
This message can be muted by setting the 'mute_dbt_upgrade_recommendation' var to true.
        {% endset %}
        {% do print(msg) %}
    {% endif %}
{% endmacro %}
