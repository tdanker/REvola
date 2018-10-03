// here, we want to reproduce the calculations that are coded in the
// large table of the "tool" tab, not the associated macro

#include <Rcpp.h>
#include <algorithm>
#include <string>

using namespace Rcpp;

// [[Rcpp::export]]
DataFrame tool1_table_cpp(DoubleVector demand,
                      DoubleVector renewable_availability_factor,
                      double Renewable_capacity = 200, // GW
                      double Curtailment_threshold = 10, // GW
                      double storage_energy_level_startvalue = 1140.65589,
                      double Efficiency_loading	= 0.81,
                      double Efficiency_discharging	= 0.926){

  DoubleVector renewable_availability(demand.size());
  DoubleVector renewable_surplus(demand.size());
  DoubleVector renewable_generation(demand.size());
  DoubleVector residual_demand(demand.size());
  DoubleVector curtailment(demand.size());
  DoubleVector storage_loading(demand.size());
  DoubleVector storage_discharging(demand.size());
  DoubleVector storage_energy_level(demand.size());
  DoubleVector conventional_generation(demand.size());
  DoubleVector residual_demand_RLDC(demand.size());
  storage_energy_level[0]=storage_energy_level_startvalue;

  for( int i = 0; i < demand.size(); i++) {
    renewable_availability[i] = renewable_availability_factor[i] * Renewable_capacity;
    renewable_generation[i]   = std::min(renewable_availability[i], demand[i]);
    renewable_surplus[i]      = renewable_availability[i]-renewable_generation[i];
    residual_demand[i]        = demand[i]-renewable_generation[i];
    curtailment[i]            = - std::min( - renewable_surplus[i] + Curtailment_threshold, 0.0);
    storage_loading[i]        = renewable_surplus[i]-curtailment[i];
    if(i>0){
      storage_discharging[i]    = std::min(residual_demand[i], storage_energy_level[i-1]*Efficiency_discharging);
      storage_energy_level[i]   = storage_energy_level[i-1]+storage_loading[i]*Efficiency_loading-storage_discharging[i] / Efficiency_discharging;
    }
    conventional_generation[i] = std::max(residual_demand[i]-storage_discharging[i], 0.0);
    residual_demand_RLDC[i]    = demand[i] - renewable_availability[i];
  }


  // return a new data frame
  return DataFrame::create(_["demand"]                        = demand,
                           _["renewable_availability_factor"] = renewable_availability_factor,
                           _["renewable_availability"]        =  renewable_availability,
                           _["renewable_surplus"]             =  renewable_surplus,
                           _["renewable_generation"]          =  renewable_generation,
                           _["residual_demand"]               =  residual_demand,
                           _["curtailment"]                   =  curtailment,
                           _["storage_loading"]               =  storage_loading,
                           _["storage_discharging"]           =  storage_discharging,
                           _["storage_energy_level"]          =  storage_energy_level,
                           _["conventional_generation"]       =  conventional_generation,
                           _["residual_demand_RLDC"]          =  residual_demand_RLDC
  );
}
