# Install & load ResourceSelection
install.packages("ResourceSelection", repos = "https://cloud.r-project.org")
library(ResourceSelection)

data <- read.csv("D:/ds-takehome-test/notebooks/model_results.csv")
model <- glm(actual_default ~ prob_default, data = data, family = "binomial")

pred <- predict(model, type = "response")
hl_result <- hoslem.test(data$actual_default, pred, g = 10)

install.packages("ResourceSelection", repos = "https://cloud.r-project.org")
library(ResourceSelection)

model <- glm(actual_default ~ prob_default, data = data, family = "binomial")
pred <- predict(model, type = "response")

hl_result <- hoslem.test(data$actual_default, pred, g = 10)
print(hl_result)

if (!require(ggplot2)) install.packages("ggplot2", repos = "https://cloud.r-project.org")
if (!require(dplyr)) install.packages("dplyr", repos = "https://cloud.r-project.org")

library(ggplot2)
library(dplyr)

# Binning 10 grup berdasarkan probabilitas prediksi
data$prob_bin <- ntile(data$prob_default, 10)
calib_data <- data %>%
  group_by(prob_bin) %>%
  summarise(
    predicted = mean(prob_default),
    actual = mean(actual_default)
  )

# Buat plot kalibrasi
p <- ggplot(calib_data, aes(x = predicted, y = actual)) +
  geom_line(color = "blue") +
  geom_point(size = 2, color = "darkred") +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  labs(
    title = "Calibration Curve",
    x = "Predicted Probability",
    y = "Actual Default Rate"
  ) +
  theme_minimal()

# Simpan ke file PNG
ggsave("D:/ds-takehome-test/validation_calibration.png", plot = p, width = 6, height = 4)

cutoff_df <- data %>%
  filter(prob_default <= 0.05) %>%
  arrange(prob_default)

head(cutoff_df, 5)