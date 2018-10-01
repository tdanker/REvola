library(shiny)
library(plotly)


SIM=tool1_table(demand$`2014`, availability$`2014`)

shinyUI(fluidPage(
  titlePanel("Explore Sinns Scenario!"),
  sidebarPanel(

    sliderInput("store", "Size of Store:", min = 0, max = 50, step = 0.2, value = 30),
    sliderInput("EE", "EE", min = 0.3, max = 2, value = 1),
    sliderInput("store_out_frac", "store out frac", min = 0.1, max = 1, value = 1),
    sliderInput("xrange", "ZOOM", min = 0, max = NROW(SIM), value = c(0, NROW(SIM))),
    textOutput("BUFF"),
    actionButton("SC1", "SC1"),
    p("in jedem Fall benötigt man die volle LEISTUNG als PUFFER-RESERVE!")
  ),
  mainPanel(
    plotlyOutput("trendPlot")
     )
))

