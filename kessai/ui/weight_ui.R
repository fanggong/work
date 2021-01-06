tabItem(
  tabName = "weight",
  column(
    width = 3,
    boxPlus(
      title = "记录提交",
      width = NULL, solidHeader = TRUE, closable = FALSE, collapsible = TRUE,
      numericInput("wt_weight", "体重(kg)", value = NA, step = 0.01),
      actionButton("wt_submit", "提交", width = "100%"),
      hr(),
      textOutput("wt_hint")
    ),
    boxPlus(
      title = "记录查看",
      width = NULL, solidHeader = TRUE, closable = FALSE, collapsible = TRUE,
      tableOutput("wt_history")
    )
  ),
  column(
    width = 9,
    boxPlus(
      title = "燃尽图",
      width = NULL, solidHeader = TRUE, closable = FALSE, collapsible = TRUE,
      uiOutput("wt_plot_range"),
      plotOutput("wt_plot")
    )
  )
)
