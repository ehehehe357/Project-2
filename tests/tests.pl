:- encoding(utf8).
:- use_module(library(plunit)).
:- ensure_loaded('../src/explanation.pl').

% Chạy câu hỏi dạng chữ, kiểm tra Result đúng như mong đợi
result_is(QueryText, Expected) :-
    term_string(Query, QueryText, [variable_names(VarNames)]),
    run_query(Query, VarNames, Result, _, _),
    Result == Expected.

% Chạy câu hỏi (phải PROVABLE) và lấy danh sách lời giải Sols
solutions_of(QueryText, Sols) :-
    term_string(Query, QueryText, [variable_names(VarNames)]),
    run_query(Query, VarNames, Result, _, Sols),
    Result == 'PROVABLE'.
proof_of(QueryText, Proof) :-
    solutions_of(QueryText, [[]-Proof]).

% Câu_hỏi_có_ĐÚNG_MỘT_biến: lấy ra các giá trị, đã sắp xếp và bỏ trùng
values_of(QueryText, SortedValues) :-
    solutions_of(QueryText, Sols),
    findall(V, member([V]-_, Sols), Vs),
    sort(Vs, SortedValues).

count_rules(proof_fact(_, _, _, _), 0).
count_rules(proof_rule(_, _, _, _, _, _, SubProofs, _), N) :-
    maplist(count_rules, SubProofs, Counts),
    sum_list(Counts, Sum),
    N is Sum + 1.

proof_ids(proof_fact(_, ID, _, _), [ID]).
proof_ids(proof_rule(_, ID, _, _, _, _, SubProofs, _), [ID|Rest]) :-
    maplist(proof_ids, SubProofs, Lists),
    append(Lists, Rest).

% Đổi giới hạn độ sâu (dùng cho test ERROR)
set_depth(N) :-
    retractall(max_depth(_)),
    assertz(max_depth(N)).

same_as_prolog(Pred, DomainX, DomainY) :-
    findall(X-Y,
            ( call(DomainX, X), call(DomainY, Y),
              G =.. [Pred, X, Y], call(G) ),
            FromProlog0),
    sort(FromProlog0, FromProlog),
    findall(X-Y,
            ( call(DomainX, X), call(DomainY, Y),
              G =.. [Pred, X, Y], once(prove(G, [], 0, _)) ),
            FromEngine0),
    sort(FromEngine0, FromEngine),
    FromProlog == FromEngine.

:- begin_tests(de_bai).

test(q01) :-
    result_is("eligible(lan, hoc_may)", 'PROVABLE').

test(q02) :-
    result_is("recommended(lan, hoc_may)", 'PROVABLE').

test(q03_proof_co_it_nhat_3_rule) :-
    proof_of("priority_recommend(lan, hoc_may)", Proof),
    count_rules(Proof, N),
    N >= 3.

test(q04) :-
    result_is("prerequisite(python, do_an_khoa_hoc_du_lieu)", 'PROVABLE').

test(q05_that_bai_P22_roi_thanh_cong_P23) :-
    proof_of("candidate(minh, truc_quan_du_lieu)", Proof),
    Proof = proof_rule(_, 'P23', _, _, _, Failed, _, _),
    memberchk(failed('P22', _), Failed).

test(q06) :-
    result_is("eligible(ngoc, co_so_du_lieu)", 'NOT_PROVABLE').

test(q07) :-
    result_is("recommended(minh, truc_quan_du_lieu)", 'NOT_PROVABLE').

test(q08) :-
    result_is("prerequisite(do_an_khoa_hoc_du_lieu, python)", 'NOT_PROVABLE').

test(q09_cac_hoc_phan_phuc_du_dieu_kien) :-
    values_of("eligible(phuc, Course)", Vs),
    Vs == [co_so_du_lieu, hoc_may, khai_pha_du_lieu,
           truc_quan_du_lieu, xac_suat_thong_ke],
    solutions_of("eligible(phuc, Course)", Sols),
    length(Sols, 5).

test(q10_cac_tien_quyet_cua_do_an) :-
    values_of("prerequisite(Prereq, do_an_khoa_hoc_du_lieu)", Vs),
    Vs == [co_so_du_lieu, dai_so_tuyen_tinh, hoc_may,
           python, truc_quan_du_lieu, xac_suat_thong_ke],
    solutions_of("prerequisite(Prereq, do_an_khoa_hoc_du_lieu)", Sols),
    length(Sols, 6).

:- end_tests(de_bai).

:- begin_tests(tu_thiet_ke).

test(sq01) :-
    result_is("eligible(quynh, do_an_khoa_hoc_du_lieu)", 'PROVABLE').

test(sq02) :-
    result_is("priority_recommend(quynh, do_an_khoa_hoc_du_lieu)", 'PROVABLE').

test(sq03) :-
    result_is("prerequisite(dai_so_tuyen_tinh, khai_pha_du_lieu)", 'PROVABLE').

test(sq04) :-
    result_is("eligible(phuc, do_an_khoa_hoc_du_lieu)", 'NOT_PROVABLE').

test(sq05) :-
    values_of("recommended(lan, Course)", [hoc_may]).

:- end_tests(tu_thiet_ke).

:- begin_tests(he_thong).

test(doi_chieu_eligible) :-
    same_as_prolog(eligible, student, course).

test(doi_chieu_recommended) :-
    same_as_prolog(recommended, student, course).

test(doi_chieu_priority_recommend) :-
    same_as_prolog(priority_recommend, student, course).

test(doi_chieu_candidate) :-
    same_as_prolog(candidate, student, course).

test(doi_chieu_prerequisite) :-
    same_as_prolog(prerequisite, course, course).

% --- Bảng ánh xạ Fxx/Pxx phải khớp knowledge base ---
test(fact_info_khop_kb) :-
    FactPreds = [student/1, course/1, passed/2, requires/2, offered/1,
                 course_area/2, interested/2, career_goal/2,
                 foundation_elective/1],
    forall(( member(P/A, FactPreds), functor(H, P, A), call(H) ),
           once(fact_info(_, H))),
    forall(fact_info(_, F), call(F)).

test(dem_fact_va_rule) :-
    findall(ID, fact_info(ID, _), FIDs),
    length(FIDs, 65),
    sort(FIDs, UniqueFIDs),
    length(UniqueFIDs, 65),
    findall(ID, rule_info(ID, _, _), PIDs),
    length(PIDs, 12).

% --- Chu trình ---
test(khong_chu_trinh) :-
    check_cycle(Status),
    Status == 'OK'.

test(co_chu_trinh,
     [ setup(assertz(requires(python, do_an_khoa_hoc_du_lieu))),
       cleanup(retract(requires(python, do_an_khoa_hoc_du_lieu))) ]) :-
    result_is("eligible(lan, hoc_may)", 'ERROR_CYCLE').

% --- ERROR phải là ERROR, không được thành NOT_PROVABLE ---
test(predicate_chua_khai_bao) :-
    result_is("foo(bar)", 'ERROR').

test(gioi_han_do_sau,
     [ setup(set_depth(1)), cleanup(set_depth(30)) ]) :-
    result_is("prerequisite(python, do_an_khoa_hoc_du_lieu)", 'ERROR').

test(ma_proof_hop_le) :-
    proof_of("prerequisite(python, do_an_khoa_hoc_du_lieu)", Proof),
    proof_ids(Proof, Ids),
    Ids \== [],
    forall(member(ID, Ids),
           ( fact_info(ID, _) ; rule_info(ID, _, _) )).

:- end_tests(he_thong).

:- begin_tests(query_an).

test(quynh_hoc_khai_pha) :-
    result_is("eligible(quynh, khai_pha_du_lieu)", 'PROVABLE').

test(lan_khong_hoc_khai_pha) :-
    result_is("eligible(lan, khai_pha_du_lieu)", 'NOT_PROVABLE').

test(python_la_tien_quyet_cua_hoc_may) :-
    result_is("prerequisite(python, hoc_may)", 'PROVABLE').

test(hoc_may_khong_la_tien_quyet_cua_python) :-
    result_is("prerequisite(hoc_may, python)", 'NOT_PROVABLE').

:- end_tests(query_an).
