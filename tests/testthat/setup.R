# Route base-graphics output to a null device so palette-drawing tests
# (show_palettes(), print.palette()) do not litter Rplots.pdf. The device is
# closed automatically when the test session ends.
grDevices::pdf(NULL)
