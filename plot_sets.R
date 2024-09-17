list.of.packages <- c("data.table", "ggplot2", "scales")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(list.of.packages, require, character.only=T)

setwd("~/git/FCDO-Humanitarian-Forecasting-Presentation/")

dat = fread("data/displacement_worldclim.csv")

dat = dat[order(dat$year, dat$iso3), ]
dat$set = "Training"
dat$set[floor((nrow(dat) * 0.6)):nrow(dat)] = "Validation/Test"

ggplot(dat, aes(x=year, y=displaced_persons, group=set, color=set)) +
  geom_point() +
  scale_y_continuous(label=dollar_format(prefix=""))
