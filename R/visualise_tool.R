visualise_tool<-function(SIM){
  opts<-pkg_options()
  plot_ly(SIM, x=~h, height=400, type = 'scatter', mode = 'lines', alpha=.5,
          name="conv",
          y=~conventional_generation,
          fill = 'tozeroy', fillcolor = opts$conventional.color, line=list(width=0, color=opts$conventional.color)) %>%

    add_ribbons(name = 'renewable generation',
                ymin = ~conventional_generation,
                ymax = ~conventional_generation+renewable_generation,
                fillcolor = opts$renewable.color, line=list(width=0, color=opts$renewable.color),mode='none') %>%

    add_ribbons(name = 'storage discharging',
                ymin = ~renewable_generation+conventional_generation,
                ymax = ~renewable_generation+conventional_generation+storage_discharging,
                fillcolor = opts$storage_discharging.color, line=list(width=0)) %>%

    add_ribbons(name = 'storage loading',
                ymin = ~conventional_generation+renewable_generation+storage_discharging,
                ymax = ~conventional_generation+renewable_generation+storage_discharging+storage_loading,
                fillcolor = opts$storage_loading.color, line=list(width=0)) %>%


    add_ribbons(name = 'curtailment',
                ymin = ~conventional_generation+renewable_generation+storage_discharging+storage_loading,
                ymax = ~conventional_generation+renewable_generation+storage_discharging+renewable_surplus,
                fillcolor = opts$curtailment.color, line=list(width=0)) %>%


    add_lines(name = 'demand',
              y = ~demand,
              mode='line', fill='none', line=list(color=opts$demand.color, width = .3)) %>%

    #add_lines(y = ~renewable_availability, name = 'renew_total',  mode='line', fill='none', line=list(color='green', width = 1)) %>%

    layout(title = '',
           xaxis = list(title = "",
                        showgrid = FALSE),
           yaxis = list(title = "Power",
                        showgrid = FALSE))
}
