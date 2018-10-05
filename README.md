# REvola
#### Visualisations of H.W. Sinns and A.Zerrahns renewable energy storage scenarios 

Sun is not always shining and wind is not always blowing. Thus, with increasing shares of renewable energy, its volatility becomes a concern. What is the best way to buffer this volatility? Is there an upper limit for renewables ?   

In his paper *"Buffering volatility: A study on the limits of Germany's energy revolution (2017)"*, Hans-Werner Sinn explores this questions, based on his own claculations, and draws some rather pessimistic conclusions.  

His view was challenged soon after by research of A. Zerrahn et al: *"On the economics of electrical storage for variable renewable energy sources (2018)"*, where Sinns calculations are reproduced, extended and finally an optimistic view is (re-)established.  

This package provides interactive visualisations of some of A. Zerrahns findings. 
You can explore it online here: https://patchexplorer.shinyapps.io/revola_deploy/

#### Technical background
The original paper is based on 2 spreadsheet tools and a  numerical optimization model, all of which are open source and available online. 
For our visualisations, we provide a fast re-implementation of both spreadsheet tools using Rcpp.
The interacitve visualisation is done with the "shiny" package. 
