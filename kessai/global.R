library(digest)
library(pool)
library(dygraphs)
library(shiny)
library(dplyr)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyjs)

db_info <- jsonlite::read_json("config.json")$postgres
pool <- dbPool(
  drv = RPostgreSQL::PostgreSQL(),
  dbname = db_info$dbname,
  host = db_info$host,
  user = db_info$user,
  password = db_info$password
)
