#setwd("~/Desktop/Coursera/DevelopDP_ShinyApp")
library(shiny)
input2bmi<-function(weight, height) weight/((height/100)^2)
bmiCheck<-function(bmi) {
        if (bmi >= 25) {
                return ("Overweight")
        } else if (bmi < 18.5) {
                return ("Underweight")
        } else { return("Normal")
        }
}
shinyServer(
        function(input, output) {
                output$inputWeight<-renderPrint({input$weight})
                output$inputHeight<-renderPrint({input$height})
                output$bmi<-renderPrint({input2bmi(input$weight, input$height)})
                output$bmicheck<-renderPrint({bmiCheck(input2bmi(input$weight, input$height))})
        }
        )
