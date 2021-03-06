(****************************************************************************)
(*                           the diy toolsuite                              *)
(*                                                                          *)
(* Jade Alglave, University College London, UK.                             *)
(* Luc Maranget, INRIA Paris-Rocquencourt, France.                          *)
(*                                                                          *)
(* Copyright 2010-present Institut National de Recherche en Informatique et *)
(* en Automatique and the authors. All rights reserved.                     *)
(*                                                                          *)
(* This software is governed by the CeCILL-B license under French law and   *)
(* abiding by the rules of distribution of free software. You can use,      *)
(* modify and/ or redistribute the software under the terms of the CeCILL-B *)
(* license as circulated by CEA, CNRS and INRIA at the following URL        *)
(* "http://www.cecill.info". We also give a copy in LICENSE.txt.            *)
(****************************************************************************)

(** Define PPC architecture *)

module Make (C:Arch_herd.Config) (V:Value.S)
=
  struct
    include PPCBase

    type lannot = bool (* atomicity *)

    let empty_annot = false
    let is_atomic annot = annot 
    let is_barrier b1 b2 = barrier_compare b1 b2 = 0

    let barrier_sets =
      [
       "SYNC",is_barrier Sync;
       "ISYNC",is_barrier Isync;
       "LWSYNC",is_barrier Lwsync;
       "EIEIO",is_barrier Eieio;
     ]

    let annot_sets = ["X",is_atomic]

    let is_isync = is_barrier Isync
    let pp_isync = "isync"

    let pp_annot annot = 
      if annot then "*" else ""

(* Now global locations, that include reservations *)
    module V = V

    include ArchExtra_herd.Make(C)        
	(struct
	  module V = V 

	  type arch_reg = reg
	  let pp_reg = pp_reg
	  let reg_compare = reg_compare

	  type arch_instruction = instruction
          let fromto_of_instr _ = None

	end)
  end
    
