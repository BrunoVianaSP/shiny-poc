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
  
  
  output$srvCategorizationReportTable = DT::renderDataTable({ mtcars })
  
  
  output$srvCategorizationReportPlot = renderPlot({
    plot(mtcars$mpg)
  })
  
  
  

}

