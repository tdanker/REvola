library(shiny)
library(plotly)
library(REvola)
library(lubridate)
pkg_options(curtailment.color=rgb(0.6,0.8,1,.5))
pkg_options(storage_loading.color=rgb(0.2,0.3,1,.5))

SIM=tool1_table("2014")

shinyUI(fluidPage(
  titlePanel("  Interaktive Simulation: Deutschlands Stromversorgung bei unterschiedlichen Anteilen erneuerbarer Energien und Speichertechnologien"),
  sidebarPanel(
    selectizeInput("year", "Year", names(demand), "2014"),
    #selectizeInput("model", "Model", c("energy oriented", "power oriented")),
    sliderInput("Renewable_capacity", "Renewable_capacity", min = 0, max = 1000, step = 0.2, value = 400),
    sliderInput("Curtailment_threshold", "Curtailment_threshold", min = 0, max = 20, value = 10),
    sliderInput("Storage_energy", "Storage_energy", min = 0, max = 10000, value = 1000),
    sliderInput("xrange", "ZOOM",
                min = ymd("2014-1-1"),
                max = ymd("2014-12-31"),
                value = c(ymd("2014-10-1"),ymd("2014-10-30")),
                timeFormat = "%b %d"),
    textOutput("BUFF"),
    actionButton("SC1", "SC1"),
    checkboxGroupInput("showvars", "Variables to show:",
                       c("storage loading" = "storage_loading",
                         "curtailment" = "curtailment"),
                       selected = c("storage loading" = "storage_loading",
                                    "curtailment" = "curtailment")),

    p("Enjoy!")
  ),
  mainPanel(
    plotlyOutput("trendPlot"),
    plotlyOutput("summaryPlot")
     )
))

