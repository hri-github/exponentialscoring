shinyServer(
    function(input, output) {
        output$myExpCurve <- renderPlot({
            MaxScore = input$MaxScore
            ExpValue = input$ExpValue

            #x-axis
            Score = c(0:MaxScore)
            
            #y-axis
            Exp01 = MaxScore * (Score / MaxScore)^ExpValue
            Exp1 = ( (MaxScore + 1) ^ (Score / MaxScore) ) -1
            
            grid(NA, 5, lwd = 2)
            plot( x = Score, y = Exp1, type = "o", col = "red", main = "Exponential Scoring")
            text( Score, Exp1, round(Exp1, 2), cex=1, pos = 3)
        })
 #       output$table<-renderTable(readRDS("mtcars.rds"))
#        output$table <- renderTable(rbind(Score, NewScore))
        mt<-readRDS("mtcars.rds")
        
        # Downloadable csv of selected dataset ----
        output$downloadData <- downloadHandler(
          filename = function() {
            paste("report",Sys.time(), ".csv", sep = "")
          },
          content = function(file) {
            write.csv(mt, file, row.names = FALSE)
          }
        )  
        
    }
)
