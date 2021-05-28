CARD <- list(
  "不能睡觉", "好好吃饭", "再来一次", "随心所欲", "马杀鸡鸡", "不许生气", 
  "听叨逼叨", "不许逼逼", "呼噜呼噜", "叫声爸爸", "想啥吃啥", "组局麻将", 
  "洗洗洗头", "减减CD", "就吃一口", "吃口粽子", "就不吃饭"
)

tabItem(
  tabName = "card",
  column(
    width = 12,
    box(
      title = NULL,
      width = NULL, solidHeader = TRUE, closable = FALSE, collapsible = TRUE,
      fluidRow(
        column(4, selectInput("card_category", "卡类别", choices = CARD)),
        column(4, dateInput("card_date", "赠送/使用日期", value = Sys.Date(), max = Sys.Date())),
        column(4, textInput("card_text", "赠送/使用原因备注"))
      ),
      fluidRow(
        column(4, br(), actionButton("card_login", "选择用户", width = "100%")),
        column(4, br(), actionButton("card_give", "赠送", width = "100%")),
        column(4, br(), actionButton("card_use", "使用", width = "100%"))
      ),
      fluidRow(
        hr(),
        column(12, DT::dataTableOutput("card_record"))
      )
    )
  )
)
