tabItem(
  tabName = "weight",
  column(
    width = 12,
    boxPlus(
      title = NULL,
      width = NULL, solidHeader = FALSE, closable = FALSE, collapsible = TRUE,
      fluidRow(
        column(width = 3, dateInput("wt_date", "日期", value = Sys.Date(), max = Sys.Date(), width = "90%")),
        column(width = 3, numericInput("wt_weight", "体重", value = NA, step = 0.01, width = "90%")),
        column(width = 3, br(), actionButton("wt_submit", "提交记录", width = "90%")),
        column(width = 3, br(), actionButton("wt_history", "查看记录", width = "90%"))
      ),
      fluidRow(
        hr(),
        column(width = 12, dygraphOutput("wt_plot", height = "530px"))
      )
    )
  )
)
