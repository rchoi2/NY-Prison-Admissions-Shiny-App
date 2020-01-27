shinyUI(dashboardPage(
    dashboardHeader(title = "NY Prison Admissions", titleWidth = 250),
    
# Sidebar tabs    
    dashboardSidebar(
        sidebarMenu(
            menuItem('Introduction', 
                     tabName = 'intro', 
                     icon = icon('info-circle')),
            menuItem('Demographic Analysis',
                     tabName = 'demographics', 
                     icon = icon('users')),
            menuItem('Trend Analysis',
                     tabName = 'trends', 
                     icon = icon('chart-line')),
            menuItem('Top Crimes',
                     tabName = 'crime', 
                     icon = icon('gavel')),
            menuItem('County Analysis',
                     tabName = 'county', 
                     icon = icon('map')),
            menuItem('Data',
                     tabName = 'data', 
                     icon = icon('table')),
            width = 250)),
     
# Dashboard Body
    dashboardBody(
        tabItems(
            
            # Introduction UI
            tabItem(tabName = 'intro',
                    fluidRow(
                        box(width = 10,
                            h2("Introduction"),
                            br(), 
                            br(),
                            p("This exploratory data analysis examines prisons admissions data in New York State starting from 2008 and ending in 2018. This was provided by the state of New York via Kaggle."), 
                            br(),
                            p("Some insights that we hope to glean pertain to a multitude of factors such as age group (i.e. which age group commits more crimes today than in the past?) and gender (i.e. which are the most common crimes for men and women?). Please leverage this Shiny app to visualize data and draw your conclusions.")))),
            
            
            # Demographics UI
             tabItem(tabName = 'demographics',
                     fluidRow(
                         box(width = 7, 
                             plotOutput("demogbar", height = 400), 
                             title = "Incarceration by Gender and Age", 
                             status = "primary", 
                            selectizeInput("demogyear",
                                           "Choose Year:",
                                           choices = c(2008:2018), 
                                           selected = 2008, 
                                           width = 250))),
                     fluidRow(
                         box(width = 5, 
                             plotOutput("demogstack", height = 478), 
                             title = "Proportion by Gender", 
                             status = "primary"),
                         box(width = 5, 
                             plotOutput("demoagestack", 
                                        height = 478),
                             title = "Proportion by Age",
                             status = "primary"))),
            
            
            # Trends UI
            tabItem(tabName = 'trends',
                    fluidRow(
                        box(width = 8, 
                            plotOutput("monthtrend", 
                                       height = 600), 
                            title = "Monthly Trend", 
                            status = "primary",
                            selectizeInput("bymonthyear",
                                           "Choose Year:",
                                           choices = c(2008:2018), 
                                           selected = 2008, 
                                           width = 250))), 
                    fluidRow(
                        box(width = 8, 
                            plotOutput("myheatmap", 
                                       height = 600), 
                            title = "Heatmap", 
                            status = "primary"))),
            
            
            # Crime UI
            tabItem(tabName = 'crime',
                    fluidRow(
                        box(width = 6, 
                            plotOutput("crimebar", 
                                       height = 600), 
                            title = "Top 20 Crimes by Year",
                            selectizeInput("crimeyear",
                                           "Year",
                                           choices = c(2008:2018), 
                                           selected = 2018,
                                           width = 300), 
                            status = "primary"),
                        column(width = 6, 
                               box(width = 11, 
                                   height = 600, 
                                   status = "primary",
                                   plotOutput('agcrimeplot'),
                                   selectizeInput("crimeagegroup",
                                                  "Age Group", 
                                                  choices = unique(prison$Age.Group), 
                                                  selected = NULL, 
                                                  width = 200),
                                   selectizeInput("crimeageyear","Year",
                                                  choices = c(2008:2018), 
                                                  selected = 2018, 
                                                  width = 300)), 
                               box(width = 11, 
                                   height = 600, 
                                   status = "primary",
                                   plotOutput('gendercrimeplot'),
                                   selectizeInput("crimegender",
                                                  "Gender", 
                                                  choices = unique(prison$Gender), 
                                                  selected = NULL, 
                                                  width = 300),
                                   selectizeInput("crimegenderyear",
                                                  "Year",
                                                  choices = c(2008:2018), 
                                                  selected = 2018, 
                                                  width = 300))))),
            
            
            # County Tabs UI
            tabItem(tabName = 'county',
                    fluidRow(
                        box(width = 6, 
                            height = 500, 
                            status = "primary",
                            plotOutput('countyrankdecade')), 
                        box(width = 6, 
                            height = 500, 
                            status = "primary",
                            plotOutput('countyrankyearly'),
                            selectizeInput("rankyyrcty", 
                                           "Year", 
                                           choices = c(2008:2018), 
                                           selected = 2018))),
                    fluidRow(box(width = 9, 
                                 height = 450, 
                                 plotOutput('trendbycounty')),
                             box(width = 3, 
                                 height = 100,
                                 selectizeInput("yrcounty","County", 
                                                choices = unique(prison$County), 
                                                selected = NULL)))),
            
            # Datatable UI
            tabItem(tabName = 'data',
                    DT::dataTableOutput("dt1"))),
        ),
    skin = "purple"))

