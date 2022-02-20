library(casabourse)
library(plotly)
library(tidyquant)
atw <- daily.data('atw',from = '01-01-2017', to = '19-02-2022')
Ouverture <- atw$Value
Ouverture <- append(Ouverture,0,0)
Ouverture <- Ouverture[-length(Ouverture)]
atw$Ouverture <- Ouverture
atw$Date <- lubridate::dmy(rownames(atw))
atw <- atw[-1,] |> dplyr::relocate(Date, .before = Value)
fig <- atw %>% plot_ly(x=~Date, type = "candlestick",
                      open =~Ouverture, close =~Value,
                      high =~Maximum, low =~Minimum)
fig <- fig %>% layout(title = 'Chandeliers japonais (ATW)')

fig1 <- ggplot(atw,aes(x= Date, y= Value)) +
                      geom_barchart(aes(open = Ouverture, close= Value , high = Maximum,
                                        low = Minimum) ) +
          labs(title = 'Chandeliers japonais (ATW)')

