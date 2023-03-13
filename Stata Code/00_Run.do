
clear all
set more off 
set type double

global path = "/Volumes/GoogleDrive/Shared drives/*Solstice | Low Income Inclusion/Projects/2019-2022 DOE SETO Contract Innovations/DOE SETO Project Implementation/Project Management/SETO Data Analysis/1. Community Solar Priorities/Qualtrics Survey/seto_survey/"

global input   = "$path/data"
global temp    = "$path/temp"
global scripts = "$path/scripts"
global output  = "$path/output"

do "$scripts/00.A Rename Variables (Qualtrics Panel).do"
do "$scripts/00.B Rename Variables (Community Groups).do" 
do "$scripts/01 Combine Qualtrics and Community Group Data.do"
do "$scripts/02 Prepare Data for Analysis.do"
do "$scripts/03.A Descriptive Analyses (Graphs).do"
do "$scripts/03.B Descriptive Analyses (Crosstabs).do"
do "$scripts/03.C Descriptive Analyses (Focus Group Prep).do"
do "$scripts/04.A Primary Analyses.do"
do "$scripts/04.B Secondary Analyses.do"

