shinyUI(dashboardPage(
    dashboardHeader(title = "NY Prison Admissions", titleWidth = 250),
    dashboardSidebar(
        sidebarMenu(
            menuItem('Total Admittance',tabName = 'totaladmittance', icon = icon('database')),
            menuItem('Demographic Analysis',tabName = 'demographics', icon = icon('users')),
            menuItem('Trend Analysis',tabName = 'trends', icon = icon('chart-line')),
            menuItem('Top Crimes',tabName = 'crime', icon = icon('gavel')),
            menuItem('County Analysis',tabName = 'county', icon = icon('map')),
            menuItem('Data',tabName = 'data', icon = icon('table')),
            menuItem('Insights',tabName = 'insight', icon = icon('lightbulb-on')),
            
            selectizeInput('year', 
                           'Choose Year:', 
                           choices = c(2008:2018), 
                           selected = 2008),
            selectizeInput('gender', 
                           'Choose Sex:', 
                           choices = unique(prison$Gender),
                           selected = "Male"),
            selectizeInput('agecategory', 
                           'Choose Age:', 
                           choices = unique(prison$Age.Group)),
            width = 250)
        ),
     
    dashboardBody(
        tabItems(
            tabItem(tabName = 'totaladmittance',
                    fluidRow(
                      box(width = 6, plotOutput("plot1", height = 500), title = "Prison Admittance Per Year", status = "primary"))),
            
            
            
             tabItem(tabName = 'demographics',
                    fluidRow(
                        box(width = 6, plotOutput("agebar", height = 400), title = "Demographic Breakout", status = "primary"),
                        box(width = 6, plotOutput("agestack", height = 400), title = "Breakout by Year", status = "primary"), 
                        selectizeInput("demoinput", 
                                       choices = c("Male","Female"), 
                                       label = "Gender", 
                                       selected = "Male"))),
            
            
            
            tabItem(tabName = 'trends',
                    fluidRow(
                        box(width = 10, plotOutput("monthhist", height = 400), title = "Monthly Trend", status = "primary")), # add year + gender interactivity 
                    fluidRow(
                        box(width = 10, offset = 1, plotOutput("myheatmap", height = 400), title = "Heatmap", status = "primary"))
                    ),
            
            
            
            
            tabItem(tabName = 'crime',
                    fluidRow(
                        box(width = 6, plotOutput("crimebar", height = 600), title = "Top 20 Crimes",  
                            selectizeInput("crimetype","Crime",choices = unique(crimes$Crime.Category),selected = NULL, width =300),
                            selectizeInput("crimeyear","Year",choices = c(2008:2018), selected = 2018, width = 300), status = "primary"),
                        column(width = 6, box(width = 12, height = 300, "BY AGE", status = "primary"), 
                               box(width = 12, height = 300, "BY GENDER", status = "primary"),
                               box(width = 12, height = 300, "TBD", status = "primary")
                               ))),
            
            
            
            tabItem(tabName = 'county',
                    fluidRow(infoBoxOutput("County1", "County 1"),
                             infoBoxOutput("County2", "County 2"),
                             infoBoxOutput("County3", "County 3"))),
            
            
            
            tabItem(tabName = 'data',
                    DT::dataTableOutput("dt1")
            
                    )
            ),
        ),
    skin = "blue"
)
)