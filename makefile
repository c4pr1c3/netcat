
cc=cl
link=link

all: nc-e.exe

#################### Compile and Link Options #######################  
!ifdef DBG 

cflags=/nologo /ML /W3 /GX /Od /D "DEBUG" /D "WIN32" /D "_CONSOLE" /D "TELNET" /D "GAPING_SECURITY_HOLE" /YX /FD /c
lflags=kernel32.lib user32.lib wsock32.lib /nologo /subsystem:console /incremental:yes /machine:I386 /out:nc-e.exe

!else

cflags=/Zi /nologo /W3 /WX- /O2 /Oi /Oy- /GL /D "GAPING_SECURITY_HOLE" /D "TELNET" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_UNICODE" /D "UNICODE" /Gm- /EHsc /GS /Gy /fp:precise /Zc:wchar_t /Zc:forScope /Fp"netcat.pch" /Fa"" /Fo"" /Fd"vc100.pdb" /Gd /analyze- /errorReport:queue  /c
lflags= /INCREMENTAL:NO /NOLOGO "kernel32.lib" "user32.lib" "gdi32.lib" "winspool.lib" "comdlg32.lib" "advapi32.lib" "shell32.lib" "ole32.lib" "oleaut32.lib" "uuid.lib" "odbc32.lib" "odbccp32.lib" /MANIFEST /ManifestFile:"netcat.exe.intermediate.manifest" /ALLOWISOLATION /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /DEBUG /PDB:"netcat.pdb" /SUBSYSTEM:CONSOLE /OPT:REF /OPT:ICF /TLBID:1 /DYNAMICBASE /NXCOMPAT /MACHINE:X86 /ERRORREPORT:QUEUE  /out:nc-e.exe

!endif

getopt.obj: getopt.c
    $(cc) $(cflags) getopt.c

doexec.obj: doexec.c
    $(cc) $(cflags) doexec.c

netcat.obj: netcat.c
    $(cc) $(cflags) netcat.c

nc-e.exe: getopt.obj doexec.obj netcat.obj
    $(link) getopt.obj doexec.obj netcat.obj $(lflags)

clean:
	del /q /s *.bak *.pdb *.sdf *.dsw *.dsp *.old *.ipch *.pch *.sbr *.obj *.tlog *.idb *.ilk *.user *.exe *.asm *.pgd *.manifest *.pgc
