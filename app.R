#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(shinyWidgets)
library(readr)
library(dplyr)
library(devtools)
#install_github("mdsumner/ozmaps")
library(sf)
library(ozmaps)
#create map background for location plots:
oz_states <- ozmaps::ozmap_states %>% filter(NAME != "Other Territories")
library(ggplot2)

#load cleaned frogs file
frogs <- read.csv("frogs_2001.csv")
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
species_list <- append(species_list, "All")

ui <- fluidPage(
  titlePanel(
    h1("Frog Observations: Melbourne Region", align="center")),
  h2("Melbourne Water Frog Census (2001 - 2018)", align="center"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("year", "Select Year:", sep="", min = 2001, max = 2018, value = 2017),
      selectInput("species", label="Select Species:", selected="All", choices=species_list),
      imageOutput("frog_img")
    ),
  mainPanel(
    plotOutput("plot1")
    )
  )
)


server <- function(input, output) {
  options(width = 100) # Increase text width for printing table
  output$plot1 <- renderPlot({
    ggplot() + 
      geom_sf(data=oz_states, color="black", fill="white") +
      geom_point(data=frogs.df %>% filter(if(input$species=="All") year==input$year
                                          else (year==input$year & Common_name==input$species)), mapping=aes(x=Longitude, y=Latitude, color=Common_name),
                 size=1.5,show.legend=TRUE ) +
      guides(color = guide_legend(title = "Species", override.aes = list(size = 7)))+
      labs(x="Longitude", y="Latitude",
           caption="Data Source: Data Vic")+
      theme(plot.title=element_text(hjust=0.5), 
            plot.caption=element_text(hjust=0, face="italic", size=10), 
            panel.border=element_rect(fill=NA,size=1),
            legend.title = element_text(size=17),
            legend.text = element_text(size=13),
            axis.text = element_text(size = 11),
            axis.title = element_text(size = 15))+
      coord_sf(xlim = c(143.5542, 146.4239), ylim = c(-39.07316, -37.01971))+
      annotate("text", x=144.12, y=-38.1493, label= "Geelong")+
      annotate("text", x=146.05, y=-39.0, label= "Wilson's Promontory")+
      annotate("text", x=145.9090, y=-37.2346, label= "Eildon")+
      annotate("text", x=143.8503, y=-37.5622, label= "Ballarat")+
      annotate("text", x=146.3, y=-38.1940, label= "Traralgon")+
      annotate("text", x=144.2172, y=-37.0633, label= "Castlemaine")+
      annotate("text", x=143.76, y=-38.9, label= "Cape Otway")
  })
  output$frog_img <- renderImage({
    if (input$species=="Eastern Banjo Frog"){
      list(height = "auto", width = "100%", src = "www/eastern_banjo_frog.jpg")
    }
    else if (input$species=="Eastern Common Froglet"){
      list(height = "auto", width = "100%", src = "www/eastern_common_froglet.jpg")
    }
    else if (input$species=="Growling Grass Frog"){
      list(height = "auto", width = "100%", src = "www/growling_grass_frog.jpg")
    }
    else if (input$species=="Southern Brown Tree Frog"){
      list(height = "auto", width = "100%", src = "www/southern_brown_tree_frog.jpg")
    }
    else if (input$species=="Spotted Marsh Frog"){
      list(height = "auto", width = "100%", src = "www/spotted_marsh_frog.jpg")
    }
    else if (input$species=="Striped Marsh Frog"){
      list(height = "auto", width = "100%", src = "www/striped_marsh_frog.jpg")
    }
    else if (input$species=="Whistling Tree Frog"){
      list(height = "auto", width = "100%", src = "www/whistling_tree_frog.jpg")
    }
    else if (input$species=="All"){
      list(height = "auto", width = "100%", src = "www/verreauxs_tree_frog.jpg")
    }
    else {
      list(height = "auto", width = "100%", src = "www/growling_grass_frog.jpg")
    }
    
    }, deleteFile = F)
  
}

shinyApp(ui, server)