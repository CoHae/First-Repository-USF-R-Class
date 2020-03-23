library(shiny)
library(readxl)


# Return a Shiny app object
#shinyApp(ui = ui, server = server)
ui <- fluidPage(
  fileInput('datasetname', label = "Your data input file"
            #            accept = c("text/csv",
            #                       "text/comma-separated-values,text/plain",
            #                       ".csv")
  ),
  fileInput(inputId = "textfilename", label = "Your text input file"),
  numericInput('VLXTcolumn', label = "VLXT column number", value = 17,
               min = 1, max = 30, step = 1),
  numericInput('VSL2column', label = "VSL2 column number", value = 18,
               min = 1, max = 30, step = 1),
  numericInput('PONDRFITcolumn', label = "PONDRFIT column number", value = 16,
               min = 1, max = 30, step = 1),
  
  # no matter the input type, there are always these 2 first mandatory parameters, 
  # inputId and lable
  
  #__Output only reserves a space on the web page in the 
  textOutput('myintroduction'),
  #  tableOutput('result'),
  #tableOutput('mydata'),
  # chosen format (text,hostogram etc). This is not the command toproduce the output
  plotOutput('doublehistVXLT'),
  plotOutput('doublehistVSL2')
  #  ,plotOutput('mypie')
)
#ui <- fluidPage("Hello World")
#server <- function(input, output) 
#{
server <- function(input, output) {
  
  
  #------------------------------------------------------------
  #fileInput does not give back a "text" --> textOutput but rather it
  #gives back a data.frame with name, size, type, datapath!    
  #  output$result <- renderTable({
  #        input$datasetname
  #    dataset <- read_excel(input$datasetname$datapath, n_max =10)
  #    dataset$VLXT
  #  })
  output$myintroduction <- renderText({
    if(!require(docxtractr)){install.packages("docxtractr")}
    library(docxtractr)
    inFile <- input$textfilename
    #    inFile$datapath
    #    if (is.null(inFile))
    #      return(NULL)
    #        introduction <- read_docx(inFile$datapath, header = input$header)
    #    introduction <- read_docx(inFile$datapath)
    introduction <- readLines(con = inFile$datapath)
    introduction
  })
  
  output$doublehistVXLT <- renderPlot({
    if(!require(scatterplot3d)){install.packages("scatterplot3d")}
    if(!require(tidyverse)){install.packages("tidyverse")}
    if(!require(readxl)){install.packages("readxl")}
    if(!require(lattice)){install.packages("lattice")}
    if(!require(latticeExtra)){install.packages("latticeExtra")}
    if(!require(plotrix)){install.packages("plotrix")}
    if(!require(base2grob)){install.packages("base2grob")}# for pie3D
    if(!require(ggplotify)){install.packages("ggplotify")}
    if(!require(Rcpp)){install.packages("Rcpp")}
    if(!require(grid)){install.packages("grid")}
    if(!require(gridExtra)){install.packages("gridExtra")}
    library(scatterplot3d)
    library(tidyverse)
    library(readxl)
    library(lattice)
    library(latticeExtra)
    library(plotrix) 
    library(base2grob)
    library(ggplotify)
    library(Rcpp) 
    library(grid)
    library(gridExtra)
    
    #    dataset <- read_excel(input$datasetname$datapath, n_max =10)
    dataset <- read_excel(input$datasetname$datapath)
    
    
    # rename the columns I work with so I can address them by name 
    #    The number of the columns are shiny input values
    #plot(dataset())
    # hist (dataset$PONDRFIT)   
    shinyinputforVLXTcolumn  <- input$VLXTcolumn
    names(dataset)[shinyinputforVLXTcolumn] <- "VLXT"
    
    shinyinputforVSL2column  <- input$VSL2column
    names(dataset)[shinyinputforVSL2column] <- "VSL2"
    
    shinyinputforPONDRFITcolumn  <- input$PONDRFITcolumn
    names(dataset)[shinyinputforPONDRFITcolumn] <- "PONDRFIT"
    
    # first group of graphs: Title "Frequency Distribution of __ Disorder Score"
    # Frequency and relative frequency plot in one graph with overlayed curve for VLXT%, VSL2% and 
    # PONDR-FIT% in 10% increments. Side by side with corresponding pie chart in 10% increments.
    
    #VLXT --------------------------------------------------
    VLXTVector <- 100*dataset$VLXT
    #Cut data into sections
    #breaks = 0:10
    breaks <- c(0,10,20,30,40,50,60,70,80,90,100) 
    
    #Cut data into sections
    VLXTVector.cut = cut(VLXTVector, breaks, right=FALSE)
    VLXTVector.freq = table(VLXTVector.cut) 
    
    #Calculate relative frequency
    VLXTVector.relfreq = VLXTVector.freq / length(VLXTVector) 
    
    #Parse to a list to use xyplot later and assigning x values
    VLXTVector.list <- list(x = c(10,20,30,40,50,60,70,80,90,100), y = as.vector(VLXTVector.relfreq))
    #Build histogram and relative frequency curve
    hist1 <- histogram(VLXTVector, breaks = 10, freq = TRUE, col='skyblue', xlab="VLXT % Disorder", 
                       ylab="Frequency", main="Frequency Distribution of the Percent Disorder Score", 
                       plot=FALSE)
    relFreqCurve <- xyplot(y ~ x, VLXTVector.list, type="l", ylab = "Relative frequency", ylim=c(0,1))
    
    #Build double objects plot
    histgraph <- as.grob(
      doubleYScale(hist1, relFreqCurve, add.ylab2 = TRUE))
    piegraph <- base2grob(~pie(VLXTVector.freq, labels = breaks))
    #     grid.arrange(histgraph, nrow = 1)
    grid.arrange(histgraph,piegraph, nrow = 1)
  })
  
  #--------------------------------------------------------------------  
  output$doublehistVSL2 <- renderPlot({
    
    #    dataset <- read_excel(input$datasetname$datapath, n_max =10)
    dataset <- read_excel(input$datasetname$datapath)
    
    
    # rename the columns I work with so I can address them by name 
    #    The number of the columns are shiny input values
    #plot(dataset())
    # hist (dataset$PONDRFIT)   
    shinyinputforVLXTcolumn  <- input$VLXTcolumn
    names(dataset)[shinyinputforVLXTcolumn] <- "VLXT"
    
    shinyinputforVSL2column  <- input$VSL2column
    names(dataset)[shinyinputforVSL2column] <- "VSL2"
    
    shinyinputforPONDRFITcolumn  <- input$PONDRFITcolumn
    names(dataset)[shinyinputforPONDRFITcolumn] <- "PONDRFIT"
    
    # first group of graphs: Title "Frequency Distribution of __ Disorder Score"
    # Frequency and relative frequency plot in one graph with overlayed curve for VLXT%, VSL2% and 
    # PONDR-FIT% in 10% increments. Side by side with corresponding pie chart in 10% increments.
    
    #VSL2 --------------------------------------------------
    VSL2Vector <- 100*dataset$VSL2
    #Cut data into sections
    #breaks = 0:10
    breaks <- c(0,10,20,30,40,50,60,70,80,90,100) 
    
    #Cut data into sections
    VSL2Vector.cut = cut(VSL2Vector, breaks, right=FALSE)
    VSL2Vector.freq = table(VSL2Vector.cut) 
    
    #Calculate relative frequency
    VSL2Vector.relfreq = VSL2Vector.freq / length(VSL2Vector) 
    
    #Parse to a list to use xyplot later and assigning x values
    VSL2Vector.list <- list(x = c(10,20,30,40,50,60,70,80,90,100), y = as.vector(VSL2Vector.relfreq))
    #Build histogram and relative frequency curve
    hist1 <- histogram(VSL2Vector, breaks = 10, freq = TRUE, col='skyblue', xlab="VSL2 % Disorder", 
                       ylab="Frequency", main="Frequency Distribution of the Percent Disorder Score", 
                       plot=FALSE)
    relFreqCurve <- xyplot(y ~ x, VSL2Vector.list, type="l", ylab = "Relative frequency", ylim=c(0,1))
    
    #Build double objects plot
    histgraph <- as.grob(
      doubleYScale(hist1, relFreqCurve, add.ylab2 = TRUE))
    piegraph <- base2grob(~pie(VSL2Vector.freq, labels = breaks))
    #     grid.arrange(histgraph, nrow = 1)
    grid.arrange(histgraph,piegraph, nrow = 1)
  })
}
shinyApp(server = server, ui = ui)  