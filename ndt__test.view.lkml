# If necessary, uncomment the line below to include explore_source.
include: "ecomm_1_0.model.lkml"

view: ndt_test {
  derived_table: {
    explore_source: orders {
      column: created_date {}
      column: count {}

    }
  }
  dimension: created_date {
    type: date
  }

  dimension: count {
    type: number
  }

}

explore: ndt_test {
  hidden: yes
}

#fjewojfoweew
