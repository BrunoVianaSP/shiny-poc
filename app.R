
library(shiny)
library(shinydashboard)
library(DT)

ui <- dashboardPage(
  
  
  dashboardHeader(title = "Basic dashboard"
                  ), # Header end
  
  
  
  
  # SIDEBAR START
  dashboardSidebar(
    
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Load Data", tabName = "load-data", icon = icon("th")),
      menuItem("CMC Reports", tabName = "cmc-reports", icon = icon("line-chart"),
               menuSubItem('Categorization',
                        tabName = 'submenu-categorization',
                        icon = icon('glyphicon glyphicon-penci')))
    )
    
  ), # SIDEBAR END
  
  
  
  
  
  dashboardBody(
    
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
              fluidRow( box(
                fileInput("FileInput", "Choose file")),
                column(DT::dataTableOutput("srvDataTable"), width = 12))
              
      ),
      
      
      # Second tab submenu content
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
  
  output$srvDataTable = DT::renderDataTable(datasetInput())
  
  
}

shinyApp(ui, server)

