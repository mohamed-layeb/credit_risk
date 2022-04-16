

#Loading libraries

library(readr)
library(dplyr)
library(caret)


credit01 <- read.csv("credit01.csv")

credit0 <- credit01%>%
  mutate_if(is.character, as.factor)%>%
  mutate(loan_status = as.factor(loan_status))

### New Data =========================

credit0 <- credit_risk_dataset %>%
  na.omit()%>%
  filter(person_age<75, person_income<150000,
         person_emp_length<25, loan_amnt<25000, 
         cb_person_cred_hist_length< 20,person_home_ownership != 'OTHER')%>%
  mutate(loan_status = as.factor(loan_status))%>%
  mutate_if(is.character, as.factor)

#==================== Web App ================================

set.seed(10000)

fitControl = trainControl(method = "cv", number = 3)

glm_model = train(loan_status~., 
                 data = credit0,
                 method="glm",
                 trControl=fitControl)

glm_model

rf_model = train(loan_status~., 
                  data = credit0,
                  method="rf",
                  trControl=fitControl)

rf_model




saveRDS(rf_model, "rf_model.rds")

# Exemple d'utilisation du modele

new_data = data.frame(
  "person_age" =20,
  "person_income" = 500000000,
  "person_home_ownership" = "RENT",
  "person_emp_length" =5,
  "loan_intent" = "PERSONAL",
  "loan_grade"= "D",
  "loan_amnt" = 40000,
  "loan_int_rate" = 17,
  "loan_percent_income" = 0.6,
  "cb_person_default_on_file" = "Y",
  "cb_person_cred_hist_length" = 5
)

new_data

pred = predict(glm_model, newdata = new_data, type = "prob")

pred


