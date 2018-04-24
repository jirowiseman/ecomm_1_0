connection: "thelook"
include: "*.view"


explore: orders_base {
  extension: required
  hidden: yes
  from: orders
  view_name: orders
  access_filter: {
    field: orders.user_id
    user_attribute: account_id
  }
  #comment
}
