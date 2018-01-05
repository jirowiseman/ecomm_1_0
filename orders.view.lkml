view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }


## single file commit

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

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }


  measure: count {
    type: count
    hidden: no

  }


  measure: sum {
    type: sum
    sql: ${TABLE}.id ;;
  }

}
