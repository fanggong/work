library(dplyr)
library(data.table)

format_makeup <- function(dt) {
  if (nrow(dt) == 0) return(data.frame())
  dt <- dt %>% 
    arrange(
      desc(date)
    ) %>%
    mutate(
      `类别` = category,
      `品牌` = brand,
      `规格` = paste0(size, "ml"),
      `价格` = paste0(price, "元"),
      `开始使用日期` = date
    ) %>% 
    select(
      `类别`, `品牌`, `规格`, `价格`, `开始使用日期`
    )
  return(dt)
}

format_card <- function(dt) {
  if (nrow(dt) == 0) return(data.frame())
  setDT(dt)
  dt <- dt %>% 
    mutate(
      `卡主` = owner,
      `卡类别` = category,
      `获得日期` = date_give,
      `获得原因及备注` = text_give,
      `卡片状态` = ifelse(status == "used", "已使用", "未使用")
    )
  if ("date_use" %in% names(dt)) {
    dt <- dt %>% 
      mutate(
        `使用日期` = date_use,
        `使用原因及备注` = text_use
      )
  } else {
    dt <- dt %>% 
      mutate(
        `使用日期` = NA,
        `使用原因及备注` = NA
      )
  }
  dt <- dt %>% 
    select(
      `卡主`, `卡类别`, `获得日期`, `获得原因及备注`, `使用日期`, `使用原因及备注`, `卡片状态`
    )
  dt <- dt[order(`使用日期`, `获得日期`, na.last = FALSE)]
  return(dt)
}


format_weight <- function(dt) {
  if (nrow(dt) == 0) return(data.frame())
  dt <- dt %>% 
    arrange(
      desc(date)
    ) %>% 
    mutate(
      `时间` = as.character(date),
      `体重` = round(weight, 2)
    ) %>% 
    select(
      `时间`, `体重`
    )
  return(dt)
}

