library(shiny)
library(shinydashboard)
library(DT)
library(shinyWidgets)

source("csv-module-input.R")
source("csv-module-server.R")

ui <- dashboardPage(


  dashboardHeader(title = "Basic dashboard",
                  titleWidth = 300
  ), # Header end




  # SIDEBAR START
  dashboardSidebar(
    width = 300,

    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Load Data", tabName = "load-data", icon = icon("th")),
      menuItem("CMC Reports", tabName = "cmc-reports", icon = icon("line-chart"),
               menuSubItem('Approved Match',
                           tabName = 'submenu-approved-match',
                           icon = icon('glyphicon glyphicon-penci')),
               menuSubItem('Categorization',
                           tabName = 'submenu-categorization',
                           icon = icon('glyphicon glyphicon-penci')),
               menuSubItem('Data Quality Performance',
                           tabName = 'submenu-data-quality-performance',
                           icon = icon('glyphicon glyphicon-penci')),
               menuSubItem('Exported Hybris Products',
                           tabName = 'submenu-exported-hybris-products',
                           icon = icon('glyphicon glyphicon-penci')),
               menuSubItem('Income Raw Products',
                           tabName = 'submenu-income-raw-products',
                           icon = icon('glyphicon glyphicon-penci')),
               menuSubItem('Refine',
                           tabName = 'submenu-refine',
                           icon = icon('glyphicon glyphicon-penci')))
    )

  ), # SIDEBAR END





  dashboardBody(

    # tags$head(
    #   tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    # ),

    tabItems(

      # First tab content
      tabItem(tabName = "dashboard",
              h2("Página Principal"),

              fluidRow(
                box(plotOutput("plot1", height = 250)),

                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
      ),




      # Second tab content
      tabItem(tabName = "load-data",
              h2("Load Data Section"),
              fluidRow(
                column(12,
                       box(title = "Histogram box title", closable = TRUE, label_status = "danger",
                           status = "warning", solidHeader = FALSE, collapsible = TRUE,
                         csvFileInput("datafile", "User data csv format"))
                       )
                ),
              fluidRow(box(title = "Histogram box title", closable = TRUE, label_status = "danger",
                           status = "warning", solidHeader = FALSE, collapsible = TRUE,
                        column(12, DT::dataTableOutput("csvTable"))
                        )
                       )
              ),


      # submenu content
      tabItem(tabName = "submenu-approved-match",
              h2("Approved Match"),
              fluidRow( box(column(DT::dataTableOutput("srv-approved-match-table"), width = 12))

              )),

      # submenu content
      tabItem(tabName = "submenu-categorization",
              h2("Categorization Report"),
              fluidRow( box(
                fileInput("FileInput", "Choose file"))),
              fluidRow(
                column(6, DT::dataTableOutput("srvCategorizationReportTable")),
                column(6, plotOutput("srvCategorizationReportPlot")))

      )




    ) # tab items end

  ) # Body end

) # UI end