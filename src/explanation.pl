:- encoding(utf8).
:- ensure_loaded('knowledge_base.pl').
:- ensure_loaded('rules.pl').
:- use_module(library(pairs)).

% Anh_xa_co_so_F1-F65
fact_info('F01', student(lan)).
fact_info('F02', student(minh)).
fact_info('F03', student(ngoc)).
fact_info('F04', student(phuc)).
fact_info('F05', student(quynh)).

fact_info('F06', course(python)).
fact_info('F07', course(dai_so_tuyen_tinh)).
fact_info('F08', course(co_so_du_lieu)).
fact_info('F09', course(xac_suat_thong_ke)).
fact_info('F10', course(hoc_may)).
fact_info('F11', course(truc_quan_du_lieu)).
fact_info('F12', course(khai_pha_du_lieu)).
fact_info('F13', course(do_an_khoa_hoc_du_lieu)).

fact_info('F14', passed(lan, python)).
fact_info('F15', passed(lan, dai_so_tuyen_tinh)).
fact_info('F16', passed(lan, co_so_du_lieu)).
fact_info('F17', passed(lan, xac_suat_thong_ke)).
fact_info('F18', passed(lan, truc_quan_du_lieu)).

fact_info('F19', passed(minh, python)).
fact_info('F20', passed(minh, dai_so_tuyen_tinh)).
fact_info('F21', passed(minh, co_so_du_lieu)).

fact_info('F22', passed(ngoc, python)).

fact_info('F23', passed(phuc, python)).
fact_info('F24', passed(phuc, dai_so_tuyen_tinh)).
fact_info('F25', passed(phuc, co_so_du_lieu)).
fact_info('F26', passed(phuc, xac_suat_thong_ke)).
fact_info('F27', passed(phuc, hoc_may)).

fact_info('F28', passed(quynh, python)).
fact_info('F29', passed(quynh, dai_so_tuyen_tinh)).
fact_info('F30', passed(quynh, co_so_du_lieu)).
fact_info('F31', passed(quynh, xac_suat_thong_ke)).
fact_info('F32', passed(quynh, hoc_may)).
fact_info('F33', passed(quynh, truc_quan_du_lieu)).

fact_info('F34', requires(co_so_du_lieu, python)).
fact_info('F35', requires(co_so_du_lieu, dai_so_tuyen_tinh)).
fact_info('F36', requires(xac_suat_thong_ke, python)).
fact_info('F37', requires(xac_suat_thong_ke, dai_so_tuyen_tinh)).
fact_info('F38', requires(hoc_may, co_so_du_lieu)).
fact_info('F39', requires(hoc_may, xac_suat_thong_ke)).
fact_info('F40', requires(truc_quan_du_lieu, co_so_du_lieu)).
fact_info('F41', requires(khai_pha_du_lieu, hoc_may)).
fact_info('F42', requires(khai_pha_du_lieu, dai_so_tuyen_tinh)).
fact_info('F43', requires(do_an_khoa_hoc_du_lieu, hoc_may)).
fact_info('F44', requires(do_an_khoa_hoc_du_lieu, truc_quan_du_lieu)).

fact_info('F45', offered(co_so_du_lieu)).
fact_info('F46', offered(xac_suat_thong_ke)).
fact_info('F47', offered(hoc_may)).
fact_info('F48', offered(truc_quan_du_lieu)).
fact_info('F49', offered(khai_pha_du_lieu)).
fact_info('F50', offered(do_an_khoa_hoc_du_lieu)).

fact_info('F51', course_area(co_so_du_lieu, du_lieu)).
fact_info('F52', course_area(xac_suat_thong_ke, thong_ke)).
fact_info('F53', course_area(hoc_may, hoc_may)).
fact_info('F54', course_area(truc_quan_du_lieu, truc_quan)).
fact_info('F55', course_area(khai_pha_du_lieu, hoc_may)).
fact_info('F56', course_area(do_an_khoa_hoc_du_lieu, hoc_may)).

fact_info('F57', interested(lan, hoc_may)).
fact_info('F58', interested(minh, hoc_may)).
fact_info('F59', interested(ngoc, truc_quan)).
fact_info('F60', interested(phuc, hoc_may)).
fact_info('F61', interested(quynh, hoc_may)).

fact_info('F62', career_goal(lan, hoc_may)).
fact_info('F63', career_goal(phuc, hoc_may)).
fact_info('F64', career_goal(quynh, hoc_may)).

fact_info('F65', foundation_elective(truc_quan_du_lieu)).

% anh_xa_rule
rule_info('P01', prerequisite(P, C), [requires(C, P)]).
rule_info('P02', prerequisite(P, C), [requires(C, M), prerequisite(P, M)]).

rule_info('P10', eligible(S, co_so_du_lieu), [
    passed(S, python),
    passed(S, dai_so_tuyen_tinh),
    offered(co_so_du_lieu)
]).

rule_info('P11', eligible(S, xac_suat_thong_ke), [
    passed(S, python),
    passed(S, dai_so_tuyen_tinh),
    offered(xac_suat_thong_ke)
]).

rule_info('P12', eligible(S, hoc_may), [
    passed(S, co_so_du_lieu),
    passed(S, xac_suat_thong_ke),
    offered(hoc_may)
]).

rule_info('P13', eligible(S, truc_quan_du_lieu), [
    passed(S, co_so_du_lieu),
    offered(truc_quan_du_lieu)
]).

rule_info('P14', eligible(S, khai_pha_du_lieu), [
    passed(S, hoc_may),
    passed(S, dai_so_tuyen_tinh),
    offered(khai_pha_du_lieu)
]).

rule_info('P15', eligible(S, do_an_khoa_hoc_du_lieu), [
    passed(S, hoc_may),
    passed(S, truc_quan_du_lieu),
    offered(do_an_khoa_hoc_du_lieu)
]).

rule_info('P20', recommended(S, C), [
    eligible(S, C),
    course_area(C, Area),
    interested(S, Area)
]).

rule_info('P21', priority_recommend(S, C), [
    recommended(S, C),
    course_area(C, Area),
    career_goal(S, Area)
]).

rule_info('P22', candidate(S, C), [
    recommended(S, C)
]).

rule_info('P23', candidate(S, C), [
    eligible(S, C),
    foundation_elective(C)
]).

% Khai_bao_predicate_hop_le
known_predicate(student, 1).      known_predicate(course, 1).
known_predicate(passed, 2).       known_predicate(requires, 2).
known_predicate(offered, 1).      known_predicate(course_area, 2).
known_predicate(interested, 2).   known_predicate(career_goal, 2).
known_predicate(foundation_elective, 1).
known_predicate(prerequisite, 2). known_predicate(eligible, 2).
known_predicate(recommended, 2).  known_predicate(priority_recommend, 2).
known_predicate(candidate, 2).

% Ktra_chu_trinh
check_cycle(Status) :-
    (   has_cycle -> Status = 'ERROR_CYCLE' ; Status = 'OK' ).

has_cycle :- course(C), reach(C, C, [C]), !.

reach(From, To, Visited) :-
    requires(From, Next),
    (   Next == To
    ;   \+ memberchk(Next, Visited),
        reach(Next, To, [Next|Visited])
    ).

% Vong_ngoai_va_cac_kiem_tra_an_toan
:- dynamic max_depth/1.
max_depth(30).

prove(Goal, Visited, Depth, Proof) :-
    check_defined(Goal),
    check_depth(Depth),
    check_loop(Goal, Visited),
    Depth1 is Depth + 1,
    (   prove_by_fact(Goal, Proof)
    ;   prove_by_rule(Goal, Visited, Depth1, Proof)
    ).

check_defined(Goal) :-
    must_be(callable, Goal),
    functor(Goal, N, A),
    (   known_predicate(N, A) -> true
    ;   throw(error(existence_error(procedure, N/A), _))
    ).

check_depth(D) :-
    max_depth(M),
    (   D >= M -> throw(error(depth_limit_exceeded(D), _)) ; true ).

check_loop(Goal, Visited) :-
    (   member(V, Visited), V =@= Goal
    ->  throw(error(loop_detected(Goal), _))
    ;   true ).

% Chung_minh_bang_fact
prove_by_fact(Goal, proof_fact(Goal, ID, Theta, Conclusion)) :-
    fact_info(ID, Fact),
    term_variables(Goal, GVars),
    label_vars(GVars, g, 0, GLabels),
    unify_with_occurs_check(Goal, Fact),
    pairs_keys_values(Theta, GLabels, GVars),
    format(string(Conclusion),
           'Goal ~w được chứng minh trực tiếp bởi fact ~w.', [Goal, ID]).

label_vars(Vars, Prefix, K, Labels) :-
    findall(L, ( nth1(I, Vars, _), format(atom(L), '~w~d_~d', [Prefix, I, K]) ), Labels).

% Chung_minh_bang_rule
prove_by_rule(Goal, Visited, Depth,
              proof_rule(Goal, RuleID, Renamed, Theta, Subgoals, Failed, SubProofs, Conclusion)) :-
    rule_info(RuleID, H0, B0),
    functor(Goal, N, A), functor(H0, N, A),
    flag(rename_counter, K, K+1),
    failed_attempts(Goal, RuleID, [Goal|Visited], Depth, Failed),
    % (1) Đổi tên biến (standardize apart)
    copy_term(H0-B0, Head-Subgoals),
    term_variables(Head-Subgoals, RVars),
    label_vars(RVars, v, K, RLabels),
    copy_term(Head-Subgoals-RVars, DH-DB-DVars),     % bản sao để hiển thị
    maplist(bind_label, RLabels, DVars),
    Renamed = rule(DH, DB),
    term_variables(Goal, GVars),
    label_vars(GVars, g, K, GLabels),
    % (2) Hợp nhất Goal với Head
    unify_with_occurs_check(Goal, Head),
    % (3) Chứng minh từng subgoal
    prove_body(Subgoals, [Goal|Visited], Depth, SubProofs),
    append(GLabels, RLabels, Labels),
    append(GVars, RVars, Vars),
    pairs_keys_values(Theta, Labels, Vars),
    format(string(Conclusion),
           'Goal ~w được suy ra bởi luật ~w vì mọi subgoal đều thỏa.', [Goal, RuleID]).

bind_label(L, '$VAR'(L)).

prove_body([], _, _, []).
prove_body([G|Gs], V, D, [P|Ps]) :-
    prove(G, V, D, P),
    prove_body(Gs, V, D, Ps).

% That_bai
failed_attempts(Goal, RuleID, Visited, Depth, Failed) :-
    findall(failed(ID, Sub),
            (   rule_info(ID, H0, B0),
                ID @< RuleID,
                functor(Goal, N, A), functor(H0, N, A),
                copy_term(Goal-H0-B0, G1-H1-B1),
                unify_with_occurs_check(G1, H1),
                first_failing(B1, Visited, Depth, Sub)
            ),
            Failed).

first_failing([G|Gs], V, D, Failing) :-
    (   prove(G, V, D, _) -> first_failing(Gs, V, D, Failing)
    ;   Failing = G ).

% Ham_chay_1_query
run_query(Query, VarNames, Result, Bindings, Sols) :-
    check_cycle(Status),
    (   Status == 'ERROR_CYCLE'
    ->  Result = 'ERROR_CYCLE', Bindings = '-', Sols = []
    ;   catch( solve(Query, VarNames, Result, Bindings, Sols),
               Error,
               ( Result = 'ERROR', Bindings = '-', Sols = [],
                 format("   [ERROR] ~q~n", [Error]) ) )
    ).

solve(Query, VarNames, Result, Bindings, Sols) :-
    var_names_values(VarNames, Names, Vars),
    (   Vars == []
    ->  findall([]-P, once(prove(Query, [], 0, P)), All)
    ;   findall(Vars-P, prove(Query, [], 0, P), All)
    ),
    (   All == []
    ->  Result = 'NOT_PROVABLE', Bindings = '-', Sols = []
    ;   Result = 'PROVABLE',
        dedupe(All, [], Sols),
        format_bindings(Names, Sols, Bindings)
    ).

var_names_values([], [], []).
var_names_values([N=V|T], [N|Ns], [V|Vs]) :- var_names_values(T, Ns, Vs).

dedupe([], _, []).
dedupe([B-P|T], Seen, R) :-
    (   memberchk(B, Seen) -> dedupe(T, Seen, R)
    ;   R = [B-P|R1], dedupe(T, [B|Seen], R1) ).

format_bindings([], _, '-') :- !.
format_bindings([Name], Sols, B) :- !,
    findall(V, member([V]-_, Sols), Vs),
    atomic_list_concat(Vs, ', ', Inner),
    format(atom(B), '~w=[~w]', [Name, Inner]).
format_bindings(Names, Sols, B) :-
    findall(S, ( member(Vals-_, Sols), pair_text(Names, Vals, S) ), Ss),
    atomic_list_concat(Ss, '; ', Inner),
    format(atom(B), '[~w]', [Inner]).

pair_text(Names, Vals, S) :-
    findall(P, ( nth1(I, Names, N), nth1(I, Vals, V), format(atom(P), '~w=~w', [N, V]) ), Ps),
    atomic_list_concat(Ps, ', ', S).

% Ghi_proof_ra_file
write_proof_file(Path, QID, QueryStr, Sols) :-
    setup_call_cleanup(
        open(Path, write, S, [encoding(utf8)]),
        write_proofs(S, QID, QueryStr, Sols),
        close(S)).

write_proofs(S, QID, QueryStr, Sols) :-
    format(S, "PROOF ~w: ~w~n", [QID, QueryStr]),
    forall( nth1(I, Sols, Vals-Proof),
            (   format(S, "~n=== Proof #~d (binding: ~w) ===~n", [I, Vals]),
                render(S, Proof, 0) ) ).

render(S, proof_fact(Goal, ID, Theta, Concl), Ind) :-
    pad(Ind, P), theta_text(Theta, T),
    format(S, "~w[FACT ~w]~n", [P, ID]),
    format(S, "~w  Goal hiện tại    : ~w~n", [P, Goal]),
    format(S, "~w  Fact áp dụng     : ~w~n", [P, ID]),
    format(S, "~w  Subgoals         : [] (fact cơ sở)~n", [P]),
    format(S, "~w  Phép thế θ       : ~w~n", [P, T]),
    format(S, "~w  Kết luận bước    : ~w~n", [P, Concl]).

render(S, proof_rule(Goal, RID, rule(H,B), Theta, Subs, Failed, SubProofs, Concl), Ind) :-
    pad(Ind, P), theta_text(Theta, T),
    W = [numbervars(true), quoted(false)],
    format(S, "~w[RULE ~w]~n", [P, RID]),
    format(S, "~w  Goal hiện tại    : ~w~n", [P, Goal]),
    format(S, "~w  Rule áp dụng     : ~w~n", [P, RID]),
    format(S, "~w  Đổi tên biến     : ~W :- ~W~n", [P, H, W, B, W]),
    format(S, "~w  Phép thế θ       : ~w~n", [P, T]),
    format(S, "~w  Subgoals sinh ra : ~w~n", [P, Subs]),
    (   Failed == [] -> true
    ;   forall( member(failed(FID, Sub), Failed),
                format(S, "~w  Nhánh đã thử & thất bại: ~w (subgoal không chứng minh được: ~w)~n",
                       [P, FID, Sub]) ) ),
    format(S, "~w  Kết luận bước    : ~w~n", [P, Concl]),
    Next is Ind + 1,
    forall( member(Sub, SubProofs), render(S, Sub, Next) ).

pad(N, P) :- C is N*4, length(L, C), maplist(=(' '), L), atomic_list_concat(L, P).

theta_text([], '{} (phép thế rỗng)') :- !.
theta_text(Theta, T) :-
    findall(S, ( member(L-V, Theta), format(atom(S), '~w -> ~w', [L, V]) ), Ss),
    atomic_list_concat(Ss, ', ', Inner),
    format(atom(T), '{~w}', [Inner]).

