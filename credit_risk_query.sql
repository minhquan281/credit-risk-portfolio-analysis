import os
import glob
import duckdb

print("🕵️‍♂️ Bước 1: Hệ thống đang tự động quét tìm file trên Kaggle của bạn...")

# Sử dụng mẹo 'glob' để tự động tìm file application_train.csv mà không cần nhập đường dẫn cố định
path_main = glob.glob('/kaggle/input/**/application_train.csv', recursive=True)
path_bureau = glob.glob('/kaggle/input/**/bureau.csv', recursive=True)
path_prev = glob.glob('/kaggle/input/**/previous_application.csv', recursive=True)

# KIỂM TRA BẢO VỆ: Nếu không tìm thấy file, hệ thống sẽ hướng dẫn bạn bằng tiếng Việt
if not path_main:
    print("\n🚨 THÔNG BÁO: Vẫn chưa tìm thấy dữ liệu trên Notebook này!")
    print("👉 CÁCH SỬA: Bạn nhìn sang CỘT BÊN PHẢI màn hình -> Bấm vào nút [+ Add Data] -> Gõ tìm 'Home Credit Default Risk' rồi bấm [Add] màu xanh nhé.")
else:
    print(f"🎉 Thành công! Đã tìm thấy file bảng chính tại: {path_main[0]}")
    
    # 2. Khởi động bộ máy dịch ngôn ngữ SQL (DuckDB)
    con = duckdb.connect(database=':memory:')
    
    # 3. Nạp các file thô vào bộ nhớ bằng đường dẫn tự động tìm được
    con.execute(f"CREATE TABLE raw_application AS SELECT * FROM read_csv_auto('{path_main[0]}')")
    con.execute(f"CREATE TABLE raw_bureau AS SELECT * FROM read_csv_auto('{path_bureau[0]}')")
    con.execute(f"CREATE TABLE raw_prev AS SELECT * FROM read_csv_auto('{path_prev[0]}')")
    
    print("\n🧹 Bước 2: Đang tiến hành dọn dẹp và tính toán chỉ số rủi ro (SQL)...")
    
    # 4. Viết câu lệnh SQL siêu sạch, loại bỏ các "hạt sạn" dữ liệu rác
    query_clean = """
    CREATE TABLE cleaned_data_final AS 
    SELECT 
        SK_ID_CURR,                         -- Mã số định danh của từng khách hàng
        TARGET,                             -- Kết quả: 1 là bùng nợ (Nợ xấu), 0 là trả tốt
        NAME_CONTRACT_TYPE AS Loan_Type,    -- Đổi tên cột loại hình vay cho dễ đọc
        
        -- Sửa lỗi tuổi âm: Lấy trị tuyệt đối ABS() rồi chia cho 365 ngày để ra Số Tuổi thực tế
        FLOOR(ABS(DAYS_BIRTH) / 365.25) AS Age,
        
        -- Sửa lỗi con số ma quái 365243 (mã hóa của việc thất nghiệp/nghỉ hưu) về số 0 năm kinh nghiệm
        CASE 
            WHEN DAYS_EMPLOYED = 365243 THEN 0 
            ELSE FLOOR(ABS(DAYS_EMPLOYED) / 365.25) 
        END AS Years_Employed,
        
        AMT_INCOME_TOTAL AS Annual_Income,  -- Thu nhập một năm của khách hàng
        AMT_CREDIT AS Loan_Amount,          -- Số tiền khách muốn vay
        
        -- TỰ CHẾ BIẾN CHỈ SỐ RỦI RO (DTI): Tiền trả góp tháng / (Thu nhập năm / 12 tháng)
        ROUND(AMT_ANNUITY / (AMT_INCOME_TOTAL / 12), 4) AS Monthly_DTI
        
    FROM raw_application
    WHERE CODE_GENDER IN ('M', 'F');        -- Bộ lọc: Loại bỏ các dòng giới tính bị lỗi nhập liệu (XNA)
    """
    
    # Ra lệnh cho máy chạy câu lệnh SQL trên
    con.execute(query_clean)
    
    # 5. Xuất thành quả ra file CSV để bạn tải về máy nạp vào Tableau
    con.execute("COPY cleaned_data_final TO 'home_credit_clean.csv' (HEADER, DELIMITER ',')")
    
    print("\n🏆 KẾT QUẢ: Đã dọn dẹp xong! File 'home_credit_clean.csv' đã sẵn sàng ở cột Output bên phải màn hình để bạn Download rồi đó!")
