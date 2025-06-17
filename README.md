# 🧪 Data Scientist Take-Home Test

Proyek ini terdiri dari tiga bagian yang mengevaluasi kemampuan analisis data, pemodelan machine learning, dan validasi statistik dalam konteks credit scoring.

## Tools & Teknologi

- **DuckDB** – Untuk analisis SQL berbasis file.
- **Python (via Anaconda)** – Untuk pemodelan prediksi menggunakan Jupyter Notebook.
- **R + ggplot2 + glmtoolbox** – Untuk validasi statistik dan visualisasi kalibrasi model.
- **VS Code** – Untuk pengelolaan project dan file coding.
- **Markdown** – Untuk mendokumentasikan insight dan hasil.

## 📁 Struktur Folder

├── data/
│ ├── credit_scoring.csv # Dataset risiko kredit
│ └── e_commerce_transactions.csv # Dataset transaksi e-commerce
├── notebooks/
│ ├── B_modeling.ipynb # Notebook model prediksi default
│ ├── model_results.csv # Output model prediksi
│ └── ecommerce.duckdb # Database DuckDB (opsional)
├── analysis.sql # SQL untuk analisis exploratory (Bagian A)
├── validation.R # Validasi statistik dan kurva kalibrasi (Bagian C)
├── validation_calibration.png # Output grafik kalibrasi (Bagian C)
├── A_findings.md # Ringkasan insight SQL (Bagian A)
├── C_summary.md # Ringkasan validasi & threshold (Bagian C)
├── requirements.txt # Dependensi Python
└── README.md # Panduan proyek ini

## Cara Menjalankan

### 🔹 Bagian A – SQL Analysis (DuckDB)

- Jalankan `analysis.sql` menggunakan DuckDB CLI atau Python-DuckDB.
- Dataset:
  - `data/e_commerce_transactions.csv`
- Ringkasan hasil: lihat `A_findings.md`

### 🔹 Bagian B – Modeling (Python)

- Buka `notebooks/B_modeling.ipynb` dengan Jupyter (Anaconda).
- Model: Logistic Regression
- Output: `notebooks/model_results.csv`
conda activate ds-env
jupyter notebook

 Bagian C – Validasi Statistik (R)
Jalankan validation.R di RStudio atau via terminal Rscript.

Output: 
Hasil HL Test di konsol
Grafik: validation_calibration.png
Ringkasan: C_summary.md

## Dependencies
- Python
pip install -r requirements.txt
- R
install.packages(c("glmtoolbox", "ggplot2", "ResourceSelection"))

