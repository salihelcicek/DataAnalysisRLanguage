# Gerekli kütüphaneleri yükle
if (!require("readxl")) install.packages("readxl")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("dplyr")) install.packages("dplyr")
if (!require("reshape2")) install.packages("reshape2")
library(readxl)
library(dplyr)
library(ggplot2)
library(reshape2)

# Veriyi Excel dosyasından yükle
file_path <- "survey (2) (1).xlsx" # Dosya yolunu kontrol edin
data <- read_excel(file_path)

# Tüm sütun isimlerini anlamlı şekilde yeniden adlandır
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

# Sütun isimlerini kontrol et
print(colnames(data))

# Rollere ve Impact_Juniors cevaplarına göre frekans hesapla
heatmap_data <- data %>%
  group_by(Role, Impact_Juniors) %>%
  summarise(Count = n(), .groups = "drop")

# Veriyi ısı haritası için geniş formata çevir
heatmap_matrix <- dcast(heatmap_data, Role ~ Impact_Juniors, value.var = "Count", fill = 0)

# Heatmap oluştur
ggplot(melt(heatmap_matrix, id.vars = "Role"), aes(x = variable, y = Role, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "steelblue") +
  labs(title = "Heatmap of Impact_Juniors Responses by Role",
       x = "Impact_Juniors Responses",
       y = "Roles",
       fill = "Count") +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, face = "bold"))
