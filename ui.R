




library(shiny)
library(dplyr)
library(leaflet)

df <- read.csv("D:\\R shiny\\new_r_shiny_learning\\AUS_HOUSE\\melb_data.csv")
mean_landsize <- mean(df$Landsize, na.rm = TRUE)

# Replace missing values with mean
df$Landsize[is.na(df$Landsize)] <- mean_landsize

regions <- unique(df$Regionname)
all_suburbs <- unique(df$Suburb)

ui <- fluidPage(
  
  tags$head(
    tags$style(HTML("
      .center-title {
        text-align: center;
      }
    "))
  ),
  
  titlePanel("Melbourne Housing Information App", windowTitle = "Melbourne Housing"),
  
  
  
  sidebarLayout(
    
    # Sidebar with a slider input
    sidebarPanel(
      selectInput("region_dropdown", label = "Select Regionname:",
                  choices = c("ALL", unique(df$Regionname)),
                  selected = NULL,
                  #multiple = TRUE,
                  selectize=TRUE),
      selectInput("suburb_dropdown", label = "Select Suburb:",
                  choices = NULL),
      checkboxGroupInput("variable", "Type",
                         choices = c("H - House, Cottage, Villa, Semi-Terrace" = "h",
                                     "U - Unit, Duplex" = "u",
                                     "T - TownHouse" = "t")),
      sliderInput("obs1", "Distance from CBD",
                  min = min(df$Distance), max = max(df$Distance), value = 3.2,step = 0.1
      ),
      numericInput("obs5", "Number Of Rooms:", 2, min = min(df$Rooms), max = max(df$Rooms)),
      # numericInput("obs2", "Number Of Bedrooms:", 3, min = min(df$Distance), max = max(df$Distance)),
      numericInput("obs3", "Number Of Bathrooms:", 1, min = min(df$Bathroom), max = max(df$Bathroom)),
      numericInput("obs4", "Number Of Car Parking spot:", 1, min = min(df$Car), max = max(df$Car)),
      
      # sliderInput("obs5", "LandSize",
      #             min = min(df$Landsize), max = max(df$Landsize), value = 30000
      # )
      # Initialize with no choices
    ),
    
    # Show a plot of the generated distribution
    mainPanel( 
      style = "margin-top:0px; height:1000px;",
      leafletOutput("map",height=620)
    )
  )
)










