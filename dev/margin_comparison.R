library(ggplot2)
library(benviplot)
library(hrbrthemes)

t1 <- theme_benvi()
t2 <- theme_minimal()
t3 <- theme_ipsum()

t1$plot.title@margin
t2$plot.title@margin
t3$plot.title@margin

t1$plot.subtitle$margin
t2$plot.subtitle$margin
t3$plot.subtitle@margin

t1$plot.caption$margin
t2$plot.caption$margin
t3$plot.caption@margin

t1$plot.margin
t2$plot.margin
t3$plot.margin
