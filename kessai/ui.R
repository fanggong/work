
# header -----------------------------
header <- dashboardHeader(
  title = "FANG & GONG"
)

# sidebar ----------------------------
sidebar <- dashboardSidebar(
  sidebarMenu(
    id = "sidebar",
    menuItem("GONG：体重记录", tabName = "weight"),
    menuItem("GONG：化妆品记录", tabName = "makeup_record"),
    menuItem("BOTH：卡片记录", tabName = "card")
  )
)

# body -----------------------------
body <- dashboardBody(
  tabItems(
    source("ui/makeup_record_ui.R", local = TRUE, encoding = "UTF-8")$value,
    source("ui/weight_ui.R", local = TRUE, encoding = "UTF-8")$value,
    source("ui/card_ui.R", local = TRUE, encoding = "UTF-8")$value
  )
)


# ui -------------------------------
ui <- dashboardPage(
  useShinyjs(),
  header = header,
  sidebar = sidebar,
  body = body
)
