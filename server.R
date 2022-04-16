
#===================== Web App =================================

library(shiny)
library(shinydashboard)
library(caret)

model <- readRDS("rf_model.rds")



shinyServer(function(input, output, session){
  
  prediction <- reactive({
    predict(
      model,
      data.frame(
        "person_age" = input$var1,
        "person_income" = input$var2,
        "person_home_ownership" = input$var3,
        "person_emp_length" = input$var4,
        "loan_intent" = input$var5,
        "loan_grade"= input$var6,
        "loan_amnt" = input$var7,
        "loan_int_rate" = input$var8,
        "loan_percent_income" = input$var9,
        "cb_person_default_on_file" = input$var10,
        "cb_person_cred_hist_length" = input$var11
      ),
      type = "raw"
    )
  })
  
  prediction_label <- reactive({
    ifelse(prediction() == "0", "Eligible au credit", "Non Eligible au credit")
  })
  
  
  prediction_prob <- reactive({
    predict(
      model,
      data.frame(
        "person_age" = input$var1,
        "person_income" = input$var2,
        "person_home_ownership" = input$var3,
        "person_emp_length" = input$var4,
        "loan_intent" = input$var5,
        "loan_grade"= input$var6,
        "loan_amnt" = input$var7,
        "loan_int_rate" = input$var8,
        "loan_percent_income" = input$var9,
        "cb_person_default_on_file" = input$var10,
        "cb_person_cred_hist_length" = input$var11
      ),
      type = "prob")
  })
  
  
  prediction_color <- reactive({
    ifelse(prediction() == "0", "green", "red")
  })
  
  
  output$score_prediction <- renderValueBox({
    valueBox(
      value = paste(round(100 * prediction_prob()$'1', 0), "%"),
      subtitle = prediction_label(),
      color = prediction_color(),
      icon = icon('hand-holding-usd')
    )
  })
  
} )

#Run the App

#shinyApp( ui = ui, server = server)

