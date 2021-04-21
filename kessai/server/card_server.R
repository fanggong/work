card_reflesh_dat <- function(pool) {
  card_dat <<- dbGetQuery(pool, sprintf(
    "select owner, category, date_give, text_give, date_use, text_use from card"
  ))
  
  output$card_record <<- DT::renderDataTable({
    DT::datatable(
      card_dat, class = "cell-border stripe", colnames = c(
        "所有者" = "owner", "卡" = "category", "获得日期" = "date_give",
        "获得备注" = "text_give", "使用日期" = "date_use", "使用备注" = "text_use"
      )
    )
  })
}

card_reflesh_dat(pool)

card_check <- eventReactive(input$card_give + input$card_use, {
  validate(
    need(input$card_text != "", "赠送/使用原因备注不能为空")
  )
})

observeEvent(input$card_give, {
  showModal(modalDialog(
    textOutput("card_hint"),
    title = icon("exclamation-triangle"), easyClose = TRUE, size = "s",
    footer = modalButton("关闭")
  ))
  output$card_hint <- renderText({
    if (is.null(card_check())) {
      card_new_record <- data.frame(
        id = as.numeric(Sys.time()),
        owner = setdiff(c("FANG", "GONG"), input$username),
        category = input$card_category,
        date_give = input$card_date,
        text_give = input$card_text,
        status = "unuse"
      )
      dbWriteTable(pool, "card", card_new_record, append = TRUE, row.names = FALSE)
      card_reflesh_dat(pool)
      "提交成功"
    }
  })
})

observeEvent(input$card_use, {
  showModal(modalDialog(
    textOutput("card_hint"),
    title = icon("exclamation-triangle"), easyClose = TRUE, size = "s",
    footer = modalButton("关闭")
  ))
  output$card_hint <- renderText({
    if (is.null(card_check())) {
      query <- sprintf(
        "select id from card where owner = '%s' and category = '%s' and status = 'unuse'",
        input$username, input$card_category
      )
      own_card <- dbGetQuery(pool, query)
      
      if (nrow(own_card) == 0) {
        "未拥有该卡"
      } else if (nrow(own_card) != 0) {
        query <- sprintf(
          "update card set date_use = '%s', text_use = '%s', status = 'used' where id = %s",
          input$card_date, input$card_text, own_card$id[1]
        )
        dbGetQuery(pool, query)
        card_reflesh_dat(pool)
        "提交成功"
      }
    }
  })
})


