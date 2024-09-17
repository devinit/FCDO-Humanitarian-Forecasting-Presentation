list.of.packages <- c("data.table", "ggplot2", "stringr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(list.of.packages, require, character.only=T)

setwd("~/git/FCDO-Humanitarian-Forecasting-Presentation/")

dat = read.delim("best_loss.txt", sep=" ", header=F)
dat = dat[,c("V2", "V3", "V5")]
dat$V2 = as.numeric(gsub("]", "", dat$V2))
names(dat) = c("epoch", "set", "loss")

valid = subset(dat, set=="VALID")
min.valid.epoch = valid$epoch[which.min(valid$loss)]
message(min.valid.epoch, "/", max(valid$epoch))
test.loss.at.epoch = dat$loss[which(dat$set=="TEST" & dat$epoch==min.valid.epoch)]
message(test.loss.at.epoch)

ggplot(dat) +
  geom_vline(aes(xintercept=min.valid.epoch), linetype="dashed") +
  geom_line(aes(x=epoch, y=loss, group=set, color=set))
