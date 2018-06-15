
include: "_base_extension.model"
include: "orders.view"
include: "users.view"


explore: order_info {
  label: "Orders and Users"
  hidden: no
  extends: [orders_base]


  join: users {
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: one_to_many
  }
}
#
