connection: "thelook"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore: orders {
#   access_filter: {
#     field: orders.user_id
#     user_attribute: wildcard
#   }



}
