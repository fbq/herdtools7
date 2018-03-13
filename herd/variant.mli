(****************************************************************************)
(*                           the diy toolsuite                              *)
(*                                                                          *)
(* Jade Alglave, University College London, UK.                             *)
(* Luc Maranget, INRIA Paris-Rocquencourt, France.                          *)
(*                                                                          *)
(* Copyright 2018-present Institut National de Recherche en Informatique et *)
(* en Automatique and the authors. All rights reserved.                     *)
(*                                                                          *)
(* This software is governed by the CeCILL-B license under French law and   *)
(* abiding by the rules of distribution of free software. You can use,      *)
(* modify and/ or redistribute the software under the terms of the CeCILL-B *)
(* license as circulated by CEA, CNRS and INRIA at the following URL        *)
(* "http://www.cecill.info". We also give a copy in LICENSE.txt.            *)
(****************************************************************************)

type t =
  | Success     (* Riscv Model with explicit success dependency *)
  | SpecialX0   (* Some events by AMO to or from x0 are not generated *)
  | NoRMW       (* No RMW event for C *)
  | AcqRelAsFence (* Riscv: Expand load acquire and store release as fences *)
  | BackCompat (* Linux, Backward compatibility -> LISA *)
  | FullScDepend    (* Complete dependencies for Store Conditinal *)

val compare : t -> t -> int      
val tags : string list
val parse : string -> t option
val pp : t -> string