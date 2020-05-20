library(shiny)
shinyUI(pageWithSidebar(  
  headerPanel("Data science FTW!"),  
  sidebarPanel(    
    h2('Big text'),    
    h3('Sidebar')  
  ),  
  mainPanel(      
    h3('Main Panel text')  
  )
))

shinyUI(pageWithSidebar(  
  headerPanel("Example plot"),  
  sidebarPanel(    
    sliderInput('mu', 'Guess at the mu',value = 70, min = 60, max = 80, step = 0.05,)  ), 
  mainPanel(    
    plotOutput('newHist')  
  )
))

library(UsingR)
data(galton)

shinyServer(  
  function(input, output) {    
    output$myHist <- renderPlot({      
      hist(galton$child, xlab='child height', col='lightblue',main='Histogram')      
      mu <- input$mu      
      lines(c(mu, mu), c(0, 200),col="red",lwd=5)      
      mse <- mean((galton$child - mu)^2)      
      text(63, 150, paste("mu = ", mu))      
      text(63, 140, paste("MSE = ", round(mse, 2)))      
    })      }
)


library(shiny)
library(miniUI)

pickXY <- function() {
  ui <- miniPage(
    gadgetTitleBar("Select Points by Dragging your Mouse"),
    miniContentPanel(
      plotOutput("plot", height = "100%", brush = "brush")
    )
  )
  
  server <- function(input, output, session) {
    output$plot <- renderPlot({
      plot(data_frame$X, data_frame$Y, main = "Plot of Y versus X",
           xlab = "X", ylab = "Y")
    })
    observeEvent(input$done, {
      stopApp(brushedPoints(data_frame, input$brush,
                            xvar = "X", yvar = "Y"))
    })
  }
  
  runGadget(ui, server)
}

my_data <- data.frame(X = rnorm(100), Y = rnorm(100))

pickXY(my_data)