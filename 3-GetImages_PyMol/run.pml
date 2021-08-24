cmd.load("%s" %("../mol-fit.pdb"), "mol-fit", quiet=0)
cmd.load("%s" %("mol-orig.pdb"), "mol", quiet=0)
extra_fit *, mol-fit, \
    method=fit, \
    cycles=5, \
    cutoff=2.0, \
    matchmaker=1, \
    mobile_state=-1, \
    target_state=-1
cmd.save("%s" %("mol.pdb"), "mol")
reinitialize
run ../apbs.py
load mol.pqr, mol
load map.dx, apbs_map01
ramp_new apbs_ramp01, apbs_map01, [-3,0,3], [red,white,blue]
show surface
set surface_color, apbs_ramp01
set surface_ramp_above_mode, 1
set_view (\
     0.162265301,   -0.882501543,   -0.441429734,\
     0.958800316,    0.246728584,   -0.140810594,\
     0.233178839,   -0.400394201,    0.886178255,\
     0.000000000,    0.000000000, -158.279953003,\
    -9.810217857,    9.004222870,  -32.869007111,\
  -395.406951904,  711.967224121,  -20.000000000 )
set spec_reflect, 0
bg_color white
set ray_opaque_background, 1
set ray_shadows, 0
disable apbs_ramp01
png mol.png, width=1920, height=1080, dpi=300, ray=1