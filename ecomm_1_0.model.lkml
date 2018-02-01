connection: "thelook"

datagroup: monthly {
  sql_trigger: DATE_TRUNC(month,now()) ;;
}

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"
fiscal_month_offset: -9


explore: orders {
  access_filter: {
    field: user_id
    user_attribute: "number"
  }

  join: order_items {
    sql_on: ${order_items.inventory_item_id} = ${order_items.inventory_item_id} ;;
    relationship: many_to_one
    fields: []
    ## testing blank fields param -- results in no fields shown from join -- use case?
  }

  join: inventory_items {
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_many
  }
}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders_analysis {
  from: orders

  join: users {
    type: left_outer
    sql_on: ${orders_analysis.user_id}.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: user_facts {
    type:  left_outer
    sql_on: ${orders_analysis.user_id} = ${user_facts.user_id}  ;;
    relationship: many_to_one
  }

  join: 5_or_more_orders_cohort_facts {
    type: left_outer
    sql_on: ${5_or_more_orders_cohort_facts.user_id} = ${user_facts.user_id} ;;
    relationship: one_to_one
  }
}

explore: products {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: users_nn {}

explore: order_fact {}
