view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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
      week,
      month,
      month_num,
      month_name,
      quarter,
      year,
      fiscal_year,
      fiscal_month_num
    ]
    sql: ${TABLE}.created_at ;;
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


  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    link: {
      label: "Status Dash"
      url: "/dashboards/6?Status={{value | url_encode}}"
    }
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
    html: {% if value < 15 %}
          <p style="color: black; background-color: tomato; border-radius: 100px; font-size:120%; text-align:center"> <a href: {{linked_value}} </a> </p>
          {% else %}
          <p style="color: black; background-color: lightgreen; border-radius: 100px; font-size:120%; text-align:center"> <a href: {{linked_value}} </a> </p>
          {% endif %}
          ;;

    }


    measure: percent_of_total{
      type: percent_of_total
      sql: ${count} ;;
      value_format: "0.00\%"
    }

  }
