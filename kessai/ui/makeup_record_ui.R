
CONSMETICS <- list(
  "化妆水", "乳液", "精华", "面霜", "眼霜", "隔离", "粉底", "散粉", "香水", "防晒"
)

tabItem(
  tabName = "makeup_record",
  column(
    width = 12,
    box(
      title = NULL,
      width = NULL, solidHeader = TRUE, closable = FALSE, collapsible = TRUE,
      fluidRow(
        column(4, selectInput("mkr_category", "类别", choices = CONSMETICS)),
        column(4, numericInput("mkr_size", "规格", value = NA, min = 0)),
        column(4, dateInput("mkr_date", "日期", value = Sys.Date(), max = Sys.Date()))
      ),
      fluidRow(
        column(4, textInput("mkr_brand", "品牌")),
        column(4, numericInput("mkr_price", "价格", value = NA, min = 0)),
        column(2, br(), actionButton("mkr_submit", "提交", width = "100%")),
        column(2, br(), actionButton("mkr_history", "查看记录", width = "100%"))
      )
    )
  )
)
