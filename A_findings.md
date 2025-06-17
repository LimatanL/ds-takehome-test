# Findings – SQL Analytics (Bagian A)

## RFM Segmentation
- Total customer dianalisis: 1,000 pelanggan.
- Segmentasi RFM berhasil memetakan pelanggan ke dalam 8 segmen.
- 22% pelanggan berisiko hilang (At Risk).
- 16% pelanggan terbaik berada di segmen Champions.
- Lost Customers masih cukup besar (9,4%), potensi program win-back.
- Potential Loyalists menunjukkan peluang untuk dijadikan pelanggan setia.

## Anomaly Detection
- Sebanyak **457 anomali** terdeteksi pada dataset `e_commerce_transactions`. Seluruh anomali dikategorikan sebagai **`Anomaly_Noise`**, yaitu anomali yang berasal dari kolom `decoy_noise`.
- Anomali ini muncul ketika nilai `decoy_noise` melebihi ambang batas ±500. Nilai noise yang terdeteksi berada pada rentang **500.54 hingga 1468.46**, yang menunjukkan kemungkinan data sintetis atau data yang terganggu secara sistematis.
- Beberapa anomali juga memiliki nilai `payment_value` yang sangat tinggi, sehingga menunjukkan perilaku pembelian yang tidak biasa. Namun, tidak ditemukan anomali dari nilai `decoy_flag` yang tidak valid.

## Repeat Purchase
Pada Januari 2024, ada 980 pelanggan yang melakukan pembelian.
Dari jumlah itu, 921 pelanggan melakukan pembelian lebih dari 1 kali dalam bulan itu.
Sehingga, 94% pelanggan adalah pelanggan yang melakukan repeat purchase dalam bulan tersebut.
Terlihat adanya penurunan bertahap pada repeat rate dari Januari hingga Mei 2025.
Repeat rate bulan pertama sangat tinggi (94%), dan kemudian turun tajam menjadi hanya 0% di bulan-bulan terakhir.