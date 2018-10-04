# code to quick-test the visualisation

SIM<-tool1_table("2014")
SIM$h<-1:NROW(SIM)/24
r1=1600:1800

visualise_tool(SIM[r1,])
#pkg_options()# does not work yet
#pkg_options(curtailment.color="orange")
#visualise_tool(SIM[r1,])
calculate_indicators(SIM)
