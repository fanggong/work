
library(digest)
library(pool)

db_info <- jsonlite::read_json("config.json")$postgres
pool <- dbPool(
  drv = RPostgreSQL::PostgreSQL(),
  dbname = db_info$dbname,
  host = db_info$host,
  user = db_info$user,
  password = db_info$password
)


server <- function(input, output, session) {
  source("funs/data_format.R", local = TRUE, encoding = "UTF-8")
  
  source("server/makeup_record_server.R", local = TRUE, encoding = "UTF-8")
  source("server/card_server.R", local = TRUE, encoding = "UTF-8")
  source("server/weight_server.R", local = TRUE, encoding = "UTF-8")
}
