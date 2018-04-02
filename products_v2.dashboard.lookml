- dashboard: product_dashboard_v2
  title: Product Dashboard
  layout: newspaper
  query_timezone: query_saved
  elements:
  - title: Top 10 Women's Products Ordered (past 6mo)
    name: Top 10 Women's Products Ordered (past 6mo)
    model: ecomm_1_0
    explore: order_items
    type: looker_bar
    fields:
    - orders.count
    - products.brand
    - products.item_name
    filters:
      orders.created_month: 6 months
      products.department: Women
    sorts:
    - orders.count desc
    limit: 10
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 8
    col: 12
    width: 12
    height: 8
  - title: Product count by Category for Allegra K
    name: Product count by Category for Allegra K
    model: ecomm_1_0
    explore: order_items
    type: looker_pie
    fields:
    - products.count
    - products.category
    filters:
      products.brand: Allegra K
    sorts:
    - products.count desc
    - products.category
    limit: 10
    query_timezone: America/Los_Angeles
    value_labels: legend
    label_type: labPer
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Dates: inventory_items.created_date
    row: 0
    col: 12
    width: 12
    height: 8
  - title: Top Brand by Inventory Count
    name: Top Brand by Inventory Count
    model: ecomm_1_0
    explore: order_items
    type: single_value
    fields:
    - products.brand
    - products.count
    sorts:
    - products.count desc
    limit: 1
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Dates: inventory_items.created_date
    row: 0
    col: 0
    width: 12
    height: 8
  - title: Top 10 Men's Products Ordered
    name: Top 10 Men's Products Ordered
    model: ecomm_1_0
    explore: order_items
    type: looker_bar
    fields:
    - orders.count
    - products.brand
    - products.item_name
    filters:
      orders.created_month: 6 months
      products.department: Men
    sorts:
    - orders.count desc
    limit: 10
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Dates: inventory_items.created_date
      status: orders.status
    row: 8
    col: 0
    width: 12
    height: 8
  - title: Total Order Revenue by Dept
    name: Total Order Revenue by Dept
    model: ecomm_1_0
    explore: order_items
    type: looker_bar
    fields:
    - order_items.total_order_revenue
    - products.department
    filters:
      orders.created_month: 6 months
    sorts:
    - order_items.total_order_revenue desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: total_revenue_from_orders
      label: Total Revenue from Orders
      expression: "${order_items.total_order_revenue}"
      value_format:
      value_format_name: usd
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - order_items.total_order_revenue
    series_types: {}
    listen:
      status: orders.status
    row: 16
    col: 0
    width: 12
    height: 8
  - title: Total Revenue From Top Brand
    name: Total Revenue From Top Brand
    model: ecomm_1_0
    explore: order_items
    type: single_value
    fields:
    - order_items.total_order_revenue
    filters:
      products.brand: Allegra K
    limit: 1
    dynamic_fields:
    - table_calculation: total_order_revenue
      label: Total Order Revenue
      expression: "${order_items.total_order_revenue}"
      value_format:
      value_format_name: usd
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields:
    - order_items.total_order_revenue
    single_value_title: Allegra K
    row: 16
    col: 12
    width: 12
    height: 8
  filters:
  - name: status
    title: status
    type: field_filter
    default_value: complete,pending
    model: ecomm_1_0
    explore: orders
    field: orders.status
    listens_to_filters: []
    allow_multiple_values: true
    required: false
  - name: Dates
    title: Dates
    type: field_filter
    default_value: 7 days
    model: ecomm_1_0
    explore: orders
    field: inventory_items.created_date
    listens_to_filters: []
    allow_multiple_values: true
    required: false
