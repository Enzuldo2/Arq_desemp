# 2026-06-30T15:51:08.773097800
import vitis

client = vitis.create_client()
client.set_workspace(path="vitis_workspace")

platform = client.create_platform_component(name = "zybo_platform",hw_design = "$COMPONENT_LOCATION/../../design_1_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",compiler = "gcc")

comp = client.create_app_component(name="hello_world",platform = "$COMPONENT_LOCATION/../zybo_platform/export/zybo_platform/zybo_platform.xpfm",domain = "standalone_ps7_cortexa9_0",template = "hello_world")

platform = client.get_component(name="zybo_platform")
status = platform.build()

status = platform.build()

comp = client.get_component(name="hello_world")
comp.build()

domain = platform.add_domain(cpu = "ps7_cortexa9_1",os = "standalone",name = "domain_core1",display_name = "domain_core1",generate_dtb = False,compiler = "gcc",hw_boot_bin = "")

status = platform.build()

comp = client.create_app_component(name="app_core0",platform = "$COMPONENT_LOCATION/../zybo_platform/export/zybo_platform/zybo_platform.xpfm",domain = "standalone_ps7_cortexa9_0")

comp = client.get_component(name="app_core0")
status = comp.import_files(from_loc="", files=["C:\Users\820759\pi_serial\vitis_workspace\hello_world\src\helloworld.c"], is_skip_copy_sources = False)

comp = client.create_app_component(name="app_core1",platform = "$COMPONENT_LOCATION/../zybo_platform/export/zybo_platform/zybo_platform.xpfm",domain = "domain_core1")

comp = client.get_component(name="app_core1")
status = comp.import_files(from_loc="", files=["C:\Users\820759\pi_serial\vitis_workspace\hello_world\src\helloworld.c"], is_skip_copy_sources = False)

proj = client.create_sys_project(name="multicore_pi", platform="$COMPONENT_LOCATION/../zybo_platform/export/zybo_platform/zybo_platform.xpfm", template="empty_accelerated_application" , build_output_type="xsa")

proj = client.get_sys_project(name="multicore_pi")

proj = client.get_sys_project(name="multicore_pi")

proj = proj.add_component(name="app_core0")

proj = proj.add_component(name="app_core1")

proj = client.get_sys_project(name="multicore_pi")

proj.build(build_comps = False)

status = comp.import_files(from_loc="$COMPONENT_LOCATION/../hello_world/src", files=["platform.c", "platform.h"], dest_dir_in_cmp = "app_core1", is_skip_copy_sources = False)

status = platform.build()

comp = client.get_component(name="app_core1")
comp.build()

comp = client.get_component(name="app_core0")
status = comp.import_files(from_loc="$COMPONENT_LOCATION/../hello_world/src", files=["platform.c", "platform.h"], dest_dir_in_cmp = "app_core0", is_skip_copy_sources = False)

status = platform.build()

comp = client.get_component(name="app_core0")
comp.build()

status = platform.build()

comp = client.get_component(name="app_core1")
comp.build()

proj.build(comp_name = ["app_core0"],build_comps = False)

client.delete_component(name="app_core0")

client.delete_component(name="componentName")

client.delete_component(name="componentName")

client.delete_component(name="app_core1")

client.delete_component(name="componentName")

client.delete_component(name="componentName")

client.delete_component(name="componentName")

client.delete_component(name="componentName")

comp = client.create_app_component(name="app_core0",platform = "$COMPONENT_LOCATION/../zybo_platform/export/zybo_platform/zybo_platform.xpfm",domain = "standalone_ps7_cortexa9_0",template = "hello_world")

comp = client.create_app_component(name="app_core1",platform = "$COMPONENT_LOCATION/../zybo_platform/export/zybo_platform/zybo_platform.xpfm",domain = "domain_core1",template = "hello_world")

status = platform.build()

comp = client.get_component(name="app_core0")
comp.build()

status = platform.build()

comp = client.get_component(name="app_core1")
comp.build()

status = platform.build()

comp = client.get_component(name="app_core0")
comp.build()

status = platform.build()

comp = client.get_component(name="app_core1")
comp.build()

proj = client.get_sys_project(name="multicore_pi")

proj = client.get_sys_project(name="multicore_pi")

proj = proj.add_component(name="app_core0")

proj = proj.add_component(name="app_core1")

proj = client.get_sys_project(name="multicore_pi")

proj.build(comp_name = ["app_core1", "app_core0"],build_comps = False)

status = platform.build()

comp = client.get_component(name="app_core0")
comp.build()

status = platform.build()

comp = client.get_component(name="app_core1")
comp.build()

component = client.get_component(name="app_core0")

lscript = component.get_ld_script(path="C:\Users\820759\pi_serial\vitis_workspace\app_core0\src\lscript.ld")

lscript.update_memory_region("ps7_ddr_0_memory_0", "0x100000", "0x10000000")

component = client.get_component(name="app_core1")

lscript = component.get_ld_script(path="C:\Users\820759\pi_serial\vitis_workspace\app_core1\src\lscript.ld")

lscript.update_memory_region("ps7_ddr_0_memory_0", "0x10100000", "0x3ff00000")

lscript.update_memory_region("ps7_ddr_0_memory_0", "0x10100000", "0x10000000")

status = platform.build()

comp = client.get_component(name="app_core0")
comp.build()

status = platform.build()

comp = client.get_component(name="app_core1")
comp.build()

status = platform.build()

comp = client.get_component(name="app_core0")
comp.build()

proj.build(comp_name = ["app_core1", "app_core0"],build_comps = False)

proj.build(comp_name = ["app_core1", "app_core0"],build_comps = False)

vitis.dispose()

