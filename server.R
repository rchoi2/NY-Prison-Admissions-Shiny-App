

shinyServer(function(input, output) {

# 
#     output$plot1 <- renderPlot(
#       prison %>% 
#         filter(Year == as.numeric(input$totalyear)) %>% 
#         group_by(Year, Month) %>% 
#         summarise(Total = n()) %>% 
#         ggplot(aes(x = Month, y = Total)) +
#         geom_bar(stat = "identity")) 
      
    
# Demographics    
    output$demogbar <- renderPlot(
      prison %>% 
        filter(Year == as.numeric(input$demogyear)) %>% 
        ggplot(aes(x = Age.Group, fill = Gender)) +
        geom_bar(position = "dodge")
      )
    
    output$demogstack <- renderPlot(
      prison %>% 
        ggplot(aes(x = Year)) +
        geom_bar(aes(fill = Gender), position = "fill")
      )

    output$demoagebar <- renderPlot(
      prison %>% 
        filter(Year == as.numeric(input$demoageyear)) %>% 
        ggplot(aes(x = Age.Group, fill = Gender), position = "dodge") +
        geom_bar())
    
    output$demoagestack <- renderPlot(
      prison %>% 
        ggplot(aes(x = Year)) +
        geom_bar(aes(fill = Age.Group), position = "fill"))
    
            
# Trend Analysis 
    
    output$monthtrend <- renderPlot(
      prison %>%
        filter(Year == as.numeric(input$bymonthyear)) %>%
        group_by(Month) %>%
        summarise(Admissions = n()) %>%
        ggplot(aes(x = Month, y = Admissions)) + 
        geom_line()) 
        
    output$myheatmap <- renderPlot(
      prison %>% 
        group_by(Year, Month) %>% 
        summarise(Admissions = n()) %>% 
        ggplot() +
        geom_tile(aes(x = Year, y = Month, fill = Admissions)) +
        scale_fill_gradient(low="white", high="darkblue")) 
      
    
    
    
# Top Crimes
    
    
    output$crimebar <- renderPlot(
      prison %>%  
        filter(Year == input$crimeyear) %>% 
        group_by(Crime.Category) %>% 
        summarise(Count = n()) %>% 
        arrange(desc(Count)) %>% 
        top_n(20) %>%  
        ggplot(aes(reorder(Crime.Category,Count), y = Count)) +
        geom_col() +
        labs(title='Top 20 Crimes', x='Offense', y='Occurences') +
        scale_fill_brewer(palette = 'Set1') +
        theme_bw() +
        theme(legend.key=element_blank(), legend.position="bottom") +
        coord_flip()
      )
    
    output$agcrimeplot <- renderPlot(
      prison %>%  
        filter(Age.Group == input$crimeagegroup  & Year ==input$crimeageyear) %>%
        group_by(Crime.Category) %>% 
        summarise(Count = n()) %>% 
        arrange(desc(Count)) %>% 
        top_n(5) %>%  
        ggplot(aes(reorder(Crime.Category, Count), y = Count)) +
        geom_col() +
        scale_fill_brewer(palette = 'Set1') +
        theme_bw() + 
        xlab ("Crime") + ylab("Total") + 
        ggtitle("Crimes by Age Group"))
    

    output$gendercrimeplot <- renderPlot(
      prison %>%  
        filter(Gender == input$crimegender  & Year ==input$crimegenderyear) %>%
        group_by(Crime.Category) %>% 
        summarise(Count = n()) %>% 
        arrange(desc(Count)) %>% 
        top_n(5) %>%  
        ggplot(aes(reorder(Crime.Category, Count), y = Count)) +
        geom_col() +
        scale_fill_brewer(palette = 'Set1') +
        theme_bw() + 
        xlab ("Crime") + ylab("Total") + 
        ggtitle("Crimes by Gender"))
    
    # output$gender
    # output$admissiontype
    
    

    
                 
# County 


    output$countyrankdecade <- renderPlot(
      prison %>%  
        group_by(County) %>% 
        summarise(Count = n()) %>% 
        arrange(desc(Count)) %>% 
        top_n(20) %>%  
        ggplot(aes(reorder(County,Count), y = Count)) +
        geom_col() +
        labs(title='Top 20 Counties from 2008 to 2018', x='County', y='Occurences') +
        scale_fill_brewer(palette = 'Set1') +
        theme_bw() +
        theme(legend.key=element_blank(), legend.position="bottom") +
        coord_flip()  
    )
    
    output$countyrankyearly <- renderPlot(
      prison %>%  
        filter(Year == input$rankyyrcty) %>%  
        group_by(County) %>% 
        summarise(Count = n()) %>% 
        arrange(desc(Count)) %>% 
        top_n(20) %>%  
        ggplot(aes(reorder(County,Count), y = Count)) +
        geom_col() +
        labs(title='Top 20 Counties by Year', x='County', y='Occurences') +
        scale_fill_brewer(palette = 'Set1') +
        theme_bw() +
        theme(legend.key=element_blank(), legend.position="bottom") +
        coord_flip())
    
    
    
    
    output$trendbycounty <- renderPlot(
      prison %>%  
        filter(County == input$yrcounty) %>% 
        group_by(Year) %>% 
        summarise(Count = n()) %>% 
        ggplot(aes(x = Year, y = Count)) +
        geom_line() + 
        scale_fill_brewer(palette = 'Set1') + 
        theme_bw() +
        ylab('Total)') + 
        ggtitle("Yearly Trend by County"))
    

      

    
# Data Tab
    output$dt1 <- DT::renderDataTable({
      prison
      }) 
})



