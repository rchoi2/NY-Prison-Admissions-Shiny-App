shinyUI(dashboardPage(
    dashboardHeader(title = "NY Prison Admissions", titleWidth = 250),
    dashboardSidebar(
        sidebarMenu(
            menuItem('Total Admittance',tabName = 'totaladmittance', icon = icon('database')),
            menuItem('Age',tabName = 'agegroup', icon = icon('database')),
            menuItem('Monthly Trend',tabName = 'monthlytrend', icon = icon('database')),
            menuItem('Data',tabName = 'data', icon = icon('database')),
            
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
                      box(width = 6, plotOutput("plot1", height = 500), title = "Prison Admittance Per Year"))),
             tabItem(tabName = 'agegroup',
                    fluidRow(
                        box(width = 5, plotOutput("plot2", height = 400), title = "Prison Admittance by Age Group"))),
            tabItem(tabName = 'monthlytrend',
                    fluidRow(
                        box(width = 10, plotOutput("plot3", height = 400), title = "Monthly Trend"))),
            tabItem(tabName = 'data',
                    DT::dataTableOutput("dt1")
                    # fluidRow(
                    #     box(width = 12, plotOutput("plot3", height = 250), title = "Prison Data"))
                    )
            ),
        ),
    skin = "blue"
)
)