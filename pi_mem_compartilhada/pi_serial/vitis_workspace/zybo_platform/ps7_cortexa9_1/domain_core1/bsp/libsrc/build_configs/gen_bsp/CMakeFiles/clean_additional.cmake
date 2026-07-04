# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "C:\\Users\\820759\\pi_serial\\vitis_workspace\\zybo_platform\\ps7_cortexa9_1\\domain_core1\\bsp\\include\\sleep.h"
  "C:\\Users\\820759\\pi_serial\\vitis_workspace\\zybo_platform\\ps7_cortexa9_1\\domain_core1\\bsp\\include\\xiltimer.h"
  "C:\\Users\\820759\\pi_serial\\vitis_workspace\\zybo_platform\\ps7_cortexa9_1\\domain_core1\\bsp\\include\\xtimer_config.h"
  "C:\\Users\\820759\\pi_serial\\vitis_workspace\\zybo_platform\\ps7_cortexa9_1\\domain_core1\\bsp\\lib\\libxiltimer.a"
  )
endif()
