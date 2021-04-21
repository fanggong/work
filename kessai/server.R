
server <- function(input, output, session) {
  
  is_logined <- reactiveVal(FALSE)
  
  observeEvent(paste0(input$sidebar, input$card_login), {
    req(input$sidebar == "card")
    req(!is_logined())
    showModal(modalDialog(
      fluidRow(
        column(12, selectInput("username", "用户", choices = list("FANG", "GONG")))
      ),
      fluidRow(
        column(12, passwordInput("password", "密码")),
      ),
      fluidRow(
        column(12, textOutput("hint"))
      ),
      fluidRow(
        column(6, br(), actionButton("login", "登录", width = "100%")),
        column(6, br(), actionButton("close", "关闭", width = "100%"))
      ),
      title = NULL, easyClose = FALSE, footer = NULL, size = "s"
    ))
  })
  
  observeEvent(input$login, {
    password <- dbGetQuery(
      pool, sprintf(
        "select password from user_info where user_name = '%s'", input$username
      )
    )
    if (password$password == digest(input$password, algo = "md5")) {
      removeModal()
      is_logined(TRUE)
    } else {
      output$hint <- renderText({
        "密码错误"
      })
    }
  })
  
  observeEvent(input$close, {
    removeModal()
  })
  
  observe({
    if (!is_logined()) {
      shinyjs::disable("card_give")
      shinyjs::disable("card_use")
    } else {
      shinyjs::enable("card_give")
      shinyjs::enable("card_use")
      shinyjs::disable("card_login")
      updateActionButton(session, "card_login", label = paste0("已登录用户", input$username))
    }
  })
  
  source("server/makeup_record_server.R", local = TRUE, encoding = "UTF-8")
  source("server/card_server.R", local = TRUE, encoding = "UTF-8")
  source("server/weight_server.R", local = TRUE, encoding = "UTF-8")
}
