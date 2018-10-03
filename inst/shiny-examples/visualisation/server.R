library(shiny)
library(plotly)


shinyServer(function(input, output, session) {
  observeEvent(input$SC1, {
    #updateSliderInput(session, "EE", value=1.1)
    #updateSliderInput(session, "store", value=0.4)

  })
  observe({
    if(!is.null(input)) {
      SIM = tool2_table(
        year                  = "2014",
        Renewable_capacity    = input$Renewable_capacity,
        Curtailment_threshold = input$`Curtailment_threshold`,
        Storage_energy        = input$Storage_energy
      )
    }

    output$trendPlot <- renderPlotly({

      SIM$h<-1:NROW(SIM)/24
      p<-visualise_tool(SIM[input$xrange[1]:input$xrange[2],])

      p2<-plot_ly(SIM[input$xrange[1]:input$xrange[2],], x=~h, y=~storage_energy_level,   name="store", type = 'scatter',
                  mode = 'line')%>%
        layout(title = '',
               xaxis = list(title = "",
                            showgrid = FALSE),
               yaxis = list(title = "Storage",
                            showgrid = FALSE), showlegend=TRUE)
      subplot(p,p2, shareX = TRUE, nrows=2, heights = c(.7,.3))
    })



  })



})
