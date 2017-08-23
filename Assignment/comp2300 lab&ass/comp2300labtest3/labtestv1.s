{\rtf1\ansi\ansicpg936\cocoartf1404\cocoasubrtf340
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 0x0100 : \
	store ZERO varpos\
	jump whilebool\
\
loop : \
	load varpos R3 \
	load R3 #varstr R4\
	store R4 0xfff0\
\
	load varpos R3\
	add R3 ONE R3\
	store R3 varpos\
\
whilebool: \
	load varpos R1\
	load R1 #varstr R2\
	jumpnz R2 loop\
	halt\
\
varpos : block 1\
varstr : block #"Hello World"}