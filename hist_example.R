library(rtichoke)
library(glue)

probs <- c(0.3, 0.6, 0.4, 0.1, 0.4, 0.7, 0.3, 0.1, 0.2, 0.1)
reals <- c(0, 1, 1, 0, 1, 1, 0, 0, 1, 0)

auroc(
  probs = list(probs),
  reals = list(reals)
)


library(plotly)

list_hist <- hist(probs, 
     plot = FALSE, 
     breaks = seq(0, 1, by = 0.05)) 

dat_hist <- data.frame(
  Probability = list_hist$mids,
  Count = list_hist$counts,
  color = I("grey")
) |> 
  mutate(
    text = glue("{Count} Observations
                [{Probability-0.05}, {Probability+0.05})" )
  )


plot_ly(
  data = dat_hist,
  x =~ Probability,
  y =~ Count,
  text =~ text,
  hoverinfo = 'text',
  color =~ color) |> 
  add_bars() |> 
  layout(
    shapes = list(
      type = "line",
      y0 = 0,
      y1 = 1,
      yref = "paper",
      x0 = 0.15,
      x1 = 0.15,
      line = list(color = "black", dash="dot")
    )
  )

