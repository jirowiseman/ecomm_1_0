include: "ecomm_1_0.model.lkml"

view: order_fact_ndt {
  derived_table: {
    explore_source: orders {
      column: count {}
      column: sum {}
      column: created_month {}
    }
  }
  dimension: count {
    type: number
  }
  dimension: sum {
    type: number
    value_format_name: decimal_2
  }
  dimension: created_month {
    type: date_month
  }
}
