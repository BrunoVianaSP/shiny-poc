server <- function(input, output) {
  
  output$mtcars_plot <- renderPlotly(plot_ly(mtcars, x = ~ mtcars[ , input$variable1],
                                             y = ~ mtcars[ , input$variable2],
                                             type = "scatter", mode = "markers")
  )
  output$mtcars_plot2 <- renderPlotly(plot_ly(mtcars, x = ~ mtcars[ , input$variable1],
                                              y = ~ mtcars[ , input$variable2],
                                              type = "scatter", mode = "markers"))
  
  output$mtcars_table <- renderDataTable(mtcars, options = list(dom = 't'))
  
  output$dropdown <- renderDropdownMenu({
    dropdownMenu(messageItem("User", "Test message", color = "teal", style = "min-width: 200px"),
                 messageItem("Users", "Test message", color = "teal", icon = "users"),
                 messageItem("See this", "Another test", icon = "warning", color = "red"))
  })
}
