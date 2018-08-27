view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id;;
    value_format_name: id
  }

  filter: date_filter {
    type: date
  }

  parameter: keyword1 {
    type: unquoted
  }
  parameter: keyword2 {
    type: unquoted
  }
  parameter: keyword3 {
    type: unquoted
  }

  dimension: keyword_1 {
    hidden: yes
    type: string
    sql: '{% parameter keyword1 %}' ;;
  }

  dimension: keyword_2 {
    hidden: yes
    type: string
    sql: '{% parameter keyword2 %}' ;;
  }

  dimension: keyword_3 {
    hidden: yes
    type: string
    sql: '{% parameter keyword3 %}' ;;
  }

  dimension: keyword1_yesno {
    hidden: yes
    type: yesno
    sql: ${status} LIKE CONCAT("%",${keyword_1},"%") ;;
  }

  dimension: keyword2_yesno {
    hidden: yes
    type: yesno
    sql: ${status} LIKE CONCAT("%",${keyword_2},"%") ;;
  }

  dimension: keyword3_yesno {
    hidden: yes
    type: yesno
    sql: ${status} LIKE CONCAT("%",${keyword_3},"%") ;;
  }

  measure: count_keyword1 {
    type: count
    group_label: "Keyword Measures"
    filters: {
      field: keyword1_yesno
      value: "yes"
    }
  }

  measure: count_keyword2 {
    group_label: "Keyword Measures"
    type: count
    filters: {
      field: keyword2_yesno
      value: "yes"
    }
  }

  measure: count_keyword3 {
    group_label: "Keyword Measures"
    type: count
    filters: {
      field: keyword3_yesno
      value: "yes"
    }
  }


## hello local repo

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      time_of_day,
      date,
      day_of_month,
      day_of_week_index,
      week,
      month,
      month_num,
      month_name,
      quarter,
      quarter_of_year,
      year,
      fiscal_year,
      fiscal_month_num
    ]
    sql: ${TABLE}.created_at ;;
  }


  dimension: last_quarter_offset {
    type: date_quarter_of_year
    hidden: no
    sql: DATE_ADD( ${created_raw}, INTERVAL -1 QUARTER) ;;
  }

  dimension: is_offset_quarter {
    type: yesno
    hidden: no
    sql: ${created_quarter_of_year} = ${last_quarter_offset};;
  }

  measure: count_last_quarter {
    type: count_distinct
    filters: {
      field: is_offset_quarter
      value: "yes"
    }
    sql: ${id} ;;
  }

  dimension: last_complete_business_day {
    type: date
    description: "Returns the date of the last business day relative to today"
    sql: CASE
    WHEN DAYOFWEEK(NOW()) IN(1,2,3,4,5) THEN DATE_ADD(NOW(), interval -1 DAY)
      WHEN DAYOFWEEK(NOW()) = 6 THEN DATE_ADD(NOW(), interval -2 DAY)
      ELSE DATE_ADD(DAYOFWEEK(NOW()), interval -3 DAY) END;;
  }

  dimension: is_last_complete_business_day {
    description: "used as a filter to show the last business day on a dashboard"
    type: yesno
    sql: ${created_date}=${last_complete_business_day}
    ;;
  }


  measure: max_time_raw {
    type: date
    sql: MAX(${created_raw} ;;
  }

  dimension: first_of_month {
    type: string
    sql: CAST(CONCAT(${created_month},'-01') AS DATE) ;;
  }

  dimension: date_reformat {
    type: string
    sql: CONCAT(${created_month_num},"-",${created_day_of_month},"-",${created_year}) ;;
  }


  measure: max_time {
    type: string
    sql: max(${created_time});;
  }


  dimension: year_string {
    type: string
    sql:
    CASE
    WHEN YEAR(NOW()) - YEAR(${created_date}) = 1 THEN "(last year)"
    ELSE ""
    END;;
  }

  dimension: status_bool {
    type: yesno
    sql: ${id} < 100 ;;
  }


  dimension: status {
    hidden:  no
    type: string
    sql: ${TABLE}.status ;;
#     html: {% if order_items.less_than_100._value == 'No' %}
#     <p style="color: black; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
#     {% endif %};;
    }




#   parameter: selected_status {
#     type: string
#     suggestions: ["complete", "pending","canceled"]
#   }
#
#   dimension: is_selected_status {
#     type: string
#     sql:
#     CASE
#       WHEN ${status} = {% parameter selected_status %} THEN 'Selected Status'
#       WHEN ${status} != {% parameter selected_status %} THEN 'Other Status'
#       ELSE NULL END;;
#   }


  dimension: is_complete {
    type: yesno
    sql: ${status} = "complete" ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }


  measure: count {
    type: count
    drill_fields: [id, created_date]
#     html: {% if value < 15 %}
#       <p style="color: black; background-color: tomato; border-radius: 100px; font-size:120%; text-align:center">{{ rendered_value }}</p>
#     {% else %}
#      <p style="color: black; background-color: lightgreen; border-radius: 100px; font-size:120%; text-align:center">{{ rendered_value }}</p>
#     {% endif %}
#     ;;
#     html: {% if value < 15 %}
#           <p style="color: black; background-color: tomato; border-radius: 100px; font-size:120%; text-align:center"> <a href: {{linked_value}} </a> </p>
#           {% else %}
#           <p style="color: black; background-color: lightgreen; border-radius: 100px; font-size:120%; text-align:center"> <a href: {{linked_value}} </a> </p>
#           {% endif %}
#           ;;



    }

#   measure: percent_of_total {
#     type: percent_of_total
#     sql: ${count} ;;
#     value_format_name: percent_0
#   }

    dimension: test_num {
      type: number
      sql: 0.11 ;;
      html:

      {% if value > 0 and value <=0.05 %}
      0-5%
      {% elsif value 0.05 and value <=0.1 %}
      5-10%
      {% elsif value 0.1 and value <=0.15 %}
      10-15%
      {% elsif value 0.15 and value <=0.2 %}
      15-20%
      {% endif %}
      </a>;;
    }
#<a href="#drillmenu" target="_self">
    measure: percent_of_total{
      type: percent_of_total
      sql: ${count} ;;
#       value_format: "0.00\%"
      ## doesn't work, all return in the first if...because percent of total runs second?
      html:
      <a href="#drillmenu" target="_self">
      {% if value > 0 and value <=0.05 %}
      0-5%
      {% elsif value 0.05 and value <=0.1 %}
      5-10%
      {% elsif value 0.1 and value <=0.15 %}
      10-15%
      {% elsif value 0.15 and value <=0.2 %}
      15-20%
      {% endif %}
      </a>;;
    }

#   dimension: status {
#     hidden:  no
#     type: string
#     sql: ${TABLE}.status ;;
# #     link: {
# #       label: "Status Dash"
# #       url: "/dashboards/6?Status={{value | url_encode}}"
# #
# #
# #     }
# ## THIS DOESN'T WORK
# #     html: {% if value == "complete" %}
# #     {{rendered_value}} {{orders.year_string._rendered_value}}
# #     {% else %}
# #     {{rendered_value}}
# #     {% endif %} ;;
# ## THIS WORKS
#     html:
#
#     {{rendered_value}} {{orders.year_string._rendered_value}};;
#   }

  }
