output$mkr_history <- DT::renderDataTable({
  do.call(format_makeup, list(dt = dbReadTable(pool, "make_up")))
})

makeup_record_new <- reactive({
  data.frame(
    category = input$mkr_category,
    brand = input$mkr_brand,
    size = input$mkr_size,
    price = input$mkr_price,
    date = input$mkr_date
  )
})

mkr_check <- eventReactive(input$mkr_submit, {
  validate(
    need(input$mkr_brand != "", "品牌不能为空"),
    need(!is.na(input$mkr_size), "规格不能为空或非数字"),
    need(!is.na(input$mkr_price), "价格不能为空或非数字"),
    need(input$mkr_date <= Sys.Date(), "日期必须在今天或今天之前")
  )
})

observeEvent(input$mkr_submit, {
  output$mkr_hint <- renderText({
    if (is.null(mkr_check())) {
      NULL
    }
  })
})

observeEvent(input$mkr_submit, {
  if (is.null(mkr_check())) {
    dbWriteTable(pool, "make_up", makeup_record_new(), append = TRUE, row.names = FALSE)
    output$mkr_history <- DT::renderDataTable({
      do.call(format_makeup, list(dt = dbReadTable(pool, "make_up")))
    })
    output$mkr_hint <- renderText({
      "提交成功"
    })
  }
})
