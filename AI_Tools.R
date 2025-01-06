# Gerekli kütüphaneleri yükle
if (!require("readxl")) install.packages("readxl")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("dplyr")) install.packages("dplyr")
if (!require("tidyr")) install.packages("tidyr")
library(readxl)
library(ggplot2)
library(dplyr)
library(tidyr)

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

# "Coding_Assistants" sütununu işleyerek birden fazla AI aracını ayrıştır
ai_usage_data <- data %>%
  separate_rows(Coding_Assistants, sep = ",\\s*") %>%
  group_by(Role, Coding_Assistants) %>%
  summarise(Count = n(), .groups = "drop")

# Boşlukları temizle
ai_usage_data$Coding_Assistants <- trimws(ai_usage_data$Coding_Assistants)

# Stacked bar chart oluştur
ggplot(ai_usage_data, aes(x = Role, y = Count, fill = Coding_Assistants)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = c("#4CAF50", "#81C784", "#A5D6A7", "#C8E6C9", "#E8F5E9","gray")) + # Yeşilimsi renkler
  labs(title = "AI Tool Usage by Role",
       x = "Role",
       y = "Usage Count",
       fill = "AI Tools") +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, face = "bold"))
