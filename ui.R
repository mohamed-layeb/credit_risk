#===================== Web App =================================

library(shiny)
library(shinydashboard)


ui <- dashboardPage(
  
  dashboardHeader(title =  "Credit Scoring"),
  
  dashboardSidebar(),
  
  dashboardBody(
    tabName = "features",
    fluidRow(box(valueBoxOutput("score_prediction")),
             box(numericInput("var1", label = "Age du demandeur de credit", value = 20, min = 18 ))),
    
    fluidRow(box(numericInput("var2", label = "Revenu annuel du demandeur de credit", value = 10000, min = 0 )),
             box(selectInput("var3", label = "Proprieté immobiliere",
                             choices = c('MORTGAGE','OWN','RENT')))),
    
    fluidRow(box(numericInput("var4", label = "Depuis quand le demandeur de credit est-il en activite professionnelle ?", 
                              value = 1, min = 18 )),
             box(selectInput("var5", label = "Motif du pret bancaaire", 
                             choices = c('PERSONAL','EDUCATION','MEDICAL','VENTURE ','HOMEIMPROVEMENT','DEBTCONSOLIDATION')))),
    
    fluidRow(box(selectInput("var6", label = "Categorie du credit", choices = c('A','B','C','D','E','F','G'))),
             box(numericInput("var7", label = "Montant de credit", value = 2000, min = 18 ))),
    
    fluidRow(box(numericInput("var8", label = "Taux d'interet de credit (%)", value = 5, min = 18 )),
             box(numericInput("var9", label = "Ratio Dette/Revenu du demandeur de credit (valeur entre 0 et 1)",
                              value = 0.4, min = 0, max =1 ))),
    
    fluidRow(box(selectInput("var10", label = "Le demandeur du credit est-il à decouvert bancaire ?", 
                             choices = c('Y','N'))),
             box(numericInput("var11", label = "Echeance des credits en cours (en nombre d'annee)",
                              value = 3, min = 0)))
  )
)

