CARD <- list(
  "不能睡觉", "好好吃饭", "再来一次", "随心所欲", "马杀鸡鸡", "不许生气", 
  "听叨逼叨", "不许逼逼", "呼噜呼噜", "叫声爸爸", "想啥吃啥", "组局麻将", 
  "洗洗洗头", "减减CD", "就吃一口", "吃口粽子", "就不吃饭"
)

tabItem(
  tabName = "card",
  column(
    width = 3,
    boxPlus(
      title = "赠送/使用提交",
      width = NULL, solidHeader = TRUE, closable = FALSE, collapsible = TRUE,
      selectInput("card_category", "卡类别", choices = CARD),
      dateInput("card_date", "赠送/使用日期", value = Sys.Date()),
      textInput("card_text", "赠送/使用原因备注"),
      selectInput("card_username", "用户", choices = list("FANG", "GONG")),
      passwordInput("card_password", "密码"),
      br(),
      fluidRow(
        column(6, actionButton("card_give", "赠送", width = "100%")),
        column(6, actionButton("card_use", "使用", width = "100%"))
      ),
      hr(),
      textOutput("card_hint")
    )
  ),
  column(
    width = 9,
    boxPlus(
      title = "记录查看",
      width = NULL, solidHeader = TRUE, closable = FALSE, collapsible = TRUE,
      DT::dataTableOutput("card_history"),
      hr()
    )
  )
)
