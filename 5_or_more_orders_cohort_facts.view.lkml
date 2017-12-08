view: 5_or_more_orders_cohort_facts {
  derived_table: {
    sql:
      SELECT *
        FROM ${user_facts.SQL_TABLE_NAME} as user_facts
      WHERE total_number_of_orders >= 5 ;;
#       sql_trigger_value: SELECT COUNT(*) FROM ${user_facts.SQL_TABLE_NAME} WHERE total_number_of_orders >=5 ;;
#     persist_for: "12 hours"
    indexes: ["user_id"]
  }

  dimension: user_id {
    sql:  ${TABLE}.user_id ;;
  }

  dimension: total_number_of_orders {
    sql: ${TABLE}.total_number_of_orders;;
  }

  dimension: first_order_date {
    sql: ${TABLE}.first_order_date ;;
  }

  dimension: latest_order_date {
    sql: ${TABLE}.latest_order_date ;;
  }

  dimension: days_since_last_order {
    sql:  ${TABLE}.days_since_last_order ;;
  }

  dimension: repeat_customer_yesno {
    type: yesno
    sql: ${TABLE}.total_number_of_orders > 1 ;;
  }

  dimension: months_as_customer {
    sql: ${TABLE}.months_as_customer;;
  }

  measure: avg_orders_per_month {
    type: number
    sql: ${total_number_of_orders}/${months_as_customer};;
  }
}

# view: users_with_orders_cohort {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
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
