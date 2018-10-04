library(shiny)
library(plotly)
library(REvola)
library(dplyr)

shinyServer(function(input, output, session) {
  observeEvent(input$SC1, {
    updateSliderInput(session, "Renewable_capacity", value=1.1)
    updateSliderInput(session, "Storage_energy", value=0.4)

  })
  observe({
    if(!is.null(input)) {
      SIM = tool2_table(
        year                  = input$year,
        Renewable_capacity    = input$Renewable_capacity,
        Curtailment_threshold = input$`Curtailment_threshold`,
        Storage_energy        = input$Storage_energy
      )
    }

    output$trendPlot <- renderPlotly({

      SIM$h<-ymd(paste(input$year, 1, 1, "-"))+dhours(1:NROW(SIM))

      yhour<-function(x) (yday(x)-1)*24+hour(x)
      xrange=yhour(input$xrange[1]):yhour(input$xrange[2])
      p<-visualise_tool(SIM[xrange,], showvars = input$showvars)

      p2<-plot_ly(SIM[xrange,], x=~h, y=~storage_energy_level,   name="store", type = 'scatter',
                  mode = 'line')%>%
        layout(title = '',
               xaxis = list(title = "",
                            showgrid = FALSE),
               yaxis = list(title = "Storage",
                            showgrid = FALSE), showlegend=TRUE)
      subplot(p,p2, shareX = TRUE, nrows=2, heights = c(.7,.3))
    })
    output$summaryPlot <- renderPlotly({
      results <- dplyr::summarise_all(SIM, sum)/1000
      opts<-pkg_options()
      p1<-plot_ly(results) %>%
        add_trace(x ="energy mix",  y = ~100*conventional_generation/demand, type = 'bar', marker=list(color= opts$conventional.color), name = 'conventional_generation') %>%
        add_trace(x ="energy mix",  y = ~100*renewable_generation/demand,    type = 'bar', showlegend=FALSE,marker=list(color= opts$renewable.color),    name = 'renewable_generation') %>%
        add_trace(x ="energy mix",  y = ~100*storage_discharging/demand,     type = 'bar', showlegend=FALSE,marker=list(color= opts$storage_discharging.color), name = 'storage_discharging') %>%

        layout(yaxis = list(title = '%'), barmode = 'stack')


      p2<-plot_ly(results) %>%
        add_trace(x ="renewables usage",  y = ~100*renewable_generation/renewable_availability,   type = 'bar', marker=list(color= opts$renewable.color),           name = 'renewables direct to grid') %>%
        add_trace(x ="renewables usage",  y = ~100*storage_discharging/renewable_availability,    type = 'bar', marker=list(color= opts$storage_discharging.color), name = 'renewables through store') %>%
        add_trace(x ="renewables usage",  y = ~100*curtailment/renewable_availability,           type = 'bar', marker=list(color= opts$curtailment.color),         name = 'renewables curtailed') %>%

        layout(yaxis = list(title = '%'), barmode = 'stack')

    subplot(p1,p2)


    })
    results<-calculate_indicators(SIM)
    output$BUFF <- renderText(sprintf("renewables: %.1f%%", results$renewables_in_net_demand))

  })



})
