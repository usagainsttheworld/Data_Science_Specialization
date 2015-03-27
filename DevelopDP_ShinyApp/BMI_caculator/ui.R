library(shiny)
shinyUI(
        pageWithSidebar(
                headerPanel("BMI Caculator"),
                sidebarPanel(
                        h4('Complete the form to determine your Body Mass Index'),
                        numericInput('weight', 'Weight (kg)', 60, min=5, max=400),
                        numericInput('height', 'Height (cm)', 170, min=35, max=273),
                        submitButton('Calculate BMI'),
                        width = 5
                        ),
                mainPanel(
                        h4('The weight you entered is:'),
                        verbatimTextOutput("inputWeight"),
                        h4('The height you entered is:'),
                        verbatimTextOutput("inputHeight"),
                        h4('Your Body Mass Index is:'),
                        verbatimTextOutput("bmi"),
                        h4('This is considered:'),
                        verbatimTextOutput("bmicheck"),
                        width = 4
                        )
                )        
        )

