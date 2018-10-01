library(shiny)
library(plotly)


shinyServer(function(input, output, session) {
  observeEvent(input$SC1, {
    updateSliderInput(session, "EE", value=1.1)
    updateSliderInput(session, "store", value=0.4)

  })
  observe({
    if(!is.null(input$store)){
      SIM=tool1_table(demand$`2014`, availability$`2014`)
    }

    output$trendPlot <- renderPlotly({

      SIM$h<-1:NROW(SIM)/24
      p<-plot_ly(SIM[input$xrange[1]:input$xrange[2],], x=~h, y=~demand,  heiht=700, name="demand", type = 'scatter', mode = 'line')%>%
        #add_trace(y = ~EE2grid+fromStore+buffer, name = 'EE+store+buff', fill = 'tozeroy', fillcolor = 'red', mode='none') %>%
        #add_trace(y = ~EE2grid+fromStore, name = 'EE+store', fill = 'tozeroy', fillcolor = 'blue', mode='none') %>%
        #add_trace(y = ~EE2grid+toStore, name = '2store', fill = 'tozeroy', fillcolor = 'skyblue', mode='none') %>%
        #add_trace(y = ~EE2grid, name = 'EE', fill = 'tozeroy', fillcolor = 'green', mode='none') %>%
        layout(title = '',
               xaxis = list(title = "",
                            showgrid = FALSE),
               yaxis = list(title = "Power",
                            showgrid = FALSE))

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
