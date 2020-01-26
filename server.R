

shinyServer(function(input, output) {


    output$plot1 <- renderPlot(
      prison %>% 
        filter(Year == as.numeric(input$year)) %>% 
        group_by(Year, Month) %>% 
        summarise(Total = n()) %>% 
        ggplot(aes(x = Month, y = Total)) +
        geom_line())
    
    
    output$agebar <- renderPlot(
      prison %>% 
        filter(Year == as.numeric(input$year)) %>% 
        ggplot(aes(x = Age.Group, fill = Gender), position = "dodge") +
        geom_bar())
    
    output$agestack <- renderPlot(
      prison %>% 
        ggplot(aes(x = Year)) +
        geom_bar(aes(fill = Age.Group), positon = "fill"))
        
    
    
    output$monthhist <- renderPlot(
      prison %>% 
        filter(Year == as.numeric(input$year)) %>%  
        group_by(Month) %>% 
        summarise(Admissions = n()) %>% 
        ggplot(aes(x = Month, y = Admissions)) + 
        geom_line())
        
    output$myheatmap <- renderPlot(
      prison %>% 
        
        group_by(Year, Month) %>% 
        summarise(Admissions = n()) %>% 
        ggplot(aes(x = Month, y = Year), fill = Admissions) + 
        geom_tile()) 
    
    output$crimebar <- renderPlot(
      crimes %>% 
        ggplot(aes(reorder(Crime.Category,Count), y = Count)) +
        geom_col() +
        labs(title='Top 20 Crimes', x='Offense', y='Occurences') +
        scale_fill_brewer(palette = 'Set1') +
        theme_bw() +
        theme(legend.key=element_blank(), legend.position="bottom") +
        coord_flip()
      
      
      
      
      
      
    )
                 
     
    output$County1 <- renderInfoBox({
      # max_value <- max(state_stat[,input$selected])
      # max_state <- 
      #   state_stat$state.name[state_stat[,input$selected]==max_value]
      infoBox() #max_state, max_value, icon = icon("hand-o-up"
    })
    
    output$County2 <- renderInfoBox({
      infoBox()
    })
    output$County3 <- renderInfoBox({
      infoBox()
      
      
    })
      
    
    
    output$dt1 <- DT::renderDataTable({
      prison
      
    }) 
})




