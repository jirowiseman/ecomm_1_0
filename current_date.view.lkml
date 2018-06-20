view: current_date {

  derived_table: {
    sql:
        SELECT NOW() as now, 100 as one_hundred

      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: one_hundred {
    type: number
    sql: ${TABLE}.one_hundred ;;
  }

  dimension_group: now {
    type: time
    timeframes: [time,date,month,year]
    sql: ${TABLE}.now ;;
  }
  }

  explore: current_date {}
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
