mkr_dat <- dbGetQuery(pool, "select category, brand, size, price, date from make_up")

mkr_check <- eventReactive(input$mkr_submit, {
  validate(
    need(input$mkr_brand != "", "品牌不能为空"),
    need(!is.na(input$mkr_size), "规格不能为空或非数字"),
    need(!is.na(input$mkr_price), "价格不能为空或非数字"),
    need(input$mkr_date <= Sys.Date(), "日期必须在今天或今天之前")
  )
})

observeEvent(input$mkr_submit, {
  showModal(modalDialog(
    textOutput("mkr_hint"),
    title = icon("exclamation-triangle"), easyClose = TRUE, size = "s", 
    footer = modalButton("关闭")
  ))
  output$mkr_hint <- renderText({
    if (is.null(mkr_check())) {
      mkr_new_record <- data.frame(
        category = input$mkr_category,
        brand = input$mkr_brand,
        size = input$mkr_size,
        price = input$mkr_price,
        date = input$mkr_date
      )
      dbWriteTable(pool, "make_up", mkr_new_record, append = TRUE, row.names = FALSE)
      mkr_dat <<- dbGetQuery(pool, "select category, brand, size, price, date from make_up")
      "提交成功"
    }
  })
})

observeEvent(input$mkr_history, {
  showModal(modalDialog(
    DT::dataTableOutput("mkr_record"),
    title = "历史记录", easyClose = TRUE, size = "l", footer = modalButton("关闭")
  ))
  output$mkr_record <- DT::renderDataTable({
    DT::datatable(
      mkr_dat, class = "cell-border stripe",
      colnames = c("类别" = "category", "品牌" = "brand", "规格" = "size",
                   "价格" = "price", "开始使用日期" = "date")
    )
  })
})

