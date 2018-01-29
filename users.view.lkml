view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      yesno
    ]
    sql: ${TABLE}.created_at ;;
    allow_fill: no
  }

  dimension: days_since_created {
    type: number
    sql: DATEDIFF(CURDATE(),${created_date}) ;;
  }

  dimension: created_event {
   case: {
    when: {
      sql:${created}= yes;;
      label: "Exists"}
    when: {
      sql: ${created} = no;;
      label: "Does not Exist"
    }
   }

  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: full_name {
    description: "User's first and last name, click to see user facts!"
    type:  string
    sql: CONCAT(${first_name},' ',${last_name});;
    link: {
      label: "User Info"
      url: "/explore/ecomm_1_0/orders?fields=users.id,users.name,users.created_date,user_facts.total_number_of_orders,user_facts.latest_order_date&f[users.full_name]={{value}}"
    }
    }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

#   dimension: user_info {
#     sql:  ${TABLE}.id;;
#     html: <a href="/explore/ecomm_1_0/orders?fields=users.name,users.created_date,user_facts.total_number_of_orders,user_facts.latest_order_date&f[users.id]={{value}}"target="_new">Facts</a>;;
#   }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: string
    sql: ${TABLE}.zip ;;
    map_layer_name: us_zipcode_tabulation_areas
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_name,
      first_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}
