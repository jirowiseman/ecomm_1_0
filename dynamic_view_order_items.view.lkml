explore: dynamic_view_order_items  {}

view: dynamic_view_order_items {
  sql_table_name: {% parameter data_model %};;

  parameter: data_model {
    type: unquoted
    allowed_value: {
      label: "order_insights"
      value: "order_items"
    }
    allowed_value: {
      label: "user_insights"
      value: "users"
    }
  }

  # Define your dimensions and measures here, like this:
  dimension: order_id {
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.order_id ;;
  }

  measure: count{
    type: count
  }

  dimension: returned_at {
    type: date
    sql: ${TABLE}.returned_at ;;
  }

}

# view: dynamic_view_order_items {
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
