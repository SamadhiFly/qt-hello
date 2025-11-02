@echo off
:: filename: clean.bat

setlocal

set TARGET_FILE_NAME=qt-hello
set TARGET_FILE_EXT=.exe
set BUILD_NINJA_FILE=build.ninja
set CMAKE_PRESETS_FILE=CMakePresets.json
set CMAKE_PRESETS_CONFIG=config-mingw
set CMAKE_PRESETS_BUILD=build-mingw

if exist "%TARGET_FILE_NAME%%TARGET_FILE_EXT%" (
    echo ### deleting target %TARGET_FILE_NAME%%TARGET_FILE_EXT%
    del /f "%TARGET_FILE_NAME%%TARGET_FILE_EXT%" 2>nul
)

if exist "%BUILD_NINJA_FILE%" (
    echo ### cleaning...
    cmake --build --preset %CMAKE_PRESETS_BUILD% --target clean
)

echo ### removing files...
set "files=.ninja_deps .ninja_log build.ninja install_manifest.txt compile_commands.json CMakeCache.txt cmake_install.cmake "
for %%f in (%files%) do (
    if exist "%%f" (
        echo removing file %%f
        del /f "%%f" 2>nul
    )
)

echo ### removing directories...
set "dirs=.cache .cmake .lupdate CMakeFiles %TARGET_FILE_NAME%_autogen "
for %%d in (%dirs%) do (
    if exist "%%d\" (
        echo removing dir %%d
        rmdir /s /q "%%d" 2>nul
    )
)

echo ### clean.bat done.
endlocal

exit /b 0
