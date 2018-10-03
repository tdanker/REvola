tool1_table<-function(year=names(demand),
                      Renewable_capacity = 200,
                      Curtailment_threshold = 10,
                      storage_energy_level_startvalue = 0,
                      Efficiency_loading = 0.81,
                      Efficiency_discharging = 0.926,
                      ...){
  year=match.arg(year)
  tool1_table_cpp(demand[,year], availability[,year],
                  Renewable_capacity ,
                  Curtailment_threshold ,
                  storage_energy_level_startvalue ,
                  Efficiency_loading  ,
                  Efficiency_discharging)
}

tool2_table<-function(year=names(demand),
                      Renewable_capacity = 200,
                      Curtailment_threshold = 10,
                      storage_energy_level_startvalue = 0,
                      Efficiency_loading = 0.81,
                      Efficiency_discharging = 0.926,
                      Storage_energy = 1000){
  year=match.arg(year)
  tool2_table_cpp(demand[,year], availability[,year],
                  Renewable_capacity ,
                  Curtailment_threshold ,
                  storage_energy_level_startvalue ,
                  Efficiency_loading  ,
                  Efficiency_discharging,
                  Storage_energy)
}

