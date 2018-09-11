
library(shiny)
library(shinydashboard)
library(DT)

source("csv-module-input.R")
source("csv-module-server.R")

ui <- dashboardPage(
  
  
  dashboardHeader(title = "Basic dashboard",
                  titleWidth = 300
                  ), # Header end
  
  
  
  
  # SIDEBAR START
  dashboardSidebar(
    width = 300,
    
    tags$head(tags$style(HTML('.shiny-server-account { display: none; }'))),
    
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
              fluidRow(csvFileInput("datafile", "User data (.csv format)")),
              fluidRow(box(column(DT::dataTableOutput("csvTable"), width = 12)))
              
      ),
      
      
      
      # menuItem("CMC Reports", tabName = "cmc-reports", icon = icon("line-chart"),
      #          menuSubItem('',
      #                      tabName = '',
      #                      icon = icon('glyphicon glyphicon-penci')),
      #          menuSubItem('Categorization',
      #                      tabName = 'submenu-categorization',
      #                      icon = icon('glyphicon glyphicon-penci')),
      #          menuSubItem('Data Quality Performance',
      #                      tabName = 'submenu-data-quality-performance',
      #                      icon = icon('glyphicon glyphicon-penci')),
      #          menuSubItem('Exported Hybris Products',
      #                      tabName = 'submenu-exported-hybris-products',
      #                      icon = icon('glyphicon glyphicon-penci')),
      #          menuSubItem('Income Raw Products',
      #                      tabName = 'submenu-income-raw-products',
      #                      icon = icon('glyphicon glyphicon-penci')),
      #          menuSubItem('Refine',
      #                      tabName = 'submenu-refine',
      #                      icon = icon('glyphicon glyphicon-penci')))
      
      
      # submenu content
      tabItem(tabName = "submenu-approved-match",
              h2("Approved Match"),
              fluidRow( box(column(DT::dataTableOutput("srv-approved-match-table"), width = 12))
              
      )),
  
      # submenu content
      tabItem(tabName = "submenu-categorization",
              h2("Categorization Report"),
              fluidRow( box(
                fileInput("FileInput", "Choose file")),
                column(DT::dataTableOutput("srvDataTable"), width = 12))
              
      )
      
      
      
    
    ) # tab items end
    
  ) # Body end
  
) # UI end


server <- function(input, output) {
  
  set.seed(122)
  histdata <- rnorm(500)
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
  
  datasetInput <- reactive({
    infile <- input$FileInput
    if(is.null(infile))
      return(NULL)
    read.csv(infile$datapath, header = TRUE)
    
  })
  
  output$csvTable = DT::renderDataTable(datasetInput())
  
  # output$srv-approved-match-table = DT::renderDataTable(datasetInput())
  
  
}

shinyApp(ui, server)

