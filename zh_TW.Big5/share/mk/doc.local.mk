# $FreeBSD: doc/zh_TW.Big5/share/mk/doc.local.mk,v 1.2 2006/06/24 12:20:46 vanilla Exp $

SP_ENCODING?=	${LANGCODE:C,^.*\.,,}

CJKTEXSTY?=	${PREFIX}/bin/cjktexsty
CJKTEXSTY_TEX_FLAGS?= -e ${SP_ENCODING} -f t1song
CJKTEXSTY_PDFTEX_FLAGS?= -c -e ${SP_ENCODING} -f song

PDFJADETEX_PREPROCESS=	${CJKTEXSTY} ${CJKTEXSTY_PDFTEX_FLAGS}
JADETEX_PREPROCESS=	${CJKTEXSTY} ${CJKTEXSTY_TEX_FLAGS}
