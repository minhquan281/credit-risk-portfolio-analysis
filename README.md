# 📊 Home Credit - Credit Risk Portfolio Analysis Dashboard

## 🌐 Live Dashboard
👉 **[Click here to view the Interactive Dashboard on Tableau Public](DÁN_LINK_TABLEAU_PUBLIC_CỦA_BẠN_VÀO_ĐÂY)**

---

## 🎯 Project Overview
This project focuses on analyzing a consumer finance loan portfolio to balance the trade-off between **Loan Volume Growth** and **Credit Risk Control (Non-Performing Loans - NPL)**. 

By building an interactive analytical dashboard in Tableau, the project pinpoints high-risk customer segments ("red zones") based on two critical financial risk drivers: **Debt-to-Income (DTI) ratio** and **Years of Employment (Job Tenure)**.

## 🖼️ Dashboard Preview
*(Tip: Bạn nên chụp 1 tấm ảnh màn hình Dashboard hoàn chỉnh của bạn, đặt tên là `dashboard_preview.png`, upload lên kho này rồi thay thế link ảnh dưới đây nhé)*
![Dashboard Preview](DÁN_LINK_ẢNH_MÀN_HÌNH_VÀO_ĐÂY_HOẶC_XÓA_DÒNG_NÀY)

---

## 🛠️ Tech Stack & Key Analytics Techniques
- **Tool:** Tableau Public (Web Authoring)
- **Data Visualization:** Dual-Axis Charts (Volume vs. NPL Ratio), Continuous Trend Lines, Gradient Risk Color Coding.
- **Interactivity:** Dynamic Cross-Filtering Action (`Use as Filter`), Advanced Label Optimization (Min/Max filtering).

---

## 🧠 Business Insights & Findings

1. **The DTI Danger Zone:** Credit risk is well-managed when the Debt-to-Income (DTI) ratio remains under 45%. However, once DTI crosses into the **Critical (>60%)** segment, the NPL ratio spikes alarmingly, despite this segment contributing a major portion of the loan volume.
2. **Tenure as a Risk Cushion:** New employees with only **1 year of tenure** represent the highest default risk, with NPL peaking at **11.41%**. This risk sharply decays and flattens out to a safe level (~5%) once employment tenure exceeds 15+ years.
3. **The Cross-Filter Discovery:** By interacting with the dashboard and filtering specifically for the high-debt segment (`DTI >60%`), the data reveals that customers with high job tenure still maintain significantly lower default rates than newer employees. This proves that job stability acts as a strong buffer against high leverage.

---

## 🚀 Data-Driven Business Recommendations

- **Tightening Credit for "Double Whammy" Profiles:** Implement strict loan rejections or heavily reduce credit limits for applicants who simultaneously have a DTI >60% AND less than 3 years of job tenure.
- **Flexibility for Stable Borrowers:** Create policy exceptions to approve high-DTI applicants (>45%) ONLY IF they can prove a stable employment history of 10+ years at a reputable organization.

---
*Developed by [Tên Của Bạn] - Connect with me on [LinkedIn](DÁN_LINK_LINKEDIN_CỦA_BẠN_VÀO_ĐÂY)*
