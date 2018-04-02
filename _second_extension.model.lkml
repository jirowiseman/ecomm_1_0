include: "_first_extension.model"

explore: user_order_items {
  label: "Order, User, and Item Info"
  extends: [order_info]

  join: order_items {
    sql_on: ${orders.id}=${order_items.order_id} ;;
    relationship: one_to_many
  }
}


# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
