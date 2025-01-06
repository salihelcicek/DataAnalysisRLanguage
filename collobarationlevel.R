# Gerekli paketleri yükle
if (!require("readxl")) install.packages("readxl")
if (!require("ggplot2")) install.packages("ggplot2")
library(readxl)
library(ggplot2)

# Veriyi Excel dosyasından yükle
file_path <- "survey (2) (1).xlsx" # Dosya yolunu düzenleyin
data <- read_excel(file_path)

# Sütun isimlerini düzenle
colnames(data) <- c("Experience", "Role", "Use_AI_Tools", "Coding_Assistants",
                    "Knowledge_Loss", "Code_Modification", "Problem_Solving",
                    "Impact_Juniors", "Focus_Seniors", "Collaboration_Teamwork")

# Collaboration seviyelerini sayısal değerlere dönüştür
collaboration_levels <- c("Strongly disagree" = 1, "Disagree" = 2, "Neutral" = 3, 
                          "Agree" = 4, "Strongly agree" = 5)
data$Collaboration_Level <- collaboration_levels[data$Collaboration_Teamwork]

# Role ve Collaboration Level'a göre frekans hesapla
bubble_data <- data %>%
  group_by(Role, Collaboration_Level) %>%
  summarise(Count = n(), .groups = "drop")

# Bubble plot oluştur
ggplot(bubble_data, aes(x = Role, y = Collaboration_Level, size = Count)) +
  geom_point(color = "black", alpha = 0.7) +
  scale_y_continuous(breaks = 1:5, labels = names(collaboration_levels)) +
  scale_size_area(max_size = 15) +
  labs(title = "Collaboration and Teamwork Impact by Role (Positively)",
       x = "Role", y = "Collaboration Level", size = "Frequency") +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, face = "bold"))
