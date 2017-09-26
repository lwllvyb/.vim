
com! -nargs=* Cdb call cdb#start(<q-args>)
com! CdbBp call cdb#breakline()
com! CdbStepOver call cdb#stepover()
com! CdbStepInto call cdb#stepinto()
com! -nargs=* CdbEval call cdb#eval(<q-args>)
com! CdbGo call cdb#go()
com! CdbQuit call cdb#quit()
