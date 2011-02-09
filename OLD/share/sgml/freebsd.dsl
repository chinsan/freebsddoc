<!-- $FreeBSD: doc/zh_TW.Big5/share/sgml/freebsd.dsl,v 1.6 2007/06/02 00:46:15 chinsan Exp $ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>
<!ENTITY % output.html  "IGNORE"> 
<!ENTITY % output.print "IGNORE">
<!ENTITY % output.print.niceheaders "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>

      <!-- �۷�� <book lang="zh_tw">  -->
      <!-- (define %default-language% "zh_tw") -->

      <!-- HTML only .................................................... -->
 
      <![ %output.html; [ 

        <!-- Generate links to HTML man pages -->
        (define %refentry-xref-link% #t)

	(define ($email-footer$)
          (make sequence
	    (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "����Ψ�L���A�i�Ѧ��U���G")
		(create-link
		  (list (list "HREF" "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                  (literal "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                (literal "�C")))
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"  
                (literal "�Y�� FreeBSD �譱�ðݡA�Х��\Ū ")
		(create-link
		  (list (list "HREF" "http://www.FreeBSD.org/docs.html"))
                  (literal "FreeBSD �������"))
                (literal "�A�p����ѨM���ܡA�A���� <")
		(create-link
		  (list (list "HREF" "mailto:questions@FreeBSD.org"))
                  (literal "questions@FreeBSD.org"))
                (literal ">�C")
                (make empty-element gi: "br")
                (literal "���󥻤�󪺰��D�A�Ь��� <")
		(create-link (list (list "HREF" "mailto:doc@FreeBSD.org"))
                  (literal "doc@FreeBSD.org"))
	        (literal ">�C")))))

;; ���n�j�ժ������A����D�β���A�������r�������ءA�B��ê�\Ū�A
;; �ק�� /usr/local/share/sgml/docbook/dsssl/modular/html/dbinline.dsl
;; Id: dbinline.dsl,v 1.11 2004/09/14 14:47:10 petere78 Exp
;; chinsan: �o�q���� zh_CN ���G :p

(element emphasis
  (let* ((class (if (and (attribute-string (normalize "role"))
			 %emphasis-propagates-style%)
		    (attribute-string (normalize "role"))
		    "emphasis")))
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" class))
	      ($bold-seq$))))

      ]]>

      <!-- More aesthetically pleasing chapter headers for print output -->

      <![ %output.print.niceheaders; [

      (define niceheader-rule-spacebefore (* (HSIZE 5) %head-before-factor%))
      (define niceheader-rule-spaceafter 0pt)

      (define ($component-title$)
	(let* ((info (cond
		((equal? (gi) (normalize "appendix"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "article"))
		 (node-list-filter-by-gi (children (current-node))
					 (list (normalize "artheader")
					       (normalize "articleinfo"))))
		((equal? (gi) (normalize "bibliography"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "chapter"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "dedication"))
		 (empty-node-list))
		((equal? (gi) (normalize "glossary"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "index"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "preface"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "reference"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "setindex"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		(else
		 (empty-node-list))))
	 (exp-children (if (node-list-empty? info)
			   (empty-node-list)
			   (expand-children (children info)
					    (list (normalize "bookbiblio")
						  (normalize "bibliomisc")
						  (normalize "biblioset")))))
	 (parent-titles (select-elements (children (current-node)) (normalize "title")))
	 (info-titles   (select-elements exp-children (normalize "title")))
	 (titles        (if (node-list-empty? parent-titles)
			    info-titles
			    parent-titles))
	 (subtitles     (select-elements exp-children (normalize "subtitle"))))
    (make sequence
      (make paragraph
	font-family-name: %title-font-family%
	font-weight: 'bold
	font-size: (HSIZE 4)
	line-spacing: (* (HSIZE 4) %line-spacing-factor%)
	space-before: (* (HSIZE 4) %head-before-factor%)
	start-indent: 0pt
	first-line-start-indent: 0pt
	quadding: %component-title-quadding%
	heading-level: (if %generate-heading-level% 1 0)
	keep-with-next?: #t

	(if (string=? (element-label) "")
	    (empty-sosofo)
	    (literal (gentext-element-name-space (current-node))
		     (element-label)
		     (gentext-label-title-sep (gi)))))
      (make paragraph
	font-family-name: %title-font-family%
	font-weight: 'bold
	font-posture: 'italic
	font-size: (HSIZE 6)
	line-spacing: (* (HSIZE 6) %line-spacing-factor%)
;	space-before: (* (HSIZE 5) %head-before-factor%)
	start-indent: 0pt
	first-line-start-indent: 0pt
	quadding: %component-title-quadding%
	heading-level: (if %generate-heading-level% 1 0)
	keep-with-next?: #t

	(if (node-list-empty? titles)
	    (element-title-sosofo) ;; get a default!
	    (with-mode component-title-mode
	      (make sequence
		(process-node-list titles)))))

      (make paragraph
	font-family-name: %title-font-family%
	font-weight: 'bold
	font-posture: 'italic
	font-size: (HSIZE 3)
	line-spacing: (* (HSIZE 3) %line-spacing-factor%)
	space-before: (* 0.5 (* (HSIZE 3) %head-before-factor%))
	space-after: (* (HSIZE 4) %head-after-factor%)
	start-indent: 0pt
	first-line-start-indent: 0pt
	quadding: %component-subtitle-quadding%
	keep-with-next?: #t

	(with-mode component-title-mode
	  (make sequence
	    (process-node-list subtitles))))

      (if (equal? (gi) (normalize "index"))
	(empty-sosofo)
	(make rule
	  length: %body-width%
	  display-alignment: 'start
	  space-before: niceheader-rule-spacebefore
	  space-after: niceheader-rule-spaceafter
	  line-thickness: 0.5pt)))))

      (element authorgroup
        (empty-sosofo))

      ]]>

      <!-- Print only ................................................... -->

      <![ %output.print; [

      (define minimal-section-labels #f)
      (define max-section-level-labels
        (if minimal-section-labels 3 10))

      (define ($section-title$)
        (let* ((sect (current-node))
      	       (info (info-element))
	       (exp-children (if (node-list-empty? info)
		 	         (empty-node-list)
			         (expand-children (children info)
					          (list (normalize "bookbiblio")
						        (normalize "bibliomisc")
						        (normalize "biblioset")))))
	       (parent-titles (select-elements (children sect) (normalize "title")))
  	       (info-titles   (select-elements exp-children (normalize "title")))
	       (titles        (if (node-list-empty? parent-titles)
		   	          info-titles
			          parent-titles))
	       (subtitles     (select-elements exp-children (normalize "subtitle")))
	       (renderas (inherited-attribute-string (normalize "renderas") sect))
	       (hlevel                          ;; the apparent section level;
	        (if renderas                    ;; if not real section level,
  	            (string->number             ;;   then get the apparent level
	             (substring renderas 4 5))  ;;   from "renderas",
	            (SECTLEVEL)))               ;; else use the real level
	       (hs (HSIZE (- 4 hlevel))))

          (make sequence
            (make paragraph
 	      font-family-name: %title-font-family%
	      font-weight:  (if (< hlevel 5) 'bold 'medium)
	      font-posture: (if (< hlevel 5) 'upright 'italic)
	      font-size: hs
	      line-spacing: (* hs %line-spacing-factor%)
	      space-before: (* hs %head-before-factor%)
	      space-after: (if (node-list-empty? subtitles)
	    	  	       (* hs %head-after-factor%)
	 	  	       0pt)
	      start-indent: (if (or (>= hlevel 3)
			            (member (gi) (list (normalize "refsynopsisdiv")
					    	       (normalize "refsect1")
						       (normalize "refsect2")
						       (normalize "refsect3"))))
	 		        %body-start-indent%
			        0pt)
	      first-line-start-indent: 0pt
	      quadding: %section-title-quadding%
	      keep-with-next?: #t
	      heading-level: (if %generate-heading-level% (+ hlevel 1) 0)
  	      ;; SimpleSects are never AUTO numbered...they aren't hierarchical
	      (if (> hlevel (- max-section-level-labels 1))
	          (empty-sosofo)
	          (if (string=? (element-label (current-node)) "")
	  	      (empty-sosofo)
		      (literal (element-label (current-node))
			       (gentext-label-title-sep (gi sect)))))
	      (element-title-sosofo (current-node)))
            (with-mode section-title-mode
	      (process-node-list subtitles))
            ($section-info$ info))))

      ]]>

      <!-- More aesthetically pleasing chapter headers for print output --> 

      <![ %output.print.niceheaders; [

      (define niceheader-rule-spacebefore (* (HSIZE 5) %head-before-factor%))
      (define niceheader-rule-spaceafter 0pt)

      (define ($component-title$)
	(let* ((info (cond
		((equal? (gi) (normalize "appendix"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "article"))
		 (node-list-filter-by-gi (children (current-node))
					 (list (normalize "artheader")
					       (normalize "articleinfo"))))
		((equal? (gi) (normalize "bibliography"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "chapter"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "dedication")) 
		 (empty-node-list))
		((equal? (gi) (normalize "glossary"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "index"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "preface"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "reference"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "setindex"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		(else
		 (empty-node-list))))
	 (exp-children (if (node-list-empty? info)
			   (empty-node-list)
			   (expand-children (children info) 
					    (list (normalize "bookbiblio") 
						  (normalize "bibliomisc")
						  (normalize "biblioset")))))
	 (parent-titles (select-elements (children (current-node)) (normalize "title")))
	 (info-titles   (select-elements exp-children (normalize "title")))
	 (titles        (if (node-list-empty? parent-titles)
			    info-titles
			    parent-titles))
	 (subtitles     (select-elements exp-children (normalize "subtitle"))))
    (make sequence
      (make paragraph
	font-family-name: %title-font-family%
	font-weight: 'bold
	font-size: (HSIZE 4)
	line-spacing: (* (HSIZE 4) %line-spacing-factor%)
	space-before: (* (HSIZE 4) %head-before-factor%)
	start-indent: 0pt
	first-line-start-indent: 0pt
	quadding: %component-title-quadding%
	heading-level: (if %generate-heading-level% 1 0)
	keep-with-next?: #t

	(if (string=? (element-label) "")
	    (empty-sosofo)
	    (literal (gentext-element-name-space (current-node))
		     (element-label)
		     (gentext-label-title-sep (gi)))))
      (make paragraph
	font-family-name: %title-font-family%
	font-weight: 'bold
	font-posture: 'italic
	font-size: (HSIZE 6)
	line-spacing: (* (HSIZE 6) %line-spacing-factor%)
;	space-before: (* (HSIZE 5) %head-before-factor%)
	start-indent: 0pt
	first-line-start-indent: 0pt
	quadding: %component-title-quadding%
	heading-level: (if %generate-heading-level% 1 0)
	keep-with-next?: #t

	(if (node-list-empty? titles)
	    (element-title-sosofo) ;; get a default!
	    (with-mode component-title-mode
	      (make sequence
		(process-node-list titles)))))

      (make paragraph
	font-family-name: %title-font-family%
	font-weight: 'bold
	font-posture: 'italic
	font-size: (HSIZE 3)
	line-spacing: (* (HSIZE 3) %line-spacing-factor%)
	space-before: (* 0.5 (* (HSIZE 3) %head-before-factor%))
	space-after: (* (HSIZE 4) %head-after-factor%)
	start-indent: 0pt
	first-line-start-indent: 0pt
	quadding: %component-subtitle-quadding%
	keep-with-next?: #t

	(with-mode component-title-mode
	  (make sequence
	    (process-node-list subtitles))))

      (if (equal? (gi) (normalize "index"))
	(empty-sosofo)
	(make rule
	  length: %body-width%
	  display-alignment: 'start
	  space-before: niceheader-rule-spacebefore
	  space-after: niceheader-rule-spaceafter
	  line-thickness: 0.5pt)))))

      (element authorgroup
        (empty-sosofo))

      ]]>

      <!-- Print only ................................................... --> 

      <![ %output.print; [

      (define minimal-section-labels #f)
      (define max-section-level-labels
        (if minimal-section-labels 3 10))

      (define ($section-title$)
        (let* ((sect (current-node))
      	       (info (info-element))
	       (exp-children (if (node-list-empty? info)
		 	         (empty-node-list)
			         (expand-children (children info) 
					          (list (normalize "bookbiblio") 
						        (normalize "bibliomisc")
						        (normalize "biblioset")))))
	       (parent-titles (select-elements (children sect) (normalize "title")))
  	       (info-titles   (select-elements exp-children (normalize "title")))
	       (titles        (if (node-list-empty? parent-titles)
		   	          info-titles
			          parent-titles))
	       (subtitles     (select-elements exp-children (normalize "subtitle")))
	       (renderas (inherited-attribute-string (normalize "renderas") sect))
	       (hlevel                          ;; the apparent section level;
	        (if renderas                    ;; if not real section level,
  	            (string->number             ;;   then get the apparent level
	             (substring renderas 4 5))  ;;   from "renderas",
	            (SECTLEVEL)))               ;; else use the real level
	       (hs (HSIZE (- 4 hlevel))))

          (make sequence
            (make paragraph
 	      font-family-name: %title-font-family%
	      font-weight:  (if (< hlevel 5) 'bold 'medium)
	      font-posture: (if (< hlevel 5) 'upright 'italic)
	      font-size: hs
	      line-spacing: (* hs %line-spacing-factor%)
	      space-before: (* hs %head-before-factor%)
	      space-after: (if (node-list-empty? subtitles)
	    	  	       (* hs %head-after-factor%)
	 	  	       0pt)
	      start-indent: (if (or (>= hlevel 3)
			            (member (gi) (list (normalize "refsynopsisdiv") 
					    	       (normalize "refsect1") 
						       (normalize "refsect2") 
						       (normalize "refsect3"))))
	 		        %body-start-indent%
			        0pt)
	      first-line-start-indent: 0pt
	      quadding: %section-title-quadding%
	      keep-with-next?: #t
	      heading-level: (if %generate-heading-level% (+ hlevel 1) 0)
  	      ;; SimpleSects are never AUTO numbered...they aren't hierarchical
	      (if (> hlevel (- max-section-level-labels 1))
	          (empty-sosofo)
	          (if (string=? (element-label (current-node)) "")
	  	      (empty-sosofo)
		      (literal (element-label (current-node)) 
			       (gentext-label-title-sep (gi sect)))))
	      (element-title-sosofo (current-node)))
            (with-mode section-title-mode
	      (process-node-list subtitles))
            ($section-info$ info))))

      ]]>

      <!-- Both sets of stylesheets ..................................... -->

      (define (local-en-label-title-sep)
        (list
          (list (normalize "warning")		": ")
	  (list (normalize "caution")		": ")
          (list (normalize "chapter")           "  ")
          (list (normalize "sect1")             "  ")
          (list (normalize "sect2")             "  ")
          (list (normalize "sect3")             "  ")
          (list (normalize "sect4")             "  ")
          (list (normalize "sect5")             "  ")
          ))

    </style-specification-body>
  </style-specification>
    
  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
