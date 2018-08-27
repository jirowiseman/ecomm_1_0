
view: state_order_facts {
  derived_table: {
    sql: SELECT
        SUM(total_orders) as grand_total
      FROM ${total_orders_by_state.SQL_TABLE_NAME}
      ;;
  }

  dimension: grand_total {
    type: number
    }

  dimension: percent_of_total {
    type: number
    sql: ROUND(${total_orders_by_state.total_orders}*1.0/${grand_total},2) ;;
  }

  dimension: percent_of_total_tiered {
    type: string
    sql:
    CASE
    WHEN ${percent_of_total} BETWEEN 0 AND 0.05 THEN "0-5%"
    WHEN ${percent_of_total} BETWEEN 0.05 AND 0.1 THEN "5-10%"
    WHEN ${percent_of_total} BETWEEN 0.1 AND 0.15 THEN "10-15%"
    WHEN ${percent_of_total} BETWEEN 0.15 AND 0.2 THEN "15-20%"
    ELSE NULL END;;

  }

  measure: count_0_to_5_percent {
    type: count_distinct
    sql: ${orders.id} ;;
    filters: {
      field: percent_of_total_tiered
      value: "0-5%"
    }
  }

  measure: count_5_to_10_percent {
    type: count_distinct
    sql: ${orders.id} ;;
    filters: {
      field: percent_of_total_tiered
      value: "5-10%"
    }
  }

}

view: total_orders_by_state {
   derived_table: {
    sql: SELECT
        u.state,
        COUNT(DISTINCT o.id) as total_orders
      FROM orders o
      JOIN users u
      ON o.user_id = u.id
      GROUP BY 1
      ;;
  }

  dimension: state {
    primary_key: yes
    map_layer_name: us_states
  }

  dimension: total_orders {}

}
