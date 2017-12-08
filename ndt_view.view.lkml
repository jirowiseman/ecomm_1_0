include: "*.model"

explore: ndt_view {}

  view: ndt_view {
    derived_table: {
      explore_source: orders {
        column: id {}
        column: created_date {}
#         derived_column: orders_count {
#           sql: COUNT(id) ;;
#         }
      }
    }

    dimension: id {
      type: number
    }

    dimension: status {}

    dimension: created_date {
      type: date
    }

#     dimension: orders_count {
#     type: number
#     }


  }
