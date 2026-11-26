:- dynamic requires/2.

% Sinh_vien
student(lan).
student(minh).
student(ngoc).
student(phuc).
student(quynh).

% Hoc_phan
course(python).
course(dai_so_tuyen_tinh).
course(co_so_du_lieu).
course(xac_suat_thong_ke).
course(hoc_may).
course(truc_quan_du_lieu).
course(khai_pha_du_lieu).
course(do_an_khoa_hoc_du_lieu).

% Hoc_phan_da_hoan_thanh
passed(lan, python).              % F14
passed(lan, dai_so_tuyen_tinh).   % F15
passed(lan, co_so_du_lieu).       % F16
passed(lan, xac_suat_thong_ke).   % F17
passed(lan, truc_quan_du_lieu).   % F18

passed(minh, python).             % F19
passed(minh, dai_so_tuyen_tinh).  % F20
passed(minh, co_so_du_lieu).      % F21

passed(ngoc, python).             % F22

passed(phuc, python).             % F23
passed(phuc, dai_so_tuyen_tinh).  % F24
passed(phuc, co_so_du_lieu).      % F25
passed(phuc, xac_suat_thong_ke).  % F26
passed(phuc, hoc_may).            % F27

passed(quynh, python).            % F28
passed(quynh, dai_so_tuyen_tinh). % F29
passed(quynh, co_so_du_lieu).     % F30
passed(quynh, xac_suat_thong_ke). % F31
passed(quynh, hoc_may).           % F32
passed(quynh, truc_quan_du_lieu). % F33

% Hoc_phan_tien_quyet_truc_tiep
requires(co_so_du_lieu, python).              % F34
requires(co_so_du_lieu, dai_so_tuyen_tinh).   % F35
requires(xac_suat_thong_ke, python).          % F36
requires(xac_suat_thong_ke, dai_so_tuyen_tinh). % F37
requires(hoc_may, co_so_du_lieu).             % F38
requires(hoc_may, xac_suat_thong_ke).         % F39
requires(truc_quan_du_lieu, co_so_du_lieu).   % F40
requires(khai_pha_du_lieu, hoc_may).          % F41
requires(khai_pha_du_lieu, dai_so_tuyen_tinh). % F42
requires(do_an_khoa_hoc_du_lieu, hoc_may).    % F43
requires(do_an_khoa_hoc_du_lieu, truc_quan_du_lieu). % F44

% Hoc_phan_duoc_mo_trong_hoc_ky_nay
offered(co_so_du_lieu).                       % F45
offered(xac_suat_thong_ke).                   % F46
offered(hoc_may).                             % F47
offered(truc_quan_du_lieu).                   % F48
offered(khai_pha_du_lieu).                    % F49
offered(do_an_khoa_hoc_du_lieu).              % F50

% linh_vuc
course_area(co_so_du_lieu, du_lieu).          % F51
course_area(xac_suat_thong_ke, thong_ke).     % F52
course_area(hoc_may, hoc_may).                % F53
course_area(truc_quan_du_lieu, truc_quan).    % F54
course_area(khai_pha_du_lieu, hoc_may).       % F55
course_area(do_an_khoa_hoc_du_lieu, hoc_may). % F56

% quan_tam
interested(lan, hoc_may).                     % F57
interested(minh, hoc_may).                    % F58
interested(ngoc, truc_quan).                  % F59
interested(phuc, hoc_may).                    % F60
interested(quynh, hoc_may).                   % F61

% muc_tieu_nghe_nghiep
career_goal(lan, hoc_may).                    % F62
career_goal(phuc, hoc_may).                   % F63
career_goal(quynh, hoc_may).                  % F64

% truc_quan_du_lieu
foundation_elective(truc_quan_du_lieu).       % F65
