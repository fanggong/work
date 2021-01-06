
CONSMETICS <- list(
  "化妆水", "乳液", "精华", "面霜", "眼霜", "隔离", "粉底", "散粉", "香水", "防晒"
)

tabItem(
  tabName = "makeup_record",
  column(
    width = 3,
    boxPlus(
      title = "记录提交",
      width = NULL, solidHeader = TRUE, closable = FALSE, collapsible = TRUE,
      selectInput("mkr_category", "类别", choices = CONSMETICS),
      textInput("mkr_brand", "品牌"),
      numericInput("mkr_size", "规格", value = NA, min = 0),
      numericInput("mkr_price", "价格", value = NA, min = 0),
      dateInput("mkr_date", "日期", value = Sys.Date()),
      br(),
      actionButton("mkr_submit", "提交", width = "100%"),
      hr(),
      textOutput("mkr_hint")
    )
  ),
  column(
    width = 9, 
    boxPlus(
      title = "记录查看",
      width = NULL, solidHeader = TRUE, closable = FALSE, collapsible = TRUE,
      DT::dataTableOutput("mkr_history"),
      hr()
    )
  )
)
