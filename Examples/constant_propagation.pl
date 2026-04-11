#!/usr/bin/env ciao-shell
%% ============================================================
%% Semantic equivalence: foo1 (unoptimized) vs foo2 (optimized)
%% Constant propagation on RISC-V
%%
%% Run:  ciao-shell constant_propagation.pl
%%   or: ciaosh, then ?- use_module('constant_propagation.pl'). ?- check_equivalence.
%% ============================================================

:- use_module(library(lists)).

%% ============================================================
%% State:  state(PC, Regs, Memory)
%%   Regs   = list of reg(Name, Value)
%%   Memory = list of mem(Addr, Value, Size)
%% ============================================================

%% --- Register operations ---

%% x0 (zero) always reads as 0
get_reg_value(_, zero, 0).
get_reg_value(Regs, Name, Val) :-
    Name \= zero,
    member(reg(Name, Val), Regs).

%% Writes to zero are discarded
write_reg_value(Regs, Regs, zero, _).
write_reg_value(Regs, RegsOut, Name, Val) :-
    Name \= zero,
    select(reg(Name, _), Regs, Rest),
    RegsOut = [reg(Name, Val) | Rest].

%% --- Memory operations ---

write_mem(Mem, MemOut, Addr, Val, Size) :-
    ( select(mem(Addr, _, Size), Mem, Rest) ->
        MemOut = [mem(Addr, Val, Size) | Rest]
    ;
        MemOut = [mem(Addr, Val, Size) | Mem]
    ).

read_mem(Mem, Addr, Val, Size) :-
    member(mem(Addr, Val, Size), Mem).

%% --- Sign extension (32 to 64 bit) ---

sign_extend_32(X, Y) :-
    X32 is X /\ 0xFFFFFFFF,
    ( X32 >= 0x80000000 ->
        Y is X32 - 0x100000000
    ;
        Y is X32
    ).

%% ============================================================
%% RISC-V instruction semantics
%% ============================================================

%% addi rd, rs1, imm
addi(state(PC0, REGS0, MEM), state(PC1, REGS1, MEM), Imm, Rs1, Rd) :-
    get_reg_value(REGS0, Rs1, Rs1val),
    Res is Rs1val + Imm,
    write_reg_value(REGS0, REGS1, Rd, Res),
    PC1 is PC0 + 4.

%% addiw rd, rs1, imm
addiw(state(PC0, REGS0, MEM), state(PC1, REGS1, MEM), Imm, Rs1, Rd) :-
    get_reg_value(REGS0, Rs1, Rs1val),
    Res32 is (Rs1val + Imm) /\ 0xFFFFFFFF,
    sign_extend_32(Res32, Res),
    write_reg_value(REGS0, REGS1, Rd, Res),
    PC1 is PC0 + 4.

%% sd rs2, offset(rs1)
sd(state(PC0, REGS0, MEM0), state(PC1, REGS0, MEM1), Offset, Rs1, Rs2) :-
    get_reg_value(REGS0, Rs1, Rs1val),
    get_reg_value(REGS0, Rs2, Rs2val),
    Addr is Rs1val + Offset,
    write_mem(MEM0, MEM1, Addr, Rs2val, 8),
    PC1 is PC0 + 4.

%% ld rd, offset(rs1)
ld(state(PC0, REGS0, MEM0), state(PC1, REGS1, MEM0), Offset, Rs1, Rd) :-
    get_reg_value(REGS0, Rs1, Rs1val),
    Addr is Rs1val + Offset,
    read_mem(MEM0, Addr, Val, 8),
    write_reg_value(REGS0, REGS1, Rd, Val),
    PC1 is PC0 + 4.

%% sw rs2, offset(rs1)
sw(state(PC0, REGS0, MEM0), state(PC1, REGS0, MEM1), Offset, Rs1, Rs2) :-
    get_reg_value(REGS0, Rs1, Rs1val),
    get_reg_value(REGS0, Rs2, Rs2val),
    Addr is Rs1val + Offset,
    Truncated is Rs2val /\ 0xFFFFFFFF,
    write_mem(MEM0, MEM1, Addr, Truncated, 4),
    PC1 is PC0 + 4.

%% lw rd, offset(rs1)
lw(state(PC0, REGS0, MEM0), state(PC1, REGS1, MEM0), Offset, Rs1, Rd) :-
    get_reg_value(REGS0, Rs1, Rs1val),
    Addr is Rs1val + Offset,
    read_mem(MEM0, Addr, RawVal, 4),
    sign_extend_32(RawVal, Val),
    write_reg_value(REGS0, REGS1, Rd, Val),
    PC1 is PC0 + 4.

%% jalr rd, imm(rs1)
jalr(state(PC0, REGS0, MEM), state(PC1, REGS1, MEM), Imm, Rs1, Rd) :-
    get_reg_value(REGS0, Rs1, Rs1val),
    ReturnAddr is PC0 + 4,
    Target is (Rs1val + Imm) /\ (-2),
    PC1 is Target,
    write_reg_value(REGS0, REGS1, Rd, ReturnAddr).

%% ============================================================
%% Programs
%% ============================================================

%% foo2 (optimized):
%%   addi  a0, zero, 3
%%   jalr  zero, 0(ra)
foo2(S0, S2) :-
    addi(S0, S1, 3, zero, a0),
    jalr(S1, S2, 0, ra, zero).

%% foo1 (unoptimized):
%%  1  addi   sp, sp, -32
%%  2  sd     ra, 24(sp)
%%  3  sd     s0, 16(sp)
%%  4  addi   s0, sp, 32
%%  5  addi   a0, zero, 1
%%  6  sw     a0, -20(s0)
%%  7  lw     a0, -20(s0)
%%  8  addiw  a0, a0, 2
%%  9  sw     a0, -24(s0)
%% 10  lw     a0, -24(s0)
%% 11  ld     ra, 24(sp)
%% 12  ld     s0, 16(sp)
%% 13  addi   sp, sp, 32
%% 14  jalr   zero, 0(ra)
foo1(S0, S14) :-
    addi(S0,  S1,  -32, sp, sp),
    sd(S1,    S2,  24,  sp, ra),
    sd(S2,    S3,  16,  sp, s0),
    addi(S3,  S4,  32,  sp, s0),
    addi(S4,  S5,  1,   zero, a0),
    sw(S5,    S6,  -20, s0, a0),
    lw(S6,    S7,  -20, s0, a0),
    addiw(S7, S8,  2,   a0, a0),
    sw(S8,    S9,  -24, s0, a0),
    lw(S9,    S10, -24, s0, a0),
    ld(S10,   S11, 24,  sp, ra),
    ld(S11,   S12, 16,  sp, s0),
    addi(S12, S13, 32,  sp, sp),
    jalr(S13, S14, 0,   ra, zero).

%% ============================================================
%% Equivalence check
%% ============================================================

initial_state(state(0x1000, Regs, [])) :-
    Regs = [reg(ra, 0x2000), reg(sp, 0x7FFFFFF0), reg(s0, 0xDEAD), reg(a0, 0)].

get_a0(state(_, Regs, _), Val) :-
    get_reg_value(Regs, a0, Val).

check_equivalence :-
    initial_state(S0),
    ( foo1(S0, S1Final), foo2(S0, S2Final) ->
        get_a0(S1Final, V1),
        get_a0(S2Final, V2),
        ( V1 =:= V2 ->
            write('EQUIVALENT: a0 = '), write(V1), write(' in both programs'), nl
        ;
            write('NOT EQUIVALENT: foo1.a0 = '), write(V1),
            write(', foo2.a0 = '), write(V2), nl
        )
    ;
        write('ERROR: one or both programs failed to execute'), nl
    ).

main(_) :- check_equivalence.
