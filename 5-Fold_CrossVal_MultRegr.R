data <- read.csv("data.csv", header = TRUE)
install.packages("DAAG")
library(DAAG)
library(caret)


predictors.log <- with(data, data.frame(log(data$total_comments), log(data$taiwan_release_date), log(data$TotalMinutes), log(data$expected_rating), 
                        log(data$num_exp_votes), log(data$actual_rating), log(data$num_actual_votes), log(data$boxoffice_taiwan.10thousand.),
                        log(data$china_release_date), log(data$china_date),  data$type_action, log(data$boxoffice_china.100million.),
                       data$type_adventure, data$type_animation, data$type_comedy, data$type_crime, data$type_drama,
                       data$type_fantasy, data$type_horror, data$type_other, data$type_romance, data$type_sci.fi, 
                       data$type_thriller, data$taiwan_day_Friday, data$taiwan_day_Thursday,	data$taiwan_day_Tuesday,	data$taiwan_day_Wednesday,	data$taiwan_month_April,
                       data$taiwan_month_August,	data$taiwan_month_December,	data$taiwan_month_February,	data$taiwan_month_January,	data$taiwan_month_July,
                       data$taiwan_month_June,	data$taiwan_month_March,	data$taiwan_month_May,	data$taiwan_month_November,	data$taiwan_month_October,
                       data$taiwan_month_September,	data$china_day_Friday,	data$china_day_Monday,	data$china_day_Saturday,	data$china_day_Sunday,
                       data$china_day_Thursday,	data$china_day_Tuesday,	data$china_day_Wednesday,	data$china_month_April,	data$china_month_August,
                       data$china_month_December,	data$china_month_February,	data$china_month_January,	data$china_month_July,	data$china_month_June,
                       data$china_month_March,	data$china_month_May,	data$china_month_November,	data$china_month_October,	data$china_month_September)
)


cv.regr1 <- CVlm(data = predictors.log, form.lm = formula(log.data.boxoffice_china.100million.. ~ log.data.total_comments. + log.data.taiwan_release_date. + 
                                                            log.data.TotalMinutes. + log.data.expected_rating. + log.data.num_exp_votes. + log.data.actual_rating. +
                                                            log.data.num_actual_votes. + log.data.boxoffice_taiwan.10thousand.. + 
                                                            log.data.china_release_date. + data.type_action +
                                                        data.type_adventure + data.type_animation + data.type_comedy + data.type_crime +
                                                        data.type_drama + data.type_fantasy + data.type_horror + data.type_other +
                                                        data.type_romance + data.type_sci.fi + data.type_thriller + 
                                                        data.taiwan_day_Friday + data.taiwan_day_Thursday+ data.taiwan_day_Tuesday +
                                                        data.taiwan_day_Wednesday + data.taiwan_month_April + data.taiwan_month_August +
                                                        data.taiwan_month_December + data.taiwan_month_February +
                                                        data.taiwan_month_July + data.taiwan_month_June + data.taiwan_month_March +
                                                        data.taiwan_month_May + data.taiwan_month_November+ data.taiwan_month_October +
                                                        data.taiwan_month_September+ data.china_day_Friday +data.china_day_Monday +
                                                        data.china_day_Saturday + data.china_day_Sunday + data.china_day_Thursday +
                                                        data.china_day_Tuesday + data.china_day_Wednesday, data.china_month_April+
                                                        data.china_month_August + data.china_month_December + data.china.month_February +
                                                        data.china_month_January + data.china_month_July + data.china_month_June + 
                                                        data.china_month_March + data.china_month_May + data.china_month_November + 
                                                        data.china_month_October + data.china_month_September), m=5,plotit = "Observed" )



cv.regr2 <- CVlm(data = predictors.log, form.lm = formula(log.data.boxoffice_china.100million.. ~ log.data.total_comments. + log.data.taiwan_release_date. + 
                                                        log.data.TotalMinutes. + log.data.expected_rating. + log.data.num_exp_votes. + log.data.actual_rating. +
                                                        log.data.num_actual_votes. + log.data.boxoffice_taiwan.10thousand.. + 
                                                        log.data.china_release_date. + data.type_action +
                                                       data.type_animation + data.type_sci.fi + 
                                                        data.taiwan_day_Friday + 
                                                        data.taiwan_day_Wednesday + data.taiwan_month_April +  data.china_day_Friday + 
                                                         data.china_month_May + data.china_day_Wednesday), m=5,plotit = "Observed" )




cv.regr3 <- CVlm(data = predictors.log, form.lm = formula(log.data.boxoffice_china.100million.. ~ log.data.total_comments. +  log.data.boxoffice_taiwan.10thousand.. + 
                                                         log.data.num_actual_votes.), m=5,plotit = "Observed" )




  
dat.reg <- lm(boxoffice_china(100million)_red ~ log.data.boxoffice_taiwan.10thousand.., data=tevotes_bot.log)
abline(tevotes_bot.regr,  lwd=2, col="red")
summary(tevotes_bot.regr)







tevotes_bot <- data.frame(data$num_exp_votes,data$boxoffice_taiwan.10thousand. )
cor(tevotes_bot)

tevotes_bot.log <- with(tevotes_bot, data.frame(log(data$num_exp_votes), log(data$boxoffice_taiwan.10thousand.)))
plot(tevotes_bot.log, main="Number of Expected Votes VS Taiwan Box Office", col="blue", lwd=1 )

tevotes_bot.regr <- lm(log.data.num_exp_votes. ~ log.data.boxoffice_taiwan.10thousand.., data=tevotes_bot.log)
abline(tevotes_bot.regr,  lwd=2, col="red")
summary(tevotes_bot.regr)

#_______________________________________
actvotes_bot <- data.frame(data$num_actual_votes,data$boxoffice_taiwan.10thousand. )
cor(actvotes_bot)

actvotes_bot.log <- with(actvotes_bot, data.frame(log(data$num_actual_votes), log(data$boxoffice_taiwan.10thousand.)))
plot(actvotes_bot.log, main="Number of Actual Votes VS Taiwan Box Office", col="blue", lwd=1 )

actvotes_bot.regr <- lm(log.data.num_actual_votes. ~ log.data.boxoffice_taiwan.10thousand.., data=actvotes_bot.log)
abline(actvotes_bot.regr,  lwd=2, col="red")
summary(actvotes_bot.regr)
#______________________________________________
boxoffice <- data.frame(data$boxoffice_china.100million.,data$boxoffice_taiwan.10thousand. )
na.omit(boxoffice)
cor(na.omit(boxoffice))

boxoffice.log <- with(na.omit(boxoffice), data.frame(log(data$boxoffice_china.100million.), log(data$boxoffice_taiwan.10thousand.)))
plot(boxoffice.log, main="China Boxoffice VS Taiwan Box Office", col="blue", lwd=1 )

boxoffice.regr <- lm(log.data.boxoffice_china.100million.. ~ log.data.boxoffice_taiwan.10thousand.., data=boxoffice.log)
abline(actvotes_bot.regr,  lwd=2, col="red")
summary(boxoffice.regr)


#___________________________________________
