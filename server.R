library(shiny)
library(dplyr)
library(gridExtra)
library(ggplot2)
library(cowplot)
library(sicegar)

##source necessary functions
source("add_inhibition_1.R")
source("make_inh_hist_1.R")

shinyServer(function(input,output) {
  
  variablesFromInput <- reactive({
    input_list <- list(
      "obs" = input$obs,
      "mRT" = input$mean,
      "std" = input$std,
      "SSRT" = input$ssrt,
      "dif1" = input$dif_1,
      "dif2" = input$dif_2,
      "dif3" = input$dif_3,
      "dif4" = input$dif_4,
      "dif5" = input$dif_5,
      "dif6" = input$dif_6
    )
    return(input_list)
  })
  
  SSD <- reactive({
    SSD_list <- list(
      "SSD1" = input$mean + input$dif_1,
      "SSD2" = input$mean + input$dif_2,
      "SSD3" = input$mean + input$dif_3,
      "SSD4" = input$mean + input$dif_4,
      "SSD5" = input$mean + input$dif_5,
      "SSD6" = input$mean + input$dif_6
    )
    return(SSD_list)
  })
  
  SRT <- reactive({
    SSD_list <- SSD()
    SRT_list <- list(
      "SRT1" = SSD_list$SSD1 + input$ssrt,
      "SRT2" = SSD_list$SSD2 + input$ssrt,
      "SRT3" = SSD_list$SSD3 + input$ssrt,
      "SRT4" = SSD_list$SSD4 + input$ssrt,
      "SRT5" = SSD_list$SSD5 + input$ssrt,
      "SRT6" = SSD_list$SSD6 + input$ssrt
    )
    return(SRT_list)
  })
  
  Inhib <- reactive({ 
    SSD_list <- SSD()
    SRT_list <- SRT()
    dist <- currentDist()
    
    Inhib1 <- sum(SRT_list$SRT1 <= dist)/length(dist)
    Inhib2 <- sum(SRT_list$SRT2 <= dist)/length(dist)
    Inhib3 <- sum(SRT_list$SRT3 <= dist)/length(dist)
    Inhib4 <- sum(SRT_list$SRT4 <= dist)/length(dist)
    Inhib5 <- sum(SRT_list$SRT5 <= dist)/length(dist)
    Inhib6 <- sum(SRT_list$SRT6 <= dist)/length(dist)
    
    Inhib1_early <- sum(dist > SRT_list$SRT1)/sum(dist > SSD_list$SSD1)
    Inhib2_early <- sum(dist > SRT_list$SRT2)/sum(dist > SSD_list$SSD2)
    Inhib3_early <- sum(dist > SRT_list$SRT3)/sum(dist > SSD_list$SSD3)
    Inhib4_early <- sum(dist > SRT_list$SRT4)/sum(dist > SSD_list$SSD4)
    Inhib5_early <- sum(dist > SRT_list$SRT5)/sum(dist > SSD_list$SSD5)
    Inhib6_early <- sum(dist > SRT_list$SRT6)/sum(dist > SSD_list$SSD6)
    
    Inhibitions <- c(Inhib1,Inhib2,Inhib3,Inhib4,Inhib5,Inhib6, Inhib1_early,Inhib2_early,Inhib3_early,Inhib4_early,Inhib5_early,Inhib6_early)
    return(Inhibitions)
  })    
  
  ##currentDist, reactive normal distribution  
  currentDist <- reactive({
    dist <- rnorm(n = input$obs, mean = input$mean, sd = input$std)
    return(dist)
  })
  
  #######################################
  
  output$plots <- renderPlot({
    input$calcButton
  
    #Determine which plot rendered depending on input choice
    if (input$graph == "Histogram")
    {
      isolate({
      dist <- currentDist()
      qplot(dist)
      })
    }
    else if (input$graph == "Histogram with Inhibition")
    {
      isolate({
      hist_inhib <- histograms()
      plot_grid(plotlist=hist_inhib, nrow=2, ncol=3)
      })
    }
    else if (input$graph == "Sigmoidal Fit")
    {
      isolate({
      sigmoidal_fit(TRUE)
      })
    }
    else if (input$graph == "All graphs")
    {
      isolate({
      dist <- currentDist()
      hist <- qplot(dist)
      hist_inhib <- histograms()
      sig <- sigmoidal_fit(FALSE)
      plot_grid(hist, sig, NULL, plotlist=hist_inhib, nrow=3, ncol=3)
      })
    }
  })
  
  
  # returns positions of values that need to be graphed 
  find_positions <- function () {
    difference <- unlist(variablesFromInput()[5:10], use.names=FALSE)
    positions <- c()
    count = 1
    for (dif in difference) {
      if (dif != 1) {
        positions <- c(positions, count)
      }
      count = count + 1
    }
    return(positions)
  }
  
  histograms <- function () {
    SSD_list <- SSD()
    SRT_list <- SRT()
    dist <- currentDist()
    positions <- find_positions()
    add_inhib_list <- rep(list(NA), length(positions))
    
    count = 1
    for (pos in positions) {
      add_inhib_list[[count]] <- add_inhibition(dist,SRT_list[[pos]],SSD_list[[pos]])

      add_inhib_list[[count]] <- make_inh_hist(add_inhib_list[[count]], SRT_list[[pos]],SSD_list[[pos]],input$mean,input$ssrt)
      count = count + 1
    }
    return(add_inhib_list)
  }
  
  sigmoidal_fit <- function(cond) {
    pos <- find_positions()
    pos_early <- pos + 6
    difference <- unlist(variablesFromInput()[5:10], use.names=FALSE)
    actual_diff <- difference[pos]
    Inhibitions <- Inhib()*100
    Inhibition_normal <- Inhibitions[pos]
    Inhibition_early <- Inhibitions[pos_early]
    time <- seq(-1000,0,1)

    df <- data.frame(delay = time, inhib = (1-pnorm(time+input$mean+input$ssrt,
                                                          input$mean,
                                                          input$std))*100)
    
    df1 <- data.frame(type = rep(c("normal"),each=length(pos)),
                      delay = actual_diff,
                      inhib = Inhibition_normal)
    df2 <- data.frame(type = rep(c("early"),each=length(pos)),
                      delay = actual_diff,
                      inhib = Inhibition_early)
    df_points <- rbind(df1,df2)
    print(df_points)
    
    ###plot sigmoidal curve 
    sigmoid_fit <- ggplot(data=df, aes(x=delay, y=inhib)) +
      xlab("SSD(ms before mRT)") +
      ggtitle("Inhibition curve") +
      ylab("percentage correct stop trials(%)") +
      geom_line() +
      geom_point(data=df_points, aes(group=type, color=type))
    g <- tableGrob(df_points)
    if (cond == TRUE)
    {
      sigmoid_fit <- sigmoid_fit + annotation_custom(grob=g,xmin=-1000,xmax=-750,ymin=0,ymax=95)
    }
  
    return(sigmoid_fit)
    
  }
  
})