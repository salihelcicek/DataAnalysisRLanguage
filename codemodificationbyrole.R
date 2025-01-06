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

# Role ve Code_Modification seviyelerine göre frekans hesapla
bar_data <- data %>%
  group_by(Role, Code_Modification) %>%
  summarise(Count = n(), .groups = "drop")

# Bar chart oluştur
ggplot(bar_data, aes(x = Role, y = Count, fill = Code_Modification)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_brewer(palette = "Set3") + # Renk paletini ayarla
  labs(title = "Distribution of Code Modification Levels by Role",
       x = "Role", y = "Count", fill = "Code Modification Level") +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, face = "bold"))
