output$card_history <- DT::renderDataTable({
  do.call(format_card, list(dt = dbReadTable(pool, "card")))
})

card_new <- reactive({
  data.frame(
    id = as.numeric(Sys.time()),
    owner = setdiff(c("FANG", "GONG"), input$card_username),
    category = input$card_category,
    date_give = input$card_date,
    text_give = input$card_text,
    status = "unuse"
  )
})

user_info <- reactive({
  dbGetQuery(
    pool, sprintf(
      "select password from user_info where user_name = '%s'", input$card_username
    )
  )
})

password_check <- eventReactive(input$card_give + input$card_use, {
  validate(
    need(user_info()$password == digest(input$card_password, algo = "md5"), "密码不正确")
  )
})

card_check <- eventReactive(input$card_give + input$card_use, {
  validate(
    need(input$card_date <= Sys.Date(), "日期必须在今天或今天之前"),
    need(input$card_text != "", "赠送/使用原因备注不能为空")
  )
})



observeEvent(input$card_give, {
  output$card_hint <- renderText({
    if (is.null(password_check())) {
      if (is.null(card_check())) {
        NULL
      }
    }
  })
  if (is.null(password_check()) & is.null(card_check())) {
    dbWriteTable(pool, "card", card_new(), append = TRUE, row.names = FALSE)
    output$card_history <- DT::renderDataTable({
      do.call(format_card, list(dt = dbReadTable(pool, "card")))
    })
    output$card_hint <- renderText({
      "赠送卡提交成功"
    })
  } 
})

observeEvent(input$card_use, {
  output$card_hint <- renderText({
    if (is.null(password_check())) {
      if (is.null(card_check())) {
        NULL
      }
    }
  })
  if (is.null(password_check()) & is.null(card_check())) {
    query <- sprintf(
      "select id from card where owner = '%s' and category = '%s' and status = 'unuse'",
      input$card_username, input$card_category
    )
    own_card <- dbGetQuery(pool, query)
    # 没有的话返回提交失败
    if (nrow(own_card) == 0) {
      output$card_hint <- renderText({
        "未拥有该卡片"
      })
    } else if (nrow(own_card) != 0) {
      dbGetQuery(
        pool, 
        sprintf(
          "update card set date_use = '%s', text_use = '%s', status = 'used' where id = %s",
          input$card_date, input$card_text, own_card$id[1]
        )
      )
      output$card_hint <- renderText({
        "使用提交成功"
      })
      output$card_history <- DT::renderDataTable({
        do.call(format_card, list(dt = dbReadTable(pool, "card")))
      })
    }
      
  }
})


