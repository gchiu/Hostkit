#--- REBOL 3.0 Host Makefile - Build A102
#--- Note: this makefile was generated by make-build.r (29-Jul-2010/22:04:56)
#--- This file intentionally kept simple - to work on all platforms.
#--- You will need REBOL 2.6 or 2.7 in your work directory or environment path

C= gcc 
CFLAGS= -c -O1 -DUNICODE -I src/include/
LIBS= lib/r3lib.lib -L c:/mingw/lib/ -lm -lwsock32 -lcomdlg32 -lgdi32 -lstdc++

#-lc -lm -lstdc++

S= src
O= obj
I= src/include
T= src/tools

INCS= \
	$I/reb-config.h\
	$I/reb-c.h\
	$I/reb-ext.h\
	$I/reb-args.h\
	$I/reb-device.h\
	$I/reb-file.h\
	$I/reb-event.h\
	$I/reb-evtypes.h\
	$I/reb-net.h\
	$I/reb-filereq.h\
	$I/reb-gob.h

OBJS= \
	$O/host-main.o\
	$O/host-args.o\
	$O/host-device.o\
	$O/host-stdio.o\
	$O/dev-net.o\
	$O/dev-dns.o\
	$O/host-lib.o\
	$O/dev-stdio.o\
	$O/dev-file.o\
	$O/dev-event.o\
	$O/dev-clipboard.o

GFX= \
	$O/host-graphics.o\
	$O/host-event.o\
	$O/host-window.o

AGG= \
	$O/agg_arc.o\
	$O/agg_arrowhead.o\
	$O/agg_bezier_arc.o\
	$O/agg_bspline.o\
	$O/agg_curves.o\
	$O/agg_image_filters.o\
	$O/agg_line_aa_basics.o\
	$O/agg_path_storage.o\
	$O/agg_rasterizer_scanline_aa.o\
	$O/agg_rounded_rect.o\
	$O/agg_sqrt_tables.o\
	$O/agg_trans_affine.o\
	$O/agg_trans_single_path.o\
	$O/agg_vcgen_bspline.o\
	$O/agg_vcgen_contour.o\
	$O/agg_vcgen_dash.o\
	$O/agg_vcgen_markers_term.o\
	$O/agg_vcgen_smooth_poly1.o\
	$O/agg_vcgen_stroke.o\
	$O/agg_vpgen_segmentator.o\
	$O/agg_compo.o\
	$O/agg_graphics.o\
	$O/compositor.o\
	$O/graphics.o

REBS= \
	reb\
	$S/os/host-init.c\
	$S/os/host-ext-graphics.c\
	$S/os/host-ext-draw.c

all:
	-mkdir obj
	make r3.exe

core:
	-mkdir obj
	make r3core.exe

clean:
	-del /q obj\*
	-del $S\os\host-init.c
	-del $S\os\host-ext-graphics.c
	-del $S\os\host-ext-draw.c

r3.exe:	$(REBS) $(OBJS) $(GFX) $(AGG) r3lib.dll
	$C $(CFLAGS) -fpack-struct -o $O/host-main.o $S/os/host-main.c
	$C -o r3.exe $(OBJS) $(GFX) $(AGG) $(LIBS)
	strip r3.exe
	
r3core.exe:	$(REBS) $(OBJS) r3lib.dll
	$C $(CFLAGS) -DCORE_ONLY -fpack-struct -o $O/host-main.o $S/os/host-main.c
	$C -o r3core.exe $(OBJS) $(LIBS)
	strip r3core.exe
	
r3lib.dll: lib/r3lib.dll
	copy lib\r3lib.dll .


#--- Convert REBOL files to C files:

reb:
	@echo "REBOL 2.6 or 2.7 needs to be in the make directory"
	rebol -sqw --do "write to-file 'reb now quit"

$S/os/host-init.c: $T/make-host-init.r $S/mezz/prot-http.r $S/mezz/view-colors.r
	rebol -sqw $T/make-host-init.r

$S/os/host-ext-graphics.c: $T/make-host-ext.r $S/boot/graphics.r
	rebol -sqw $T/make-host-ext.r

$S/os/host-ext-draw.c: $T/make-host-ext.r $S/boot/draw.r
	rebol -sqw $T/make-host-ext.r


#--- Host Program:

$O/host-main.o:     $S/os/host-main.c $(INCS) $I/reb-host.h $I/host-lib.h $I/rebol-lib.h
	$C $(CFLAGS) -fpack-struct -o $O/host-main.o $S/os/host-main.c

$O/host-args.o:     $S/os/host-args.c $(INCS) $I/reb-config.h $I/reb-c.h $I/reb-args.h
	$C $(CFLAGS) -fpack-struct -o $O/host-args.o $S/os/host-args.c

$O/host-device.o:   $S/os/host-device.c $(INCS) $I/reb-host.h $I/host-lib.h $I/rebol-lib.h
	$C $(CFLAGS) -fpack-struct -o $O/host-device.o $S/os/host-device.c

$O/host-stdio.o:    $S/os/host-stdio.c $(INCS) $I/reb-host.h $I/host-lib.h
	$C $(CFLAGS) -fpack-struct -o $O/host-stdio.o $S/os/host-stdio.c

$O/dev-net.o:       $S/os/dev-net.c $(INCS) $I/reb-host.h $I/host-lib.h $I/sys-net.h
	$C $(CFLAGS) -fpack-struct -o $O/dev-net.o $S/os/dev-net.c

$O/dev-dns.o:       $S/os/dev-dns.c $(INCS) $I/reb-host.h $I/host-lib.h $I/sys-net.h
	$C $(CFLAGS) -fpack-struct -o $O/dev-dns.o $S/os/dev-dns.c

$O/host-init.o:     $S/os/host-init.c $(INCS) 
	$C $(CFLAGS) -fpack-struct -o $O/host-init.o $S/os/host-init.c

$O/host-lib.o:      $S/os/win32/host-lib.c $(INCS) $I/reb-host.h $I/host-lib.h
	$C $(CFLAGS) -fpack-struct -o $O/host-lib.o $S/os/win32/host-lib.c

$O/dev-stdio.o:     $S/os/win32/dev-stdio.c $(INCS) $I/reb-host.h $I/host-lib.h
	$C $(CFLAGS) -fpack-struct -o $O/dev-stdio.o $S/os/win32/dev-stdio.c

$O/dev-file.o:      $S/os/win32/dev-file.c $(INCS) $I/reb-host.h $I/host-lib.h
	$C $(CFLAGS) -fpack-struct -o $O/dev-file.o $S/os/win32/dev-file.c

$O/dev-event.o:     $S/os/win32/dev-event.c $(INCS) $I/reb-host.h $I/host-lib.h
	$C $(CFLAGS) -fpack-struct -o $O/dev-event.o $S/os/win32/dev-event.c

$O/dev-clipboard.o: $S/os/win32/dev-clipboard.c $(INCS) $I/reb-host.h $I/host-lib.h $I/sys-net.h
	$C $(CFLAGS) -fpack-struct -o $O/dev-clipboard.o $S/os/win32/dev-clipboard.c

$O/host-graphics.o: $S/os/win32/host-graphics.c $(INCS) $I/reb-host.h $I/host-lib.h $I/rebol-lib.h $I/agg-draw.h
	$C $(CFLAGS) -fpack-struct -o $O/host-graphics.o $S/os/win32/host-graphics.c

$O/host-event.o:    $S/os/win32/host-event.c $(INCS) $I/reb-host.h $I/host-lib.h $I/rebol-lib.h
	$C $(CFLAGS) -fpack-struct -o $O/host-event.o $S/os/win32/host-event.c

$O/host-window.o:   $S/os/win32/host-window.c $(INCS) $I/reb-host.h $I/host-lib.h $I/rebol-lib.h $I/agg-compositor.h
	$C $(CFLAGS) -fpack-struct -o $O/host-window.o $S/os/win32/host-window.c


#--- AGG Library:

$O/agg_arc.o:       $S/agg/agg_arc.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_arc.o $S/agg/agg_arc.cpp

$O/agg_arrowhead.o: $S/agg/agg_arrowhead.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_arrowhead.o $S/agg/agg_arrowhead.cpp

$O/agg_bezier_arc.o:$S/agg/agg_bezier_arc.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_bezier_arc.o $S/agg/agg_bezier_arc.cpp

$O/agg_bspline.o:   $S/agg/agg_bspline.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_bspline.o $S/agg/agg_bspline.cpp

$O/agg_curves.o:    $S/agg/agg_curves.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_curves.o $S/agg/agg_curves.cpp

$O/agg_image_filters.o:$S/agg/agg_image_filters.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_image_filters.o $S/agg/agg_image_filters.cpp

$O/agg_line_aa_basics.o:$S/agg/agg_line_aa_basics.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_line_aa_basics.o $S/agg/agg_line_aa_basics.cpp

$O/agg_path_storage.o:$S/agg/agg_path_storage.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_path_storage.o $S/agg/agg_path_storage.cpp

$O/agg_rasterizer_scanline_aa.o:$S/agg/agg_rasterizer_scanline_aa.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_rasterizer_scanline_aa.o $S/agg/agg_rasterizer_scanline_aa.cpp

$O/agg_rounded_rect.o:$S/agg/agg_rounded_rect.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_rounded_rect.o $S/agg/agg_rounded_rect.cpp

$O/agg_sqrt_tables.o:$S/agg/agg_sqrt_tables.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_sqrt_tables.o $S/agg/agg_sqrt_tables.cpp

$O/agg_trans_affine.o:$S/agg/agg_trans_affine.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_trans_affine.o $S/agg/agg_trans_affine.cpp

$O/agg_trans_single_path.o:$S/agg/agg_trans_single_path.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_trans_single_path.o $S/agg/agg_trans_single_path.cpp

$O/agg_vcgen_bspline.o:$S/agg/agg_vcgen_bspline.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_vcgen_bspline.o $S/agg/agg_vcgen_bspline.cpp

$O/agg_vcgen_contour.o:$S/agg/agg_vcgen_contour.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_vcgen_contour.o $S/agg/agg_vcgen_contour.cpp

$O/agg_vcgen_dash.o:$S/agg/agg_vcgen_dash.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_vcgen_dash.o $S/agg/agg_vcgen_dash.cpp

$O/agg_vcgen_markers_term.o:$S/agg/agg_vcgen_markers_term.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_vcgen_markers_term.o $S/agg/agg_vcgen_markers_term.cpp

$O/agg_vcgen_smooth_poly1.o:$S/agg/agg_vcgen_smooth_poly1.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_vcgen_smooth_poly1.o $S/agg/agg_vcgen_smooth_poly1.cpp

$O/agg_vcgen_stroke.o:$S/agg/agg_vcgen_stroke.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_vcgen_stroke.o $S/agg/agg_vcgen_stroke.cpp

$O/agg_vpgen_segmentator.o:$S/agg/agg_vpgen_segmentator.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_vpgen_segmentator.o $S/agg/agg_vpgen_segmentator.cpp

$O/agg_compo.o:     $S/agg/agg_compo.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_compo.o $S/agg/agg_compo.cpp

$O/agg_graphics.o:  $S/agg/agg_graphics.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/agg_graphics.o $S/agg/agg_graphics.cpp

$O/compositor.o:    $S/agg/compositor.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/compositor.o $S/agg/compositor.cpp

$O/graphics.o:      $S/agg/graphics.cpp $(INCS) 
	$C $(CFLAGS)  -o $O/graphics.o $S/agg/graphics.cpp

