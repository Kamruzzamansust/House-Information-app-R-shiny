library(shiny)
library(dplyr)
library(leaflet)

df <- read.csv("D:\\R shiny\\new_r_shiny_learning\\AUS_HOUSE\\melb_data.csv")
mean_landsize <- mean(df$Landsize, na.rm = TRUE)

# Replace missing values with mean
df$Landsize[is.na(df$Landsize)] <- mean_landsize
regions <- unique(df$Regionname)
all_suburbs <- unique(df$Suburb)

server <- function(input, output, session) {
  
  # Filter data based on user inputs
  filtered_data <- reactive({
    df_filtered <- df
    
    # Filter by region if selected
    if(input$region_dropdown != "ALL") {
      df_filtered <- df_filtered[df_filtered$Regionname == input$region_dropdown, ]
    }
    
    # Filter by suburb if selected
    if(input$suburb_dropdown != "ALL") {
      df_filtered <- df_filtered[df_filtered$Suburb %in% input$suburb_dropdown, ]
    }
    
    if (!is.null(input$variable)) {
      df_filtered <- df_filtered[df_filtered$Type %in% input$variable, ]
    }
    if (!is.null(input$obs5)) {
      df_filtered <- df_filtered[df_filtered$Rooms == input$obs5, ]
    }
    if (!is.null(input$obs1)) {
      df_filtered <- df_filtered[df_filtered$Distance == input$obs1, ]
    }
    # if (!is.null(input$obs2)) {
    #   df_filtered <- df_filtered[df_filtered$Bedroom2 == input$obs2, ]
    # }
    if (!is.null(input$obs3)) {
      df_filtered <- df_filtered[df_filtered$Bathroom == input$obs3, ]
    }
    if (!is.null(input$obs3)) {
      df_filtered <- df_filtered[df_filtered$Car == input$obs4, ]
    }
    
    print(df_filtered)
    # Filter by other criteria
    # You can add more filter conditions here based on other inputs
    
    return(df_filtered)
  })
  
  # Update suburb dropdown based on selected region
  observeEvent(input$region_dropdown, {
    if(input$region_dropdown == "ALL") {
      choices <- c("ALL" , all_suburbs)
    } else {
      choices <- c("ALL", unique(df[df$Regionname == input$region_dropdown, "Suburb"]))
    }
    updateSelectInput(session, "suburb_dropdown", choices = choices)
  })
  
  # Render leaflet map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(data = filtered_data(),
                 ~Longtitude, ~Lattitude,
                 popup = ~paste("Suburb:", Suburb, "<br>",
                                "Price:", Price))
    # Adjust the popup information as per your requirement
  })
}

