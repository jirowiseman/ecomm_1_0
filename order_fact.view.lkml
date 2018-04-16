view: order_fact {
  derived_table: {
    sql:
    SELECT
        user_id as user_id
        , created_at as created_at
        , sale_price as sale_price
        , order_id as order_id
        , COUNT(*) as lifetime_orders
        , MAX(orders.created_at) as most_recent_purchase_at
--        , row_number() over(partition by user_id,
--        {% if order_fact.created_at_date._in_query %}
--        created_at
--        {% elsif order_fact.created_at_week._in_query %}
--        ${order_fact.created_at_week}
--        {% endif %}  order by order_fact.sale_price desc) as rank
      FROM orders_items
      GROUP BY 1,2,3,4
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: user_id {
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: created_at {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  dimension: sale_price {
    type: number
  }

#   dimension: rank {
#     type: number
#   }
#   need to figure out what's wrong with this window function

  dimension: order_id {
    type: number
  }

  measure: count {
    type: count
  }


  }

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
