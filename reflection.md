# BÁO CÁO PHẢN ÁNH CÁ NHÂN (REFLECTION)

**Học phần:** Biểu diễn tri thức và tìm kiếm nâng cao (UET.AI2014)  
**Sinh viên:** Nguyễn Lê Mai Phương — **MSSV:** 25022986 — **Phiên bản:** V2 (Khoa học dữ liệu)  

---

### 1. Quyết định mô hình hóa khó khăn
Thách thức lớn nhất trong dự án là mô hình hóa điều kiện "đủ các môn tiên quyết" mà không được dùng phủ định thất bại (`\+`) hay vị từ bậc cao (`forall/2`). Ban đầu, tôi định duyệt danh sách toàn bộ môn tiên quyết rồi kiểm tra môn đã tích lũy, nhưng cách này vi phạm giới hạn Horn clauses thuần túy và làm phức tạp cây chứng minh. Do đó, tôi quyết định viết các luật `eligible/2` riêng cho từng môn học (P10–P15) dưới dạng hội các tiên quyết trực tiếp. Giải pháp này bảo đảm đúng logic Horn, giúp Prolog suy diễn tự nhiên và cho phép Meta-Interpreter ghi nhận chính xác mã luật Pxx cùng các subgoal để sinh cây chứng minh.

### 2. Lỗi và nhánh quay lui (Backtracking) đã xử lý
Lỗi xảy ra tại câu truy vấn Q05: `candidate(minh, truc_quan_du_lieu)`. Theo yêu cầu đề bài, truy vấn này phải thất bại ở nhánh P22 rồi mới thành công ở P23. Khi lập trình ban đầu, tôi đặt luật P23 trước P22 trong file `rules.pl`. Khi chạy, Prolog thành công ngay ở P23 do Minh đủ điều kiện và môn này là tự chọn nền tảng (`foundation_elective`), làm bỏ qua nhánh P22. Tôi đã sửa lại thứ tự: đặt P22 (`recommended`) trước P23. Khi đó, Prolog thử nhánh P22 trước và thất bại vì Minh không quan tâm đến lĩnh vực Trực quan dữ liệu. Cơ chế quay lui kích hoạt, chuyển sang P23 và chứng minh thành công đúng kỳ vọng.

### 3. Khai báo sử dụng AI
Tôi đã sử dụng trợ lý AI (Google Antigravity / Gemini) trong quá trình học tập và hoàn thiện dự án. AI hỗ trợ giải thích cú pháp Prolog, gợi ý khung Meta-Interpreter để chuẩn hóa biến (standardizing apart) và tạo bảng dữ kiện ban đầu. Toàn bộ luật suy diễn, kiểm tra chu trình và logic chứng minh đều do tôi trực tiếp kiểm thử, đối chiếu lý thuyết thủ công và xác thực qua 11 bài kiểm thử tự động `plunit` trên SWI-Prolog. Việc dùng AI giúp tôi tối ưu thời gian cài đặt và tập trung vào bản chất logic của hệ tri thức.
