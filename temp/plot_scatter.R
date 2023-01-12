plot_scatter <- function(data, x, y, color,
                         variable,
                         trend = FALSE,
                         trend.variable = FALSE,
                         trend.model = NULL,
                         trend.ci = FALSE,
                         zero = "none",
                         pal_name,
                         scale.name = "",
                         scale.label = waiver(),
                         ...) {
  
  if (missing(variable)) {
    if (missing(color)) { color <- "#3957BD" }
    
    p <- ggplot(data = data, aes(x = {{ x }}, y = {{ y }})) +
      geom_point(color = color, ...)
    
  } else {
    
    if (missing(pal_name)) { pal_name <- "Qual9" }
    
    p <- ggplot(data = data, aes(x = {{ x }}, y = {{ y }}, color = {{ variable }})) +
      geom_point(...) +
      scale_color_benvi_d(pal_name = pal_name, name = scale.name, labels = scale.label)
    
  }
  
  if (zero != "none") {
    p <- plot_add_xy(p, type = zero)
  }
  
  if (isTRUE(trend)) {
    
    p <- p + geom_smooth(
      data = data,
      aes(x = {{ x }}, y = {{ y }}),
      method = trend.model,
      se = trend.ci,
      inherit.aes = trend.variable)
    
  }
  
  p + theme_benvi
  
}

plot_add_xy <- function(plot, type = "both") {
  
  if (type == "x") {
    plot + geom_hline(yintercept = 0)
  }
  
  if (type == "y") {
    plot + geom_vline(xintercept = 0)
  }
  
  if (type == "both") {
    plot + geom_hline(yintercept = 0) + geom_vline(xintercept = 0)
  }
  
}