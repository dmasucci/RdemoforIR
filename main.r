# Load required libraries
library(readr)
library(ggplot2)
library(dplyr)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# Step 1: Load recent ACLED data (example: Africa conflict events sample)
acled_url <- "https://acleddata.com/download/29066/ (Note: Actual download requires login or manual download)"
# For demo purposes, use a pre-cleaned sample (or download CSV manually and read it like below)
# acled_data <- read_csv("acled_africa_sample.csv")

# Demo: Simulated structure (substitute this with real data)
acled_data <- data.frame(
  longitude = c(30.5, 31.2, 35.6, 28.3, 29.7),
  latitude = c(3.2, 2.9, -1.3, 0.5, 4.0),
  event_type = c("Battles", "Protests", "Violence against civilians", "Battles", "Riots")
)

# Step 2: Convert to spatial object
conflict_sf <- st_as_sf(acled_data, coords = c("longitude", "latitude"), crs = 4326)

# Step 3: Load base map of Africa
africa_map <- ne_countries(scale = "medium", continent = "Africa", returnclass = "sf")

# Step 4: Plot map
ggplot(data = africa_map) +
  geom_sf(fill = "gray90", color = "white") +
  geom_sf(data = conflict_sf, aes(color = event_type), size = 3, alpha = 0.8) +
  scale_color_brewer(palette = "Set1") +
  labs(
    title = "Recent Conflict Events in Africa",
    subtitle = "Using Sample Data from ACLED",
    color = "Event Type"
  ) +
  theme_minimal()

