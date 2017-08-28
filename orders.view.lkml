view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      time_of_day,
      day_of_month,
      date,
      week,
      month,
      month_num,
      quarter,
      year,
      fiscal_year,
      fiscal_month_num
    ]
    sql: ${TABLE}.created_at ;;
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
      url: "embed/dashboards/6?Status={{value | url_encode}}"
    }
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [created_date, users.id, order_items.count]
    link: {
      label: "Status Dash Measure"
      url: "embed/dashboards/6?Status={{orders.created_date._value | url_encode}}"
    }
  }
}
