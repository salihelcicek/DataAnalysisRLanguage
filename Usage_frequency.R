# Gerekli kütüphaneleri yükle
if (!require("readxl")) install.packages("readxl")
if (!require("dplyr")) install.packages("dplyr")
if (!require("ggplot2")) install.packages("ggplot2")
library(readxl)
library(dplyr)
library(ggplot2)

# Veriyi Excel dosyasından yükle
file_path <- "survey (2) (1).xlsx" # Dosya yolunu kontrol edin
data <- read_excel(file_path)

# Sütun isimlerini anlamlı şekilde yeniden adlandır
colnames(data) <- c(
  "Experience", 
  "Role", 
  "Use_AI_Tools", 
  "Coding_Assistants", 
  "Knowledge_Loss", 
  "Code_Modification", 
  "Problem_Solving", 
  "Impact_Juniors", 
  "Focus_Seniors", 
  "Collaboration_Teamwork"
)

# Use_AI_Tools sütunundaki yanıtların frekansını hesapla
bar_data <- data %>%
  group_by(Use_AI_Tools) %>%
  summarise(Count = n(), .groups = "drop")

# Eksik kategorileri ekle (eğer yoksa)
categories <- c("Strongly agree", "Agree", "Neutral", "Disagree", "Strongly Disagree")
bar_data <- bar_data %>%
  complete(Use_AI_Tools = categories, fill = list(Count = 0)) %>%
  arrange(factor(Use_AI_Tools, levels = categories))

# Bar chart oluştur
ggplot(bar_data, aes(x = Use_AI_Tools, y = Count)) +
  geom_bar(stat = "identity", fill = "#ADD8E6", color = "black", width = 0.7) + # Açık mavi renk
  labs(title = "AI Tool Usage Frequency",
       x = "Usage",
       y = "Count") +
  theme_minimal(base_size = 14) +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
        axis.text.y = element_text(size = 12))
