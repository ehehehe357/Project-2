# DỰ ÁN 2: TỪ BÀI TOÁN ĐẾN CHỨNG MINH LOGIC VỚI SWI-PROLOG
**Học phần:** Biểu diễn tri thức và tìm kiếm nâng cao (UET.AI2014)

---

## 1. THÔNG TIN SINH VIÊN
* **Họ và tên:** Nguyễn Lê Mai Phương
* **Mã số sinh viên (MSSV):** 25022986
* **Chữ số cuối MSSV:** 6
* **Mã phiên bản phân công:** **V2 — Khoa học dữ liệu (Data Science)**
* **Môi trường & Phiên bản SWI-Prolog:** SWI-Prolog version 11.0.1 for x64-win64

---

## 2. CẤU TRÚC THƯ MỤC DỰ ÁN
```text
P2_25022986_NguyenLeMaiPhuong/
├── src/
│   ├── knowledge_base.pl    # Cơ sở tri thức (F01 - F65)
│   ├── rules.pl             # Các luật suy diễn chính sách (P01 - P23)
│   ├── explanation.pl       # Bộ suy diễn Meta-Interpreter & Cây chứng minh có cấu trúc
│   └── main.pl              # Điểm thực thi chính: chạy 15 queries & xuất kết quả
├── tests/
│   └── tests.pl             # Bộ 11 kiểm thử tự động (PlUnit)
├── results/
│   ├── query_results.txt    # Bảng tổng hợp kết quả 15 queries
│   ├── proof_q01.txt        # File chứng minh cho Q01
│   ├── proof_q02.txt        # File chứng minh cho Q02
│   ├── proof_q03.txt        # File chứng minh cho Q03 (>= 3 lần áp dụng rule)
│   ├── proof_q04.txt        # File chứng minh cho Q04
│   ├── proof_q05.txt        # File chứng minh cho Q05 (thử P22 thất bại, quay lui sang P23)
│   ├── proof_q09.txt        # File chứng minh cho Q09 (liệt kê bindings)
│   ├── proof_q10.txt        # File chứng minh cho Q10 (liệt kê bindings)
│   ├── proof_sq01.txt       # File chứng minh cho SQ01
│   ├── proof_sq02.txt       # File chứng minh cho SQ02
│   ├── proof_sq03.txt       # File chứng minh cho SQ03
│   └── proof_sq05.txt       # File chứng minh cho SQ05
├── README.md                # Hướng dẫn chạy & thông tin dự án
└── reflection.md            # Báo cáo cá nhân về mô hình hóa, gỡ lỗi & AI (300-500 từ)
```

---

## 3. HƯỚNG DẪN THỰC THI

### 3.1. Chạy chương trình chính (Sinh kết quả & Proof)
Mở Terminal / PowerShell tại thư mục `src/` và chạy lệnh:
```bash
swipl -q -g "main, halt." -s main.pl
```
*Chương trình sẽ tự động kiểm tra chu trình đồ thị, thực thi 15 câu queries, xuất bảng tổng hợp ra `../results/query_results.txt` và ghi đầy đủ các file proof chi tiết vào `../results/`.*

### 3.2. Chạy bộ kiểm thử tự động (Automated Tests)
Mở Terminal / PowerShell tại thư mục `tests/` và chạy lệnh:
```bash
swipl -q -g "run_all_tests, halt." -s tests.pl
```
*Toàn bộ 11 tests (bao gồm 5 tests query đề bài, 5 tests query tự thiết kế và 1 test kiểm tra chu trình) sẽ được thực thi qua `plunit`.*
