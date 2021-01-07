output$wt_history <- renderTable({
  do.call(format_weight, list(dt = dbReadTable(pool, "weight")))
})

output$wt_plot_range <- renderUI({
  min <- dbGetQuery(pool, "select min(date) from weight")
  min <- as.Date(min$min)
  dateRangeInput("wt_plot_range", "选择时间范围", start = min, end = Sys.Date(), width = "60%")
})

wt_check <- eventReactive(input$wt_submit, {
  validate(
    need(!is.na(input$wt_weight), "体重不能为空或包含非数字")
  )
})

observeEvent(input$wt_submit, {
  output$wt_hint <- renderText({
    if (is.null(wt_check())) {
      NULL
    }
  })
  if (is.null(wt_check())) {
    new <- data.frame(
      date = Sys.time(),
      weight = input$wt_weight
    )
    dbWriteTable(pool, "weight", new, append = TRUE, row.names = FALSE)
    output$wt_history <- renderTable({
      do.call(format_weight, list(dt = dbReadTable(pool, "weight")))
    })
    output$wt_hint <- renderText({
      "提交成功"
    })
    dat <- dbReadTable(pool, "weight")
  }
})

wt_dat <- reactive({
  dbGetQuery(
    pool, sprintf(
      "select date, weight from weight where date >= '%s' and date < '%s' order by date",
      input$wt_plot_range[1], input$wt_plot_range[2] + 1
    )
  )
})

output$wt_plot <- renderPlot({
  req(input$wt_plot_range)
  default <- par(
    mar = c(2.5, 2.5, 0.5, 0.5) + 0.1,
    mgp = c(1.3, 0.3, 0),
    family = "STKaiti"
  )
  date <- as.Date(wt_dat()$date, tz = "Asia/Taipei")
  plot(
    date, round(wt_dat()$weight, 2), type = "b",
    pch = 16, col = "royalblue2", xaxs = "r",
    xlab = "DATE", ylab = "WEIGHT",
    xlim = range(date), xaxt = "n",
    ylim = c(floor(min(wt_dat()$weight)), ceiling(max(wt_dat()$weight))), yaxt = "n"
  )
  axis.Date(
    1, at = seq(min(date), max(date), 7), 
    format = "%m-%d", tck = -0.01, label = FALSE
  )
  axis.Date(
    1, at = seq(min(date), max(date), 1), 
    format = "%m-%d", tck = -0.005
  )
  axis(
    2, at = seq(floor(min(wt_dat()$weight)), ceiling(max(wt_dat()$weight)), 1),
    tck = -0.01, labels = FALSE
  )
  axis(
    2, at = seq(floor(min(wt_dat()$weight)), ceiling(max(wt_dat()$weight)), 0.5),
    tck = -0.005
  )
  par(default)
})






