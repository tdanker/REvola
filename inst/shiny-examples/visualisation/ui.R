library(shiny)
library(plotly)
library(REvola)


SIM=tool1_table("2014")

shinyUI(fluidPage(
  titlePanel("  Simulation der Energieversorgung in Deutschland mit unterschiedlichen Anteilen erneuerbarer Energien und Speichertechnologien"),
  sidebarPanel(
    selectizeInput("year", "Year", names(demand), "2014"),
    #selectizeInput("model", "Model", c("energy oriented", "power oriented")),
    sliderInput("Renewable_capacity", "Renewable_capacity", min = 0, max = 1000, step = 0.2, value = 200),
    sliderInput("Curtailment_threshold", "Curtailment_threshold", min = 0, max = 20, value = 10),
    sliderInput("Storage_energy", "Storage_energy", min = 0, max = 10000, value = 1000),
    sliderInput("xrange", "ZOOM", min = 0, max = NROW(SIM), value = c(0, 0.01*NROW(SIM))),
    textOutput("BUFF"),
    actionButton("SC1", "SC1"),
    checkboxGroupInput("showvars", "Variables to show:",
                       c("storage loading" = "storage_loading",
                         "curtailment" = "curtailment")),

    p("Enjoy!")
  ),
  mainPanel(
    plotlyOutput("trendPlot"),
    plotlyOutput("summaryPlot")
     )
))

