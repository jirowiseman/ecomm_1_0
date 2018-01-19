- dashboard: single_tile_udd
  title: Single Tile UDD
  layout: newspaper
  elements:
  - title: Table Visualization
    name: Table Visualization
    model: ecomm_1_0
    explore: orders
    type: table
    fields:
    - orders.created_month_num
    - orders.created_day_of_month
    - orders.count
    filters:
      orders.created_day_of_month: ''
    sorts:
    - orders.count desc
    limit: 500
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    row:
    col:
    width:
    height:
