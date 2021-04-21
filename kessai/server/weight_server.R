dygraph_plot <- function(dat) {
  dat <- xts::xts(dat$weight, order.by = dat$date)
  dygraph(dat, main = "Health curve") %>%
    dySeries(label = "Weight", color = "#22537B") %>% 
    dyAxis("x", drawGrid = FALSE) %>%
    dyAxis("y", label = "Weight") %>% 
    dyOptions(drawPoints = TRUE, pointSize = 2) %>% 
    dyRangeSelector()
}

wt_dat <- dbGetQuery(pool, "select date, weight from weight")

output$wt_plot <- renderDygraph({
  dygraph_plot(wt_dat)
})

wt_check <- eventReactive(input$wt_submit, {
  validate(
    need(!is.na(input$wt_weight), "体重不能为空或非数字")
  )
})

observeEvent(input$wt_submit, {
  showModal(modalDialog(
    textOutput("wt_hint"),
    title = icon("exclamation-triangle"), easyClose = TRUE, size = "s", 
    footer = modalButton("关闭")
  ))
  output$wt_hint <- renderText({
    if (is.null(wt_check())) {
      wt_new_record <- data.frame(date = input$wt_date, weight = input$wt_weight)
      dbWriteTable(pool, "weight", wt_new_record, append = TRUE, row.names = FALSE)
      wt_dat <<- dbGetQuery(pool, "select date, weight from weight")
      output$wt_plot <- renderDygraph({
        dygraph_plot(wt_dat)
      })
      "提交成功"
    }
  })
})

observeEvent(input$wt_history, {
  showModal(modalDialog(
    DT::dataTableOutput("wt_record"),
    title = "历史记录", easyClose = TRUE, size = "m", footer = modalButton("关闭")
  ))
  output$wt_record <- DT::renderDataTable({
    wt_formated_dat <- wt_dat %>% 
      mutate(date = as.character(date))
    DT::datatable(wt_formated_dat, class = "cell-border stripe")
  })
})











