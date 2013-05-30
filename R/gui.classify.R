
# TODO: manual files selection should be done within this function
# (the same applies to gui.stylo)
# ATTENTION: here we have TWO sets

# TODO: apart from pronoun deletion, there should be also stoplist deletion
# (in two flavors: a. a predefined list of stop words; b. a custom list)

# TODO: delta on centroids




# #################################################
# Function for displaying simple yet effective graphical interface (GUI).
# If you execute this option, the values stored in the function 
# stylo.default.settings() will serve as default for the GUI for the first run.
# In the subsequent runs, recent values will appear as default in the GUI.
# No optional arguments.
# Usage: gui.classify()
# #################################################    

gui.classify <-
function() {
  
  # loading required libraries
  library(tcltk)
  library(tcltk2)

  # loading default settings
  stylo.default.settings()

  # using recently used settings to overwrite the default options
  if(file.exists("classify_config.txt") == TRUE) {
    source("classify_config.txt") 
    }

  
  .Tcl("font create myDefaultFont -family tahoma -size 8")
  .Tcl("option add *font myDefaultFont")  
  
    cancel_pause <- FALSE
    tt <- tktoplevel()
    tktitle(tt) <- "Stylometry with R: enter analysis parameters"
    
    push_OK <- function(){
        cancel_pause <<- TRUE
        tkdestroy(tt)
        }
  
  corpus.format <- tclVar(corpus.format)
  mfw.min <- tclVar(mfw.min)
  mfw.max <- tclVar(mfw.max)
  mfw.incr <- tclVar(mfw.incr)
  start.at <- tclVar(start.at)
  culling.min <- tclVar(culling.min)
  culling.max <- tclVar(culling.max)
  culling.incr <- tclVar(culling.incr)
  ngram.size <- tclVar(ngram.size)
  analyzed.features <- tclVar(analyzed.features)
  use.existing.freq.tables <- tclVar(use.existing.freq.tables)
  use.existing.wordlist <- tclVar(use.existing.wordlist)
  interactive.files <- tclVar(interactive.files)
  use.custom.list.of.files <- tclVar(use.custom.list.of.files)
  mfw.list.cutoff <- tclVar(mfw.list.cutoff)
  #
  classification.method <- tclVar(classification.method)
  culling.of.all.samples <- tclVar(culling.of.all.samples)
  reference.wordlist.of.all.samples <- tclVar(reference.wordlist.of.all.samples)
  z.scores.of.all.samples <- tclVar(z.scores.of.all.samples)
  number.of.candidates <- tclVar(number.of.candidates)
  final.ranking.of.candidates <- tclVar(final.ranking.of.candidates)
  how.many.correct.attributions <- tclVar(how.many.correct.attributions)
  #
  delete.pronouns <- tclVar(delete.pronouns)
  corpus.lang <- tclVar(corpus.lang)
  distance.measure <- tclVar(distance.measure)
  save.distance.tables <- tclVar(save.distance.tables)
  save.analyzed.features <- tclVar(save.analyzed.features)
  save.analyzed.freqs <- tclVar(save.analyzed.freqs)
  sampling <- tclVar(sampling)
  sample.size <- tclVar(sample.size)
  length.of.random.sample <- tclVar(length.of.random.sample)
  consensus.strength <- tclVar(consensus.strength)
  dump.samples <- tclVar(dump.samples)
  
  f1 <- tkframe(tt)
  f2 <- tkframe(tt)
  f3 <- tkframe(tt)
  f4 <- tkframe(tt)
  f5 <- tkframe(tt)
  
  # layout of the GUI begins here:
  tab1 <- function() {
  tkgrid(f1,row=1,column=0,columnspan=5)
  tkgrid.forget(f2)
  tkgrid.forget(f3)
  tkgrid.forget(f4)
  tkgrid.forget(f5)
  tkconfigure(t1.but,state="disabled", background="white")
  tkconfigure(t2.but,state="normal", background="aliceblue")
  tkconfigure(t3.but,state="normal", background="aliceblue")
  tkconfigure(t4.but,state="normal", background="aliceblue")
  tkconfigure(t5.but,state="normal", background="aliceblue")
  }
  tab2 <- function() {
  tkgrid(f2,row=1,column=0,columnspan=5)
  tkgrid.forget(f1)
  tkgrid.forget(f3)
  tkgrid.forget(f4)
  tkgrid.forget(f5)
  tkconfigure(t2.but,state="disabled", background="white")
  tkconfigure(t1.but,state="normal", background="aliceblue")
  tkconfigure(t3.but,state="normal", background="aliceblue")
  tkconfigure(t4.but,state="normal", background="aliceblue")
  tkconfigure(t5.but,state="normal", background="aliceblue")
  }
  tab3 <- function() {
  tkgrid(f3,row=1,column=0,columnspan=5)
  tkgrid.forget(f1)
  tkgrid.forget(f2)
  tkgrid.forget(f4)
  tkgrid.forget(f5)
  tkconfigure(t3.but,state="disabled", background="white")
  tkconfigure(t1.but,state="normal", background="aliceblue")
  tkconfigure(t2.but,state="normal", background="aliceblue")
  tkconfigure(t4.but,state="normal", background="aliceblue")
  tkconfigure(t5.but,state="normal", background="aliceblue")
  }
  tab4 <- function() {
  tkgrid(f4,row=1,column=0,columnspan=5)
  tkgrid.forget(f1)
  tkgrid.forget(f2)
  tkgrid.forget(f3)
  tkgrid.forget(f5)
  tkconfigure(t4.but,state="disabled", background="white")
  tkconfigure(t1.but,state="normal", background="aliceblue")
  tkconfigure(t2.but,state="normal", background="aliceblue")
  tkconfigure(t3.but,state="normal", background="aliceblue")
  tkconfigure(t5.but,state="normal", background="aliceblue")
  }
  tab5 <- function() {
  tkgrid(f5,row=1,column=0,columnspan=5)
  tkgrid.forget(f1)
  tkgrid.forget(f2)
  tkgrid.forget(f3)
  tkgrid.forget(f4)
  tkconfigure(t5.but,state="disabled", background="white")
  tkconfigure(t1.but,state="normal", background="aliceblue")
  tkconfigure(t2.but,state="normal", background="aliceblue")
  tkconfigure(t3.but,state="normal", background="aliceblue")
  tkconfigure(t4.but,state="normal", background="aliceblue")
  }
  t1.but <- tkbutton(tt,text="     INPUT & LANGUAGE     ",command=tab1)
  t2.but <- tkbutton(tt,text="         FEATURES         ",command=tab2)
  t3.but <- tkbutton(tt,text="        STATISTICS        ",command=tab3)
  t4.but <- tkbutton(tt,text="         SAMPLING         ",command=tab4)
  t5.but <- tkbutton(tt,text="          OUTPUT          ",command=tab5)
  tkgrid(t1.but)
  tkgrid(t2.but, column=1, row=0)
  tkgrid(t3.but, column=2, row=0)
  tkgrid(t4.but, column=3, row=0)
  tkgrid(t5.but, column=4, row=0)
  # Grid for individual tabs
   
  # initial state!
  tkgrid(f1,row=1,column=0,columnspan=5)
  tkconfigure(t1.but,state="disabled", background="white")
  tkconfigure(t2.but,state="normal", background="aliceblue")
  tkconfigure(t3.but,state="normal", background="aliceblue")
  tkconfigure(t4.but,state="normal", background="aliceblue")
  tkconfigure(t5.but,state="normal", background="aliceblue")
  
  # the OK button: active on each tab
  #
  button_1 <- tkbutton(tt,text="       OK       ",command=push_OK,relief="raised",background="aliceblue")
  tkbind(button_1,"<Return>",push_OK) 
  tkgrid(button_1,columnspan=10)
  tk2tip(button_1, "Press this only if you've visited all the tabs, or if you know\nyou want to leave values in some as they are.")
  
  
  ########################################################################################################################
  # layout of the GUI begins here:
  #
  tkgrid(tklabel(f1,text="    "),padx=0,pady=0) # blank line (serving as the top margin)
  tkgrid(tklabel(f2,text="    ")) # blank line (serving as the top margin)
  tkgrid(tklabel(f3,text="    ")) # blank line (serving as the top margin)
  tkgrid(tklabel(f4,text="    ")) # blank line (serving as the top margin)
  tkgrid(tklabel(f5,text="    ")) # blank line (serving as the top margin)
  
  # first row: INPUT
  #
  entry_TXT <- tkradiobutton(f1)
  entry_XML <- tkradiobutton(f1)
  entry_XMLDrama <- tkradiobutton(f1)
  entry_XMLNoTitles <- tkradiobutton(f1)
  entry_HTML <- tkradiobutton(f1)
  #
  tkconfigure(entry_TXT,variable=corpus.format,value="plain")
  tkconfigure(entry_XML,variable=corpus.format,value="xml")
  tkconfigure(entry_XMLDrama,variable=corpus.format,value="xml.drama")
  tkconfigure(entry_XMLNoTitles,variable=corpus.format,value="xml.notitles")
  tkconfigure(entry_HTML,variable=corpus.format,value="html")
  #
  entrylabel_TXT <- tklabel(f1,text="plain text")
  entrylabel_XML <- tklabel(f1,text="xml")
  entrylabel_XMLDrama <- tklabel(f1,text="xml (plays)")
  entrylabel_XMLNoTitles <- tklabel(f1,text="xml (no titles)")
  entrylabel_HTML <- tklabel(f1,text="html")
  #
  tkgrid(tklabel(f1,text="       INPUT:"),entrylabel_TXT,entrylabel_XML,entrylabel_XMLDrama,entrylabel_XMLNoTitles,entrylabel_HTML,columnspan=1)
  tkgrid(tklabel(f1,text="            "),entry_TXT,entry_XML,entry_XMLDrama,entry_XMLNoTitles,entry_HTML,columnspan=1)
  # Tooltips for the above
  tk2tip(entrylabel_TXT, "Plain text files. \nIf your corpus does not contain diacritics, no encoding is needed. \nOtherwise, use ANSI for Windows, UTF-8 for Mac/Linux.")
  tk2tip(entrylabel_XML, "XML: all tags and TEI headers are removed.")
  tk2tip(entrylabel_XMLDrama, "XML for plays: all tags, TEI headers, \nand speakers' names between <speaker>...</speaker> tags are removed.")
  tk2tip(entrylabel_XMLNoTitles, "XML contents only: all tags, TEI headers, \nand chapter/section (sub)titles between <head>...</head> tags are removed.")
  tk2tip(entrylabel_HTML, "HTML headers, menus, links and other tags are removed.")
  tkgrid(tklabel(f1,text="    ")) # blank line for aesthetic purposes
  
  # next row: LANGUAGE
  #
  entry_ENG <- tkradiobutton(f1)
  entry_EN2 <- tkradiobutton(f1)
  entry_EN3 <- tkradiobutton(f1)
  entry_POL <- tkradiobutton(f1)
  entry_LAT <- tkradiobutton(f1)
  entry_LA2 <- tkradiobutton(f1)
  entry_FRA <- tkradiobutton(f1)
  entry_GER <- tkradiobutton(f1)
  entry_HUN <- tkradiobutton(f1)
  entry_ITA <- tkradiobutton(f1)
  entry_DUT <- tkradiobutton(f1)
  entry_SPA <- tkradiobutton(f1)
  #
  tkconfigure(entry_ENG,variable=corpus.lang,value="English")
  tkconfigure(entry_EN2,variable=corpus.lang,value="English.contr")
  tkconfigure(entry_EN3,variable=corpus.lang,value="English.all")
  tkconfigure(entry_LAT,variable=corpus.lang,value="Latin")
  tkconfigure(entry_LA2,variable=corpus.lang,value="Latin.corr")
  tkconfigure(entry_POL,variable=corpus.lang,value="Polish")
  tkconfigure(entry_FRA,variable=corpus.lang,value="French")
  tkconfigure(entry_GER,variable=corpus.lang,value="German")
  tkconfigure(entry_HUN,variable=corpus.lang,value="Hungarian")
  tkconfigure(entry_ITA,variable=corpus.lang,value="Italian")
  tkconfigure(entry_DUT,variable=corpus.lang,value="Dutch")
  tkconfigure(entry_SPA,variable=corpus.lang,value="Spanish")
  #
  entrylabel_ENG <- tklabel(f1,text="    English     ")
  entrylabel_POL <- tklabel(f1,text="    Polish      ")
  entrylabel_LAT <- tklabel(f1,text="    Latin       ")
  entrylabel_FRA <- tklabel(f1,text="    French      ")
  entrylabel_GER <- tklabel(f1,text="    German      ")
  entrylabel_HUN <- tklabel(f1,text="   Hungarian    ")
  entrylabel_ITA <- tklabel(f1,text="    Italian     ")
  entrylabel_EN2 <- tklabel(f1,text="English (contr.)")
  entrylabel_EN3 <- tklabel(f1,text="  English (ALL) ")
  entrylabel_LA2 <- tklabel(f1,text="Latin (u/v > u) ")
  entrylabel_DUT <- tklabel(f1,text="     Dutch      ")
  entrylabel_SPA <- tklabel(f1,text="    Spanish     ")
  #
  tkgrid(tklabel(f1,text="LANGUAGE: "),entrylabel_ENG,entrylabel_EN2,entrylabel_EN3,entrylabel_LAT,entrylabel_LA2)
  tkgrid(tklabel(f1,text="          "),entry_ENG,entry_EN2,entry_EN3,entry_LAT,entry_LA2)
  tkgrid(tklabel(f1,text="          "),entrylabel_POL,entrylabel_HUN,entrylabel_FRA,entrylabel_ITA,entrylabel_SPA)
  tkgrid(tklabel(f1,text="          "),entry_POL,entry_HUN,entry_FRA,entry_SPA,entry_ITA)
  tkgrid(tklabel(f1,text="          "),entrylabel_DUT,entrylabel_GER)
  tkgrid(tklabel(f1,text="          "),entry_DUT,entry_GER)
  tkgrid(tklabel(f1,text="    ")) # blank line for aesthetic purposes
  
  # Tooltips for the above
  tk2tip(entrylabel_ENG, "Plain English: contractions and \ncompound words are split")
  tk2tip(entrylabel_POL, "Plain Polish: contractions and \ncompound words are split")
  tk2tip(entrylabel_EN2, "Modified English: \ncontractions are not split")
  tk2tip(entrylabel_EN3, "Further Modified English: contractions \nand compound words are not split")
  tk2tip(entrylabel_LAT, "Plain Latin: U and V \ntreated as distinct letters")
  tk2tip(entrylabel_FRA, "Plain French: contractions and \ncompound words are split")
  tk2tip(entrylabel_GER, "Plain German: contractions and \ncompound words are split")
  tk2tip(entrylabel_HUN, "Plain Hungarian: contractions and \ncompound words are split")
  tk2tip(entrylabel_ITA, "Plain Italian: contractions and \ncompound words are split")
  tk2tip(entrylabel_LA2, "Modified Latin: U and V \nboth treated as U")
  tk2tip(entrylabel_DUT, "Plain Dutch: contractions and \ncompound words are split")
  tk2tip(entrylabel_SPA, "Plain Castilian: contractions and \ncompound words are split")
  
  # next row: TEXT FEATURES
  entry_W <- tkradiobutton(f2)
  entry_L <- tkradiobutton(f2)
  cb_NGRAMS <- tkcheckbutton(f2)
  entry_NGRAMSIZE <- tkentry(f2,textvariable=ngram.size,width="8")
  #
  tkconfigure(entry_W,variable=analyzed.features,value="w")
  tkconfigure(entry_L,variable=analyzed.features,value="c")
  #
  entrylabel_W <- tklabel(f2,text="words")
  entrylabel_L <- tklabel(f2,text="chars")
  entrylabel_NGRAMSIZE <- tklabel(f2,text="ngram size")
  #
  tkgrid(tklabel(f2,text="        FEATURES:"),entrylabel_W,entrylabel_L,entrylabel_NGRAMSIZE)
  tkgrid(tklabel(f2,text="                 "),entry_W,entry_L,entry_NGRAMSIZE)
  
  # Tooltips for the above
  tk2tip(entrylabel_W, "Select this to work on words")
  tk2tip(entrylabel_L, "Select this to work on characters \n(does not make much sense unless you use ngrams)")
  tk2tip(entrylabel_NGRAMSIZE, "State your n for n-grams \nto work on word/char clusters of n")
  tkgrid(tklabel(f2,text="    ")) # blank line for aesthetic purposes
  
  # next row: MFW SETTINGS
  #
  entry_MFW_MIN <- tkentry(f2,textvariable=mfw.min,width="8")
  entry_MFW_MAX <- tkentry(f2,textvariable=mfw.max,width="8")
  entry_MFW_INCR <- tkentry(f2,textvariable=mfw.incr,width="8")
  entry_START_AT <- tkentry(f2,textvariable=start.at,width="8")
  #
  entrylabel_MFW_MIN <- tklabel(f2,text="Minimum")
  entrylabel_MFW_MAX <- tklabel(f2,text="Maximum")
  entrylabel_MFW_INCR <- tklabel(f2,text="Increment")
  entrylabel_START_AT <- tklabel(f2,text="Start at freq. rank")
  #
  tkgrid(tklabel(f2,text="MFW SETTINGS:"),entrylabel_MFW_MIN,entrylabel_MFW_MAX,entrylabel_MFW_INCR,entrylabel_START_AT)
  tkgrid(tklabel(f2,text="             "),entry_MFW_MIN,entry_MFW_MAX,entry_MFW_INCR,entry_START_AT)
  tkgrid(tklabel(f2,text="    ")) # blank line for aesthetic purposes
  
  # Tooltips for the above
  tk2tip(entrylabel_MFW_MIN, "Set the minimum number of most frequent words. \nThe script will conduct its first analysis for \nthe number of words specified here")
  tk2tip(entrylabel_MFW_MAX, "Set the maximum number of most frequent words. \nThe script will conduct its final analysis for \nthe number of words specified here")
  tk2tip(entrylabel_MFW_INCR, "Set the increment added to \nthe minimum number of most frequent \nwords for each subsequent analysis.")
  tk2tip(entrylabel_START_AT, "Set the number of words from the top of \nthe frequency list to skip in the analysis.")
  
  # next row: CULLING
  #
  cb_DEL_PRON <- tkcheckbutton(f2)
  #
  entry_CUL_MIN <- tkentry(f2,textvariable=culling.min,width="8")
  entry_CUL_MAX <- tkentry(f2,textvariable=culling.max,width="8")
  entry_CUL_INCR <- tkentry(f2,textvariable=culling.incr,width="8")
  entry_CUT_OFF <- tkentry(f2,textvariable=mfw.list.cutoff,width="8")
  tkconfigure(cb_DEL_PRON,variable=delete.pronouns)
  #
  entrylabel_CUL_MIN <- tklabel(f2,text="Minimum")
  entrylabel_CUL_MAX <- tklabel(f2,text="Maximum")
  entrylabel_CUL_INCR <- tklabel(f2,text="Increment")
  entrylabel_CUT_OFF <- tklabel(f2,text="List Cutoff")
  cblabel_DEL_PRON <- tklabel(f2,text="Delete pronouns")
  #
  tkgrid(tklabel(f2,text="         CULLING:"),entrylabel_CUL_MIN,entrylabel_CUL_MAX, entrylabel_CUL_INCR,entrylabel_CUT_OFF,cblabel_DEL_PRON)
  tkgrid(tklabel(f2,text="                 "),entry_CUL_MIN,entry_CUL_MAX,entry_CUL_INCR,entry_CUT_OFF,cb_DEL_PRON)
  tkgrid(tklabel(f2,text="    ")) # blank line for aesthetic purposes
    
  # next row: LISTS & FILES
  #
  cb_FREQS <- tkcheckbutton(f2)
  cb_LISTS <- tkcheckbutton(f2)
  cb_INTFILES <- tkcheckbutton(f2)
  cb_MYFILES <- tkcheckbutton(f2)
  #
  tkconfigure(cb_FREQS,variable=use.existing.freq.tables)
  tkconfigure(cb_LISTS,variable=use.existing.wordlist)
  tkconfigure(cb_INTFILES,variable=interactive.files)
  tkconfigure(cb_MYFILES,variable=use.custom.list.of.files)
  #
  cblabel_FREQS <- tklabel(f2,text="Existing frequencies")
  cblabel_LISTS <- tklabel(f2,text="Existing wordlist")
  cblabel_INTFILES <- tklabel(f2,text="Select files manually")
  cblabel_MYFILES <- tklabel(f2,text="List of files")
  #
  tkgrid(tklabel(f2,text="    VARIOUS:"),cblabel_FREQS,cblabel_LISTS,cblabel_INTFILES,cblabel_MYFILES)
  tkgrid(tklabel(f2,text="            "),cb_FREQS,cb_LISTS,cb_INTFILES,cb_MYFILES)
    
  # Tooltips for the above  
  tk2tip(entrylabel_CUL_MIN, "State the minimum culling setting. \n0 means no words are omitted from the analysis. \n50 means a word needs to appear in \nat least 50% of the texts to be included in the analysis. \n100 means that only words appearing in all the texts \nwill be included in the analysis")
  tk2tip(entrylabel_CUL_MAX, "State the maximum culling setting. \n0 means no words are omitted from the analysis. \n50 means a word needs to appear in \nat least 50% of the texts to be included in the analysis. \n100 means that only words appearing in all the texts \nwill be included in the analysis")
  tk2tip(entrylabel_CUL_INCR, "State the increment added to the minimum culling \nsetting for each subsequent analysis.")
  tk2tip(entrylabel_CUT_OFF, "Set the maximum size of the word frequency table. \nAnything above 5000 requires patience and a fast computer")
  tk2tip(cblabel_DEL_PRON, "Select if you want to omit pronouns in the analysis. \nThis improves attribution in some languages")
  tk2tip(cblabel_FREQS, "Select to use the frequency lists generated by the previous analysis. \nThis speeds up the process dramatically. \nA very bad idea if you've just changed your selection of texts!")
  tk2tip(cblabel_LISTS, "Select to use the wordlist generated by \nthe previous analysis or a custom wordlist.")
  tk2tip(cblabel_INTFILES, "Select this to manually select files \nrather than use the entire corpus. \nMake sure that \"Existing frequencies\" is unchecked!")
  tk2tip(cblabel_MYFILES, "Select this if you want to use custom list \nof files to be loaded; the list should be stored \nin \"files_to_analyze.txt\", and the entries delimited \nwith spaces, tabs, or newlines.")
  
  
  tkgrid(tklabel(f2,text="    ")) # blank line for aesthetic purposes 
  
  # next row: STATISTICS
  #
  #
  entry_DELTA <- tkradiobutton(f3)
  entry_KNN <- tkradiobutton(f3)
  entry_SVM <- tkradiobutton(f3)
  entry_NBAYES <- tkradiobutton(f3)
  entry_NSC <- tkradiobutton(f3)
  #
  tkconfigure(entry_DELTA,variable=classification.method,value="delta")
  tkconfigure(entry_KNN,variable=classification.method,value="knn")
  tkconfigure(entry_SVM,variable=classification.method,value="svm")
  tkconfigure(entry_NBAYES,variable=classification.method,value="naivebayes")
  tkconfigure(entry_NSC,variable=classification.method,value="nsc")
  #
  entrylabel_DELTA <- tklabel(f3,text="Delta")
  entrylabel_KNN <- tklabel(f3,text="k-NN")
  entrylabel_SVM <- tklabel(f3,text="SVM")
  entrylabel_NBAYES <- tklabel(f3,text="NaiveBayes")
  entrylabel_NSC <- tklabel(f3,text="NSC")
  #
  tkgrid(tklabel(f3,text=" STATISTICS:"),entrylabel_DELTA,entrylabel_KNN,entrylabel_SVM,entrylabel_NBAYES,entrylabel_NSC)
  tkgrid(tklabel(f3,text="            "),entry_DELTA,entry_KNN,entry_SVM,entry_NBAYES,entry_NSC)
  tkgrid(tklabel(f3,text="    ")) # blank line for aesthetic purposes
  # Tooltips for the above
  tk2tip(entrylabel_DELTA, "Burrows's Delta")
  tk2tip(entrylabel_KNN, "k-Nearest Neighbor Classification")
  tk2tip(entrylabel_SVM, "Support Vector Machines")
  tk2tip(entrylabel_NBAYES, "Naive Bayes Classification. To use this method, you should have \nat least two texts of each class (author, genre, etc.) in the primary set")
  tk2tip(entrylabel_NSC, "Nearest Shrunken Centroids Classification. To use this method, you should have \nat least two texts of each class (author, genre, etc.) in the primary set")

  # next row: GENERAL OPTIONS
  cb_ALL_C <- tkcheckbutton(f3)
  cb_ALL_L <- tkcheckbutton(f3)
  cb_ALL_Z <- tkcheckbutton(f3)
  #
  tkconfigure(cb_ALL_C,variable=culling.of.all.samples)
  tkconfigure(cb_ALL_L,variable=reference.wordlist.of.all.samples)
  tkconfigure(cb_ALL_Z,variable=z.scores.of.all.samples)
  #
  cblabel_ALL_C <- tklabel(f3,text="ALL culling")
  cblabel_ALL_L <- tklabel(f3,text="ALL wordlists")
  cblabel_ALL_Z <- tklabel(f3,text="ALL z-scores")
  #
  tkgrid(tklabel(f3,text=" GENERAL:"),cblabel_ALL_C,cblabel_ALL_L,cblabel_ALL_Z)
  tkgrid(tklabel(f3,text="            "),cb_ALL_C,cb_ALL_L,cb_ALL_Z)
  tkgrid(tklabel(f3,text="    ")) # blank line for aesthetic purposes
  # Tooltips for the above
  tk2tip(cblabel_ALL_C, "If this is left unchecked, the culling procedure \nis based on data from the primary set alone. \nChecking this box ensures words present in ALL texts \nof BOTH sets ar affected by the culling.")
  tk2tip(cblabel_ALL_L, "If this is left unchecked, both frequency tables \nare built using a pre-prepared wordlist of the primary set. \nChecking this box compiles the list \nbasing on both primary and secondary sets.")
  tk2tip(cblabel_ALL_Z, "If this is left unchecked, then the z-scores \nare based on the primary set only (applicable to Delta).")

  # next row: DELTA SETTINGS: DISTANCES
  #
  entry_CD <- tkradiobutton(f3)
  entry_AL <- tkradiobutton(f3)
  entry_ED <- tkradiobutton(f3)
  entry_ES <- tkradiobutton(f3)
  entry_MH <- tkradiobutton(f3)
  entry_CB <- tkradiobutton(f3)
  entry_EU <- tkradiobutton(f3)
  #
  tkconfigure(entry_CD,variable=distance.measure,value="CD")
  tkconfigure(entry_AL,variable=distance.measure,value="AL")
  tkconfigure(entry_ED,variable=distance.measure,value="ED")
  tkconfigure(entry_ES,variable=distance.measure,value="ES")
  tkconfigure(entry_MH,variable=distance.measure,value="MH")
  tkconfigure(entry_CB,variable=distance.measure,value="CB")
  tkconfigure(entry_EU,variable=distance.measure,value="EU")
  #
  entrylabel_CD <- tklabel(f3,text="Classic Delta")
  entrylabel_AL <- tklabel(f3,text="Argamon's Delta")
  entrylabel_ED <- tklabel(f3,text="Eder's Delta")
  entrylabel_ES <- tklabel(f3,text="Eder's Simple")
  entrylabel_MH <- tklabel(f3,text="Manhattan")
  entrylabel_CB <- tklabel(f3,text="Canberra")
  entrylabel_EU <- tklabel(f3,text="Euclidean")
  #
  tkgrid(tklabel(f3,text="  DELTA DISTANCE:  "),entrylabel_CD,entrylabel_AL,entrylabel_ED,entrylabel_ES)
  tkgrid(tklabel(f3,text="            "),entry_CD,entry_AL,entry_ED,entry_ES)
  tkgrid(tklabel(f3,text="            "),entrylabel_MH,entrylabel_CB,entrylabel_EU)
  tkgrid(tklabel(f3,text="            "),entry_MH,entry_CB,entry_EU)
  tkgrid(tklabel(f3,text="    ")) # blank line for aesthetic purposes
  # Tooltips for the above
  tk2tip(entrylabel_CD, "Select the Classic Delta measure as developed by Burrows.")
  tk2tip(entrylabel_AL, "Select Argamon's Linear Delta (based on Euclidean principles).")
  tk2tip(entrylabel_ED, "Select Eder's Delta (explanation and mathematical equation: TBA).")
  tk2tip(entrylabel_ES, "Select Eder's Simple measure (explanation and mathematical equation: TBA).")
  tk2tip(entrylabel_MH, "Select Manhattan Distance (obvious and well documented).")
  tk2tip(entrylabel_CB, "Select Canberra Distance (risky, but sometimes amazingly good).")
  tk2tip(entrylabel_EU, "Select Euclidean Distance (basic and the most *natural*).")
  
  # next row: OTHER METHODS
  #
  tkgrid(tklabel(f3,text="  SVM OPTIONS:     "))
  tkgrid(tklabel(f3,text="    ")) # blank line for aesthetic purposes
  tkgrid(tklabel(f3,text="  k-NN OPTIONS:    "))
  tkgrid(tklabel(f3,text="    ")) # blank line for aesthetic purposes


  # next tab: SAMPLING
  entry_SAMP <- tkradiobutton(f4)
  entry_RAND <- tkradiobutton(f4)
  entry_NOSAMP <- tkradiobutton(f4)
    
  tkconfigure(entry_SAMP, variable=sampling, value="normal.sampling")
  tkconfigure(entry_RAND, variable=sampling, value="random.sampling")
  tkconfigure(entry_NOSAMP, variable=sampling, value="no.sampling")
    
  entry_SAMPLESIZE <- tkentry(f4,textvariable=sample.size,width="10")
  entry_SIZE <- tkentry(f4,textvariable=length.of.random.sample,width="10")
  
  entrylabel_SAMP <- tklabel(f4,text="Normal sampling")
  entrylabel_RAND <- tklabel(f4,text="Random sampling")
  entrylabel_NOSAMP <- tklabel(f4,text="No sampling")
  
  entrylabel_SAMPLESIZE <- tklabel(f4,text="Sample size")
  entrylabel_SIZE <- tklabel(f4,text="Random sample size")
  
  
  # Position and display sampling parameters on the grid:
  tkgrid(entrylabel_NOSAMP,entrylabel_SAMP, entrylabel_RAND)
  tkgrid(entry_NOSAMP, entry_SAMP, entry_RAND)
  tkgrid(tklabel(f4,text="    "),entrylabel_SAMPLESIZE, entrylabel_SIZE)
  tkgrid(tklabel(f4,text="    "),entry_SAMPLESIZE, entry_SIZE)
  tkgrid(tklabel(f4,text="    ")) # blank line for aesthetic purposes
  
  # Tooltips for the above
  tk2tip(entrylabel_SAMP, "Specify whether the texts in the corpus should be divided in equal-sized samples.")
  tk2tip(entrylabel_SAMPLESIZE, "Specify the size for the samples (expressed in words). \nOnly relevant when normal sampling is switched on.")
  tk2tip(entrylabel_RAND, "When the analyzed texts are significantly unequal in length, \nit is not a bad idea to prepare samples as randomly chosen *bags of words*. \nIf this option is switched on, the desired size of a sample should be indicated.")
  tk2tip(entrylabel_SIZE, "Specify the random sample size. \nOnly relevant when random sampling is switched on.")
  tk2tip(entrylabel_NOSAMP, "No internal sampling will be performed: entire texts are considered as samples.")
  
  # next row: OUTPUT
  #
  cb_QUEER <- tkcheckbutton(f5)
  cb_GUESS <- tkcheckbutton(f5)
  #
  tkconfigure(cb_QUEER,variable=final.ranking.of.candidates)
  tkconfigure(cb_GUESS,variable=how.many.correct.attributions)
  entry_CAND <- tkentry(f5,textvariable=number.of.candidates,width="8")
  #
  cblabel_QUEER <- tklabel(f5,text="Misclassifications")
  cblabel_GUESS <- tklabel(f5,text="Count good guesses")
  entrylabel_CAND <- tklabel(f5,text="No. of candidates")
  #
  tkgrid(tklabel(f5,text="  GENERAL:  "),cblabel_QUEER,cblabel_GUESS,entrylabel_CAND)
  tkgrid(tklabel(f5,text="                   "),cb_QUEER,cb_GUESS,entry_CAND)
  tkgrid(tklabel(f5,text="    ")) # blank line for aesthetic purposes
  # Tooltips for the above
  tk2tip(cblabel_QUEER, "Select to list misattributions in the final results file.")
  tk2tip(cblabel_GUESS, "Select to count the proportion of correct attributions.")
  tk2tip(entrylabel_CAND, "Set the number of candidates in the final results file.")

  # next row: VARIOUS
  cb_TABLESAVE <- tkcheckbutton(f5)
  cb_FEATURESAVE <- tkcheckbutton(f5)
  cb_FREQSAVE <-tkcheckbutton(f5)
  cb_DUMPSAMPLES<-tkcheckbutton(f5)
  #
  tkconfigure(cb_TABLESAVE,variable=save.distance.tables)
  tkconfigure(cb_FEATURESAVE,variable=save.analyzed.features)
  tkconfigure(cb_FREQSAVE,variable=save.analyzed.freqs)
  tkconfigure(cb_DUMPSAMPLES,variable=dump.samples)
  #
  cblabel_TABLESAVE <- tklabel(f5,text="Save distance table")
  cblabel_FEATURESAVE <- tklabel(f5,text="Save features")
  cblabel_FREQSAVE <- tklabel(f5,text="Save frequencies")
  cblabel_DUMPSAMPLES <- tklabel(f5,text="Dump samples")
  #
  tkgrid(tklabel(f5,text="    VARIOUS:   "), cblabel_TABLESAVE,cblabel_FEATURESAVE,cblabel_FREQSAVE,cblabel_DUMPSAMPLES)
  tkgrid(tklabel(f5,text="            "), cb_TABLESAVE,cb_FEATURESAVE,cb_FREQSAVE,cb_DUMPSAMPLES)
  tkgrid(tklabel(f5,text="    ")) # blank line for aesthetic purposes
  # Tooltips for the above
  tk2tip(cblabel_TABLESAVE, "Save final distance table(s) in separate text file(s).")
  tk2tip(cblabel_FEATURESAVE, "Save final feature (word, n-gram) list(s), e.g. the words actually used in the analysis.")
  tk2tip(cblabel_FREQSAVE, "Save frequency table(s) in separate text file(s).")
  tk2tip(cblabel_DUMPSAMPLES, "Save a dump of all samples in the directory 'Dumps' for post-analysis inspection.")

  
  # next row: the OK button
  #
  # button_1 <- tkbutton(tt,text="     OK     ",command=push_OK,relief="groove")
  # tkbind(button_1,"<Return>",push_OK) 
  # tkgrid(button_1,columnspan="10")
  tkgrid(tklabel(tt,text="    ")) # blank line (i.e., bottom margin)
  
  
  ##########
  
  repeat{
    if(cancel_pause){
      analyzed.features <<- as.character(tclvalue(analyzed.features))
      ngram.size <<- as.numeric(tclvalue(ngram.size))
      corpus.format <<- as.character(tclvalue(corpus.format))
      mfw.min <<- as.numeric(tclvalue(mfw.min))
      mfw.max <<- as.numeric(tclvalue(mfw.max))
      mfw.incr <<- as.numeric(tclvalue(mfw.incr))
      start.at <<- as.numeric(tclvalue(start.at))
      culling.min <<- as.numeric(tclvalue(culling.min))
      culling.max <<- as.numeric(tclvalue(culling.max))
      culling.incr <<- as.numeric(tclvalue(culling.incr))
      use.existing.freq.tables <<- as.logical(as.numeric(tclvalue(use.existing.freq.tables)))
      use.existing.wordlist <<- as.logical(as.numeric(tclvalue(use.existing.wordlist)))
      interactive.files <<- as.logical(as.numeric(tclvalue(interactive.files)))
      use.custom.list.of.files <<- as.logical(as.numeric(tclvalue(use.custom.list.of.files)))
      classification.method <<- as.character(tclvalue(classification.method))
      culling.of.all.samples <<- as.logical(as.numeric(tclvalue(culling.of.all.samples)))
      reference.wordlist.of.all.samples <<- as.logical(as.numeric(tclvalue(reference.wordlist.of.all.samples)))
      z.scores.of.all.samples <<- as.logical(as.numeric(tclvalue(z.scores.of.all.samples)))
      number.of.candidates <<- as.numeric(tclvalue(number.of.candidates))
      final.ranking.of.candidates <<- as.logical(as.numeric(tclvalue(final.ranking.of.candidates)))
      how.many.correct.attributions <<- as.logical(as.numeric(tclvalue(how.many.correct.attributions)))
      delete.pronouns <<- as.logical(as.numeric(tclvalue(delete.pronouns)))
  	  dump.samples <<- as.logical(as.numeric(tclvalue(dump.samples)))
      save.distance.tables <<- as.logical(as.numeric(tclvalue(save.distance.tables)))
      save.analyzed.features <<- as.logical(as.numeric(tclvalue(save.analyzed.features)))
      save.analyzed.freqs <<- as.logical(as.numeric(tclvalue(save.analyzed.freqs)))
      sampling <<- as.character(tclvalue(sampling))
      sample.size <<- as.numeric(tclvalue(sample.size))
      length.of.random.sample <<- as.numeric(tclvalue(length.of.random.sample))
      mfw.list.cutoff <<- as.numeric(tclvalue(mfw.list.cutoff))
      distance.measure <<- as.character(tclvalue(distance.measure))
      corpus.lang <<- as.character(tclvalue(corpus.lang))
      consensus.strength <<- as.numeric(tclvalue(consensus.strength))
    break
    }
  .Tcl("font delete myDefaultFont")
  }
}