# Gerekli paketleri yükle
if (!require("readxl")) install.packages("readxl")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("dplyr")) install.packages("dplyr")
library(readxl)
library(ggplot2)
library(dplyr)

# Veriyi Excel dosyasından yükle
file_path <- "survey (2) (1).xlsx" # Dosya yolunu düzenleyin
data <- read_excel(file_path)

# Sütun isimlerini düzenle
colnames(data) <- c("Experience", "Role", "Use_AI_Tools", "Coding_Assistants",
                    "Knowledge_Loss", "Code_Modification", "Problem_Solving",
                    "Impact_Juniors", "Focus_Seniors", "Collaboration_Teamwork")

# Code_Modification seviyelerinin toplam frekansını hesapla
pie_data <- data %>%
  group_by(Code_Modification) %>%
  summarise(Count = n(), .groups = "drop")

# Pie chart oluştur
ggplot(pie_data, aes(x = "", y = Count, fill = Code_Modification)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  scale_fill_brewer(palette = "Set3") + # Renk paletini ayarla
  labs(title = "Distribution of Code Modification Levels",
       fill = "Code Modification Level") +
  theme_void(base_size = 14) + # Temiz bir tema
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))






