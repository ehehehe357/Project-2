:- encoding(utf8).
:- use_module(library(filesex)).
:- ensure_loaded('explanation.pl').

:- dynamic src_dir/1.
:- prolog_load_context(directory, D), asserta(src_dir(D)).

% 10_query_de_cho
query_spec('Q01', "eligible(lan, hoc_may)").
query_spec('Q02', "recommended(lan, hoc_may)").
query_spec('Q03', "priority_recommend(lan, hoc_may)").
query_spec('Q04', "prerequisite(python, do_an_khoa_hoc_du_lieu)").
query_spec('Q05', "candidate(minh, truc_quan_du_lieu)").
query_spec('Q06', "eligible(ngoc, co_so_du_lieu)").
query_spec('Q07', "recommended(minh, truc_quan_du_lieu)").
query_spec('Q08', "prerequisite(do_an_khoa_hoc_du_lieu, python)").
query_spec('Q09', "eligible(phuc, Course)").
query_spec('Q10', "prerequisite(Prereq, do_an_khoa_hoc_du_lieu)").

% 5_query_tu_thiet_ke
query_spec('SQ01', "eligible(quynh, do_an_khoa_hoc_du_lieu)").
query_spec('SQ02', "priority_recommend(quynh, do_an_khoa_hoc_du_lieu)").
query_spec('SQ03', "prerequisite(dai_so_tuyen_tinh, khai_pha_du_lieu)").
query_spec('SQ04', "eligible(phuc, do_an_khoa_hoc_du_lieu)").
query_spec('SQ05', "recommended(lan, Course)").

main :-
    src_dir(Src),
    atomic_list_concat([Src, '/../results'], Dir),
    make_directory_path(Dir),
    atomic_list_concat([Dir, '/query_results.txt'], ResFile),
    findall(ID-Str, query_spec(ID, Str), Specs),
    setup_call_cleanup(
        open(ResFile, write, Out, [encoding(utf8)]),
        maplist(run_one(Dir, Out), Specs),
        close(Out)),
    format("Xong. Kết quả: ~w~n", [ResFile]).

run_one(Dir, Out, ID-QStr) :-
    parse_query(QStr, Query, VarNames, Ok),
    (   Ok == true
    ->  run_query(Query, VarNames, Result, Bindings, Sols)
    ;   Result = 'ERROR', Bindings = '-', Sols = []
    ),
    (   Result == 'PROVABLE'
    ->  downcase_atom(ID, Low),
        atomic_list_concat(['proof_', Low, '.txt'], PF),
        atomic_list_concat([Dir, '/', PF], Path),
        write_proof_file(Path, ID, QStr, Sols)
    ;   PF = '-'
    ),
    format(Out, "~w | ~w | ~w | ~w | ~w~n", [ID, QStr, Bindings, Result, PF]),
    format("~w: ~w~n", [ID, Result]).

parse_query(Str, Query, VarNames, Ok) :-
    catch( ( term_string(Query, Str, [variable_names(VarNames)]), Ok = true ),
           _,
           ( Ok = false, VarNames = [] ) ).
