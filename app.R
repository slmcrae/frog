#
library(shiny)
library(dplyr)
library(leaflet)
library(shinyWidgets)
library(readr)
library(RColorBrewer)

#load cleaned frogs file
frogs <- read.csv("C:/Users/SMcRae/udacity-git-course/frog/frogs_2001.csv")
# find frequency of each species
top_frogs_2001 <- frogs %>% group_by(Common_name) %>% summarise(Count=n())
# order by most observations to least
top_frogs_2001 <- top_frogs_2001[order(-top_frogs_2001$Count),]
# use the top 7 most observed because the numbers drop from 1433 for the 7th most commonly
# observed species (striped marsh frog) to 333 for the 8th most common species (Peron's Tree frog).
top_frogs <- head(top_frogs_2001,7)
# create a list of the names of the top 7 frogs
species_list <- unique(top_frogs$Common_name)
frogs.df <- frogs %>% filter(Common_name %in% species_list)
#species_list <- append(species_list, "All")

# add text for "about" tab:
about_text_1 <- "To use the app, select a year using the slide rule and then select one or more
            of the seven species of frogs in the drop down menu. Markers will appear on the map
            to indicate where observations were made. Click on the markers to view the scientific 
            and common names of the frogs at that location."

about_text_1.5 <-"Select a species from the list under \"What do they look like?\" to browse the 
            images."

about_text_2 <- "This app utilizes data from the Melbourne Water Corporation made available
            to the public on the Data Vic website. Melbourne Water began its citizen scientist 
            frog monitoring program in 2001. This data was collated with data from other sources 
            including the Victorian Biodiversity Atlas and incidental observations recorded during
            unrelated surveys, for example, surveys of birds and other wildlife."

about_text_3 <- "For more information, including links, photo credits and code, visit: https://github.com/slmcrae/frog"


# Define UI for application that draws a histogram
ui <- bootstrapPage(
  theme= shinythemes::shinytheme('simplex'),
  titlePanel(
         h1("Frog Observations: Melbourne Region", align="center")),
         h2("Melbourne Water Frog Census (2001 - 2018)", align="center"),
  leaflet::leafletOutput('map', width="100%", height="100%"),
  
  # place map on the ui:
  absolutePanel(top=120, left=30, id="controls", width=300, height="auto",
                tabsetPanel(
                  tabPanel("Data",
                sliderInput("year", "Select Year:", sep="", min = 2001, max = 2018, value = 2014),
                pickerInput("species", label="Select Species:", choices=species_list, 
                            selected="Growling Grass Frog",multiple=TRUE),
                hr(),
                selectInput("pic", "What do they look like?", choices=species_list, 
                            selected="Growling Grass Frog"),
                imageOutput("frog_img")),
                  tabPanel("About", htmlOutput("about"))
                
                
      )
    ),
  
  #add style to controls
  tags$style(type="text/css", "html, body {width:100%;height:100%}
		#controls{background-color:white;padding:20px;opacity:0.85;}"),
   
  )

# add interactive maps:
server <- function(input, output, session){
  
  filtered_data <- reactive({
       # frogs.df %>% filter(if(input$species=="All") year==input$year
                       #else (year==input$year & Common_name==input$species))
    frogs.df %>% 
      filter (year==input$year) %>%
      filter(Common_name %in% input$species)
  })
  
  output$map <- leaflet::renderLeaflet({
    #pal <- colorQuantile("Dark1", frogs.df$Common_name, n=7)
   pal <- colorFactor(
      palette= 'Dark2',
      domain = frogs.df$Common_name
    )
    # create base map with leaflet function
    filtered_data() %>%
    leaflet() %>%
      addTiles() %>%
      addCircleMarkers(lng=~Longitude, lat=~Latitude, fillOpacity=1, weight=1, 
                       radius=6, color= ~pal(Common_name),
                       popup= paste("Common name: ", frogs.df$Common_name, "<br>",
                                    "Scientific name: ", frogs.df$Scientific_name)) 
    
  })
  
  output$frog_img <- renderImage({
    if (input$pic=="Eastern Banjo Frog"){
      list(height = "auto", width = "100%", src = "www/eastern_banjo_frog.jpg")
    }
    else if (input$pic=="Eastern Common Froglet"){
      list(height = "auto", width = "100%", src = "www/eastern_common_froglet.jpg")
    }
    else if (input$pic=="Growling Grass Frog"){
      list(height = "auto", width = "100%", src = "www/growling_grass_frog.jpg")
    }
    else if (input$pic=="Southern Brown Tree Frog"){
      list(height = "auto", width = "100%", src = "www/southern_brown_tree_frog.jpg")
    }
    else if (input$pic=="Spotted Marsh Frog"){
      list(height = "auto", width = "100%", src = "www/spotted_marsh_frog.jpg")
    }
    else if (input$pic=="Striped Marsh Frog"){
      list(height = "auto", width = "100%", src = "www/striped_marsh_frog.jpg")
    }
    else if (input$pic=="Whistling Tree Frog"){
      list(height = "auto", width = "100%", src = "www/whistling_tree_frog.jpg")
    }
    #else if (input$species=="All"){
      #list(height = "auto", width = "100%", src = "www/verreauxs_tree_frog.jpg")
    #}
    else {
      list(height = "auto", width = "100%", src = "www/verreauxs_tree_frog.jpg")
    }
    
  }, deleteFile = F)
  
  output$about <- renderUI({
    about_text <- HTML(paste(about_text_1, about_text_1.5, about_text_2, about_text_3, sep="</br></br>"))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
