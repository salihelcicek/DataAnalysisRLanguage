# Gerekli paketleri yükle
if (!require("readxl")) install.packages("readxl")
if (!require("kableExtra")) install.packages("kableExtra")
if (!require("dplyr")) install.packages("dplyr")
library(readxl)
library(dplyr)
library(kableExtra)

# Veriyi Excel dosyasından yükle
file_path <- "survey (2) (1).xlsx" # Dosya yolunu düzenleyin
data <- read_excel(file_path)

# Rolleri gruplandır ve sayıları hesapla
role_distribution <- data %>%
  group_by(`2.    What is your current role?`) %>%
  summarise(Count = n()) %>%
  rename(Role = `2.    What is your current role?`)

# Tabloyu sanal olarak oluştur
role_distribution %>%
  kbl(col.names = c("Role", "Count"), align = "c", caption = "Role Distribution Table") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = F) %>%
  add_header_above(c("Role Distribution Summary" = 2))
