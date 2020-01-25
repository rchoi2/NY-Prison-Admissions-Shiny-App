

shinyServer(function(input, output) {


    output$plot1 <- renderPlot(
      prison %>% 
        filter(Year == as.numeric(input$year)) %>% 
        group_by(Year, Month) %>% 
        summarise(Total = n()) %>% 
        ggplot(aes(x = Month, y = Total)) +
        geom_line())
    
    
    output$plot2 <- renderPlot(
      prison %>% 
        filter(Year == as.numeric(input$year) &
                 Gender == input$gender) %>% 
        ggplot(aes(x = Age.Group)) +
        geom_bar())
    
    output$plot3 <- renderPlot(
      prison %>% 
        filter(Year == as.numeric(input$year)) %>%  
        group_by(Month) %>% 
        summarise(Admissions = n()) %>% 
        ggplot() + 
        geom_line(aes(x = Month, y = Admissions)) # ADD A HEATMAP 
      
      
      )
        
                 
    
    
    
    output$dt1 <- DT::renderDataTable({
      prison
      
    }) 
})




