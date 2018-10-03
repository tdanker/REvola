library(shiny)
library(plotly)


SIM=tool1_table("2014")

shinyUI(fluidPage(
  titlePanel("Das macht Sinn!"),
  sidebarPanel(

    sliderInput("Renewable_capacity", "Renewable_capacity", min = 0, max = 500, step = 0.2, value = 200),
    sliderInput("Curtailment_threshold", "Curtailment_threshold", min = 0, max = 20, value = 10),
    sliderInput("Storage_energy", "Storage_energy", min = 0, max = 10000, value = 1000),
    sliderInput("xrange", "ZOOM", min = 0, max = NROW(SIM), value = c(0, NROW(SIM))),
    textOutput("BUFF"),
    actionButton("SC1", "SC1"),
    p("in jedem Fall benötigt man die volle LEISTUNG als PUFFER-RESERVE!")
  ),
  mainPanel(
    plotlyOutput("trendPlot")
     )
))

