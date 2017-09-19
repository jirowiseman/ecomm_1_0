view: user_facts {
  derived_table: {
    sql:
      SELECT
        users.id as user_id,
        COUNT(orders.id) as total_number_of_orders,
        SUM(order_items.sale_price) as lifetime_revenue,
        MAX(order_items.sale_price) as largest_item_purchase,
        MIN(order_items.sale_price) as smallest_item_purchase,
        AVG(order_items.sale_price) as avg_item_purchase,
        MIN(DATE(orders.created_at)) as first_order_date,
        MAX(DATE(orders.created_at)) as latest_order_date,
        DATEDIFF(CURDATE(),MAX(DATE(orders.created_at))) as days_since_last_order,
        TIMESTAMPDIFF(MONTH,MIN(DATE(orders.created_at)),CURDATE()) as months_as_customer
      FROM users
      LEFT JOIN orders ON users.id = orders.user_id
      LEFT JOIN order_items ON order_items.order_id = orders.id
      GROUP BY users.id;;
      persist_for: "24 hours"
      indexes: ["user_id"]
  }

  dimension: user_id {
    sql:  ${TABLE}.user_id ;;
    hidden: yes
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

  dimension: largest_item_purchase {
    sql: ${TABLE}.largest_item_purchase ;;
  }

  dimension: smallest_item_purchase {
    sql: ${TABLE}.smallest_item_purchase ;;
  }

  dimension: avg_item_purchase {
    sql: ${TABLE}.avg_item_purchase ;;
  }

  dimension: avg_orders_per_month {
    type: number
    sql: ${total_number_of_orders}/${months_as_customer};;
  }


}
