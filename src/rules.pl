:- ensure_loaded('knowledge_base.pl').

% Truc_tiep
prerequisite(P, C) :-
    requires(C, P).

% Gian_tiep
prerequisite(P, C) :-
    requires(C, M),
    prerequisite(P, M).

% P10
eligible(Student, co_so_du_lieu) :-
    passed(Student, python),
    passed(Student, dai_so_tuyen_tinh),
    offered(co_so_du_lieu).

% P11
eligible(Student, xac_suat_thong_ke) :-
    passed(Student, python),
    passed(Student, dai_so_tuyen_tinh),
    offered(xac_suat_thong_ke).

% P12
eligible(Student, hoc_may) :-
    passed(Student, co_so_du_lieu),
    passed(Student, xac_suat_thong_ke),
    offered(hoc_may).

% P13
eligible(Student, truc_quan_du_lieu) :-
    passed(Student, co_so_du_lieu),
    offered(truc_quan_du_lieu).

% P14
eligible(Student, khai_pha_du_lieu) :-
    passed(Student, hoc_may),
    passed(Student, dai_so_tuyen_tinh),
    offered(khai_pha_du_lieu).

% P15
eligible(Student, do_an_khoa_hoc_du_lieu) :-
    passed(Student, hoc_may),
    passed(Student, truc_quan_du_lieu),
    offered(do_an_khoa_hoc_du_lieu).

% P20_De_xuat_hoc_phan
recommended(Student, Course) :-
    eligible(Student, Course),
    course_area(Course, Area),
    interested(Student, Area).

% P2_De_xuat_uu_tien
priority_recommend(Student, Course) :-
    recommended(Student, Course),
    course_area(Course, Area),
    career_goal(Student, Area).

% P22_Ung_vien_theo_dien_duoc_de_xuat
candidate(Student, Course) :-
    recommended(Student, Course).

% P23_Ung_vien_theo_dien_tu_chon_nen_tang
candidate(Student, Course) :-
    eligible(Student, Course),
    foundation_elective(Course).
